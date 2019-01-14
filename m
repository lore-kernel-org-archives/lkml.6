Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D2BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B341620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ3eF7Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfANLn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:43:28 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38579 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:43:27 -0500
Received: by mail-vk1-f196.google.com with SMTP id w72so4772003vkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLHmEQqa2x/EGqvUp0veNjwTBHRLqBj786YkUdevd6Y=;
        b=OJ3eF7Q/5Plk/Ct0HEYDJaEeORICjfjGgOm8EMhlDLf9gQzEEkWeST7k48JhkRX49I
         cLNK3xx1+ZJxjHu3bE8yB4sWVpzsSPiRurNNjwzc2jWqk1fOIeuQWOgRjXQrQlg2WWIu
         yKtmS36ETOgzUpvum/pobh+0oyXUqwoFIbeIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLHmEQqa2x/EGqvUp0veNjwTBHRLqBj786YkUdevd6Y=;
        b=WvvvcbyOdKph/qDKL9dodr06Lwd0riXw+GsJrV8UdibATCTbTffAWO98kjEUuOVVYH
         9EQJEJ5ZYcLf4sBUtRZc6Wn6jTmK5ivGZJ/tSzmYHReynrfGvt2decwiWHgORNkH3l5P
         1rE0woqDpxpOa7CyOK2wSVDKMOoMJB6QeG4jI3XH6e8JTaEHgWvnMbCGBF6YYaWjhXyw
         Y6w9y2FBWhLiTVez89DLt5roF9TRt71ECHIdzzFnSc6C4bhkJpLe5/WJXHR2wjkDqZr5
         i7U4fNJ+7ZCgXxMUGAS/kNKDjAbArf0cvu1tusTgO59WlQG5QlTFKPdo93wxdaTiuwiR
         A+og==
X-Gm-Message-State: AJcUukchW9RQPE7KjNq2fWVqveqV2xMSIIgQvLYUNr6tlIbKrhxJ6YSo
        2fz1sArLzmiMJ2jUohoQZPsy+vyHXc94XqUwvWahag==
X-Google-Smtp-Source: ALg8bN7zE1r7qkWSwCs265qTX8lZaBXUDw6Swp2jIciXdeLtzwmHTzsO6dXsp2UKjhgSUiXTRLjOlAbYsVi2JQVK+Qc=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr9157633vka.4.1547466206597;
 Mon, 14 Jan 2019 03:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20181218232652.12700-1-andrew.smirnov@gmail.com>
In-Reply-To: <20181218232652.12700-1-andrew.smirnov@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jan 2019 12:42:50 +0100
Message-ID: <CAPDyKFo5+aEmKjORs_h3Ts_-thRBnuBhc7M+F2m3mkXEiUqLJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Constify driver data
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 00:27, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Variant specific driver data doesn't change at run-time, so mark it as
> const to reflect that.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied for next, thanks!

Kind regrads
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f44e49014a44..39ace4f1036b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -148,38 +148,38 @@ struct esdhc_soc_data {
>         u32 flags;
>  };
>
> -static struct esdhc_soc_data esdhc_imx25_data = {
> +static const struct esdhc_soc_data esdhc_imx25_data = {
>         .flags = ESDHC_FLAG_ERR004536,
>  };
>
> -static struct esdhc_soc_data esdhc_imx35_data = {
> +static const struct esdhc_soc_data esdhc_imx35_data = {
>         .flags = ESDHC_FLAG_ERR004536,
>  };
>
> -static struct esdhc_soc_data esdhc_imx51_data = {
> +static const struct esdhc_soc_data esdhc_imx51_data = {
>         .flags = 0,
>  };
>
> -static struct esdhc_soc_data esdhc_imx53_data = {
> +static const struct esdhc_soc_data esdhc_imx53_data = {
>         .flags = ESDHC_FLAG_MULTIBLK_NO_INT,
>  };
>
> -static struct esdhc_soc_data usdhc_imx6q_data = {
> +static const struct esdhc_soc_data usdhc_imx6q_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING,
>  };
>
> -static struct esdhc_soc_data usdhc_imx6sl_data = {
> +static const struct esdhc_soc_data usdhc_imx6sl_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
>                         | ESDHC_FLAG_HS200,
>  };
>
> -static struct esdhc_soc_data usdhc_imx6sx_data = {
> +static const struct esdhc_soc_data usdhc_imx6sx_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>
> -static struct esdhc_soc_data usdhc_imx7d_data = {
> +static const struct esdhc_soc_data usdhc_imx7d_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_HS400,
> --
> 2.19.1
>
