Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C98C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9D126742
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9D126742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeFZSaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:30:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36048 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeFZSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:30:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so4700576pfh.3;
        Tue, 26 Jun 2018 11:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMeCInSn5HV4ZxyWsLPZK2lw5qRLL1OhPzhXOibJvmc=;
        b=nnNUwD0ax9haKFCv53Lu+77HCOl6uLluMJkfwak5IdWVP7pBlKkvpg56HY9MGKxq2i
         g8oulX3reYsiCVF2fHnsugRIcVBLbDPjnDKzuVAIH4HZgMmByktsw2kbh413iURSwL9a
         qrzAiZtRDXC4bTgMvSvtiR8inEj14ebjpxV3ixwEpBd78EpNzzud5S/XdA4hDT6t/pif
         3PARhEeieFEZpoychbJkZKzdugisPaXde2qn1D4mszrk2LCKTof8EWSi9vsBxtURrMwF
         /UZ7byCTjcGcFcEptId7DXl8DZbu/IISTG/MDV0U2hWUl/4wGZYXADlnn4mqHPl9/Tvj
         ALwA==
X-Gm-Message-State: APt69E2FQyzFvkJYsIUohjPr4mgdHI6KWYb7vUJhLlNPXNEI72KwbFY3
        yBvmDNSKxAV8qYnJh3MpmA==
X-Google-Smtp-Source: ADUXVKLHMiedY3jdMep3RZZDXM/OzonEPuxL9CxJC9KpJjSciJDRSiT/VRT7VAJCMnR1NEzlfCc04g==
X-Received: by 2002:a65:5ac9:: with SMTP id d9-v6mr2365525pgt.238.1530037806600;
        Tue, 26 Jun 2018 11:30:06 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g70-v6sm4211010pfc.107.2018.06.26.11.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 11:30:05 -0700 (PDT)
Date:   Tue, 26 Jun 2018 12:30:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     yixun.lan@amlogic.com, linux-mtd@lists.infradead.org,
        boris.brezillon@bootlin.com, richard@nod.at,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        devicetree@vger.kernel.org, liang.yang@amlogic.com,
        jian.hu@amlogic.com, khilman@baylibre.com, carlo@caione.org,
        linux-amlogic@lists.infradead.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com
Subject: Re: [PATCH 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
Message-ID: <20180626183003.GA3019@rob-hp-laptop>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
 <20180613161314.14894-2-yixun.lan@amlogic.com>
 <CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 12:46:59AM +0200, Martin Blumenstingl wrote:
> Hello Yixun, Hello Liang,
> 
> I have a few small comments inline below
> additionally I tried to explain the reason behind
> "amlogic,mmc-syscon", clkin0 and clkin1 so Rob (or the devicetree
> maintainers in general) can give feedback. feel free to correct me
> wherever I'm wrong or provide additional notes in case I missed
> something!
> 
> On Wed, Jun 13, 2018 at 10:17 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
> >
> > From: Liang Yang <liang.yang@amlogic.com>
> >
> > Add Amlogic NAND controller dt-bindings for Meson SoC,
> > Current this driver support GXBB/GXL/AXG platform.
> >
> > Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >  .../bindings/mtd/amlogic,meson-nand.txt       | 118 ++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> > new file mode 100644
> > index 000000000000..eac9f9433d5d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> > @@ -0,0 +1,118 @@
> > +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> > +
> > +This file documents the properties in addition to those available in
> > +the MTD NAND bindings.
> > +
> > +Required properties:
> > +- compatible : contains one of:
> > +  - "amlogic,meson-gxl-nfc"
> > +  - "amlogic,meson-axg-nfc"
> the patch description states that GXBB/GXL/AXG are supported
> shouldn't you add a compatible string for GXBB as well?
> 
> > +- clocks     :
> > +       A list of phandle + clock-specifier pairs for the clocks listed
> > +       in clock-names.
> > +
> > +- clock-names: Should contain the following:
> > +       "core" - NFC module gate clock
> > +       "clkin0" - Parent clock of internal mux
> > +       "clkin1" - Other parent clock of internal mux
> to give the devicetree maintainers some context on clkin0 and clkin1:
> 
> older SoCs (Meson8, Meson8b - not supported by this binding/driver
> yet) had a dedicated NAND clock. there neither clkin0 or clkin1 would
> be used, instead we just had a "nand" or "interface" clock (I'm not
> aware of the actual naming in Amlogic's internal datasheets)
> 
> newer SoCs do NOT have a dedicated NAND "interface" clock anymore.
> instead they are sharing the clock with the "sd_emmc_c" controller (I
> *believe* the reason for this is because sd_emmc_c and the NAND
> controller use the same pads on the SoC, pinctrl muxing controls where
> these pads are routed -> NAND and sd_emmc_c cannot be used at the same
> time, so SoC designers probably decided to re-use the clock)
> 
> unfortunately the sd_emmc_c clock is not provided by the "main" clock
> controller on these newer SoCs
> instead the clock is part of the MMC controller's register space (see
> the SD_EMMC_CLOCK register in drivers/mmc/host/meson-gx-mmc.c)
> even worse: the SD_EMMC_CLOCK contains more than just clock settings
> (bit 25 enables the SDIO interrupt, which is currently not supported
> by the meson-gx-mmc driver though)
> 
> the SD_EMMC_CLOCK register has a mux (CLK_SRC_MASK) to choose from
> clkin0 and clkin1 which are passed here
> the "amlogic,mmc-syscon" property is used to get a phandle to the
> sd_emmc_c syscon register space
> thus there is a bit of code duplication in the MMC and NAND drivers
> with this binding (because both need to configure the SD_EMMC_CLOCK
> register)

Well, that's ugly. Really, the SD controller should be modeled as a 
clock provider. But then you would have to always have a driver 
instantiated for it. Maybe you need that anyway if accessing this 
register is dependent on some other clock or reset to the module being 
enabled (which you may not hit if you only access the reg during boot)?

But if you really want to do it this way, I guess that is fine.

> > +
> > +- pins     : Select pins which NFC need.
> > +- nand_pins: Detail NAND pins information.
> > +               nand_pins: nand {
> > +                       mux {
> > +                               groups = "emmc_nand_d0",
> > +                                       "emmc_nand_d1",
> > +                                       "emmc_nand_d2",
> > +                                       "emmc_nand_d3",
> > +                                       "emmc_nand_d4",
> > +                                       "emmc_nand_d5",
> > +                                       "emmc_nand_d6",
> > +                                       "emmc_nand_d7",
> > +                                       "nand_ce0",
> > +                                       "nand_rb0",
> > +                                       "nand_ale",
> > +                                       "nand_cle",
> > +                                       "nand_wen_clk",
> > +                                       "nand_ren_wr";
> > +                               function = "nand";
> > +                       };
> > +               };
> > +
> > +- amlogic,mmc-syscon   : Required for NAND clocks, it's shared with SD/eMMC
> > +                               controller port C
> > +
> > +Optional children nodes:
> > +Children nodes represent the available nand chips.
> > +
> > +Optional properties:
> > +- meson-nand-user-mode :
> > +       only set 2 or 16 which mean the way of reading OOB bytes by NFC.
> as far as I know vendor specific properties should follow the naming
> schema "vendor,purpose"
> in this case this would be "amlogic,nand-user-mode"
> 
> maybe Rob can comment on this?

Yes.

> 
> > +- meson-nand-ran-mode :
> > +       setting 0 or 1, means disable/enable scrambler which keeps the balence
> > +       of 0 and 1
> I assume 0 and 1 are the only possible values.
> to use of_property_read_bool in the driver the property would be either:
> - (absent) = scrambler is disabled
> - amlogic,nand-enable-scrambler (without any value - also same comment
> as above for the value) = scrambler is enabled
> 
> 
> Regards
> Martin
