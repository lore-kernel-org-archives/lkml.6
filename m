Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D061217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9AeXEx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBSCKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:10:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43307 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfBSCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:10:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so31644928ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFnc6TuIIf7eoV7IcHxKyahge7C07vk0gFTK0eynXic=;
        b=Q9AeXEx/pdrQgmMmAdxlPydfrVzm013cT82n86FlxsHofl6jJY92fLQOzs2SBFTmVr
         +2FiLHyxlDCqBYgj1sHFAFSioJlaExMBGJno1ATCL5NrYy9cS5/n4xMccfwcWOZ3K6tN
         BNbSvNP/2GQDzMqUVoQyQdKSSjyKS1HQ8hPwhYGkM1OyK/gyUVh3bCh8xS169W6s3aE7
         295XU9iZ8+FX2KrmxT3b5uNdWSqD6Fjout4V3TJDeY7x1U27UJRb0vBrvgdqQP2iAIKi
         sbYqdwXkFTkltML1OXmF+ge69bSR9y+ACWvi01dGIPz5G5pjyzQOnJa7+uYSMzxA+w9a
         ULbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFnc6TuIIf7eoV7IcHxKyahge7C07vk0gFTK0eynXic=;
        b=TfujQjOe54cdGtVucv1C2Xp2xu1QO8cdL4jYz34nK3DlDrouxVvUU5UHwu90FWKYwi
         LEX1RcNJaTMOTXwFoYwvtaI8ar2ncOilzSaJm8jLFmcAEW1GaXdCf1TB6TRXGdadByoW
         Z7AFqu44furorEG9japAca4gLijE2QA1S6a0TuaxsxNtq/4uPbAL5GfxEhlZ06W+DmoC
         KNcG0Z7pDDjGczOHNG32R9u0jlQ7TMcuxOjUJFaW1yClo3u9Hfz/7EQWvZll049PKa9/
         jvbQQdxSDX2F/0njx7c2DyxOCm8ju281bTvG1BFMc/AsVKbRD0jMm8wBUtJ/ImwRweET
         RSHA==
X-Gm-Message-State: AHQUAuaYrB0Pr01ViLH+FY7c13Rm2nB2PW6FofWqaiO7iteWm7/qunSx
        tpXpNKn2Jq8VipClg/k7lDSYWIazI3hZ4hIPsPr4qg==
X-Google-Smtp-Source: AHgI3IYV2zo1+VcrnJC/KtLVRCpG3R2ZtI/i7NhBZ40X7S6zc5GmLDy7I5bLWMlT+FQud+6rumZeuCC76X2rmUghyeA=
X-Received: by 2002:aca:aa07:: with SMTP id t7mr1080518oie.126.1550542200504;
 Mon, 18 Feb 2019 18:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-7-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-7-tobin@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Feb 2019 03:09:34 +0100
Message-ID: <CAG48ez0t4DJGnv6oVVtiEeR-m3Oz_Zt-JNNzrA2CD2aZWAamvA@mail.gmail.com>
Subject: Re: [PATCH 6/6] lib: Add function strscpy_from_user()
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:25 AM Tobin C. Harding <tobin@kernel.org> wrote:
> Currently we have strncpy_from_userspace().  If the user string is
> longer than the destination kernel buffer we get an error code -EFAULT.

No, see the other thread. If the user string is too long,
strncpy_from_userspace() fills the output buffer with non-null bytes
and returns the supplied length.

> We are unable to recover from here because this is the same error
> returned if the access to userspace fails totally.
>
> There is no reason we cannot continue execution with the user string
> truncated.
>
> Add a function strscpy_from_user() that guarantees the string written is
> null-terminated.  If user string is longer than destination buffer
> truncates the string.  Returns the number of characters written
> excluding the null-terminator.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/strncpy_from_user.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 11fe9a4a00fd..6bd603ccec7a 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -120,3 +120,46 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
>         return -EFAULT;
>  }
>  EXPORT_SYMBOL(strncpy_from_user);
> +
> +/**
> + * strscpy_from_user() - Copy a NUL terminated string from userspace.
> + * @dst:   Destination address, in kernel space.  This buffer must be at
> + *         least @count bytes long.
> + * @src:   Source address, in user space.
> + * @count: Maximum number of bytes to copy, including the trailing %NUL.
> + *
> + * Copies a NUL-terminated string from userspace to kernel space.  When
> + * the function returns @dst is guaranteed to be null terminated.
> + *
> + * Return: If access to userspace fails, returns -EFAULT.

That's wrong. Actually, you only return -EFAULT if the specified
source address points to an address outside the userspace address
range.

> Otherwise,
> + *         return the number of characters copied excluding the trailing
> + *         %NUL.
> + */
> +long strscpy_from_user(char *dst, const char __user *src, long count)
> +{
> +       unsigned long max_addr, src_addr;
> +
> +       if (unlikely(count <= 0))
> +               return 0;

The "supply a signed long and quietly bail out if it's smaller than
zero" pattern seems bad to me. If count is zero, you can't guarantee
that the buffer will be null-terminated, and if it's smaller than
zero, something has gone very wrong.

> +       max_addr = user_addr_max();
> +       src_addr = (unsigned long)src;
> +       if (likely(src_addr < max_addr)) {
> +               unsigned long max = max_addr - src_addr;
> +               long retval;
> +
> +               kasan_check_write(dst, count);
> +               check_object_size(dst, count, false);
> +               if (user_access_begin(src, max)) {
> +                       retval = do_strncpy_from_user(dst, src, count, max);
> +                       user_access_end();
> +                       if (retval == -EFAULT) {
> +                               dst[count-1] = '\0';
> +                               return count - 1;

Uh... this looks bad. If do_strncpy_from_user() gets a fault -
anywhere -, you just put a nullbyte at the end of the supplied buffer
and return? As far as I can tell, this means that the caller will
think that you've filled the entire buffer, but actually everything
except for the last byte might be uninitialized.

> +                       }
> +                       return retval;
> +               }
> +       }
> +       return -EFAULT;
> +}
> +EXPORT_SYMBOL(strscpy_from_user);
> --
> 2.20.1
>
