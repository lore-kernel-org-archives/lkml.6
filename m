Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6AAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841F22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8qheqqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841F22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeLKNpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:45:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44936 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:45:03 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so11768687iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9sQkAAtn2j+B/eG6nV+WxPFHWxvsOW4cNfp2WIK/CQ=;
        b=W8qheqqEnn3cGQbnEGKZ2cUmE3ClyYDHisWwH9SJ15ifncbKC5FuoDZHHGH+YRdz2Y
         lS3TuH2JtgD6a6WbDbW6vfY9eOhTwOqMhOl9MDsnP2+x7zSd5WjpR8Y854pbCHsXl8Zj
         tFaCN+bu5zKtvSrwEHBD5VvIvVgHOzeciXH8o4+JIV1S2Mq/AL74C7948e9hO+71W13m
         ieRenRt7V+rLi4FNWwbfQFJYoPkEyObA7M3Nui17Rx5YkAspRlKwt7uhGkRE1LEhD+RL
         AWoZPu/TT/l51Y9//fbKiYFCQjFPRR2UZ0nvf6QFGJQJ09co+9japNfw19IHJGRp3mze
         26pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9sQkAAtn2j+B/eG6nV+WxPFHWxvsOW4cNfp2WIK/CQ=;
        b=rWoNTts+E+MimN0Oq2jH/baVCfLdNUx6qyCHief4E/gYbSb+ucd5adIzj9H7E6Uv28
         Rv2KIm2XzfkeXFvbLvfNLPIgNzop5gIuNYKIPT4lBVchI22U2cHmiViBJi/vGssSGOsL
         W0+7nGrTUSBJlkS36Y4zr2/U8Vw8tuoAKFmREwvLQhqjURtpG6kIMX8XMj7cLcO8ABB8
         xapgcvomRUAzgykQrvPX74szbSwtpdeu/wWAxi+TLluTSWdg1bOwuH7WcfIz8ED75JJN
         XQoNfthiqLsmswpA5f9oeaTsAQm8+na54g6paf+M5iKQqb1ZXdO3eDu3XYFmgKCMThzw
         g3fQ==
X-Gm-Message-State: AA+aEWazti2x1qJIBg5mGIdA1BnFizDsZMpDrBI5scYfTOajYzNh8UA+
        hfbfo7ZmK+Zcy3Tt3CZhUNO0jMYGfXl84gg2bQBwlQ==
X-Google-Smtp-Source: AFSGD/UPBgozwfY2EB3HOU56jA4WFFLUVTqsF+rDHcK9gIYFaeLgf8frlD2wjhGCL4XZzTJxBQFkbSh3dc+3ezXlBBw=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr13057010iom.11.1544535901894;
 Tue, 11 Dec 2018 05:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20181211133453.2835077-1-arnd@arndb.de>
In-Reply-To: <20181211133453.2835077-1-arnd@arndb.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Dec 2018 14:44:50 +0100
Message-ID: <CACT4Y+bRzY9hO5b=TjHeXTsVVO1z3eBOHz6oLgBhVR4OSm1d1w@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        anders.roxell@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building little-endian allmodconfig kernels on arm64 started failing
> with the generated atomic.h implementation, since we now try to call
> kasan helpers from the EFI stub:
>
> aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in function `atomic_set':
> include/generated/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
>
> I suspect that we get similar problems in other files that explicitly
> disable KASAN for some reason but call atomic_t based helper functions.
>
> We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
> that the compiler sets instead of checking CONFIG_KASAN, but this in turn
> requires a small hack in mm/kasan/common.c so we do see the extern
> declaration there instead of the inline function.


Alexander, I think you are doing a similar thing for similar reasons
in KMSAN patch (see KMSAN_CHECK_ATOMIC_PARAMS):
https://github.com/google/kmsan/commit/17ebbfe19624c84adf79b0e5a74fd258c49ff12b
Namely, non-KMSAN-instrumented files must not get KMSAN callbacks from
atomics too.

Arnd patch does it the other way around: non-instrumented files need
to opt-in instead of opt-out.
Let's settle on a common way to do this, so that we can use it
consistently across all tools.



> Fixes: b1864b828644 ("locking/atomics: build atomic headers as required")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kasan-checks.h | 2 +-
>  mm/kasan/common.c            | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index d314150658a4..a61dc075e2ce 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_KASAN_CHECKS_H
>  #define _LINUX_KASAN_CHECKS_H
>
> -#ifdef CONFIG_KASAN
> +#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
>  void kasan_check_read(const volatile void *p, unsigned int size);
>  void kasan_check_write(const volatile void *p, unsigned int size);
>  #else
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 03d5d1374ca7..51a7932c33a3 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -14,6 +14,8 @@
>   *
>   */
>
> +#define __KASAN_INTERNAL
> +
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> --
> 2.20.0
>
