Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EA421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nK+LCP7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfA1TeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:34:06 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41105 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfA1TeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:34:06 -0500
Received: by mail-yb1-f196.google.com with SMTP id n6so1774171ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9P0JlK7TAlLH5SSh3b5O7nFYcPhob3t67r27vQgFQk0=;
        b=nK+LCP7EsHUUkhSkTTSS0Cw2cLlfKSxhaWLW8bPu5pQAHdw69mtfrjEVH3Xg5pAubF
         IINhv0geoN4pWF0NscdY+BrMSdRkBW2/IzaEsaDr0H65lVtG/cG8kCP/qi0bTbiqOFCy
         aMsA3BoMjazhmuBxpwWkbTtrVKosJBrYwkFXRh6LjqzTrwcb6duKSAf/WrMk3b6AoUjd
         GzirvRFTjF6v24oEbOpjIY0/iicu45/tNgiwXvaW6B7L4yDfONymrZdpUTEqX0yTdy22
         9zh9bfj6M2kfE2vXgRc9VMngI52I4TS7WCFtTHNyIxv9Pl9aPZA9bygATQXDuMjzcSqJ
         oxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9P0JlK7TAlLH5SSh3b5O7nFYcPhob3t67r27vQgFQk0=;
        b=X0s0yjJdu9LYABTJvLwxtnualgHmyrMlyeXqBDrawKhDVni77WQH/4fSoEQAsx9Ky9
         Q02Si58OP7KGiFphr583VNkovdSxgW+7ARfLFJwhLLojzcDNvCw3ey95XS2g4rTn9U+E
         EjAErBM3D6qNrVVvxwrV5lHHHnabCoBjYQLyfA/peTg8zodwfJkJEFX1fM8Wz5ltyMks
         o173mPOPPwrTr0rowOOJADpBPDUAU5c5IFWOSRm1JxOBGj0YTNbAAjN8cs1/qM3dnrVX
         r0BCej3Cdzf7VD4CNvThoTBcvPWuaO8swiTbv0zHfKkSoRtxQ0Fbk1DnVStF3H9OKP5x
         ARLA==
X-Gm-Message-State: AJcUukccKwRRP8ZEbfpETZjXMpPJAF0Q43yan1glL7tta2cH3iCL4lD6
        JAeHqI8l0ADsrUDgv6HetUzdQ3S3buo98K2TKGA2jA==
X-Google-Smtp-Source: ALg8bN4kfXZnW1H9jeqOLgZ7fZuZZ6hAjNqwuUF2ZX0XdbRBB1TMLMiR+LSPOI40WpcBu+lWG7kMyZhdJcdjA7Gnt98=
X-Received: by 2002:a25:1006:: with SMTP id 6mr21289231ybq.151.1548704044591;
 Mon, 28 Jan 2019 11:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-9-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-9-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:33:53 -0800
Message-ID: <CABXOdTdNGds4MbEY3hEv4zaR0NecMjJrAKhxwYuZxJewc4yC7A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] platform/chrome: cros_ec_proto: switch to SPDX identifier
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 1:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_proto.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index d2ba662fc713..d259ff264e9d 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -1,18 +1,7 @@
> -/*
> - * ChromeOS EC communication protocol helper functions
> - *
> - * Copyright (C) 2015 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// ChromeOS EC communication protocol helper functions
> +//
> +// Copyright (C) 2015 Google, Inc
>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/delay.h>
> --
> 2.20.1
>
