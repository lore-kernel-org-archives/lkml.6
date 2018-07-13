Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9152147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvOAph/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9152147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbeGMA2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbeGMA2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:28:08 -0400
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com [209.85.223.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930C5214C4;
        Fri, 13 Jul 2018 00:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531440969;
        bh=FapD3InQPnJ85vrcDXBnEu5fZuqWuNoPIH/+JtYA+pM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IvOAph/MaxG6GYXq089kHQGIG7H03o+3fQYwDl3M4hDwQvfrOhHv4TNkR8r0DWlIW
         gZMv8TXe2aMn4/6lFCiQgUBQNrwRIPjXQFULmBjR8QWUrBRAQhDvlfkA+r+S8VKFX2
         jQPCp7wmr/sSBLJ5G9wUFfGHpPLfCf260lMuFW2M=
Received: by mail-io0-f181.google.com with SMTP id e13-v6so29820401iof.6;
        Thu, 12 Jul 2018 17:16:09 -0700 (PDT)
X-Gm-Message-State: APt69E1Ia+zE2O5bXNZV8xPoMPexlYJTZY+ScGF2H8kAs3cIeD2vT5lm
        lfPlckKa1PGUIZ4blIS1KLZ7gGMT2c/gv5TA5g==
X-Google-Smtp-Source: AAOMgpcmX6C53QctekjQQ88Vg4Ovuvm2xk7GNVnnyL4Bifaz2es8XiWwf6HUqr1ei0CTyAncr1/xYPQEqFr1ualgRuA=
X-Received: by 2002:a6b:c693:: with SMTP id w141-v6mr29232739iof.79.1531440968967;
 Thu, 12 Jul 2018 17:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180710163658.6175-1-yixun.lan@amlogic.com> <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop> <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
 <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com> <5442a2e8-eb49-2aa8-e53e-8db88cd0bd58@amlogic.com>
In-Reply-To: <5442a2e8-eb49-2aa8-e53e-8db88cd0bd58@amlogic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Jul 2018 18:15:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com>
Message-ID: <CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock controller
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:29 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> HI Rob
>
> see my comments
>
> On 07/12/2018 10:17 PM, Rob Herring wrote:
> > On Wed, Jul 11, 2018 at 8:47 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
> >>
> >> Hi Rob
> >>
> >> see my comments
> >>
> >> On 07/12/18 03:43, Rob Herring wrote:
> >>> On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
> >>>> Document the MMC sub clock controller driver, the potential consumer
> >>>> of this driver is MMC or NAND.
> >>>
> >>> So you all have decided to properly model this now?
> >>>
> >> Yes, ;-)
> >>
> >>>>
> >>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> >>>> ---
> >>>>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
> >>>>  1 file changed, 31 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>>> new file mode 100644
> >>>> index 000000000000..ff6b4bf3ecf9
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>>> @@ -0,0 +1,31 @@
> >>>> +* Amlogic MMC Sub Clock Controller Driver
> >>>> +
> >>>> +The Amlogic MMC clock controller generates and supplies clock to support
> >>>> +MMC and NAND controller
> >>>> +
> >>>> +Required Properties:
> >>>> +
> >>>> +- compatible: should be:
> >>>> +            "amlogic,meson-gx-mmc-clkc"
> >>>> +            "amlogic,meson-axg-mmc-clkc"
> >>>> +
> >>>> +- #clock-cells: should be 1.
> >>>> +- clocks: phandles to clocks corresponding to the clock-names property
> >>>> +- clock-names: list of parent clock names
> >>>> +    - "clkin0", "clkin1"
> >>>> +
> >>>> +Parent node should have the following properties :
> >>>> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"
> >>>
> >>> You don't need "simple-mfd" and probably not syscon either. The order is
> >>> wrong too. Most specific first.
> >>>
> >> Ok, I will drop "simple-mfd"..
> >>
> >> but the syscon is a must, since this mmc clock model access registers
> >> via the regmap interface
> >
> > A syscon compatible should not be the only way to get a regmap.
> do you have any suggestion about other function that I can use? is
> devm_regmap_init_mmio() feasible
>
> > Removing lines 56/57 of drivers/mfd/syscon.c should be sufficient.
> >
> I'm not sure what's the valid point of removing compatible 'syscon' in
> driver/mfd/syscon.c, sounds this will break a lot DT/or need to fix?
> will you propose a patch for this? then I can certainly adjust here

Removing the 2 lines will simply allow any node to be a syscon. If
there's a specific driver for a node, then that makes sense to allow
that.

>
> > Why do you need a regmap in the first place? What else needs to access
> > this register directly?
> Yes, the SD_EMMC_CLOCK register contain several bits which not fit well
> into common clock model, and they need to be access in the NAND or eMMC
> driver itself, Martin had explained this in early thread[1]
>
> In this register
> Bit[31] select NAND or eMMC function
> Bit[25] enable SDIO IRQ
> Bit[24] Clock always on
> Bit[15:14] SRAM Power down
>
> [1]
> https://lkml.kernel.org/r/CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com
>
> > Don't you need a patch removing the clock code
> > from within the emmc driver? It's not even using regmap, so using
> > regmap here doesn't help.
> >
> No, and current eMMC driver still use iomap to access the register

Which means a read-modify-write can corrupt the register value if both
users don't access thru regmap. Changes are probably infrequent enough
that you get lucky...

> I think we probably would like to take two steps approach.
> first, from the hardware perspective, the NAND and eMMC(port C) driver
> can't exist at same time, since they share the pins, clock, internal
> ram, So we have to only enable one of NAND or eMMC in DT, not enable
> both of them.

Yes, of course.

> Second, we might like to convert eMMC driver to also use mmc-clkc model.

IMO, this should be done as part of merging this series. Otherwise, we
have duplicated code for the same thing.

Rob
