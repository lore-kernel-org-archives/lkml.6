Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297F72171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pz+1ZV/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfA1TcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:32:01 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42336 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfA1TcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:32:01 -0500
Received: by mail-yb1-f193.google.com with SMTP id l20so7063750ybl.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAlSwUbunHrIk/LZUAMl1xPywHh/LV/I5NKw5LCasxI=;
        b=Pz+1ZV/5tlF4V1NZ98kvwjihkPpj8tBzu2CQbIJ1Uq6ycVeVrImP8l8EwQGVUH7n38
         THckc4w6iYWDzsY7YBcwb0h4KszRKlNTnc/qkL35CuRpRPHlWvz4kJ2IOp1H9hTsM1j7
         Z6NT/9kd0becSFJ1NDURblLa/+UtEzYrV2psVEUhUBjndHXwa/sE9L4cZxhABh1UCSrY
         0MfA6uvBCBe+oJYmhXLpfc1EZT25dpQ5nBl/UGXTOluXQL7qwHrxPlhwX3RljrzwEnYw
         2fHdhwq9H1c0ekLIKexhQKhaZOMxeb4hxmzulosEKRbZeTeZO/Wm7uz8gqPuVsBpbTXI
         4tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAlSwUbunHrIk/LZUAMl1xPywHh/LV/I5NKw5LCasxI=;
        b=OFoW4glc3jtyxXto+Rs11oFRFzTvQTRekDiURk5iX+1bqhdmA3mD1RUlEx51gsOmBf
         fXNu2fKOFNWsO/1Jtajj8KXmM2qYeF7YkGgwiArNUr9uG9KsW0EemGzFtIHU9qjuevOL
         V92JFJvYcUpiqUMf/ha6Zn4yTRxiQcqI3fC9DU8iyEkeF6YNUfXji06E8huOZRyffRhI
         CRSSAzBDkA48eU3pQx9NncIJ3+xoLSjkUXZsipaHQmdGL5NGruyoelHcPVfvQEHm+uBU
         dqbTFQurU/nEXjOO7PU0Gp54jINnsSxwVRyGAhiai6+SZdJ1lkMpS775lX1HCjp/s5fs
         fsmg==
X-Gm-Message-State: AJcUuke57wjx7EstcwX5Xzuf+vDA1roQeB8yTYKMvkvbf3qLcmfdqLYt
        nsJx8f+zzBGS3jg0hL6wOXnaeXPfD0JEPQ4CXFcPjw==
X-Google-Smtp-Source: ALg8bN4d2PdjHaNVG0ZWbqhZIlaIaJrl49dmks5vIJ2L9PJBapDFcJeMVrxi4aK0qLJfQTkrQNV7hIYSQyzqm6WhaPA=
X-Received: by 2002:a25:7ec5:: with SMTP id z188mr22015838ybc.282.1548703920453;
 Mon, 28 Jan 2019 11:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-7-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-7-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:31:49 -0800
Message-ID: <CABXOdTef3AUEp+tb1pJQuid=C20p+n_F5MuTxGtRYp=V79-mNQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] platform/chrome: cros_ec_i2c: switch to SPDX identifier
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
> management. Also fix the module license mismatch and change the
> description for a more descriptive phrase.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_i2c.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index 739b985c97e1..691744912dac 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -1,17 +1,7 @@
> -/*
> - * ChromeOS EC multi-function device (I2C)
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
> +// SPDX-License-Identifier: GPL-2.0+

Should be GPL 2.0 only.

> +// I2C interface for ChromeOS Embedded Controller
> +//
> +// Copyright (C) 2012 Google, Inc
>
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> @@ -373,5 +363,5 @@ static struct i2c_driver cros_ec_driver = {
>
>  module_i2c_driver(cros_ec_driver);
>
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("ChromeOS EC multi function device");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("I2C interface for ChromeOS Embedded Controller");
> --
> 2.20.1
>
