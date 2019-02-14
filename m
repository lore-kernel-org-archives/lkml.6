Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25636C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69CE20823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NbQpkTDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407859AbfBNQWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:22:48 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40487 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404917AbfBNQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:22:47 -0500
Received: by mail-ua1-f67.google.com with SMTP id c5so295627uaq.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De1M2uOQLitpM1G0Or/O1X7lkUYE1szLVW86srBvkyw=;
        b=NbQpkTDVWMEILL4BQaTiRnty4NfyMwvFmoq8FcOjgK1UGq5hnmeJf+p8batXLyWHma
         YzR9JkxvLZFrP/mI/C3YNSlwuciYyn/xvmuS4VSxRaYP2jZkKULss9BlNZ7THfw7pQ2v
         WG7p53l8w3xvz6oHSluj3/e78yslBPgKByOcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De1M2uOQLitpM1G0Or/O1X7lkUYE1szLVW86srBvkyw=;
        b=EqKywrFWR//0IQGfFGIB1oLXGQFaYDhO4FsAKzr4I+I1wILIjy/U8iG2PEPh1MacCX
         00iYZUV5k0IxFu2Ge3XR21Ef0oNO/Ke4HTh5ppsF4HObd13FtT8hzbEQ1I2QyOnMOrjr
         dlCY/CETehUY5nWkdQEiFaNp+YCyXDbBAkucnteck9QXDyRoBr5juIX7obDzD3oHTrZx
         y/g0RobwcVPiKjgzDW16QZvVURjBS4UOqY0gewGnGvwjBHpoAcE+fKMqcWY7zC1EpjuS
         zol2eIX8CuTRRnzrJtAfxwOW6F+ob3nzSbwtvrRYdbj5ycPZzZQ92aZphD+z2CAnoWCo
         hdfQ==
X-Gm-Message-State: AHQUAuYMZep+Mgp9wkvVEpF6sYf4huYPTqcQxKRrru8DZYNZdDRZAV8i
        ezNa0QItcvkPYqRzIxnVQrbP+FQa+eU=
X-Google-Smtp-Source: AHgI3IattGGXuMD13NUaf9JCjknQy5mdSRAG6pFqd1qijXWCmJYPdXcqVc5AyhYbZbFyzx24zpQq4g==
X-Received: by 2002:ab0:470d:: with SMTP id h13mr2402800uac.122.1550161366101;
        Thu, 14 Feb 2019 08:22:46 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id b1sm2767785vkf.9.2019.02.14.08.22.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:22:45 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id z18so3981602vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:22:44 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr2564321vsi.66.1550161364502;
 Thu, 14 Feb 2019 08:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20190214193113.0000609f.zbestahu@gmail.com>
In-Reply-To: <20190214193113.0000609f.zbestahu@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Feb 2019 08:22:32 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Oi_2SyUb=pZ37PtGyPCvuZqnxAaGKDMiTsO0qWE6Rtg@mail.gmail.com>
Message-ID: <CAGXu5j+Oi_2SyUb=pZ37PtGyPCvuZqnxAaGKDMiTsO0qWE6Rtg@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Avoid possible failure of dummy device unregister
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:31 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> From 08ac260f36b4c11eb33fa58466462a5e1027bdb3 Mon Sep 17 00:00:00 2001
> From: Yue Hu <zbestahu@gmail.com>
> Date: Thu, 14 Feb 2019 19:34:16 +0800
> Subject: [PATCH] pstore/ram: Avoid possible failure of dummy device unregister
>
> If create dummy platform device failed, dummy variable should not
> been set as NULL. Because the following platform_device_unregister()
> will judge if the dummy is NULL or not, if dummy is NULL nothing
> happen for unregister flow.
>
> Signed-off-by: Yue Hu <zbestahu@gmail.com>

I've gotten this email a few times today. :)

I already replied that this isn't what we want to do: we have to mark
it NULL since prior to that it was an ERR_PTR, and will break the
unregister.

-Kees

> ---
>  fs/pstore/ram.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 4a06675..61bc573 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -994,7 +994,6 @@ static void __init ramoops_register_dummy(void)
>         if (IS_ERR(dummy)) {
>                 pr_info("could not create platform device: %ld\n",
>                         PTR_ERR(dummy));
> -               dummy = NULL;
>                 ramoops_unregister_dummy();
>         }
>  }
> --
> 1.9.1
>


-- 
Kees Cook
