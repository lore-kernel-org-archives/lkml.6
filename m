Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB09CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4GILYUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfAOFrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:47:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36719 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfAOFrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:47:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so1090336lfg.3;
        Mon, 14 Jan 2019 21:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLy7r4spxh0MBAa8NxNyfruATrU3TaK+A4DUCJTfflM=;
        b=h4GILYUOhTEMyK9+3ocL7Yy/3OQ4C7lRFmP91TS4X1zIrIrW7PlKvdAx+zoJ1OuJ9u
         INc4lxqUYJNV5JczNMtsY/PkkrYZchWKyz3nHwqjexZcBEWc/2RlZP366jdIYwgkHYT8
         g3yxv+y8v/21xfdoTvIkjjSFW+MTCTKr19K/EeVHXWUjKPgXs3cP7qvCqp97PD+H2Bhu
         uGdEXhvXFALo9SIBBT3GH2IEhyGYnydJWPKLEa9AY2c9nauDNyrvYXk5WIxQoazcDfep
         jxfYJIOWPQ2cj6o7d1PnGIJstA1L1CpQ1ndVP8Udfp0OSqIvDUXCjogsqcRPod6I1DZl
         gzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLy7r4spxh0MBAa8NxNyfruATrU3TaK+A4DUCJTfflM=;
        b=aJt/sX7dR3RKHRRUsyLDeqeMDy6scQw1v0ccaChaPAlHCrL6ALDdoQuzbf9TB4cBYf
         aY8o8Te5OBgbwAPc5i55sl4WyxO8ChmcjHmTyTjpxwS3Bj1yoVUnLg7oDzcFzWCr4YZs
         naAyoElYM1pgqmujEDKdPC8Vz1LpUnsflzxC1uN+sT0EI3JqXFb/rDjr1iRmfcRq7I5E
         UMcisaq8a/XxSAzisp9MmzaopWvoMoTdothvz/wE7TXBHHfjqv0wyFcoj1Zt2QExlIdK
         6/bg2pSotjJssRRl/hAKafSi9dxHZ/QfzUpAcy5kQ+OHWhwRBXrdpaHyUpQQNH0ZVBx4
         INIg==
X-Gm-Message-State: AJcUukdmtMPJr1Gba8svaU36MSrQj/e8IKd0z2zD2BSTXJsw87lamUnF
        +1rBKXkXgeJ6wYSeEz7geJdjSjq9vruLN1XY9Z8=
X-Google-Smtp-Source: ALg8bN7fOfVwsP/zrBWt9U4LJsCJoo9Or2bH8Oot94+z2WqGehB3gDkRRWYwaRbc2wb/RKtENB77DQKWuj37eX/E8zU=
X-Received: by 2002:a19:c70a:: with SMTP id x10mr1471557lff.88.1547531257068;
 Mon, 14 Jan 2019 21:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20190109142959.GA29659@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190109142959.GA29659@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 15 Jan 2019 11:17:25 +0530
Message-ID: <CAFqt6zbXzpvRS-aO7_s21k+vzzmQwOayZzJqw8c85fUPuq=soQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc/qcom_sysmon.c: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:00 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/notifier.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  drivers/remoteproc/qcom_sysmon.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index e976a602b015..603b813151f2 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -7,7 +7,6 @@
>  #include <linux/notifier.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> -#include <linux/notifier.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc/qcom_rproc.h>
> --
> 2.17.1
>
