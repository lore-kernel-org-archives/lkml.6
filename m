Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E148620700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sqm5I3p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfBVJQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:16:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44283 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfBVJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:16:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id a81so1172681oii.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9s9sENDVvcQk4+5EmVMidR0j8JyqjATq/o7SGgapacY=;
        b=sqm5I3p0Upvvrs+vn7pf/xGxX/4AO2YhlQnyJ5UmoVDvjWgAOsuhC8GQtSpTqGlvte
         HgBTbhx6pwx1v4f1dPGHaq20qFD6XjRDIznUdrTT7BmPo96FOCDRAHvUMu37NJu/2d8X
         oo8iL5F0MMSu4EiEpw/aVKZ+CAnr6vml1Loa2WPn0J1jTQ/50NBzE0o3EUBEzIUT904s
         ExQdG3sz8jj0mM7YzChHMxJ8/HRSFCmUZULkWHsyfAeqHwCMG9uI9C3w3CyKg1KtPFqn
         d4skoOJ3K6yR/2CluZRMFlxZ95q9OhpmF0sCvdWEhm5r93E/qziVa5TbmPzNKsV0o8NU
         +p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9s9sENDVvcQk4+5EmVMidR0j8JyqjATq/o7SGgapacY=;
        b=HFj2okxJCGm2fz87TUNEH2MiTyQNzp3IrVXCe8mJcvXvx9RHSM99roeQzXFWqqfrxk
         PEwcOZwpwh/QCYIpP2QUPrtwu4xzp0armAFzCse9Xqzyn5oX5C6JXz2sDD+TmRDdpwXq
         wf/1bpVbRlP35R376ZdH/Uq+tAOIkD1abf2ptdtCOPMpC3TT/qC/SSMmxfrD3ferqNIh
         Jeq7+brxahTExCtaZ5vsxWRS6ObGfbp7cdc76+iPRWMtgNKwo1JwkScCFGkYRva1k5x4
         EiAEWrIZvUNNYk2Vg+crEWVfWYcFrSjQNRcPACbmvBon0HHJkY49RcCit5z8DkfkK8BO
         36dQ==
X-Gm-Message-State: AHQUAuaFGvMiKQjUpCWTrJ+YycNCLW1wb1V0U+/jSMKYKeSh+9V7DNhp
        VgBv3EhWK8XEEOrhk3crRMm92e4Are/xLLmRF2J+HA==
X-Google-Smtp-Source: AHgI3IYwm5ULFstm7arWhnWohA3b1ClqsYuMN3evOkm8n2kJXkPyFBItFN8fQ86x/O7oKv2BpRSdbRMuKxkpWXCJ28M=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr1942368oii.170.1550827005569;
 Fri, 22 Feb 2019 01:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20190222090921.2068-1-axel.lin@ingics.com>
In-Reply-To: <20190222090921.2068-1-axel.lin@ingics.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 22 Feb 2019 10:16:34 +0100
Message-ID: <CAMpxmJXTX7RcBqXziFuvmUvZWyWfBaRYmoEORm48mhbF-HN5ZQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Fix set_current_limit implementation
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 lut 2019 o 10:09 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a):
>
> Current code always return error, fix it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/max77650-regulator.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/m=
ax77650-regulator.c
> index 411912d5278b..a1af414db751 100644
> --- a/drivers/regulator/max77650-regulator.c
> +++ b/drivers/regulator/max77650-regulator.c
> @@ -243,7 +243,7 @@ static int max77650_regulator_set_current_limit(struc=
t regulator_dev *rdev,
>  {
>         struct max77650_regulator_desc *rdesc;
>         struct regmap *map;
> -       int rv, i, limit;
> +       int i, limit;
>
>         rdesc =3D rdev_get_drvdata(rdev);
>         map =3D rdev_get_regmap(rdev);
> @@ -252,11 +252,9 @@ static int max77650_regulator_set_current_limit(stru=
ct regulator_dev *rdev,
>                 limit =3D max77650_current_limit_table[i];
>
>                 if (limit >=3D min_uA && limit <=3D max_uA) {
> -                       rv =3D regmap_update_bits(map, rdesc->regA,
> +                       return regmap_update_bits(map, rdesc->regA,
>                                         MAX77650_REGULATOR_CURR_LIM_MASK,
>                                         MAX77650_REGULATOR_CURR_LIM_SHIFT=
(i));
> -                       if (rv)
> -                               return rv;
>                 }
>         }
>
> --
> 2.17.1
>

Thanks for spotting that!

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
