Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D64E20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uClpNe9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D64E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeLKNPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:15:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55050 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLKNPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:15:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2171018wmh.4;
        Tue, 11 Dec 2018 05:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dphSfbsjSZj33H3I+CK/0LfW2iFi3OYhO56M6vIsI50=;
        b=uClpNe9asttjvszCUsiV39H8Kgodo4oqJgCRPMw+72bAyVpIDkAi3sXtXLQP2MJFY/
         zNdOnmADxjZicTFHZksyLXmUhHdmI3/MRDWzPzcqyQabE6ZO/BDKuJoOQ4f4aoc+DNvv
         WA/fPVRnfXq43ih4iGYL/9l+JQHDr7Fe+6FDgjxoonBGtI93cJGh1oDSqcj7h9m1bxEH
         QOm3YbeBcHOZSFaxMXQ15T9+K+eBuWLh08A7FFsAwDBHHKskoPTdhY3cvU8b7J3Cx2sX
         vsd6VL4whnBcnOtJLNqkQBEj9WR/XZN3ouTRzRUO9n4+hF7XWXuiBLOShI8xkt6Q+DyN
         Gw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dphSfbsjSZj33H3I+CK/0LfW2iFi3OYhO56M6vIsI50=;
        b=KUpORnuKRB9U8kzLf+5OEhRUVbJf7+K4Jmo4jDUScBXBRnIAMM7ku5wb0LsZ+Isumk
         eGaOMIdQyRZpsQLCisaNECujiIOTouYhev1u+oyqn0EtU/nVF+HBpt5w6cbdLV3S6zIm
         rEF39HheZT21FdJdPUo97OMQjGtyGDy2gFFXtaiNhVPYEMxCuCTd4iciH/QpJODUqXRR
         ry/Qvq7x4lZh133TcDhC5KXARDIhvxDumQWZiz3HAlZHC3G0tMll2o2LZimsAiHR76XJ
         qafP4AVtyBeM5r9JClfywr0f8nUGKqv7fYcuYL9E/HvFkIu4uKJRXxIV40zN3MYMMck3
         8oXA==
X-Gm-Message-State: AA+aEWY/IHtCtXakXIzCQfABVTQqTKTB9noGCHRibzDauX6mGmXdyW6R
        FI/BL68Wfe5HJzo+J6TSUhQZL3W+ZZimDg2qsqtfow==
X-Google-Smtp-Source: AFSGD/Ub6247rZwplT7MfSNoqPP6WOkVdPxpyXyIXLPWhmqCoOQzWXcvFwkKfkgiqpPSoifQfbsJJU670NPvet2pIVo=
X-Received: by 2002:a1c:58ce:: with SMTP id m197mr2375364wmb.31.1544534109240;
 Tue, 11 Dec 2018 05:15:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <2bfe47f173fe72a30b0036dcdeebc2123962ff33.1544466940.git-series.plaes@plaes.org>
In-Reply-To: <2bfe47f173fe72a30b0036dcdeebc2123962ff33.1544466940.git-series.plaes@plaes.org>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Wed, 12 Dec 2018 00:14:57 +1100
Message-ID: <CAGRGNgX2d4u0HP2xLxcGhH2QkN-GdYZf4iKV_XAn53A8z0y8JQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/8] regulator: axp20x: add support for
 set_ramp_delay for AXP209
To:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Priit and Olliver,

On Tue, Dec 11, 2018 at 5:42 AM Priit Laes <plaes@plaes.org> wrote:
>
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> The AXP209 supports ramping up voltages on several regulators such as
> DCDC2 and LDO3.
>
> This patch adds preliminary support for the regulator-ramp-delay property
> for these 2 regulators. Note that the voltage ramp only works when
> regulator is already enabled. E.g. when going from say 0.7 V to 3.6 V.
>
> When turning on the regulator, no voltage ramp is performed in hardware.
>
> What this means, is that if the bootloader brings up the voltage at 0.7 V,
> the ramp delay property is properly applied. If however, the bootloader
> leaves the power off, no ramp delay is applied when the power is
> enabled by the regulator framework.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/regulator/axp20x-regulator.c | 85 +++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 9a2db28..1d9fa62 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -346,6 +357,79 @@
>                 .ops            = &axp20x_ops_range,                            \
>         }
>
> +static const int axp209_dcdc2_ldo3_slew_rates[] = {
> +       1600,
> +        800,
> +};
> +
> +static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> +{
> +       struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> +       const struct regulator_desc *desc = rdev->desc;
> +       u8 reg, mask, enable, cfg = 0xff;
> +       const int *slew_rates;
> +       int rate_count = 0;
> +
> +       if (!rdev)
> +               return -EINVAL;
> +
> +       switch (axp20x->variant) {
> +       case AXP209_ID:
> +               if (desc->id == AXP20X_DCDC2) {

Is slew_rates supposed to be set here?

> +                       rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> +                       reg = AXP20X_DCDC2_LDO3_V_RAMP;
> +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
> +                              AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
> +                       enable = (ramp > 0) ?
> +                                AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN :
> +                                !AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN;
> +                       break;
> +               }
> +
> +               if (desc->id == AXP20X_LDO3) {
> +                       slew_rates = axp209_dcdc2_ldo3_slew_rates;
> +                       rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
> +                       reg = AXP20X_DCDC2_LDO3_V_RAMP;
> +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
> +                              AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
> +                       enable = (ramp > 0) ?
> +                                AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN :
> +                                !AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN;
> +                       break;
> +               }
> +
> +               if (rate_count > 0)
> +                       break;

You could save one to two tests by combining the above three if statements, i.e.

if (DCDC2) {
    // set DCDC2 stuff

    break;
} else if (LDO3) {
    // set LDO3 stuff

    break;
}

As written, the rate_count > 0 test will never be true as every block
that sets rate_count breaks out of the switch block.

You could then calculate rate_count below the switch block.

> +
> +               /* fall through */
> +       default:
> +               /* Not supported for this regulator */
> +               return -ENOTSUPP;
> +       }
> +
> +       if (ramp == 0) {
> +               cfg = enable;
> +       } else {
> +               int i;
> +
> +               for (i = 0; i < rate_count; i++) {
> +                       if (ramp <= slew_rates[i])
> +                               cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
> +                       else
> +                               break;
> +               }
> +
> +               if (cfg == 0xff) {
> +                       dev_err(axp20x->dev, "unsupported ramp value %d", ramp);
> +                       return -EINVAL;
> +               }
> +
> +               cfg |= enable;
> +       }
> +
> +       return regmap_update_bits(axp20x->regmap, reg, mask, cfg);
> +}
> +



-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
