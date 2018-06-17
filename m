Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5047C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466C208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWnRNOMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5466C208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933527AbeFQDXQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 23:23:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34932 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754082AbeFQDXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 23:23:15 -0400
Received: by mail-it0-f68.google.com with SMTP id a3-v6so7782003itd.0;
        Sat, 16 Jun 2018 20:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ul4OAsZiCbWFc6cLCTku1njSWcCC5uYCg8BkAM9h7KM=;
        b=fWnRNOMcU0v5/Um/4FRU7GyPrCMDVY2Qw0bg4zSwBeGYk8mZfDaRyEBAoqe3qPEAow
         EEnp1OHFEabMAwC9OAuYNMdUIvVHUGeMRvSLh+Nj+HXPTTJdGsF0oFnM/N5LaSR4atiK
         wm7NKT73VAixd9K3NGsrjJ/wIADPj/eNJ2uoKkH2zXcPdbfVbhi1QAUBMgUUmSevNTq8
         TPutWbtO06drioI+2gH28oky/giK7+ssRr19pjRL2BNtbklgwuDO/Hm/ZnewMPKkBxlJ
         iMGcmcFzhhLVJMqHzuyB7P9iKju2j5kiK1ZW14mx14rEyGBnoNIF4+eEgOzLpGzc25X6
         hsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=Ul4OAsZiCbWFc6cLCTku1njSWcCC5uYCg8BkAM9h7KM=;
        b=mTl566A4bEIcnOfzRBEQQV3ngMMWNf15X4HXEQsEduKNKyLwhUGMyrtflh4ZrLQHNZ
         lekym9oeRaElPjXqEa5T+jo0M1w2qd3gBQMgljpESrGumbMrGM9vWqlTxygURyFqiIA6
         20JgCDz+65j9oDYsXSWdcqgJJSbBUZDS/LfoQGnWG95UqBXQb7apnW1rma/5o+zIMT/V
         ZR8WFJQthq09h6nD6LxRrMI+J0M25LPyBwn5Q1szTDFENtwFnJ4PnNsXWfVGtQiy5G6d
         /Xn8cZVXQsoJ6N3J+/N/JZBK2MAoRw6hqg4FGIFMhqG+ij6HtKUqX9C8SJvVYnlyeR/U
         uw2w==
X-Gm-Message-State: APt69E2a9ZPHo+S8OKyiVzudamnd7t1+ajQgJhZrbA7B0IMGUgf/NfXy
        3Chcovp0nETZ1d0KEHCfl99D85O6OiPPdiKhSGM=
X-Google-Smtp-Source: ADUXVKIUOAADfpuZZqD7q/6uhqrexJsdE/zzoyjT/Y/lYrp2RVMsT6bQlL77M/YH7bWBrVkJGlgDt3JowJ4wgCnWbLA=
X-Received: by 2002:a24:e645:: with SMTP id e66-v6mr6210514ith.41.1529205794322;
 Sat, 16 Jun 2018 20:23:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8d04:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 20:23:13
 -0700 (PDT)
Reply-To: cwchoi00@gmail.com
In-Reply-To: <20180615151217.29872-1-enric.balletbo@collabora.com>
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 17 Jun 2018 12:23:13 +0900
Message-ID: <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on reload.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@collabora.com>:
> The opp table is not removed when the driver is unloaded neither when
> there is an error within probe, so if the driver is reloaded the opp
> core shows the following warning:
>
>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>                200000000, volt: 900000, enabled: 1. New: freq: 200000000,
>                volt: 900000, enabled: 1
>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>                400000000, volt: 900000, enabled: 1. New: freq: 400000000,
>                volt: 900000, enabled: 1
>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>                666000000, volt: 900000, enabled: 1. New: freq: 666000000,
>                volt: 900000, enabled: 1
>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>                800000000, volt: 900000, enabled: 1. New: freq: 800000000,
>                volt: 900000, enabled: 1
>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>                928000000, volt: 900000, enabled: 1. New: freq: 928000000,
>                volt: 900000, enabled: 1
>
> This patch fixes the error path in the probe function and adds a .remove
> function to properly cleanup the opp table on unloading.
>
> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index d5c03e5abe13..e795ad2b3f6b 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>         data->rate = clk_get_rate(data->dmc_clk);
>
>         opp = devfreq_recommended_opp(dev, &data->rate, 0);
> -       if (IS_ERR(opp))
> -               return PTR_ERR(opp);
> +       if (IS_ERR(opp)) {
> +               ret = PTR_ERR(opp);
> +               goto err_free_opp;
> +       }
>
>         data->rate = dev_pm_opp_get_freq(opp);
>         data->volt = dev_pm_opp_get_voltage(opp);
> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>                                            &rk3399_devfreq_dmc_profile,
>                                            DEVFREQ_GOV_SIMPLE_ONDEMAND,
>                                            &data->ondemand_data);
> -       if (IS_ERR(data->devfreq))
> -               return PTR_ERR(data->devfreq);
> +       if (IS_ERR(data->devfreq)) {
> +               ret = PTR_ERR(data->devfreq);
> +               goto err_free_opp;
> +       }
> +
>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
>
>         data->dev = dev;
>         platform_set_drvdata(pdev, data);
>
> +       return 0;

It looks strange. Because rk3399_dmcfreq_probe() already include
'return 0' when success.
What is the base commit of this patch?

[snip]

Anyway, if probe fail, device driver have to remove registered OPP table.
Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
