Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF38CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CE42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CE42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeLENPx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:15:53 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38686 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeLENPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:15:52 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so12021432vsa.5;
        Wed, 05 Dec 2018 05:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yJGQWX7BCfclkTNr/FN7ojD2pX7oQB6h++MHlYXRt+g=;
        b=PUEpPrjx5WZpkoRXO7SvbCZtaxW+7/boyCViFZumIKwWwfUc/WKG3W1wHM2D0DChZU
         RxAAuAhHpDJ5wXnZAFnfGxMN+w5wJtm8JDp88a77WdZyx9QXSCv6zswPzywSOwruK22+
         PK/CKkLTHS1IQ4/vag/prizFPDZtiHbc6lK/aiLBKRJz9111y/6YcIy9LYiSujrq7UKk
         nww3eQTAP13TXaqEMTXODUJIBfNJ6F56vvoNwa/Yg1PC8HwuQCdSck3rPPEvGn58wamD
         55VF01jIZKUN6tQ+PuAYpqjfD2k2vbRJBxTqt1HMUi+dRofRIKHZiyn4jPdESeGucR62
         IoPw==
X-Gm-Message-State: AA+aEWYps4JFrBhE0DIP9/9HvFIObdqkmMX+Rym+++cflJcdIAti9saZ
        x4gdVvOQB/t3Q5EwZsDjngSlONoAI4TEjmfQOeo=
X-Google-Smtp-Source: AFSGD/VQ2DIbQP0tKN1X+cCVbcDxQBXPuk+L1L24XxHafqwwSHbxRLnwwTx1LakbWxo3PdvkNehBbfzSTkLhGLRtJKA=
X-Received: by 2002:a67:f43:: with SMTP id 64mr10771627vsp.166.1544015750923;
 Wed, 05 Dec 2018 05:15:50 -0800 (PST)
MIME-Version: 1.0
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com> <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
In-Reply-To: <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Dec 2018 14:15:37 +0100
Message-ID: <CAMuHMdV-Ca5sderSKmdbtovKrd-Z7piwVZbwDtB6vVXPa8Q5AA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     masonccyang@mxic.com.tw,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Wed, Dec 5, 2018 at 1:57 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 12/05/2018 08:44 AM, masonccyang@mxic.com.tw wrote:
> >> "Marek Vasut" <marek.vasut@gmail.com>
> >> 2018/12/05 上午 10:04
> >> On 12/03/2018 10:18 AM, Mason Yang wrote:
> >> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> >> >
> >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

> >> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> >> > +{
> >> > +   /*
> >> > +    * NOTE: The 0x260 are undocumented bits, but they must be set.
> >> > +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> >> > +    *   0x0 : the delay is biggest,
> >> > +    *   0x1 : the delay is 2nd biggest,
> >> > +    *   0x3 or 0x6 is a recommended value.
> >> > +    */
> >>
> >> Doesn't this vary by SoC ? I think H3 ES1.0 had different value here,
> >> but I might be wrong.
> >
> > I check the Renesas bare-metal code, mini_monitor v4.01.
> > It set 0x03 or 0x0 and I test them w/ 0x0, 0x3 and 0x6 are all OK.
>
> Shouldn't this somehow use the soc_device_match() then and configure it
> accordingly for various chips ? Like eg. the r8a7795-cpg-mssr driver does.

Please don't use soc_device_match() for per-SoC configuration, if
you already have of_device_id.data.

BTW, this drivers support r8a7795 only (for now), as per the compatible
value.

> >> > +#ifdef CONFIG_RESET_CONTROLLER
> >>
> >> Just make the driver depend on reset controller.
> >
> > ?
> > please refer to
> > https://github.com/torvalds/linux/blob/master/drivers/clk/renesas/renesas-cpg-mssr.c
> >
> > line 124 ~ 126
>
> This seems like a stopgap measure for systems which do not have a reset
> api compatible controller. Geert ?

So far CONFIG_RESET_CONTROLLER is optional.


> >> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> >> > +            const void *tx_buf, void *rx_buf)
> >> > +{
> >> > +   u32 smenr, smcr, data, pos = 0;
> >> > +   int ret = 0;
> >> > +
> >> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> >> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> >> > +              RPC_CMNCR_BSZ(0));
> >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
> >> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> >> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> >> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
> >> > +
> >> > +   if (tx_buf) {
> >> > +      smenr = rpc->smenr;
> >> > +
> >> > +      while (pos < rpc->xferlen) {
> >> > +         u32 nbytes = rpc->xferlen  - pos;
> >> > +
> >> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
> >> > +                 *(u32 *)(tx_buf + pos));
> >>
> >> *(u32 *) cast is probably not needed , fix casts globally.
> >
> > It must have it!
>
> Why ?

Else you get a compiler warning, as tx_bug is void *.

> >> > +#ifdef CONFIG_PM_SLEEP
> >> > +static int rpc_spi_suspend(struct device *dev)
> >> > +{
> >> > +   struct platform_device *pdev = to_platform_device(dev);
> >> > +   struct spi_master *master = platform_get_drvdata(pdev);
> >> > +
> >> > +   return spi_master_suspend(master);
> >>
> >> Won't the SPI NOR lose state across suspend ? Is that a problem ?
> >
> > I don't think so.
> > Because when the device is not in operation and CS# is high,
> > it is put in stand-by mode.
>
> Is the power to the SPI NOR retained ?

Not if PSCI system suspend turns of power to the SoC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
