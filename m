Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F66C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7FA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u+LrDzRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfA3JOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:14:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45200 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfA3JOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:14:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so18594391oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BaQpOeJGdEz7IbhHokNW6p6OJpPJD2oq5IUtu8Txer8=;
        b=u+LrDzRrciq5AsFTREKMaDeQF/zo0jnk1/lmi8GliP9SeF1fI+u5Z66odPASnccfh2
         qN7xVz0z2olZ0mg4ouivLDtNWQli1L+Niwd/DJeFz15fE4P5kJCsLLFwY/pnhxEqMDkZ
         IFhLH+HXB1hDmMwwST7afUr28kXTv9KKUmPy3D4IMqDF6ZqPEnPV1JsMMV7vFTqWXtAp
         cC+tZjRgNPK51AV8G5yc0nLyDdwZCnxAlBJxsS3iELXUSR4okpei9Ycw+QNNfprVb56B
         JdY1LIrpByR9FA8pwHzIZnmu8aiMbP7YhXn/sVl/Uc56B9qNWY4ucGx4y7utDjMkXcVh
         BjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BaQpOeJGdEz7IbhHokNW6p6OJpPJD2oq5IUtu8Txer8=;
        b=Ar9nFnB19tspUCp5KKQ5Ht7JFT/LXsTa51CwtyTNDV3qLfEAAq4myAqAnBkP6WemCx
         fHvr02ghFitiPGsBeXyLQAG6obEiJnV00fYw2y1Yh68N+0qWLAAGesJ8C6qSGz1TyKu7
         JCPfoWhIsStMCm8fNHpVF31D0i0X1rjX5L95d75SiaubutV1tb8I1tVJsE3WhLtOWagl
         hmo2oFyssV/umw4VJceeKDss/AdZSocysr+9r2MuJMsuYGodJWInIqhPaP4QJC+ZHGjx
         QwNRyr1V0WouFMbKiuZsrvIVDAU/p413VVO0gZUsEyY1ZdwXKmyQ9EQtt1uadfSLsvpI
         p65w==
X-Gm-Message-State: AJcUukeTDexd4amJp9HFIMiIuP7kMLyQvgnmlUhJasXmmeeeJD4vLFKz
        z4iDoYxsyudu4YmwHuKZjSf9VyuCQzczbL1DhcPkBvv5VE8=
X-Google-Smtp-Source: ALg8bN5c+SpiGdEcoDpN9zCMBkSlPRDm/XF3n3jHFpszJKmmS4D0iO5keTeRuasvbxTOKOL5THWi9vq9kkGm4McMTuU=
X-Received: by 2002:aca:1e17:: with SMTP id m23mr12178482oic.332.1548839641708;
 Wed, 30 Jan 2019 01:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20190130090722.24134-1-axel.lin@ingics.com>
In-Reply-To: <20190130090722.24134-1-axel.lin@ingics.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 30 Jan 2019 10:13:51 +0100
Message-ID: <CAMpxmJX3hRPx1WWBfqLDHbsWG7wSXQWTsskOjQ=-eVNgh6A6RQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: max77650: Fix include files
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

=C5=9Br., 30 sty 2019 o 10:07 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a=
):
>
> This is a platform driver, no need to include linux/i2c.h.
> Include linux/of.h for of_match_ptr.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/max77650-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/m=
ax77650-regulator.c
> index 474f2c02f2d5..5afb91400832 100644
> --- a/drivers/regulator/max77650-regulator.c
> +++ b/drivers/regulator/max77650-regulator.c
> @@ -5,7 +5,7 @@
>  //
>  // Regulator driver for MAXIM 77650/77651 charger/power-supply.
>
> -#include <linux/i2c.h>
> +#include <linux/of.h>
>  #include <linux/mfd/max77650.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> --
> 2.17.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
