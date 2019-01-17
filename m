Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC05C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68DF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LrK0CZYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfAQQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:56:46 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37869 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfAQQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:56:45 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so3701333uae.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70nZCuQkIKbRfqYUZVeK7oZl5fyaWnmUBg0C0u3l2OE=;
        b=LrK0CZYEJNpsxz8cLymvHGgUVV5qg8W+/CAFIxN1fZBIypBnacGhvo5OYmAZBfoCTH
         E8FFnUJvFZggqjFEh7oqYz/CMn5mVOranCwI3CSFOdOIdo+AXGQflkLyb3CEz7XyDMJ0
         ZO6/Q0HWe0HZwUU5uspjr/SG3LM4VjHrFsZrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70nZCuQkIKbRfqYUZVeK7oZl5fyaWnmUBg0C0u3l2OE=;
        b=bjU6cizHCgsIKvlkAlAn5pQ+KhBKhKvpY354EzcyQPnsDv71I3n0G63fu0+FFlIb4Z
         DXFWqTgbprmsdzkkSYo6ZqWFg+LdWi6Rjt+boCTA5wi1bnWhWrLhn6uYv+x59tMiYvdg
         92sB0scL66igOTwrVH9qv6tB+msi+pq1q7czPXGzg0qu0Pd176vNsnov4CA1kg2z2vgt
         Y84QxeJos6yVAaH1ryQJObQj98H7y/tRbetbutfLABF+mztDQj7tIlJ4YTbg8Z0GYqaX
         1LRb5RVKoy+hKLXezXMI+aU//VbnXf5RNmWHYjiEMWZwGztpYc2eFiqF06iKhQK6kD2N
         0N1Q==
X-Gm-Message-State: AJcUukfx6/VHRXmOI1sFMj3ezhsCUT94DFzeN/wafB8Jli9udyetiCmV
        XAXpxrp0pfNtgsSaLYhagwUK6zdtXww=
X-Google-Smtp-Source: ALg8bN6ZgGG/P/YN2yDUpUu6IGv/R6kzCraqDAG50XU/85rp74pXPS7O7nQiU+zzd0ddRnsMV6RQRg==
X-Received: by 2002:ab0:3b7:: with SMTP id 52mr6087182uau.38.1547744204225;
        Thu, 17 Jan 2019 08:56:44 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id v19sm188128uao.3.2019.01.17.08.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:56:43 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id p9so3697660uaa.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:56:42 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr6185447uaa.10.1547744202573;
 Thu, 17 Jan 2019 08:56:42 -0800 (PST)
MIME-Version: 1.0
References: <5c400062.1c69fb81.baac0.7895SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c400062.1c69fb81.baac0.7895SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 08:56:30 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+HMj92iN+H1482TvWkxf7iv1w95Ru6Z_1kNzPuVjmXUw@mail.gmail.com>
Message-ID: <CAGXu5j+HMj92iN+H1482TvWkxf7iv1w95Ru6Z_1kNzPuVjmXUw@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Fix failure-path memory leak in ramoops_probe
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

On Wed, Jan 16, 2019 at 8:11 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From 12a3e710e54a00f1ccb781d38707e7d4b344403b Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Wed, 16 Jan 2019 16:58:19 +0800
> Subject: [PATCH] pstore/ram: Fix failure-path memory leak in
> ramoops_probe
>
> Missing devm_kfree(pdata) if probe fail with successful allocation
> of platform data buffer via devm_kzalloc().

Actually, I think this is missing a free in the normal path too. pdata
is only allocated when:

    !dev->platform_data && dev_of_node(dev)

So I think it needs to be freed in both places. However, devm_*alloc()
really only makes sense for something that will have a scope larger
than the current function. Instead, I think we should just switch this
to a stack variable and be done with it. Something like this (pardon
whitespace damage):

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 96f7d32cd184..be7142ae3937 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -711,18 +711,15 @@ static int ramoops_probe(struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
        struct ramoops_platform_data *pdata = dev->platform_data;
+       struct ramoops_platform_data local_data;
        struct ramoops_context *cxt = &oops_cxt;
        size_t dump_mem_sz;
        phys_addr_t paddr;
        int err = -EINVAL;

        if (dev_of_node(dev) && !pdata) {
-               pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-               if (!pdata) {
-                       pr_err("cannot allocate platform data buffer\n");
-                       err = -ENOMEM;
-                       goto fail_out;
-               }
+               pdata = &local_data;
+               memset(pdata, 0, sizeof(*pdata));

                err = ramoops_parse_dt(pdev, pdata);
                if (err < 0)


Does that look sensible to you?

-Kees

>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/ram.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index cb9cac1..f9a6a8d 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -612,6 +612,7 @@ static int ramoops_probe(struct platform_device
> *pdev) size_t dump_mem_sz;
>         phys_addr_t paddr;
>         int err = -EINVAL;
> +       bool free_pdata = false;
>
>         if (dev_of_node(dev) && !pdata) {
>                 pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata),
> GFP_KERNEL); @@ -619,6 +620,7 @@ static int ramoops_probe(struct
> platform_device *pdev) err = -ENOMEM;
>                         goto fail_out;
>                 }
> +               free_pdata = true;
>
>                 err = ramoops_parse_dt(pdev, pdata);
>                 if (err < 0)
> @@ -754,6 +756,8 @@ static int ramoops_probe(struct platform_device
> *pdev) fail_init_cprz:
>         ramoops_free_przs(cxt);
>  fail_out:
> +       if (free_pdata)
> +               devm_kfree(&pdev->dev, pdata);
>         return err;
>  }
>
> --
> 1.9.1
>
>
>
>


-- 
Kees Cook
