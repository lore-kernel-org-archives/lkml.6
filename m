Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652DBC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2860E21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N7W2BnHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVBzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:55:31 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40941 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfAVBzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:55:31 -0500
Received: by mail-vk1-f195.google.com with SMTP id v70so5012929vkv.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIkWHd2cZrXCgkMKwvQCLGQPOiyLHkTkobG1AOxnzrA=;
        b=N7W2BnHRSnx5xPlI/Ano54X9gifFGjm5ofyhYAW6bEmKZcsAI0spORV+l1LhGmR8Y4
         k2f+/OoI/BzTaHojMGNlW1uF+FvMWt4RppI9cA2SfuqRpKKs80O6yfhtGV+mxwchLp6G
         vnRlKOeo7a9503ENGeY56X151uGOnpzEFZqfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIkWHd2cZrXCgkMKwvQCLGQPOiyLHkTkobG1AOxnzrA=;
        b=Wv5/ENJZe5yiSsOgJiUd75kywtZtXn+trMB/9HRKaIxkqj8C+ybUis1EUQNAj9lA/G
         PruU0vtIuNadLSPd/fWw5+wfGyXvUz8gos/iN9JGMcdbX1FX+EHkQ6aVLMqmvMbRwqzP
         YS8B1+jj11xoBOQN+ZAYkNXwtZgkWboXD+Blt2xUPLxWYjtb/zkIuuOoctwTGgNVZl4U
         Lin6j24YrZd4AnJresKjiAkUoqDiR8BUuL46zc+8XA2UCZDtZA5J98BvauYLa+V8d7xB
         XQLIw61ulBSgFLUFbu3XcJqSAa3U52+eol1yO+Nzttiim7sV9ouiBvUGMw/JKfD44eDa
         L8KA==
X-Gm-Message-State: AJcUukeoXB4dNa7guEW6bBmtinxRFLmedM1Hq/WMwJsTNt3wfSeKQnEv
        IrqMxRqmvcBYlsacEWSfpOorY33AMxY=
X-Google-Smtp-Source: ALg8bN50duBq1WdtNWkikyo1xYLOSK0W9XvRu9oomrry4XOQ7V7NTKCW9oag8ZCpvoZdNZHsuNODDw==
X-Received: by 2002:a1f:7244:: with SMTP id n65mr12653060vkc.75.1548122129228;
        Mon, 21 Jan 2019 17:55:29 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id l13sm93885340vka.16.2019.01.21.17.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 17:55:28 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id d19so7536626uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 17:55:28 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr12357457uaf.106.1548122127669;
 Mon, 21 Jan 2019 17:55:27 -0800 (PST)
MIME-Version: 1.0
References: <5c4585eb.1c69fb81.488aa.06ceSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c4585eb.1c69fb81.488aa.06ceSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 14:55:16 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJ_a-UHUVFCdmhxFQH1iMRDxW3ECJz7b=hh7u0WTwJ9Tw@mail.gmail.com>
Message-ID: <CAGXu5jJ_a-UHUVFCdmhxFQH1iMRDxW3ECJz7b=hh7u0WTwJ9Tw@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Add ramoops_register_dummy failure process
To:     Yue Hu <huyue2@yulong.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 9:42 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From 0888dbf0e3ac4a6a8a6307e97d003e8deb9cc6db Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Mon, 21 Jan 2019 14:30:19 +0800
> Subject: [PATCH] pstore/ram: Add ramoops_register_dummy failure process
>
> If create dummy/dummy_data failed, platform_driver_register()
> could also return 0 which leads to successful ramoops_init().
> This logic is not reasonable, it should tell kernel ramoops is
> failed. This change can also avoid duplicated ramoops dummy
> unregister and remove some unnecessary messages too.

No, this is working as intended (perhaps this code needs better
comments). If there is no module parameters, they may yet still be a
custom platform driver (see
drivers/platform/chrome/chromeos_pstore.c), or device tree entry (see
Documentation/admin-guide/ramoops.rst).

-Kees

>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/ram.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 64a51cd..7fb97aa 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -905,7 +905,7 @@ static inline void ramoops_unregister_dummy(void)
>         dummy_data = NULL;
>  }
>
> -static void __init ramoops_register_dummy(void)
> +static int __init ramoops_register_dummy(void)
>  {
>         /*
>          * Prepare a dummy platform data structure to carry the module
> @@ -913,15 +913,13 @@ static void __init ramoops_register_dummy(void)
>          * parameters, and we can skip this.
>          */
>         if (!mem_size)
> -               return;
> +               return -EINVAL;
>
>         pr_info("using module parameters\n");
>
>         dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
> -       if (!dummy_data) {
> -               pr_info("could not allocate pdata\n");
> -               return;
> -       }
> +       if (!dummy_data)
> +               return -ENOMEM;
>
>         dummy_data->mem_size = mem_size;
>         dummy_data->mem_address = mem_address;
> @@ -942,18 +940,20 @@ static void __init ramoops_register_dummy(void)
>         dummy = platform_device_register_data(NULL, "ramoops", -1,
>                         dummy_data, sizeof(struct ramoops_platform_data));
>         if (IS_ERR(dummy)) {
> -               pr_info("could not create platform device: %ld\n",
> -                       PTR_ERR(dummy));
> -               dummy = NULL;
>                 ramoops_unregister_dummy();
> +               return PTR_ERR(dummy);
>         }
> +       return 0;
>  }
>
>  static int __init ramoops_init(void)
>  {
>         int ret;
>
> -       ramoops_register_dummy();
> +       ret = ramoops_register_dummy();
> +       if (ret)
> +               return ret;
> +
>         ret = platform_driver_register(&ramoops_driver);
>         if (ret != 0)
>                 ramoops_unregister_dummy();
> --
> 1.9.1
>
>
>
>


-- 
Kees Cook
