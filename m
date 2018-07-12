Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E35C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C3C2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="rk8KQ3SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeGLIXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:23:13 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.130]:14926 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeGLIXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1531383280;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=bySVrdh/CNLMH/WyNJxS0yo9d7DFrEL4n2Bhwvd6fLY=;
        b=rk8KQ3SNE1I2JHxowZrx36c+fJyF1UYbU5Qz8n4ZTMv0Lw+eZ9/PmtxxUOd8pOOKwq
        78t8tBpCFoa3gNWn5kP5XFiJrEsPNaEaU91uzgnGJ8pyV9jh6Mmlbt/nzxOHKTr2wKqk
        3ViNIzJ+HuwIpgJ39IL1fMQeSfF4O9YsjbJiq2XKl/CekVaOg3EjwIVatkuyos9lffqV
        0fM74I3nA/dUe5uZU1qOF/fCgU/C/B+zjv93n3570EKsNs8mseO8arXULf9967Qe7ffh
        gYlsyIVbEpHFJRAwcUXtQXuR5fo0K/74/gjEu2/jf93w1s3l9jqrvJVqmn7Vp7AkHRtK
        K+ng==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCFd9YT6GX08QoC8ogb0FwvlNKlCnkzs3Qyd3v/"
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24e2:5300:490d:5c5c:8c42:ccc2]
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id z029adu6C8Dw3Xz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 12 Jul 2018 10:13:58 +0200 (CEST)
Subject: Re: [PATCH v2 05/12] dt-bindings: spi: Adjust the bindings for the
 FSL QSPI driver
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, broonie@kernel.org, david.wolfe@nxp.com,
        fabio.estevam@nxp.com, prabhakar.kushwaha@nxp.com,
        yogeshnarayan.gaur@nxp.com, han.xu@nxp.com, shawnguo@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
 <20180711160521.GA16884@rob-hp-laptop>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <9fd871dd-3d10-044c-db80-d65df161a7d9@exceet.de>
Date:   Thu, 12 Jul 2018 10:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711160521.GA16884@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11.07.2018 18:05, Rob Herring wrote:
> On Thu, Jul 05, 2018 at 01:15:01PM +0200, Frieder Schrempf wrote:
>> Adjust the documentation of the new SPI memory interface based
>> driver to reflect the new drivers settings.
> 
> Bindings shouldn't change (other than new properties) due to driver
> changes.

Right, I added an explanation below, why I think the changes are necessary.

> 
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v2:
>> ==============
>> * Split the moving and editing of the dt-bindings in two patches
>>
>>   .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 22 ++++++++++----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>> index 483e9cf..8b4eed7 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>> @@ -3,9 +3,8 @@
>>   Required properties:
>>     - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
>>   		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
>> -		 "fsl,ls1021a-qspi"
>> +		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
>>   		 or
>> -		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
>>   		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
> 
> So the 2080a h/w was compatible with the 1021a h/w, but now it is not?
> How did the h/w change?

I guess this should be posted as a separate fix. Formerly there was only 
"fsl,ls1021a-qspi" handled in the driver and the bindings here claimed 
that "fsl,ls2080a-qspi" is compatible.

Some time ago a separate entry for "fsl,ls2080a-qspi" was added to the 
driver [1] and it adds a quirk, that is not set for "fsl,ls1021a-qspi". 
That's why I concluded, that these two are actually not compatible.

> 
>>     - reg : the first contains the register location and length,
>>             the second contains the memory mapping address and length
>> @@ -15,14 +14,15 @@ Required properties:
>>     - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
>>   
>>   Optional properties:
>> -  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
>> -                              Each bus can be connected with two NOR flashes.
>> -			      Most of the time, each bus only has one NOR flash
>> -			      connected, this is the default case.
>> -			      But if there are two NOR flashes connected to the
>> -			      bus, you should enable this property.
>> -			      (Please check the board's schematic.)
> 
> You can't just remove properties without explanation. Why is this no
> longer needed? What about backwards compatibility with existing dtbs?

You're right, the explanation is missing here.

The "old" driver was using this property to select one of two dual chip 
setups (two chips on one bus or two chips on separate buses). And it 
used the order in which the subnodes are defined in the dt to select the 
CS, the chip is connected to.

Both methods are wrong and in fact the "reg" property should be used to 
determine which bus and CS a chip is connected to. This also enables us 
to use different setups than just single chip, or symmetric dual chip.

So the porting of the driver from the MTD to the SPI framework actually 
enforces the use of the "reg" properties and makes 
"fsl,qspi-has-second-chip" superfluous.

As all boards that have "fsl,qspi-has-second-chip" set, also have 
correct "reg" properties, the removal of this property shouldn't lead to 
any incompatibilities.

The only compatibility issues I can see are with imx6sx-sdb.dts and 
imx6sx-sdb-reva.dts, which have their reg properties set incorrectly 
(see explanation here: [2]), all other boards should stay compatible.

> 
>> -  - big-endian : That means the IP register is big endian
>> +  - big-endian : That means the IP registers format is big endian
> 
> This is a standard property so it doesn't really need to be redefined
> here, but just reference the definition.

So I will change that to:

	big-endian : See common-properties.txt for a definition

Thanks,
Frieder

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mtd/spi-nor/fsl-quadspi.c?h=v4.18-rc4&id=d728a7ea9037c2df085bf9494d56e90d0ff69d7d
[2] https://patchwork.ozlabs.org/patch/922817/#1925445

> 
>> +
>> +Required SPI slave node properties:
>> +  - reg: There are two buses (A and B) with two chip selects each.
>> +	 This encodes to which bus and CS the flash is connected:
>> +		<0>: Bus A, CS 0
>> +		<1>: Bus A, CS 1
>> +		<2>: Bus B, CS 0
>> +		<3>: Bus B, CS 1
>>   
>>   Example:
>>   
>> @@ -40,7 +40,7 @@ qspi0: quadspi@40044000 {
>>   	};
>>   };
>>   
>> -Example showing the usage of two SPI NOR devices:
>> +Example showing the usage of two SPI NOR devices on bus A:
>>   
>>   &qspi2 {
>>   	pinctrl-names = "default";
>> -- 
>> 2.7.4
>>
