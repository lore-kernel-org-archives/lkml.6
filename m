Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B333FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBBF2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UujQ3IVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBBF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeJOSO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:14:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40740 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOSO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:14:28 -0400
Received: by mail-it1-f194.google.com with SMTP id i191-v6so26928016iti.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sSXtiDuCCaI2hcCx44yKcXUbp9izKXoYmZW203wptsk=;
        b=UujQ3IVaXFiuzoJVGekA7KleZXV5bAEnHoEkfmbYUHhbqr+/N+oFnFEI43wR55UHNF
         U6tDFeWnWrWnDomtqZdhHRHD8baI6lqsBACpu7p4jtYH4y8woQFhbCYai2DHNFA7H5dw
         tYJjaHQbLTCIIK5b20OkuL4p90fWZrF8VgwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sSXtiDuCCaI2hcCx44yKcXUbp9izKXoYmZW203wptsk=;
        b=WcMOwlnSYS4pNFL4TatcBua0KSMuMbJOw/gxv/wXlo+UUgHAN2shmmF7i9dSgr9opN
         1bEChv9AfNegWpidxSp1jycmT7nbTmp2uTaRcx9qyn2MxcL2Z3wTdz9Yqg+Ltif1tRsu
         bms5yOZFnJVuTyXCmr2OVsRxmkPOuNAlQM2A7LOvm77iPbvsz/PirknA/vf/fLpWjlRs
         aWAMCjgflx2RUFxPHCyCTdSMoVanAc6IOVZHlW0LXDehj5vTfeL4OfOBdiKz7g0jE8Uh
         8aoLqO6Y7/a5PaOmgmMWZdCFdXDx3KY0ChO8jAZV13WQOZs4g0oEPNFpTWdoxf9g7WkV
         w6HA==
X-Gm-Message-State: ABuFfogKgIQsqZ99C10HR8BNJrWWVlYKk8s6p2YieM+rciQpHr0CdCoS
        /+sxOiqFuLyMOGde33p01PRo+ckz81d358Lq9FiOPA==
X-Google-Smtp-Source: ACcGV60Fp61kj+Vyw+JuAvIGOO8YDLJhZo+AWMDbM8749fBNgxoX4dmpMWM49emV9AXK/BhNRvaW+WyErsb6eE1GZHo=
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr11502004itb.78.1539599388601;
 Mon, 15 Oct 2018 03:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 03:29:08
 -0700 (PDT)
In-Reply-To: <20181012190901.1243-1-jmkrzyszt@gmail.com>
References: <20180925192433.1377-1-jmkrzyszt@gmail.com> <20181012190901.1243-1-jmkrzyszt@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 12:29:08 +0200
Message-ID: <CAPDyKFo+wbVRAZuSvTTVQ1Poy8eLXO3yt_Ss30dC+Edab9L38Q@mail.gmail.com>
Subject: Re: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kukjin Kim <kgene@kernel.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 21:09, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The new code introduced into
> mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, only member 0 of the array is handled correctly.
>
> Moreover, wrong assumption is taken about the 'values' bitmap size not
> exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Hi,
>
> I think that patch has been missed while we were resolving issues
> related to GPIO fast bitmap processing.  Since all issues other than the
> one addreessed by this patch have been been hopefully identified and
> fixed, GPIO tree seems now to be in good shape in regard to that.
> However, I believe pwrseq_simple is still broken.  Hence, I'm
> resubmitting this patch to Ulf for inclusion in MMC tree, Cc: many other
> people who are kindly requested to test it if possible.
>
> I've identified the following DT files representing devices which may be
> affected (have more than one GPIO assigned to pwrseq_simple):
> - arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
> - arch/arm/boot/dts/exynos5250-snow-common.dtsi
> - arch/arm/boot/dts/imx6sl-warp.dts
> - arch/arm/boot/dts/omap3-igep0030.dts
> - arch/arm/boot/dts/omap3-igep0020.dts
> - arch/arm/boot/dts/rk3036-kylin.dts
> - arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> - arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
>
> Please start with checking if pwrseq_simple from linux-next works for
> you and if not, please test if this patch fixes the issue.
>
> Thanks,
> Janusz
>
>
>  drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 7f882a2bb872..ece34c734693 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>         struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>
>         if (!IS_ERR(reset_gpios)) {
> -               DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +               unsigned long *values;
>                 int nvalues = reset_gpios->ndescs;
>
> -               values[0] = value;
> +               values = bitmap_alloc(nvalues, GFP_KERNEL);
> +               if (!values)
> +                       return;
> +
> +               if (value)
> +                       bitmap_fill(values, nvalues);
> +               else
> +                       bitmap_zero(values, nvalues);
>
>                 gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>                                                reset_gpios->info, values);
> +
> +               kfree(values);
>         }
>  }
>
> --
> 2.16.4
>
