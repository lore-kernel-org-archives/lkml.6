Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB3BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DC32146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGYHxNoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfBUAsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:48:36 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43138 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:48:35 -0500
Received: by mail-vs1-f66.google.com with SMTP id i15so12557348vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qoEIm9QOpARKQzRDIM5YOb0J+XSgKTcGWX9ZCHCZOI=;
        b=AGYHxNoZV44F9cPuw6mkxcZBweYnalbzmiEFd8ydu6n9YcQnX+H96PlqX7pZMH4f6F
         zEnX8G6wrPkeMMpUiWjVYVyYdpAjFxrBmktcNedmE5QYroE604Iubmjz/3+0yQTlkdHE
         Dvi6LplpFd5auMqdnRSKcnXJdbxOdgJI31VKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qoEIm9QOpARKQzRDIM5YOb0J+XSgKTcGWX9ZCHCZOI=;
        b=s/4HycwI9sGctxBPi/g84amtvs0WoJuEzj8BCJye0JWDUJiSi6mwXP0XD+WCgnWC+D
         IJrBKS470oxW/X+p8b1vse/2jWVUvpf1iQv1YuOCedqPHJnk44kyGd0Dhbl/0Q39syDQ
         ScP+ACU6dHrR1nkv6+0rFaXZKxuxhrpHNBuG4gVAJLwlg5TqoxM253RJhf4VWhcMt15c
         7mKkDmMfr5QfUeuIgRF2rQ1v+ps9TE8cTCNIlOJtjAbJ62AJ9INYFYS0mfi9jdPV84Zj
         Pj90kNyIB/MenXr4yrNzQGFzk8nfiL0bNnINQmkvuuHG6C4cuuOzuiOloPFGHw+fZMJ7
         bHMA==
X-Gm-Message-State: AHQUAuaIWBF18sfOg4ALWNj0uPqqDnVSWMaEh98yRGKEsfuPU3EBwFEZ
        /1zYjrhn5kOd+pU63d2ctwqDzolhoek=
X-Google-Smtp-Source: AHgI3IbYqi7f03uxgdmJrlej9p8FPw4dRDxPIDDPwDd09OYA4aIT4Mx6BleKov1I+irKxDbjyofdQw==
X-Received: by 2002:a67:8809:: with SMTP id k9mr20424627vsd.223.1550710113521;
        Wed, 20 Feb 2019 16:48:33 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id y132sm4346180vkd.44.2019.02.20.16.48.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:48:32 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id v26so8928390uap.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 16:48:31 -0800 (PST)
X-Received: by 2002:ab0:74cb:: with SMTP id f11mr18163138uaq.14.1550710111449;
 Wed, 20 Feb 2019 16:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-5-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-5-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 16:48:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJe7CiQ0aResT4Hnsuhm+grZyLTcVAkdwsBdtbdrnBbuQ@mail.gmail.com>
Message-ID: <CAGXu5jJe7CiQ0aResT4Hnsuhm+grZyLTcVAkdwsBdtbdrnBbuQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] lib/string: Add string copy/zero function
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> We have a function to copy strings safely and we have a function to copy
> strings _and_ zero the tail of the destination (if source string is
> shorter than destination buffer) but we do not have a function to do
> both at once.  This means developers must write this themselves if they
> desire this functionality.  This is a chore, and also leaves us open to
> off by one errors unnecessarily.
>
> Add a function that calls strscpy() then memset()s the tail to zero if
> the source string is shorter than the destination buffer.
>
> Add testing via kselftest.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  include/linux/string.h |  4 ++++
>  lib/Kconfig.debug      |  2 +-
>  lib/string.c           | 30 ++++++++++++++++++++++++++++--
>  lib/test_string.c      | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f80c..695a5e6a31e3 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
>  #ifndef __HAVE_ARCH_STRSCPY
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
> +
> +/* Wrapper function, no arch specific code required */
> +ssize_t strscpy_zeroed(char *dest, const char *src, size_t count);

bikeshed: I think "pad" is shorter and more descriptive. How about
something like strspad() strscpy_pad() or strscpy_zero()? (just to
shorten it slightly)

Not a blocker, just a TODO: we need a wrapper to do
CONFIG_FORTIFY_SOURCE checking for strscpy() (and strscpy_zeroed()) to
check for __builtin_object_size() vs the "size" argument, as done in
strlcpy() in include/linux/string.h

> @@ -238,6 +237,33 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
>  EXPORT_SYMBOL(strscpy);
>  #endif
>
> +/**
> + * strscopy_zeroed() - Copy a C-string into a sized buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @count: Size of destination buffer
> + *
> + * If the source string is shorter than the destination buffer, zeros
> + * the tail of the destination buffer.
> + *
> + * Return: The number of characters copied (not including the trailing
> + *         NUL) or -E2BIG if the destination buffer wasn't big enough.
> + */
> +ssize_t strscpy_zeroed(char *dest, const char *src, size_t count)
> +{
> +       ssize_t written;
> +
> +       written = strscpy(dest, src, count);
> +       if (written < 0)
> +               return written;

If written < 0 we filled everything (i.e. we wrote "count - 1" bytes).
If we also exactly wrote "count - 1", then we also don't need the zero
padding either, since strscpy wrote the trailing NUL.

so:

if (written < 0 || (count && written == count - 1))
    return written;

> +
> +       if (written < count)
> +               memset(dest + written, 0, count - written);

Now we know written must be [0, count - 2], so we can just:

memset(dest + written + 1, 0, count - written - 1);

The pattern (which should be added to the seltest) is:

count           source  written                                 pad@
0               *       -E2BIG (0 char, 0 NUL, 0 to zero)

1               "a"     -E2BIG (0 char, 1 NUL, 0 to zero)
1               ""      0 (0 char, 1 NUL, 0 to zero)

2               "ab"    -E2BIG (1 char, 1 NUL, 0 to zero)
2               "a"     1 (1 char, 1 NUL, 0 to zero)
2               ""      0 (0 char, 1 NUL, 1 to zero)            dest + 1

3               "abc"   -E2BIG (2 char, 1 NUL, 0 to zero)
3               "ab"    2 (2 char, 1 NUL, 0 to zero)
3               "a"     1 (1 char, 1 NUL, 1 to zero)            dest + 2
3               ""      0 (0 char, 1 NUL, 2 to zero)            dest + 1

4               "abcd"  -E2BIG (3 char, 1 NUL, 0 to zero)
4               "abc"   3 (3 char, 1 NUL, 0 to zero)
4               "ab"    2 (2 char, 1 NUL, 1 to zero)            dest + 3
4               "a"     1 (1 char, 1 NUL, 2 to zero)            dest + 2
4               ""      0 (0 char, 1 NUL, 3 to zero)            dest + 1


> +
> +       return written;
> +}
> +EXPORT_SYMBOL(strscpy_zeroed);
> +
>  #ifndef __HAVE_ARCH_STRCAT
>  /**
>   * strcat - Append one %NUL-terminated string to another
> diff --git a/lib/test_string.c b/lib/test_string.c
> index a9cba442389a..cc4eef51a395 100644
> --- a/lib/test_string.c
> +++ b/lib/test_string.c
> @@ -111,6 +111,32 @@ static __init int memset64_selftest(void)
>         return 0;
>  }
>
> +static __init int strscpy_zeroed_selftest(void)
> +{
> +       char buf[6];
> +       int written;
> +
> +       memset(buf, 'a', sizeof(buf));
> +
> +       written = strscpy_zeroed(buf, "bb", 4);
> +       if (written != 2)
> +               return 1;
> +
> +       /* Copied correctly */
> +       if (buf[0] != 'b' || buf[1] != 'b')
> +               return 2;
> +
> +       /* Zeroed correctly */
> +       if (buf[2] != '\0' || buf[3] != '\0')
> +               return 3;
> +
> +       /* Only touched what it was supposed to */
> +       if (buf[4] != 'a' || buf[5] != 'a')
> +               return 4;
> +
> +       return 0;
> +}

Cool, I like both the positive and negative tests. :) Can you add all
the cases above, too, which should validate the various corners?

> +
>  static __init int test_string_init(void)
>  {
>         int test, subtest;
> @@ -130,6 +156,11 @@ static __init int test_string_init(void)
>         if (subtest)
>                 goto fail;
>
> +       test = 4;
> +       subtest = strscpy_zeroed_selftest();
> +       if (subtest)
> +               goto fail;
> +
>         pr_info("String selftests succeeded\n");
>         return 0;
>  fail:
> --
> 2.20.1
>

Nice! :)

-- 
Kees Cook
