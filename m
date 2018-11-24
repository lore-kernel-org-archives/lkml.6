Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099420865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQgI2k+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B099420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeKXTLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:11:31 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54934 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKXTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:11:30 -0500
Received: by mail-it1-f193.google.com with SMTP id a205-v6so21329838itd.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4AdPKNKI/lKwFAClVNj9C9dS1hVhzBFgaN20yeFwPQ=;
        b=bQgI2k+ouRcJ1+PNz3TRG1Mk6rg/AYub/ZuNrsLjGIxqUFOEHqAFMq4m6D+oZrDX/8
         YMKUlXbQFMVGDWKJwtcFIuCVnLgINCHokjo1iP9ULPvFz7LOZCg0ZDF2awesi56+VjEX
         XcI14vJHv85yPTJh1/pTXvgMcQckYYpz6mw6Ol7lUoEORp5xzOmiZroIUmzoV6VJuhUJ
         x3W+QpywF0D1jLrbezLeDlfFofc5n644LSjXUnnmjyRsBzXuYOJmxLlEhzo6eUU7XMEw
         11aRHdISqawFyvpQEDKwaO2FTLrFMJXAc2j+M0cU+TJgVovMtKxQBHw7sXhPHv9Yxg2g
         NmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4AdPKNKI/lKwFAClVNj9C9dS1hVhzBFgaN20yeFwPQ=;
        b=T043vQ0b8XlIhYtn4QhX0Y8PBgaT8d73K3TY2aOv9QsNquOviu9dj4DOwhYO6d6Mpj
         gqJKaGES6nJIjzSv+pLfNcUMKNB20/usE3pkiXNAJPJU0p41sMUYif6E3mI7O1N+9Z4h
         m5yl/9zd/ar91cyLxEKljz1eJyr2waA6PERUcD97tXiwK58DobwzOihwxteHIOywrg2S
         4at435SqEaLvW+aGZp72oqYLrfjJpXKIqIQq/uokKFN9OrAPS388d7fcadmxOtG8l+wC
         bd95lmRLv9u7ZjjzJlJyeYV+tSNxNbdPvtm8R4nvkZ6GFlHGb4K4L1uNSjgZVAgDaZgh
         qO2w==
X-Gm-Message-State: AA+aEWZg2ikC2HL6ifv0TRt+xz5+6sB+xdMoVv/EQtfyR9ndoHMqTNzX
        LrOwbDNSSX02Mpzqh6aqMOQuUWcLzUOFJh1DfR4=
X-Google-Smtp-Source: AFSGD/WEAngmI/bq7iTslZbtuOVwaMnKrOePjCFPm9pE7Najhth0u9jwZ6i9j/7ZWPH/DD+mkzjpGeLKe9gaHmeJ4qo=
X-Received: by 2002:a02:9281:: with SMTP id b1mr16582014jah.86.1543047826615;
 Sat, 24 Nov 2018 00:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20181116100557.GA2497@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181116100557.GA2497@hp-pavilion-15-notebook-pc-brajeswar>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Sat, 24 Nov 2018 13:53:31 +0530
Message-ID: <CAFqtX7ne0tFJ7tuO0JSWh2HR3MbQPrLnzFctkaPd6ogsSn0EZQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpcon.c: Remove duplicate header
To:     Stuart Yoder <stuyoder@gmail.com>, laurentiu.tudor@nxp.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 3:36 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/fsl/mc.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/bus/fsl-mc/dpcon.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/bus/fsl-mc/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
> index 760555d7946e..97b6fa605e62 100644
> --- a/drivers/bus/fsl-mc/dpcon.c
> +++ b/drivers/bus/fsl-mc/dpcon.c
> @@ -5,7 +5,6 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/fsl/mc.h>
> -#include <linux/fsl/mc.h>
>
>  #include "fsl-mc-private.h"
>
> --
> 2.17.1
>
