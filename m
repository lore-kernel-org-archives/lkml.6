Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8402086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOnLq1dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfARAQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:16:03 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43688 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfARAQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:16:02 -0500
Received: by mail-vk1-f195.google.com with SMTP id o130so2693249vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62OxJKS1GUqnP0lfZQEqSZI1ytuOXouAQZ7DJcGC17o=;
        b=WOnLq1dSIuQKUTS9G45AuEvhtX1JPiGC62PP7QHbwv1Z8ydJC+q6uPpyI6iCxf+rJq
         haAn7TmxKnvWUmnd/hhP8g6XzJFzJYIdgT9VAerS/+kPGpMu4Qvy2Veeiv70vBHgTPST
         ZZM3YEw+CnSB3O3DynCeJxp54p3f4zKW4+3rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62OxJKS1GUqnP0lfZQEqSZI1ytuOXouAQZ7DJcGC17o=;
        b=pJ1vKxjzxIYlW285vRnR15w4a8dWDf39fG7syYeAgjv09y99uk0B3Yer4oVKgqFBA8
         frsmIbESqccY+cf/l4Nc6fB2rf1sXMGs6+U/maZ6vSb2phNsIAhcfIzcYE2oevlbfM4K
         YI+1YlQmaorg/4fwcLNE73FZui4b4FcSbtzFGw9KAmq3q5gCjn8z/sk6nw5X2TJmS4zU
         JCtNEHlYeRjkx38zcDbX7rJBfzYwSj3FwAl0NKBxCPhL2HluHf4IVkH+RxlEYn4KWK1N
         TFPzh+aZFxaakxTDzZT2q5oJ2G9pUsuPzwz7AGBrQghXZRr6yD/hBcuM4Vxp6X0CXruY
         PqTg==
X-Gm-Message-State: AJcUukdcirqXapm7WMCmpe/oBKt1prpVEgIbz4UsQ8+yZlsrrfPgsAEh
        fadV8GfY6ebQTCGiF6yLf0nBqIO+BIQ=
X-Google-Smtp-Source: ALg8bN6FyZkRwRRG+bP82ipBSV+Ns3oB2feFmCzeFuyMvvo8kscjPdRobzz62bGRBXNkzJTB1z03xQ==
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr6368507vkd.74.1547770561022;
        Thu, 17 Jan 2019 16:16:01 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id w65sm8203430vsc.16.2019.01.17.16.15.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 16:15:59 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id h78so7401160vsi.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 16:15:59 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr6650286vsd.222.1547770558450;
 Thu, 17 Jan 2019 16:15:58 -0800 (PST)
MIME-Version: 1.0
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com> <1546862462-19640-3-git-send-email-liaoweixiong@allwinnertech.com>
In-Reply-To: <1546862462-19640-3-git-send-email-liaoweixiong@allwinnertech.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 16:15:46 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
Message-ID: <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
Subject: Re: [RFC v5 2/4] pstore/blk: add sample for pstore_blk
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 4:01 AM liaoweixiong
<liaoweixiong@allwinnertech.com> wrote:
>
> It is a sample for pstore_blk, using general ram rather than block device.
> According to pstore_blk, the data will be saved to ram buffer if not
> register device path and apis for panic. So, it can only used to dump
> Oops and some things will not reboot.

I'm not sure I see the purpose of this implementation? Doesn't this
just cause all the pstore machinery to skip any actions? i.e. without
bzinfo->part_path, won't blkz_sample_write() just return -EINVAL, etc?

>
> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> ---
>  fs/pstore/Kconfig  |  9 +++++++++
>  fs/pstore/Makefile |  2 ++
>  fs/pstore/blkbuf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 fs/pstore/blkbuf.c
>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index a881c53..18b1fe6 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -159,3 +159,12 @@ config PSTORE_BLK
>         help
>           This enables panic and oops message to be logged to a block dev
>           where it can be read back at some later point.
> +
> +config PSTORE_BLKBUF
> +       tristate "pstore block buffer sample"
> +       depends on PSTORE_BLK
> +       help
> +         This is a sample for pstore block, but do NOT have a block dev.
> +         According to pstore_blk, the data will be saved to ram buffer and
> +         dropped when reboot. So, it can only used to dump Oops and some
> +         things will not reboot.
> diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
> index c431700..4a6cde1 100644
> --- a/fs/pstore/Makefile
> +++ b/fs/pstore/Makefile
> @@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)      += ramoops.o
>
>  obj-$(CONFIG_PSTORE_BLK)       += pstore_blk.o
>  pstore_blk-y += blkzone.o
> +
> +obj-$(CONFIG_PSTORE_BLKBUF)    += blkbuf.o
> diff --git a/fs/pstore/blkbuf.c b/fs/pstore/blkbuf.c
> new file mode 100644
> index 0000000..f1c6f57
> --- /dev/null
> +++ b/fs/pstore/blkbuf.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * blkbuf.c: Block device Oops/Panic logger
> + *
> + * Copyright (C) 2019 liaoweixiong <liaoweixiong@gallwinnertech.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#define pr_fmt(fmt) "blkbuf: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pstore_blk.h>
> +
> +struct blkz_info blkbuf_info = {
> +       .owner = THIS_MODULE,
> +       .name = "blkbuf",
> +       .part_size = 512 * 1024,
> +       .dmesg_size = 64 * 1024,
> +       .dump_oops = true,
> +};
> +
> +static int __init blkbuf_init(void)
> +{
> +       return blkz_register(&blkbuf_info);
> +}
> +module_init(blkbuf_init);
> +
> +static void __exit blkbuf_exit(void)
> +{
> +       blkz_unregister(&blkbuf_info);
> +}
> +module_exit(blkbuf_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("liaoweixiong <liaoweixiong@allwinnertech.com>");
> +MODULE_DESCRIPTION("Sample for Pstore BLK with Oops logger");
> --
> 1.9.1
>


-- 
Kees Cook
