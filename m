Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91279C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D6F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lpWYcu2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfA3GEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:04:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40760 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfA3GEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:04:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so18008178edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=aJTjGP6xuRvN5ml+k+nOAP5sZjlzx1oTAMIdkprynv0=;
        b=lpWYcu2O8idu2AvZOES6EGCS7R4zW9JSKzrx9qM1j8xVnuOT6vBc2iqeD9SmfZnl5y
         yU5/U3BhAzV37UBcpsLgX6MWgQJBp/JNKOZqSV/iOsXFa4SHy2uerRdb7Sx3yP4PiCsv
         wL/i9LVhnh0CTokQkNmy4WGalv1r2zg7K+txY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=aJTjGP6xuRvN5ml+k+nOAP5sZjlzx1oTAMIdkprynv0=;
        b=VtegwtzFHeGB01LcjzcRXwjJ7J9lxvwTYHuEJBmTPLEb96pospz5J3VfHwDHrO7m3E
         uGNkslRS1G5biDAot6qyEYCTofSfqWnoleoh63rnjigpUHAirJcxVxQzfFM4T/W887Mj
         0i9MLReFp9zk5qz7fUwVGdzL9mwbaEDOw+NKk/33oORBT3/+2x5koOlpx+MJ2h24Ndyl
         QvdCIDvrn0xa2LTM9Jv8kejretrgqXkWdhhdWOA/UgbT6HxxeLDjXBJ6tNMfCqGIIKaM
         y1E1XaT4ase0VZanzfpOSQR2qUNEF4srbNK+Wb4uvN26oftJKPBrQIcSujvjsyVphf8x
         J+nw==
X-Gm-Message-State: AJcUukfeUgtXcPHY38twRqbeT8kZO0uBJZuLq4XzfAfjhRD8bR4JgrN6
        cjr4YHfSnnGdg2BjHerJiuBkvyeqZIT7mItty+7jCg==
X-Received: by 2002:a50:f5af:: with SMTP id u44mt25022648edm.172.1548828292400;
 Tue, 29 Jan 2019 22:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20190109055724.184692-1-pihsun@chromium.org>
In-Reply-To: <20190109055724.184692-1-pihsun@chromium.org>
From:   Peter Shih <pihsun@chromium.org>
Date:   Wed, 30 Jan 2019 14:04:40 +0800
Message-ID: <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael.Kao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Michael Kao to cc list.

On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
> which cause out of bound access with the ->banks[] member. Change it to
> a fixed size array instead.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/thermal/mtk_thermal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0691f260f6eabe..ea11edb3fcced6 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -159,6 +159,9 @@
>  #define MT7622_NUM_SENSORS_PER_ZONE    1
>  #define MT7622_TS1     0
>
> +/* The maximum number of banks */
> +#define MAX_NUM_ZONES          8
> +
>  struct mtk_thermal;
>
>  struct thermal_bank_cfg {
> @@ -178,7 +181,7 @@ struct mtk_thermal_data {
>         const int *sensor_mux_values;
>         const int *msr;
>         const int *adcpnp;
> -       struct thermal_bank_cfg bank_data[];
> +       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>  };
>
>  struct mtk_thermal {
> @@ -197,7 +200,7 @@ struct mtk_thermal {
>         s32 vts[MT8173_NUM_SENSORS];
>
>         const struct mtk_thermal_data *conf;
> -       struct mtk_thermal_bank banks[];
> +       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>  };
>
>  /* MT8173 thermal sensor data */
> --
> 2.20.1.97.g81188d93c3-goog
>
