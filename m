Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69DF20866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0UhBioK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeLSVve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:51:34 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45667 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeLSVve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:51:34 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so8752966ywd.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GM5hGu4M0G7cLJiG/Agci333y79vb/B6Mg/bPozxqbQ=;
        b=d0UhBioKbOj3lUW4AGfleaR68HWYnVZ51nyMcG4O+WkRY3xIcpbjHL3t8lSkZPAkRg
         cWh00QeeQeSnJZQ5dJk30aggq6GezcAXHtyUyz6B0UFLiG/a1VChq4/l+jcxjcnvOrzk
         dj4vJSRiE4slCuvIBEKYqRGIZdIkmkPwvRxqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GM5hGu4M0G7cLJiG/Agci333y79vb/B6Mg/bPozxqbQ=;
        b=joJ0hRTt5iCIYibMee0yD+S8gKVqaOFgm7YL8lsJGYCVJN4MnXFwrvjNHOmoObAiGh
         VRSTZJGpHLJbUR8yq+Yreq2ZgKVoQWbEmYagI59Ck8UOaC69Jhw1LeNo48qsVvjzb30y
         JB1PDoWlXbpHmPUjxQzXTtSxl432UXMHpjGqOGS/n05ZrxNhwyO/m+Yhk/TdCXRhvZ3F
         +mIr1gvRaY+R2aDrxnoyTKdrv0ct5w2HzR6phbCdubzYN47246G0y132YGWPqijf2Jf2
         4yhKXiCUAZGQkHZBNNTwdvMcA+rbNfYpPQuecQ+Y9z+aE3/5VS2Zcd72p4JjuH8PSeUM
         ObDg==
X-Gm-Message-State: AA+aEWaIMJHoLbZG4Wv0rZuij++FhXcbczOClmCRGp+3jgTc9JD14jDl
        02qXB3XcIFfk/wO+a2hWEE7zqJpqYmw=
X-Google-Smtp-Source: AFSGD/Wee28JALnKkXwP6BaiFV/ZtghqVXHv5rnzC87l0NO6yckkqxYXDFHEfSG+By2zyNbpwD+3iw==
X-Received: by 2002:a81:7342:: with SMTP id o63mr22825597ywc.131.1545256291971;
        Wed, 19 Dec 2018 13:51:31 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id i21sm11616082ywg.5.2018.12.19.13.51.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:51:29 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 64so8502271ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:51:29 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr21956262ybi.171.1545256289326;
 Wed, 19 Dec 2018 13:51:29 -0800 (PST)
MIME-Version: 1.0
References: <ecb306ea6f4a83302e78884713ad7823@codeaurora.org>
In-Reply-To: <ecb306ea6f4a83302e78884713ad7823@codeaurora.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 19 Dec 2018 13:51:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK68J6xHMva1p6aM0ZoQDyY0QiEV3qW3K8UDoK-OeP5Ng@mail.gmail.com>
Message-ID: <CAGXu5jK68J6xHMva1p6aM0ZoQDyY0QiEV3qW3K8UDoK-OeP5Ng@mail.gmail.com>
Subject: Re: usercopy_warn in __copy_to_user
To:     rishabhb@codeaurora.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux-arm Kernel <linux-arm-kernel@lists.infradead.org>,
        tsoni@codeaurora.org, ckadabi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:51 AM <rishabhb@codeaurora.org> wrote:
>
>
> In the 4.19 kernel, we are seeing a USERCOPY_WARN in __copy_to_user
> during bootup.
> The code-flow is something like this:
>
> (arch/arm64/kernel/signal.c)
> struct sigset_t *set;
> __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set))
>
> (include/linux/uaccess.h)
> __copy_to_user(void __user *to, const void *from, unsigned long n)
> {
>                  might_fault();
>                  kasan_check_read(from, n);
>                  check_object_size(from, n, true);
>                  return raw_copy_to_user(to, from, n);
> }
>
> (include/linux/thread_info.h)
> static __always_inline void check_object_size(const void *ptr,
>                                   unsigned long n, bool to_user)
> {
>                  if (!__builtin_constant_p(n))
>                                  __check_object_size(ptr, n, to_user);
> }
>
> Since sizeof(*set) is constant, __builtin_constant_p(n) should return
> true.
> But we are seeing that its returning the value as false. Because of
> which
> the code goes on to __check_object_size and generates a USERCOPY_WARN
> ("usercopy: WARN() on slab cache usercopy
> region violations").
>
> We are using LLVM clang version 6.0 to compile the kernel and not gcc.

This is fixed in the latest LLVM and Clang:

https://github.com/ClangBuiltLinux/linux/issues/7

-Kees

> In clang, __builtin_constant_p is evaluated immediately, before inlining
> or other optimizations run, gcc evaluates it later.
> We believe that maybe causing __builtin_constant_p(n) to return false.
> There=E2=80=99s upstream work to change LLVM, so __builtin_constant_p wor=
ks more
> like gcc when optimization is enabled, but its still in progress.
>
>
> For this scenario is there a way to avoid the warning? Should the code
> be
> written in a different to avoid dependency on compiler?
>
> Thanks,
> Rishabh



--=20
Kees Cook
