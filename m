Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4179221A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF96k0Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394000AbfBOLH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:07:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37937 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393771AbfBOLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:07:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so9889112wrw.5;
        Fri, 15 Feb 2019 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHreN7FmvfNjJM3uXrYhnaHzqQk+jmY9ofZPntDTasI=;
        b=mF96k0AbTJhNZCfTcEsvKSncScD1ZXwuN6JBD8+SmL9l6B9W9wbYM/MNfWu9EVfvyK
         qsZ3SjgifMyROTc155lHthisuXMNbHX9hi8KeFmm1M51Tibk2pe9//OOOl/6zgtsALA6
         QLf4rx8W+QCJ69hQBg10yi/mNvAKjeyE3iy8GxMshPtAyrbzTtvPvmrokqcR8mNEiPi5
         yFQk0mv6IDS/v950tFSS+yjupdYiMaQGHg7UqNbzDotndW4Z5eob1DrcXZ/7CKAdsigd
         0BgRcgzmKkn4qG+W2drHveKivVBz+kziQacK1KFAiE76889N2cdu7koKJ6z7XSNOzYdt
         iuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHreN7FmvfNjJM3uXrYhnaHzqQk+jmY9ofZPntDTasI=;
        b=HOF7Om4N8pfgDljVa5bXdVzOv6oQfT8J2CpCLt8PesjcR8f6CSWUM9rpymmK6P1Mom
         b3h4kjrX6U9aosZjd/X3ctxTOUZUrqy1443cRTEAN4RPDGwG8/3RPnh/3anTZ9guAbxE
         4g4hgkpSaQZwpWx7XpfK5HVXZr7625+7ffnLi3lv724oOu8lcAFRoA40WyjdgMXkDaUR
         Oqw2vjwEtg9TdDBQiA9833RMf44g4LKqD5ZTyM6+E+dvJ/8vGKS5ztaV0jIgOkydl3Iw
         bPlQDA25Ifpb3FRFzz6Kk8NrAWGwYyu7p5pmu8Y4K8HczkZU1KkdczwEuRO6OLk/RuGH
         rHUQ==
X-Gm-Message-State: AHQUAubYjvIMkgznvZDnVq4V/L0m+4fcmx0Tajxcetbm0yqA6KFHwz+8
        1EToqucMNidZRf1ABRJIwvgKR3v8+7jim35Wiv4=
X-Google-Smtp-Source: AHgI3IZKH68DrdTcf1gIsMsZukuofUUR2cx420By69f0NaWIFbm6xY/eUgsqqrzWZVTyy3PGN0rhyyGX1aiFYjcMlB8=
X-Received: by 2002:a5d:5504:: with SMTP id b4mr3800825wrv.291.1550228877049;
 Fri, 15 Feb 2019 03:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129195214.30272-1-sxauwsk@163.com>
In-Reply-To: <20190129195214.30272-1-sxauwsk@163.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Fri, 15 Feb 2019 16:37:46 +0530
Message-ID: <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive error interrupts
To:     sxauwsk <sxauwsk@163.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sxauwsk,

On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
>
> When the adapter receive error interrupts, such as NACK, arbitration lost,
> cdns_i2c_master_xfer return to the caller directly instead of resuming
> the adapter which resulted in the adapter being out of control.
>
> So when driver detect err_status then try to repair and fix it.
>
> Signed-off-by: sxauwsk <sxauwsk@163.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b13605718291..e10048d7524a 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
>                           CDNS_I2C_IDR_OFFSET);
>
> -       /* If it is bus arbitration error, try again */
> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> -               return -EAGAIN;
> -
>         return 0;
>  }
>
> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                         id->bus_hold_flag = 0;
>
>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> -               if (ret)
> +               if (!ret)
>                         goto out;
>
In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
and we will miss the check  below.

Am I missing something ?

>                 /* Report the other error interrupts to application */
>                 if (id->err_status) {
>                         cdns_i2c_master_reset(adap);
>
> +                       /* If it is bus arbitration error, try again */
> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> +                               ret = -EAGAIN;
> +                               goto out;
> +                       }
> +
>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
>                                 ret = -ENXIO;
>                                 goto out;
> --
> 2.19.2
>
>
