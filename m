Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="yDwwo1G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63A9D60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeFFMO1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:14:27 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42214 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:14:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 06 Jun 2018 14:14:23 +0200
From: Stefan Agner <stefan@agner.ch>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Dmitry Osipenko <digetx@gmail.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        benjamin.lindqvist@endian.se, pgaikwad@nvidia.com, dev@lynxeye.de,
        mirza.krak@gmail.com, richard@nod.at, pdeschrijver@nvidia.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mtd: rawnand: tegra: add devicetree binding
In-Reply-To: <20180606110735.GM11810@ulmo>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-4-stefan@agner.ch> <20180601093025.2817ff30@bbrezillon>
 <faa40dac-ab2a-2d43-3a43-2d46cebcd539@gmail.com>
 <20180606103903.GJ11810@ulmo> <20180606124540.46bfa00b@bbrezillon>
 <20180606110735.GM11810@ulmo>
Message-ID: <c687fc59e2662d07568f94efb55bc250@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[22];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.2018 13:07, Thierry Reding wrote:
> On Wed, Jun 06, 2018 at 12:45:40PM +0200, Boris Brezillon wrote:
>> Hi Thierry,
>>
>> On Wed, 6 Jun 2018 12:39:03 +0200
>> Thierry Reding <thierry.reding@gmail.com> wrote:
>>
>> > On Tue, Jun 05, 2018 at 11:19:14PM +0300, Dmitry Osipenko wrote:
>> > > On 01.06.2018 10:30, Boris Brezillon wrote:
>> > > > On Fri,  1 Jun 2018 00:16:34 +0200
>> > > > Stefan Agner <stefan@agner.ch> wrote:
>> > > >
>> > > >> This adds the devicetree binding for the Tegra 2 NAND flash
>> > > >> controller.
>> > > >>
>> > > >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> > > >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > > >> ---
>> > > >>  .../bindings/mtd/nvidia-tegra20-nand.txt      | 64 +++++++++++++++++++
>> > > >>  1 file changed, 64 insertions(+)
>> > > >>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>> > > >>
>> > > >> diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>> > > >> new file mode 100644
>> > > >> index 000000000000..5cd984ef046b
>> > > >> --- /dev/null
>> > > >> +++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>> > > >> @@ -0,0 +1,64 @@
>> > > >> +NVIDIA Tegra NAND Flash controller
>> > > >> +
>> > > >> +Required properties:
>> > > >> +- compatible: Must be one of:
>> > > >> +  - "nvidia,tegra20-nand"
>> > > >
>> > > > As discussed previously, I prefer "nvidia,tegra20-nand-controller" or
>> > > > "nvidia,tegra20-nfc".
>> > > >
>> > > >> +- reg: MMIO address range
>> > > >> +- interrupts: interrupt output of the NFC controller
>> > > >> +- clocks: Must contain an entry for each entry in clock-names.
>> > > >> +  See ../clocks/clock-bindings.txt for details.
>> > > >> +- clock-names: Must include the following entries:
>> > > >> +  - nand
>> > > >> +- resets: Must contain an entry for each entry in reset-names.
>> > > >> +  See ../reset/reset.txt for details.
>> > > >> +- reset-names: Must include the following entries:
>> > > >> +  - nand
>> > > >> +
>> > > >> +Optional children nodes:
>> > > >> +Individual NAND chips are children of the NAND controller node. Currently
>> > > >> +only one NAND chip supported.
>> > > >> +
>> > > >> +Required children node properties:
>> > > >> +- reg: An integer ranging from 1 to 6 representing the CS line to use.
>> > > >> +
>> > > >> +Optional children node properties:
>> > > >> +- nand-ecc-mode: String, operation mode of the NAND ecc mode. Currently only
>> > > >> +		 "hw" is supported.
>> > > >> +- nand-ecc-algo: string, algorithm of NAND ECC.
>> > > >> +		 Supported values with "hw" ECC mode are: "rs", "bch".
>> > > >> +- nand-bus-width : See nand.txt
>> > > >> +- nand-on-flash-bbt: See nand.txt
>> > > >> +- nand-ecc-strength: integer representing the number of bits to correct
>> > > >> +		     per ECC step (always 512). Supported strength using HW ECC
>> > > >> +		     modes are:
>> > > >> +		     - RS: 4, 6, 8
>> > > >> +		     - BCH: 4, 8, 14, 16
>> > > >> +- nand-ecc-maximize: See nand.txt
>> > > >> +- nand-is-boot-medium: Makes sure only ECC strengths supported by the boot ROM
>> > > >> +		       are choosen.
>> > > >> +- wp-gpios: GPIO specifier for the write protect pin.
>> > > >> +
>> > > >> +Optional child node of NAND chip nodes:
>> > > >> +Partitions: see partition.txt
>> > > >> +
>> > > >> +  Example:
>> > > >> +	nand@70008000 {
>> > > >
>> > > > 	nand-controller@70008000 {
>> > > >
>> > > >> +		compatible = "nvidia,tegra20-nand";
>> > > >
>> > > > 		compatible = "nvidia,tegra20-nand-controller";
>> > > >
>> > > > or
>> > > >
>> > > > 		compatible = "nvidia,tegra20-nfc";
>> > > >
>> > >
>> > > Maybe it's just me, but when I'm reading "nfc", my first association is the
>> > > "Near Field Communication". Probably an explicit
>> > > "nvidia,tegra20-nand-controller" variant is more preferable.
>>
>> I also prefer nvidia,tegra20-nand-controller.
>>
>> >
>> > We don't really use a -controller suffix for any of the other
>> > controllers because it is kind of implied. "nfc" is also not something
>> > that is ever referred to in the technical documentation.
>> >
>> > "nvidia,tegra20-nand" would be most consistent with all the rest of
>> > Tegra (c.f. "nvidia,tegra*-ahci", "nvidia,tegra*-pci",
>> > "nvidia,tegra*-hda", "nvidia,tegra*-gmi", ...).
>>
>> People get confused about what this node represents when you just have
>> "nvidia,tegra20-nand", and then you start seeing NAND related props or
>> partition nodes being defined under the NAND controller node.
>> I really prefer to have the "-controller" prefix here to avoid such
>> confusions.
> 
> Hmm... odd. I mean, the node is already called nand-controller@...,
> which makes it pretty obvious to me that this represents a controller
> rather than a NAND chip. Also, the placement of this in the DT hierarchy
> should make it pretty obvious that it is a controller since you can't
> just put a NAND chip directly on the CPU's address bus.
> 
> In addition I think the nvidia,tegra* part already pretty strongly
> suggests that this is part of an SoC, so further implies "controller".

The reference manual states:
"16.0 NAND FLASH CONTROLLER

The NAND flash controller allows Tegra 2 Processor to access NAND flash
memories for mass storage."

So I guess "nvidia,tegra20-nand-flash-controller" would be most
explicit. But the manual also has "GPIO controller" and we use
"nvidia,tegra20-gpio" as compatible string.

I dislike nfc since it is an increasingly less known abbreviation and
not used in the reference manual at all.

"nvidia,tegra20-nand" or "nvidia,tegra20-nand-flash-controller" is fine
for me...

--
Stefan
