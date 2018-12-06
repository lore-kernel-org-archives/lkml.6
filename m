Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67286C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1720700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF1720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLFQOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:14:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34435 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:14:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so796537lfc.1;
        Thu, 06 Dec 2018 08:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUrsARknn6B7SFPBTcSP5pFE0qif7myp3b7qGWFG7ts=;
        b=U5b4C+FN3fm+qomnbWvVMP1fiy270UEU0CjjJArUSJFPOTqYpnFVq0GgRXNrb4PjTZ
         AnmX5e2Iq0V2I/bN9AJJBJf+X4lNX9LYiTN9ktj4PiPUoxYifAYBP9vlIA5EHb40cB51
         UKvU8uTIYoyvFA7faEUt3v4DSl/W/krw4+zWSHEg60BjXi+ihKzmWUyFiH+bcsAQzRqS
         Ota6ESFSbnPJs5qclOojmSbxjMAIu8ReC+PaJLvZZXveE7kXh5UXJZAo7p/lNZ3g7YZr
         aCEd0UKKW4B7uHCVufe5Q09ZXVDAXyrhp+H78oiuwtyeUWrYP0uBxBcEks3ZHkN1SlJq
         ozCA==
X-Gm-Message-State: AA+aEWam/vKSH7ENi4ns7o1s5hIJOA1pKVCsKpv8iHNSpzYq42SniD0/
        B/oCzP83makjBt307MyF60sCrABvNPd/UOgEC+Q=
X-Google-Smtp-Source: AFSGD/WKEnmi+6YSSxGZBsZ21gTFiOnpuKbcY/kFbIk0DsPPS864ln+83Uht/9rdIILxq4LX5dPM+eNdR5/5E51FQnQ=
X-Received: by 2002:a19:8096:: with SMTP id b144mr18284323lfd.8.1544112861102;
 Thu, 06 Dec 2018 08:14:21 -0800 (PST)
MIME-Version: 1.0
References: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Dec 2018 17:14:02 +0100
Message-ID: <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: unistd.h: fixup broken macro include.
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Mao Han <han_mao@c-sky.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:07 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> The broken macros make the glibc compile error. If there is no
> __NR3264_fstat*, we should also removed related definitions.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for the reminder!

Marcin had already sent me the same patch a while ago
and I forgot to apply it. I applied your version now, which
as a slightly better changelog, so it will be in linux-next
tomorrow, and I plan to send it after that shows no regressions.

     Arnd

>  include/uapi/asm-generic/unistd.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 538546e..c7f3321 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -760,8 +760,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_ftruncate __NR3264_ftruncate
>  #define __NR_lseek __NR3264_lseek
>  #define __NR_sendfile __NR3264_sendfile
> +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>  #define __NR_newfstatat __NR3264_fstatat
>  #define __NR_fstat __NR3264_fstat
> +#endif
>  #define __NR_mmap __NR3264_mmap
>  #define __NR_fadvise64 __NR3264_fadvise64
>  #ifdef __NR3264_stat
> @@ -776,8 +778,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_ftruncate64 __NR3264_ftruncate
>  #define __NR_llseek __NR3264_lseek
>  #define __NR_sendfile64 __NR3264_sendfile
> +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>  #define __NR_fstatat64 __NR3264_fstatat
>  #define __NR_fstat64 __NR3264_fstat
> +#endif
>  #define __NR_mmap2 __NR3264_mmap
>  #define __NR_fadvise64_64 __NR3264_fadvise64
>  #ifdef __NR3264_stat
> --
> 2.7.4
>
