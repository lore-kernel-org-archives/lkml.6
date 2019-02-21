Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C546BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9312920880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nrkzUn6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfBUAHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:07:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40905 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBUAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:07:41 -0500
Received: by mail-vs1-f65.google.com with SMTP id z18so15132464vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRKBx2tAAhYMU3oy+6HW7xnfCYbxJzmVxaOevapArmM=;
        b=nrkzUn6oG98z5yqEMRbhVq9XOuhwv+086wge8d8IPhS+LFwKbnpFq8rA+c5hq7pexf
         PKFQPqdU2X9lWLukGFYhOAq6sp3UxPaTAzm67PCgAuG2UXbub3gvl16UzbyJq8UiVon/
         NJKoEV3XXCOBp2Z92Qqd+AAzF3r9Rue4L36ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRKBx2tAAhYMU3oy+6HW7xnfCYbxJzmVxaOevapArmM=;
        b=tOwF+HIcE17m2TsIb1o+h1Uim6JWCqum5VGMscwqixTygSRB40n6nkuyTqdx47iBYC
         aNXDt960/PHmKdFlFTEorUuB5HN2n/OxKFKeU4hcGVcSOGbf/TymQuxAxO9RZnbsfYqn
         FsGuXHoP9EOy44QOlS7+DCsdsh0945SpS1GgyNRQU0qEywAPeLPsSlKhDJLdAx9BLVH7
         R1d2VY9fgP19Pn00acEZHcj9JDOT/9RKVbWYtwvuKLC3yNBgqZee2aoDL3O7GHKy5zs3
         4ThDqqpL84HsgSREH48ZDtPEDPttXS5+rjvd+kgkxdDb1O/EQ8kIUF9AEXCJvtkBEB8K
         1RcA==
X-Gm-Message-State: AHQUAuYFTEF9wuCgOEHD3mOFrQE2+kQ3lzIYclKMinLGb7o2O1k5z0kP
        kRKcT+XxgzZ/KU6C73eAc8ufar9A854=
X-Google-Smtp-Source: AHgI3IbVIsJaws245ghJGEQzbCRpRE42LrYIhMam65bdijQzZcfHohoJUMtJU5vTCCWQ4cB6zvJJCg==
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr13441238vsq.215.1550707659250;
        Wed, 20 Feb 2019 16:07:39 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id t133sm19099621vsc.8.2019.02.20.16.07.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:07:38 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id v187so4157406vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:07:38 -0800 (PST)
X-Received: by 2002:a1f:998d:: with SMTP id b135mr20727031vke.44.1550707657673;
 Wed, 20 Feb 2019 16:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-4-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-4-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 16:07:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ++_VufY8t3WYsGW8VN-3yJEbVpOi_67RxHPicCC-K6A@mail.gmail.com>
Message-ID: <CAGXu5jJ++_VufY8t3WYsGW8VN-3yJEbVpOi_67RxHPicCC-K6A@mail.gmail.com>
Subject: Re: [PATCH 3/6] lib/string: Use correct docstring format
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Currently the docstring comments for strscpy() are not in the correct
> format.  Prior to working on this file fix up the docstring.
>
> Use correct docstring format for strscpy().

Is this attached to "make htmldocs" anywhere? Maybe in the device
driver api doc? That's where I put refcount_t. See
driver-api/basics.rst and put something like:

String Handling
--------------------

.. kernel-doc:: lib/string.c
   :internal:

and add that chunk to this patch.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/string.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index 7f1d72db53c5..65969cf32f5d 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
>   * @src: Where to copy the string from
>   * @count: Size of destination buffer
>   *
> - * Copy the string, or as much of it as fits, into the dest buffer.
> - * The routine returns the number of characters copied (not including
> - * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
> - * The behavior is undefined if the string buffers overlap.
> - * The destination buffer is always NUL terminated, unless it's zero-sized.
> + * Copy the string, or as much of it as fits, into the dest buffer.  The
> + * behavior is undefined if the string buffers overlap.  The destination
> + * buffer is always NUL terminated, unless it's zero-sized.
>   *
>   * Preferred to strlcpy() since the API doesn't require reading memory
>   * from the src string beyond the specified "count" bytes, and since
> @@ -175,6 +173,9 @@ EXPORT_SYMBOL(strlcpy);
>   * doesn't unnecessarily force the tail of the destination buffer to be
>   * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
>   * check the return size, then just memset() the tail of the dest buffer.
> + *
> + * Return: The number of characters copied (not including the trailing
> + *         NUL) or -E2BIG if the destination buffer wasn't big enough.
>   */
>  ssize_t strscpy(char *dest, const char *src, size_t count)
>  {
> --
> 2.20.1
>


-- 
Kees Cook
