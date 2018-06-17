Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81070C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269502086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 03:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvIRq8fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269502086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbeFQDud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 23:50:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52843 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754082AbeFQDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 23:50:31 -0400
Received: by mail-it0-f67.google.com with SMTP id m194-v6so7769871itg.2;
        Sat, 16 Jun 2018 20:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=G5AzYCvWpE0PWQPnq3oTdAoqUfTtjA65P9GPeI0R0D4=;
        b=pvIRq8fnyjrrDJZ6B8VFPU7YAJWx3+PylIIruyAMW8eTZL8BaJ+H+C3FLeBNYHhPbG
         Xu4CE/Uo2xTBNhIaYlr/pj7P1SsLaVpwT43ZMJ+R2zGB82khAFKYwWFLjqqgDLXk/POe
         Y8+BtSByO1eDR+osu0wCMtsb6r7284HzUokZf2ONhPyl/5do35jmJ+HSVyux40qlGHwh
         hF3WmdbaSd6sh8oOeTXWK8w6rjF7OYSxPGOttWJk7qoMEMY9Q07OVjU89ibjKUznEkWa
         5ArrgWjsypZWnhS51n3NaP/GFMzcoZl1nIDPZmEfKdSJpycPvVKHKlK9k64IFPZsOti5
         MElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=G5AzYCvWpE0PWQPnq3oTdAoqUfTtjA65P9GPeI0R0D4=;
        b=Vztgrv9Mxkn5SHhz0sDkHfRbCJMsQ4OYSQSqDFtWacq+CDCi5j5TtNFf2R1bojiV4K
         W6RdYfWlr3qENRRwTDlKR75fBKtYIlmgEHYklW9GpaFmQXfoXEK7NlpaF4aIGE6LRN4h
         9YPf5An4E8Oqomoc24stRkpRHEBMZLudTROKEQRWV05sHTaUS6e1Yh5h3lzBBGwXhe91
         4ENB4Pbujt97XFAMHfx01x2IYm1xj6lfFua7gRXX6D1VSTGk6isMCTY0mf1IR6TEIe5X
         hxi49KwPI5meHCtZxqohHt+FmZ0X83ufXjsf98rOmxFOyItfGa3P5LpIWIvSatxDExsE
         uT8A==
X-Gm-Message-State: APt69E1XpWuZIgP94o3GrlWYif+PqYK8A3eIllZsAeOgik5YwAi81vFW
        yB4OhigWc9JkY80TERnSf6RHcya3NF/UaVFA/47LbA==
X-Google-Smtp-Source: ADUXVKIBBmn+VlfkU4POm56fCQZgwac8Kkq7Jc//PMvDni3ng80OqbW0XQ0aNCPf+Ao1BljtawGRgVFNy3rZtPAz5Gk=
X-Received: by 2002:a24:459f:: with SMTP id c31-v6mr5780871itd.132.1529207430678;
 Sat, 16 Jun 2018 20:50:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8d04:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 20:50:30
 -0700 (PDT)
Reply-To: cwchoi00@gmail.com
In-Reply-To: <20180615100452.17466-1-enric.balletbo@collabora.com>
References: <20180615100452.17466-1-enric.balletbo@collabora.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 17 Jun 2018 12:50:30 +0900
Message-ID: <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
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

This issue will happen on the position to use find_devfreq_governor()
as following:
- devfreq_add_governora() and governor_store()

If device driver with module type after loaded want to change the
scaling governor,
new governor might be not yet loaded. So, devfreq bettero to consider this case
in the find_devfreq_governor().

2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> When the devfreq driver and the governor driver are built as modules,
> the call to devfreq_add_device() fails because the governor driver is
> not loaded at the time the devfreq driver loads. The devfreq driver has
> a build dependency on the governor but also should have a runtime
> dependency. We need to make sure that the governor driver is loaded
> before the devfreq driver.
>
> This patch fixes this bug in devfreq_add_device(). First tries to find
> the governor, and then, if was not found, it requests the module and
> tries again.
>
> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..1d917f043e30 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <linux/kernel.h>
> +#include <linux/kmod.h>
>  #include <linux/sched.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
>
>         governor = find_devfreq_governor(devfreq->governor_name);
>         if (IS_ERR(governor)) {
> -               dev_err(dev, "%s: Unable to find governor for the device\n",
> -                       __func__);
> -               err = PTR_ERR(governor);
> -               goto err_init;
> +               list_del(&devfreq->node);
> +               mutex_unlock(&devfreq_list_lock);
> +
> +               /*
> +                * If the governor is not found, then request the module and
> +                * try again. This can happen when both drivers (the governor
> +                * driver and the driver that calls devfreq_add_device) are
> +                * built as modules.
> +                */
> +               if (!strncmp(devfreq->governor_name,
> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
> +                       err = request_module("governor_%s", "simpleondemand");
> +               else
> +                       err = request_module("governor_%s",
> +                                            devfreq->governor_name);
> +               if (err)
> +                       goto err_unregister;
> +
> +               mutex_lock(&devfreq_list_lock);
> +               list_add(&devfreq->node, &devfreq_list);
> +
> +               governor = find_devfreq_governor(devfreq->governor_name);
> +               if (IS_ERR(governor)) {
> +                       dev_err(dev,
> +                               "%s: Unable to find governor for the device\n",
> +                               __func__);
> +                       err = PTR_ERR(governor);
> +                       goto err_init;
> +               }
>         }
>
>         devfreq->governor = governor;
> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_init:
>         list_del(&devfreq->node);
>         mutex_unlock(&devfreq_list_lock);
> -
> +err_unregister:
>         device_unregister(&devfreq->dev);
>  err_dev:
>         if (devfreq)
> --
> 2.17.1
>



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
