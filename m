Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D85256A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XYatDSeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D85256A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeF0Xkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:40:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35945 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeF0Xkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:40:47 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so1788515plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UlLcojM2OaiG0/AhHvdlxKUTAaeDpNRGOa1PI+9C+m8=;
        b=XYatDSeRh5OP67FscXR7laHXbWv8Z25PIJ4cmAFzuK2wDFs474ykDeZFP2XNvE6NRR
         17NhesZgCjSQAUbOItDd9fAnNf40Uv8WCANFXSxuc1+BTd/s0hgVzLuC+sj3g3NAy4AX
         Oup7R/6/aSp5DlkX3sEiD1f1Irg/0ShfCu1faJPdofUTBGOHYXScs53Gf4vs30I2h4l0
         u/1+nHtJzMgFavPvpluncc1Jn/Z8juIfiKeTGzhjkVl4vk7GVQQwGtoBtok2NHYXDsrN
         Ah6FA8SPVFm8NeinI5C7kJqJ9MjWOMg93BUdIl3lmLxglwwRsAboANA+eG5S2PGXUH0w
         jB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UlLcojM2OaiG0/AhHvdlxKUTAaeDpNRGOa1PI+9C+m8=;
        b=oYxF6Pk4utgd/7KwmA0WwgmTbHH2NRMAZtGHSiycYa+qcwtNBlKhQeSf6HKI9ScQ2n
         sypuE69+nSdDrCnLorqGmJbLo34KkMBC3aEwe9utl0xlfMgHeZ8orS/Er5z/VTHnQHSd
         /avdgLUFkPEa1DUNc7oAkC1QhjkQX8p8SfArsq4eyqQufmMlUCDvyUUFdAnlJmvvGE4p
         V7JHkGZCQvSckHAHa7rHvOF0Jilc1QWLp1n9xaNwX875QO1/Xr6HkIE8xg8ocljp1mC8
         VWd0h417lHqrzNythD/xjY37EA5UxfSavw4489SjUwjdBBjg+c8kzeIcP2ZRPikoasC1
         skuQ==
X-Gm-Message-State: APt69E0zSVP5JCAYGpGqlYQvnIQaOyZwv7OFXWMUX1M2jsv+1Di8RDle
        LH8If0eYUX6ShHTtrdFf03okbg==
X-Google-Smtp-Source: ADUXVKIQePEqMLmzETfY1/5s2s1YV7y+0VtY/MhtSGXKNepvcjCJAAYiL3CU+F20O0XMHQGVAYs8Nw==
X-Received: by 2002:a17:902:5991:: with SMTP id p17-v6mr7940485pli.191.1530142846568;
        Wed, 27 Jun 2018 16:40:46 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id p12-v6sm11396319pfi.175.2018.06.27.16.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 16:40:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        yixun.lan@amlogic.com, linux-mtd@lists.infradead.org,
        boris.brezillon@bootlin.com, richard@nod.at,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        devicetree@vger.kernel.org, liang.yang@amlogic.com,
        jian.hu@amlogic.com, carlo@caione.org,
        linux-amlogic@lists.infradead.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com
Subject: Re: [PATCH 1/2] dt-bindings: nand: meson: add Amlogic NAND controller driver
Organization: BayLibre
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
        <20180613161314.14894-2-yixun.lan@amlogic.com>
        <CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com>
        <20180626183003.GA3019@rob-hp-laptop>
Date:   Wed, 27 Jun 2018 16:40:45 -0700
In-Reply-To: <20180626183003.GA3019@rob-hp-laptop> (Rob Herring's message of
        "Tue, 26 Jun 2018 12:30:03 -0600")
Message-ID: <7hvaa3hk76.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Sun, Jun 24, 2018 at 12:46:59AM +0200, Martin Blumenstingl wrote:
>> Hello Yixun, Hello Liang,
>> 
>> I have a few small comments inline below
>> additionally I tried to explain the reason behind
>> "amlogic,mmc-syscon", clkin0 and clkin1 so Rob (or the devicetree
>> maintainers in general) can give feedback. feel free to correct me
>> wherever I'm wrong or provide additional notes in case I missed
>> something!
>> 
>> On Wed, Jun 13, 2018 at 10:17 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>> >
>> > From: Liang Yang <liang.yang@amlogic.com>
>> >
>> > Add Amlogic NAND controller dt-bindings for Meson SoC,
>> > Current this driver support GXBB/GXL/AXG platform.
>> >
>> > Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> > ---
>> >  .../bindings/mtd/amlogic,meson-nand.txt       | 118 ++++++++++++++++++
>> >  1 file changed, 118 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> > new file mode 100644
>> > index 000000000000..eac9f9433d5d
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> > @@ -0,0 +1,118 @@
>> > +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>> > +
>> > +This file documents the properties in addition to those available in
>> > +the MTD NAND bindings.
>> > +
>> > +Required properties:
>> > +- compatible : contains one of:
>> > +  - "amlogic,meson-gxl-nfc"
>> > +  - "amlogic,meson-axg-nfc"
>> the patch description states that GXBB/GXL/AXG are supported
>> shouldn't you add a compatible string for GXBB as well?
>> 
>> > +- clocks     :
>> > +       A list of phandle + clock-specifier pairs for the clocks listed
>> > +       in clock-names.
>> > +
>> > +- clock-names: Should contain the following:
>> > +       "core" - NFC module gate clock
>> > +       "clkin0" - Parent clock of internal mux
>> > +       "clkin1" - Other parent clock of internal mux
>> to give the devicetree maintainers some context on clkin0 and clkin1:
>> 
>> older SoCs (Meson8, Meson8b - not supported by this binding/driver
>> yet) had a dedicated NAND clock. there neither clkin0 or clkin1 would
>> be used, instead we just had a "nand" or "interface" clock (I'm not
>> aware of the actual naming in Amlogic's internal datasheets)
>> 
>> newer SoCs do NOT have a dedicated NAND "interface" clock anymore.
>> instead they are sharing the clock with the "sd_emmc_c" controller (I
>> *believe* the reason for this is because sd_emmc_c and the NAND
>> controller use the same pads on the SoC, pinctrl muxing controls where
>> these pads are routed -> NAND and sd_emmc_c cannot be used at the same
>> time, so SoC designers probably decided to re-use the clock)
>> 
>> unfortunately the sd_emmc_c clock is not provided by the "main" clock
>> controller on these newer SoCs
>> instead the clock is part of the MMC controller's register space (see
>> the SD_EMMC_CLOCK register in drivers/mmc/host/meson-gx-mmc.c)
>> even worse: the SD_EMMC_CLOCK contains more than just clock settings
>> (bit 25 enables the SDIO interrupt, which is currently not supported
>> by the meson-gx-mmc driver though)
>> 
>> the SD_EMMC_CLOCK register has a mux (CLK_SRC_MASK) to choose from
>> clkin0 and clkin1 which are passed here
>> the "amlogic,mmc-syscon" property is used to get a phandle to the
>> sd_emmc_c syscon register space
>> thus there is a bit of code duplication in the MMC and NAND drivers
>> with this binding (because both need to configure the SD_EMMC_CLOCK
>> register)
>
> Well, that's ugly. Really, the SD controller should be modeled as a 
> clock provider. But then you would have to always have a driver 
> instantiated for it. Maybe you need that anyway if accessing this 
> register is dependent on some other clock or reset to the module being 
> enabled (which you may not hit if you only access the reg during boot)?

On some earlier rounds of off-lis review, we did consider making the
SD/MMC controller a clock provider.  But forcing it to be instantiated
was kinda ugly too, especailly because there are several instances of
the MMC IP, and only one of them shares the clock with the NAND, so only
one of them needs to be a clock provider. :(

> But if you really want to do it this way, I guess that is fine.

Thanks.  We did consider a few options, and found this one to be the
least worst of a few options.

Kevin
