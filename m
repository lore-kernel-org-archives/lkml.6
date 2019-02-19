Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24778C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E421821773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US8PSd6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbfBSAwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:52:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33160 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBSAwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:52:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so31532873otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6bwZrtMcmwWydCM0A4I4xtuvFI7qdUWvEkyWRni/BI=;
        b=US8PSd6FUfcYc2XUsS80WLADA84lREh8Z+JAzV3OXFl5SiPDygqhbxKNfG1JvYl7rA
         qKW4uNtfNB71Iza43/+bjc+/ZzowBMT8DjTnOpWGDSZNoQsLGtjrzZDiNOE9SnYjU0vB
         MZFMdeP387hDj2VYzlsvLy58YBgiOjuPEaTAn9wMNq5fanRgd+JRDptAU9GDczeyufTz
         1Moebwft7AK3GW6ck8weNhzlmpVxySo2Xh1TO9tSXiDXFs0cWEko2K3oblFY/Hxrnaws
         vL+nh0xkbQz0E/agPcz+BLPTxVGo1i2E0UqhJL73cx36ZyGJdK33a+p5H6zj0HPPwAzw
         ttpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6bwZrtMcmwWydCM0A4I4xtuvFI7qdUWvEkyWRni/BI=;
        b=XRieJ2p1FmGIQ+KOxyOGVekoNqNFrgwu2GmE/qeBAynlcRk7x0ucdVfjKavaOykKWm
         4qzNhHPW6GNfLf5m97jpCXuIURB0fYxsvpsfV/L/mAXbi76PyWuIrN7p5YAaK4YaZ7KS
         MvP55O19/Y0yUFPknQ3xnEvUDM5ocuVWyLpFAkj/Kx5F4CM2x3a9IKC0AYPi6QK7HBnR
         sx8/1R3B+ottTzC51DCh2DhiG+nSvP1hjOAC2b0Bs4RU7rL7qnAStKKA7lnPY90jecg9
         plfl+2DVAb4DYNxy3YUstAzxrGBNGFdPYteaCItK50xgAK+7f3nlWu6Wdx3P1Ir9z3SE
         mklA==
X-Gm-Message-State: AHQUAuZIXNuiRg9bVSyhUumfIP0TT5Ju0r0BrG4uGFaiQVWD747gU65a
        CyeXf8k8H3gO8jRyxzU3JseJX5nhkn/PRliDJUuUvQ==
X-Google-Smtp-Source: AHgI3IYO8E3a/SGseRSdSex9FzoaqTpBby+dsgIUzkJu5gYGOaa/5d1Uy1UMM59JovYD+PpHLVEPIRJedQZmXBROt7o=
X-Received: by 2002:aca:e003:: with SMTP id x3mr971735oig.39.1550537531202;
 Mon, 18 Feb 2019 16:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-6-tobin@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Feb 2019 01:51:45 +0100
Message-ID: <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Andy because he's also preparing a patch for this function

On Tue, Feb 19, 2019 at 12:25 AM Tobin C. Harding <tobin@kernel.org> wrote:
> Current function documentation for strncpy_from_user() is incorrect.  If
> @count (size of destination buffer) is less than the length of the user
> string the function does _not_ return @count but rather returns -EFAULT.
>
> Document correctly the function return value, also add note that string
> may be left non-null terminated.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/strncpy_from_user.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 58eacd41526c..11fe9a4a00fd 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -82,22 +82,19 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
>  }
>
>  /**
> - * strncpy_from_user: - Copy a NUL terminated string from userspace.
> + * strncpy_from_user() - Copy a NUL terminated string from userspace.
>   * @dst:   Destination address, in kernel space.  This buffer must be at
>   *         least @count bytes long.
>   * @src:   Source address, in user space.
> - * @count: Maximum number of bytes to copy, including the trailing NUL.
> + * @count: Maximum number of bytes to copy, including the trailing %NUL.
>   *
>   * Copies a NUL-terminated string from userspace to kernel space.
>   *
> - * On success, returns the length of the string (not including the trailing
> - * NUL).
> - *
> - * If access to userspace fails, returns -EFAULT (some data may have been
> - * copied).
> - *
> - * If @count is smaller than the length of the string, copies @count bytes
> - * and returns @count.
> + * Return: If access to userspace fails, returns -EFAULT.  Otherwise,
> + *         return the number of characters copied excluding the trailing
> + *         %NUL, if the length of the user string exceeds @count return
> + *         -EFAULT (in which case @dst will be left without a %NUL
> + *         terminator).
>   */

AFAICS the byte_at_a_time loop exits when max==0 is reached, and then
if `res >= count` (in other words, if we've copied as many bytes as
requested, haven't encountered a null byte so far, and haven't reached
the end of the address space), we return `res`, which is the same as
`count`. Are you sure?
