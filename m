Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE988C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DA42082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q+xfrl/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfAPI1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:27:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34484 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388644AbfAPI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:27:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so824055otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CvTpH+csN9DqGl2AzefMvzmxWEH9AM8kFMvWr30SQkg=;
        b=Q+xfrl/Csl5/C3SvvbmiXfuVCzMg7WgeoMzI1QyEHBFQ4YiQHjoc7k2FizfQ7hVqy2
         mJ4DmRoSN1rVe5x++ZK5HIQyMsettB27vPRvLUkqgEY9PI843O2S4+IsGII5tVj6m89R
         6eDemZSk3Nn+f6aTmdhRBi+KXh+OK1kpwKEkO+S9rVv/nMKskaMPIB3P3tYOkZFgwJ0j
         cIjkkYSvN67y8qeQjjdXpxLjC1rcG7/TYe6SAwFY36jXFzT4tKb240f/E0BbJxa2BvPH
         uzCUPk5YFt2CRbr4+02q5WYGkv3ecdAgMFbvF0U0ALHasRp2Cm1E4/1nvdcpPKWau/tB
         BRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CvTpH+csN9DqGl2AzefMvzmxWEH9AM8kFMvWr30SQkg=;
        b=fNj096auflbG0tJaqBOCGKp1DyWKgWGCDQjH/OGNNGXq3g8CLn1bL3Lwpw8gzPDJhQ
         jD1joXU78MwI4cRNIjKCqWy+LyckvhgIGNxXbzh6aE9UzMTUlym8QPXtGHS8UL+iS6oM
         VNx4e9lciq9gJ+6yw7VDR9d85h2MhLzenASlEcAbDa4fgbIYePprNhyifmrNNI16rcDR
         DkF6gVuBVmwMK4HPtXRLV2hUdZONM0FyT2tfT8uDqK+J2An9gETf2nU3kAWN9C1k47vh
         L9Uw5XCLPyFXJ3T3kQTuxEHHKzJ8mtHwULOCmrBjamrmG2Sdtk7hpTeFyg44FbZEGjQa
         1dDw==
X-Gm-Message-State: AJcUukemlHYncJ6yY7CKtjB+jYb0Vyknf9ZvJVzovjFqxDxlHiZMCTqF
        r74obgDTI+zfPiRxNNdlXY2yLlHjti2lcQM3izL5kA==
X-Google-Smtp-Source: ALg8bN7590Awde7Gc8fNKatQTRKO+PWrz+HvtVl0vHbMzTZ92j2OH3zVhA6KVbAm8jehfa0/yXCp3W2N8AsD7ZBBV2A=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr4600874otj.301.1547627259383;
 Wed, 16 Jan 2019 00:27:39 -0800 (PST)
MIME-Version: 1.0
References: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
In-Reply-To: <24594f8799f6aabdeaad3935fe36d832fb465148.1547615070.git.baolin.wang@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 16 Jan 2019 09:27:28 +0100
Message-ID: <CAMpxmJWamqR23xsWQZgkPO7sOEWrvKER4niG2brndCZGpsZChw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: sprd: Fix the incorrect data register
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, neo.hou@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 sty 2019 o 06:06 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
>
> From: Neo Hou <neo.hou@unisoc.com>
>
> Since differnt type EICs have its own data register to read, thus fix the
> incorrect data register.
>
> Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Add fix tag and CC stable.
> ---
>  drivers/gpio/gpio-eic-sprd.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index e0d6a0a..257df59 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -180,7 +180,18 @@ static void sprd_eic_free(struct gpio_chip *chip, un=
signed int offset)
>
>  static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
>  {
> -       return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
> +       struct sprd_eic *sprd_eic =3D gpiochip_get_data(chip);
> +
> +       switch (sprd_eic->type) {
> +       case SPRD_EIC_DEBOUNCE:
> +               return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
> +       case SPRD_EIC_ASYNC:
> +               return sprd_eic_read(chip, offset, SPRD_EIC_ASYNC_DATA);
> +       case SPRD_EIC_SYNC:
> +               return sprd_eic_read(chip, offset, SPRD_EIC_SYNC_DATA);
> +       default:
> +               return -ENOTSUPP;
> +       }
>  }
>
>  static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned int=
 offset)
> --
> 1.7.9.5
>

Both applied for fixes, thanks!

Bartosz
