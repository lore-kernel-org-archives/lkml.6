Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EEBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375972171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF6qmarU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfA1TgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:36:10 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35631 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1TgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:36:10 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so2774444ybs.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqnAPPOb3cS9Qt8LEu5uD+7sIH8H3sxrbxO6oH7Sjm4=;
        b=nF6qmarU8Qb/1pJGtPEXBneiOli445Mm+FtNSreCKkd8/K3Ou7FrTO7Dl5TnwZpdRn
         Xdjx6gwGulTOL6OJ6veE7g/lWgwwqvDnceomTdDnkAtVGI5hILcad+NxIhop3ubSm+8u
         yeiIroLYMnVZodtY52QFWYkzgqGMk8lQf+sdxW71w8LE461EWZkNQNc0s3m+wcJ1FEqv
         zXbOspWjmd2ND6KBnEyIQ0rEs1su6MgPG4ktZbHEovvLMamNQBRQygaXzh9HXTm2jhOi
         BvMdoEOej8BYvXVoJsGUR+Llm5Spj1RhTh+XBS8g8A5ZsaZQhge8h4oNaWB2ydekVn/A
         UqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqnAPPOb3cS9Qt8LEu5uD+7sIH8H3sxrbxO6oH7Sjm4=;
        b=S+kvIt+ddSkBbs36AUMZMQ10fikLC12VUnCPavj1/iRKGZ1Gk19pXlNfPZWuR4ij0L
         8Yk7CPdrwOSMOLi6mC+tWEpZJ+B8xZt7Z6yRB51IKYb/qRb9htkRdgrYqRy46lijzou7
         FUP1B//Bq1YYoIMUJtCn3lI/5OhZTnqTHiR9jZs08NBGrRbWnOTG722H62Bo7FG45yTR
         IA5Lcj3v0e09nmvoHZaMjq9u3I4MjZ2jzozWR/oDg31RxgH9s6y7x9T0gXmZFujgSDTd
         Tko8oqoDY05jdA33QukLwkK4ogx7uFYZrxAt/Dp/7IpJu4PybvZKah8DxxxXCwC3x0h8
         9u0g==
X-Gm-Message-State: AJcUukeZP2jd+BbDGHgW6Zk0iv9yfFP1/+TdTDUeHQ8AIYP/zRH8UwhZ
        j/z0xt7vHb64gEmCdmxb5VTyYvW6eXyBaO3SK16pdCv6JreIYw==
X-Google-Smtp-Source: ALg8bN5M+uhJBiBQuvG82U5sGTJ/Q8jmupvknTahjgLb+doZ5S9ZluKlp9NS8dUWdcF4i/uzR0DhcNgBukGOd6WojGA=
X-Received: by 2002:a5b:9c3:: with SMTP id y3mr21628066ybq.7.1548704168829;
 Mon, 28 Jan 2019 11:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-11-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-11-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:35:58 -0800
Message-ID: <CABXOdTetsM0bVmMyiu+9z9v9MCegwBKerYS4g4gUP+tE4Ua4tA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] platform/chrome: cros_kbd_led_backlight: switch
 to SPDX identifier
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
> management. Also change the term 'Chrome OS' for 'ChromeOS' to be
> coherent with other drivers.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  .../platform/chrome/cros_kbd_led_backlight.c  | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index ca3e4da852b4..aa409f0201fb 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -1,18 +1,7 @@
> -/*
> - *  Keyboard backlight LED driver for Chrome OS.
> - *
> - *  Copyright (C) 2012 Google, Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Keyboard backlight LED driver for ChromeOS
> +//
> +// Copyright (C) 2012 Google, Inc.
>
>  #include <linux/acpi.h>
>  #include <linux/leds.h>
> --
> 2.20.1
>
