Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40568C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1171E2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcBUe8RV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBUSke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:40:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43238 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:40:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so10191261uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mp4pnfHys4jvF3jBuqE7QwrktgZBhoaCym5yPDpKHeg=;
        b=mcBUe8RVc+BNX/A93n/s92MRPTsIq3fkWmu4KLSKhzTjRmoHVbW0EuS51Sri43Mm0s
         Bo5+eNa4eNexgve62I62L7pDbXsLDBNjbdYLPdUCB6lgxZcw1+CvmnQ0CuKzddKUt44H
         RRQL0xNn0IthNuQKXSyp7Q9sq6LqnoVarO2ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mp4pnfHys4jvF3jBuqE7QwrktgZBhoaCym5yPDpKHeg=;
        b=FtQKeaKHYUzcCXhmJSskbAQ67V+MiXBb1VtZQgMDrKn+axE44TC7w/s6/xTdaknf7m
         rBiJBbbXcIIKYp6eejGwVqSqtK/G0ZJjbmYuO+Y7Zs0OIMxqRzgqjJ5j4hFBlb+p+iy/
         UVMGzqx/TqyhqhYWObEcFji9G12zkDQNCCcalyD5saQZwrH0HTR6LtkNbJgxbc6zvX2B
         Tp/Y3FN2Pye0qNQ3fce27m2hLKuXoUmY3Xna4etUi057+iIXoQ9aIyDkxyeAEOhuTcmP
         WTHskQG14fR2u9feJAW2oS5mH9i1bm+1ZxqRU5A4QJQJDa9BQFhop7W2yiONYQMtiDaF
         fsQg==
X-Gm-Message-State: AHQUAuYsNnaVkoSFf89C7r5qBVmCUlk/sBg/C9I4vQ+bY1t9DZ7ZnTDU
        JJc+E3dKvO7+sUisHonjrShDK+hjFvU=
X-Google-Smtp-Source: AHgI3IblxjsJVYiP0Mit+/vUBm2Q/fRgYCHxsxhZE25DV2RlITsAKEbeHwavvjOptYgFsvcE8ug1sw==
X-Received: by 2002:a67:8809:: with SMTP id k9mr22685695vsd.223.1550774432883;
        Thu, 21 Feb 2019 10:40:32 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id f188sm3696875vkg.11.2019.02.21.10.40.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:40:31 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id s15so10196117uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:40:31 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr20620554vsc.222.1550774431262;
 Thu, 21 Feb 2019 10:40:31 -0800 (PST)
MIME-Version: 1.0
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com> <8166cf23-db52-7679-3378-8523889a9cd0@sandeen.net>
In-Reply-To: <8166cf23-db52-7679-3378-8523889a9cd0@sandeen.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 10:40:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+m8TBnBZYUAAeS-e8d-ZtPWZ+KFw=ibGAekHs9JT57nA@mail.gmail.com>
Message-ID: <CAGXu5j+m8TBnBZYUAAeS-e8d-ZtPWZ+KFw=ibGAekHs9JT57nA@mail.gmail.com>
Subject: Re: [PATCH] sysctl: add proc_do_large_bitmap test node
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 9:45 AM Eric Sandeen <sandeen@sandeen.net> wrote:
>
> Add a test node for proc_do_large_bitmap to the test_sysctl.c
> infrastructure.  It's sized the same as the one existing user.
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 3dd801c1c85b..1263be4ebfaf 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -47,6 +47,9 @@ struct test_sysctl_data {
>         unsigned int uint_0001;
>
>         char string_0001[65];
> +
> +#define SYSCTL_TEST_BITMAP_SIZE        65536
> +       unsigned long *bitmap_0001;
>  };
>
>  static struct test_sysctl_data test_data = {
> @@ -102,6 +106,13 @@ static struct ctl_table test_table[] = {
>                 .mode           = 0644,
>                 .proc_handler   = proc_dostring,
>         },
> +       {
> +               .procname       = "bitmap_0001",
> +               .data           = &test_data.bitmap_0001,
> +               .maxlen         = SYSCTL_TEST_BITMAP_SIZE,
> +               .mode           = 0644,
> +               .proc_handler   = proc_do_large_bitmap,
> +       },
>         { }
>  };
>
> @@ -129,15 +140,21 @@ static struct ctl_table_header *test_sysctl_header;
>
>  static int __init test_sysctl_init(void)
>  {
> +       test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
> +       if (!test_data.bitmap_0001)
> +               return -ENOMEM;
>         test_sysctl_header = register_sysctl_table(test_sysctl_root_table);
> -       if (!test_sysctl_header)
> +       if (!test_sysctl_header) {
> +               kfree(test_data.bitmap_0001);
>                 return -ENOMEM;
> +       }
>         return 0;
>  }
>  late_initcall(test_sysctl_init);
>
>  static void __exit test_sysctl_exit(void)
>  {
> +       kfree(test_data.bitmap_0001);
>         if (test_sysctl_header)
>                 unregister_sysctl_table(test_sysctl_header);
>  }
>


-- 
Kees Cook
