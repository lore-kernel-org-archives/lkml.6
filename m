Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A022C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F622086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tC1ClSPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfA2OoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:44:03 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43383 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2OoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:44:03 -0500
Received: by mail-yb1-f193.google.com with SMTP id e12so8241704ybn.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 06:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEXDVTn4s64kYhcrAHsN/sqlu5BQ5ywbDCvF7M+oxx8=;
        b=tC1ClSPmrFpV40tRQv4ZzOX4YqZOPUtwWPLHwQTO8ll37PbYL+wbfyZE+u0qSFBm4G
         MGl0Ru0XwpEDOgERba1goggTsBe6vK+NqShr56mAyWZBG6TBeM+stnYwtQ7VwhctsGGb
         IcspJJeV9/4Zvteo6Qv7vMYEqoqXlCW4czc6A8lLrSEsI1UACGuAZK7KtwaD4QkVDFkT
         oy5hB6s2NQLZ9QXqbYVqRARKXbwECy5OYKE2r62WPbWiJSc0cefWJXGC4OhiL21bIg0z
         fgND/GWR7IFrQMD2geWQsZPnj4tSulBHrBGoj9UtxP2jn5YEEPnbPToqxL8FAEyjf5zW
         dEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEXDVTn4s64kYhcrAHsN/sqlu5BQ5ywbDCvF7M+oxx8=;
        b=s0nZNlz/9OST4gevfQBZRO5CvTBIPZ7hSygB3oackk4BbG0s+xbk/PpTivwQ9851qA
         USxm91oaC3rJsOtWFSTzw3e0M/7BzwB2VgL4vQ83Cm+eLOhDGIiTEwtkAtcDjCaViZBY
         ndYs4Bwr6fBySCPJ1g8FEIGnk3eJ+W39nGyy0A7yLHe0qLFF5r+MGOpNKR+fsrI8jqdR
         Grio4iAzH3M9ovpiwrq4/TiWHXxDPT9dEJfGg1Ooy8lU0kuNzgPWW5yV/blGOvEojJcf
         Et5N6J9I4awBfytS8E6Nx2Iovm2Ud9CQRc0JzhjnZVNVOtLIumEZCoNxdm9ORinhiGyJ
         9aeg==
X-Gm-Message-State: AJcUukcBAzl/YEOW8l2eUjTIocgrh5PIBqDzo60AQQpHBonw5sdQQ+kc
        rObeWZ4JFvcmT14BtzLwC+jbOxfDkQJZ/TzRgxRUYg==
X-Google-Smtp-Source: ALg8bN6bx/N/1J61CxcXBmny2hMyO0nwaMjB+9zGYwH0w4ZNYNspWC8TLLhuanRMo1Brb4ZR7qiZKodCUlqr0creyuU=
X-Received: by 2002:a25:8685:: with SMTP id z5mr24755137ybk.247.1548773042163;
 Tue, 29 Jan 2019 06:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20190129093823.27137-1-enric.balletbo@collabora.com> <20190129093823.27137-10-enric.balletbo@collabora.com>
In-Reply-To: <20190129093823.27137-10-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 29 Jan 2019 06:43:51 -0800
Message-ID: <CABXOdTcufAXnY4SwcvGeCYpdvpee+hi86TYuXXBrJOBzVDPFsA@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] platform/chrome: cros_ec_spi: switch to SPDX identifier
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

On Tue, Jan 29, 2019 at 1:38 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management. Also change the description for one more appropriate.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - cros_ec_spi: Fix SPDX license tag.
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_spi.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 2be41e8afa47..63020d000c3d 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -1,17 +1,7 @@
> -/*
> - * ChromeOS EC multi-function device (SPI)
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// SPI interface for ChromeOS Embedded Controller
> +//
> +// Copyright (C) 2012 Google, Inc
>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> @@ -730,4 +720,4 @@ static struct spi_driver cros_ec_driver_spi = {
>  module_spi_driver(cros_ec_driver_spi);
>
>  MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("ChromeOS EC multi function device (SPI)");
> +MODULE_DESCRIPTION("SPI interface for ChromeOS Embedded Controller");
> --
> 2.20.1
>
