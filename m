Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A25C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 22:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A3C24D59
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 22:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ii0iwCvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A3C24D59
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeFWWrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 18:47:13 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34479 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeFWWrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 18:47:11 -0400
Received: by mail-oi0-f67.google.com with SMTP id i205-v6so9268120oib.1;
        Sat, 23 Jun 2018 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vUYcKNR6gCfticAfSjv5F0245/HU36Q/4+62ZTdgUI=;
        b=Ii0iwCvGXKQ0DFbaxEVb5la1CjmIdRHZw0n3ruPL8rTwFxj4yrShL4jP/pipAbjsmG
         XQnrbiD3flxVID43b/Q4kT/I7ucF7fXrzarRG/J9uvID1JXxg2Qxgc96itgGnvc2p+0f
         0QrqqrjbaRimzcBq3KObj8L5ihiHJB+tlwh1yUehA2QPS/ShhupRkUmPO7iZlCTVZOSF
         4+KtX+6Ls2PYTearh/mINboV2B4r/uO0gV6+4B+Zz4xToPAvbSDQ2tSbUnKS9fga9HOw
         rqYrx6a30jMcrPewDtukgccKVWBMYoFrYT7V+IaC6u5jkrvPhHSXfoVsFC7t/7bJyhrY
         J6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vUYcKNR6gCfticAfSjv5F0245/HU36Q/4+62ZTdgUI=;
        b=T18i/74fpir6RvWR2UVQQfWH3RvD7m0OUBhrMjJBx65B8qfRDduC3llonXSGI8CWLc
         kQmDvW5CSyq99ri/lyloxthbW1uIElZJ5Zi51QadsnHJ41MPJZS2TANUqIJ2nGOrVL49
         genMhop28EelAWCt2kv1cMck5kJZ+9YVGqXPCsa05IvnMEOxJOLV969J+oM8aVpO+HZp
         HFkBEyqlGqA1WTlMJRsaAAwS53uPEcJJH4VOAOpYgRjMvEULrqO9zZ+u806vyurHkoSr
         XQ79MxCEiaYyxKElZKQm6kh2bAj9LmwSXcDe3+iNyOiE1BMl3hjhnx5QUw8VWmLC50uU
         Ou9w==
X-Gm-Message-State: APt69E0znCMrxZTFtbeid7BjYlhF1QG5IkPvTAyPTIHO1UZSAxqsRAJG
        dhRWO/G1zPFXtkEl09wCLRk9SPI4gYsGs5o0Eq4=
X-Google-Smtp-Source: ADUXVKJ9z405IvaJApgj7cIvl0gsGg0HoT7CVxUk1HyH5gvbCbCmx0il1ftJKfvyVway1aAdQrjiN40+mjEjhUP1X08=
X-Received: by 2002:aca:ed8c:: with SMTP id l134-v6mr3593469oih.65.1529794030979;
 Sat, 23 Jun 2018 15:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180613161314.14894-1-yixun.lan@amlogic.com> <20180613161314.14894-2-yixun.lan@amlogic.com>
In-Reply-To: <20180613161314.14894-2-yixun.lan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 24 Jun 2018 00:46:59 +0200
Message-ID: <CAFBinCBeyXf6LNaZzAw6WnsxzDAv8E=Yp2eem0xCPWMEUi6pnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: nand: meson: add Amlogic NAND controller driver
To:     yixun.lan@amlogic.com
Cc:     linux-mtd@lists.infradead.org, robh@kernel.org,
        boris.brezillon@bootlin.com, richard@nod.at,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        devicetree@vger.kernel.org, liang.yang@amlogic.com,
        jian.hu@amlogic.com, khilman@baylibre.com, carlo@caione.org,
        linux-amlogic@lists.infradead.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yixun, Hello Liang,

I have a few small comments inline below
additionally I tried to explain the reason behind
"amlogic,mmc-syscon", clkin0 and clkin1 so Rob (or the devicetree
maintainers in general) can give feedback. feel free to correct me
wherever I'm wrong or provide additional notes in case I missed
something!

On Wed, Jun 13, 2018 at 10:17 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> From: Liang Yang <liang.yang@amlogic.com>
>
> Add Amlogic NAND controller dt-bindings for Meson SoC,
> Current this driver support GXBB/GXL/AXG platform.
>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> new file mode 100644
> index 000000000000..eac9f9433d5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> @@ -0,0 +1,118 @@
> +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> +
> +This file documents the properties in addition to those available in
> +the MTD NAND bindings.
> +
> +Required properties:
> +- compatible : contains one of:
> +  - "amlogic,meson-gxl-nfc"
> +  - "amlogic,meson-axg-nfc"
the patch description states that GXBB/GXL/AXG are supported
shouldn't you add a compatible string for GXBB as well?

> +- clocks     :
> +       A list of phandle + clock-specifier pairs for the clocks listed
> +       in clock-names.
> +
> +- clock-names: Should contain the following:
> +       "core" - NFC module gate clock
> +       "clkin0" - Parent clock of internal mux
> +       "clkin1" - Other parent clock of internal mux
to give the devicetree maintainers some context on clkin0 and clkin1:

older SoCs (Meson8, Meson8b - not supported by this binding/driver
yet) had a dedicated NAND clock. there neither clkin0 or clkin1 would
be used, instead we just had a "nand" or "interface" clock (I'm not
aware of the actual naming in Amlogic's internal datasheets)

newer SoCs do NOT have a dedicated NAND "interface" clock anymore.
instead they are sharing the clock with the "sd_emmc_c" controller (I
*believe* the reason for this is because sd_emmc_c and the NAND
controller use the same pads on the SoC, pinctrl muxing controls where
these pads are routed -> NAND and sd_emmc_c cannot be used at the same
time, so SoC designers probably decided to re-use the clock)

unfortunately the sd_emmc_c clock is not provided by the "main" clock
controller on these newer SoCs
instead the clock is part of the MMC controller's register space (see
the SD_EMMC_CLOCK register in drivers/mmc/host/meson-gx-mmc.c)
even worse: the SD_EMMC_CLOCK contains more than just clock settings
(bit 25 enables the SDIO interrupt, which is currently not supported
by the meson-gx-mmc driver though)

the SD_EMMC_CLOCK register has a mux (CLK_SRC_MASK) to choose from
clkin0 and clkin1 which are passed here
the "amlogic,mmc-syscon" property is used to get a phandle to the
sd_emmc_c syscon register space
thus there is a bit of code duplication in the MMC and NAND drivers
with this binding (because both need to configure the SD_EMMC_CLOCK
register)

> +
> +- pins     : Select pins which NFC need.
> +- nand_pins: Detail NAND pins information.
> +               nand_pins: nand {
> +                       mux {
> +                               groups = "emmc_nand_d0",
> +                                       "emmc_nand_d1",
> +                                       "emmc_nand_d2",
> +                                       "emmc_nand_d3",
> +                                       "emmc_nand_d4",
> +                                       "emmc_nand_d5",
> +                                       "emmc_nand_d6",
> +                                       "emmc_nand_d7",
> +                                       "nand_ce0",
> +                                       "nand_rb0",
> +                                       "nand_ale",
> +                                       "nand_cle",
> +                                       "nand_wen_clk",
> +                                       "nand_ren_wr";
> +                               function = "nand";
> +                       };
> +               };
> +
> +- amlogic,mmc-syscon   : Required for NAND clocks, it's shared with SD/eMMC
> +                               controller port C
> +
> +Optional children nodes:
> +Children nodes represent the available nand chips.
> +
> +Optional properties:
> +- meson-nand-user-mode :
> +       only set 2 or 16 which mean the way of reading OOB bytes by NFC.
as far as I know vendor specific properties should follow the naming
schema "vendor,purpose"
in this case this would be "amlogic,nand-user-mode"

maybe Rob can comment on this?

> +- meson-nand-ran-mode :
> +       setting 0 or 1, means disable/enable scrambler which keeps the balence
> +       of 0 and 1
I assume 0 and 1 are the only possible values.
to use of_property_read_bool in the driver the property would be either:
- (absent) = scrambler is disabled
- amlogic,nand-enable-scrambler (without any value - also same comment
as above for the value) = scrambler is enabled


Regards
Martin
