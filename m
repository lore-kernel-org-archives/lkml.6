Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F26FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C75721741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="au2oc9Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfA1TaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:30:03 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44046 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1TaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:30:03 -0500
Received: by mail-yb1-f196.google.com with SMTP id k189so7160673yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QHhKVMY3KHgCtlRraqAEq+184Z+ENeF3gep/l00m+E=;
        b=au2oc9Zqc0ylZCXYZ+TQhOiNjymwRFIHWjSBklwYRLLO2yagTQ5/kmHDcunJHVsNb9
         3GdxwqeVUJ1L/WdrEnHfQAtbsI/BXZqEuFWttqHc6YZWUHK9C9S4U9bpn+avlu+hdL0a
         yBh/mrJsWERyTLbraZTQZ6PoTz+z9o4U/v/svnGSLP369v6ZhUW90W52bj+9vyljuszO
         N59FvbpKDwnN+zh/QT91jnKeNHTzCg3hYKOGCpXU/qwofRNt03l1E2M1cfXBOUFDdeo1
         yqgBpAcjC/0rvAN8lVun+1CI1qmKzIj9LGxoAIpof3iiPBnAvxzqrs8qzib5ZRYBAdxY
         Ym4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QHhKVMY3KHgCtlRraqAEq+184Z+ENeF3gep/l00m+E=;
        b=JeYnUR9ML8dMWwCdm1DJS6BWCrg3UHXSurOJEMdcPWF2z2o85SRhGLi9ubdH23h35U
         PGJIicbV3/GbHo4AV5X4D3FXRSoLWDMkDhcJq833q0XgxWNXhpynf9yNHggsRGodp5S+
         sHAf5YEYbD7psTmiS74w/UEKF3lF6HDWTzLxWdfBl24olt1QEJDBpRJ/Uux6kIhTx5kW
         vBk/47tN9MJQoOIXYgk0pbZIngfm3bEHkp0UY4ZUDbPXbRNHSc4adkecagw2VHFiANU7
         y83K9nsfYd3hWeTbn44Y/n4e31BVz1CJmOcercYLLLwEM0Cd1/rhwnOzI3hxKhl99XaJ
         +oXQ==
X-Gm-Message-State: AJcUukekeyYuvwBK5bpbiF8z75Xuwf1XJ/s5V+WED1s50QpIM1VjCLtI
        z3KpdcDWmUn2qcRLdta8D/Pugim2dewaM7a0vQBMRQ==
X-Google-Smtp-Source: ALg8bN70BjkhSPAnBiF+oiY2MOz+BVHm4GNf1CFkk1BUeM8QpDp35X76V6HoQiJyzYygVDlEumlrtl27KTriAVCWqk0=
X-Received: by 2002:a5b:9c3:: with SMTP id y3mr21608158ybq.7.1548703802192;
 Mon, 28 Jan 2019 11:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-5-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-5-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:29:51 -0800
Message-ID: <CABXOdTerV4VwxfOCpupMHd=h+C4A8dyniX-uHwcNna-ms3bfRg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] platform/chrome: cros_ec_sysfs: switch to SPDX identifier
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
> management. Also change the description for one more appropriate.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_sysfs.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index 0ff5aa30c070..01c420727ee1 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -1,21 +1,7 @@
> -/*
> - * cros_ec_sysfs - expose the Chrome OS EC through sysfs
> - *
> - * Copyright (C) 2014 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Expose the ChromeOS EC through sysfs
> +//
> +// Copyright (C) 2014 Google, Inc.
>
>  #define pr_fmt(fmt) "cros_ec_sysfs: " fmt
>
> @@ -389,5 +375,5 @@ static struct platform_driver cros_ec_sysfs_driver = {
>  module_platform_driver(cros_ec_sysfs_driver);
>
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("ChromeOS EC control driver");
> +MODULE_DESCRIPTION("Expose the ChromeOS EC through sysfs");
>  MODULE_ALIAS("platform:" DRV_NAME);
> --
> 2.20.1
>
