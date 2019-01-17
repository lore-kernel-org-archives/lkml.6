Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3768C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7098720652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfAQQYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:24:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42122 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAQQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:24:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so6305037qke.9;
        Thu, 17 Jan 2019 08:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fl8OGx6ndVYbjgvru49LD7C7lNOt4NO1xk+uY0yoX8Y=;
        b=l7V+X61BXA8R8tZTtBJ8jbpifjx+Z8rk2JBNKXD16r/IAePgmhyxHNLcO0R9I+4+1l
         L8jElsUXti9aXvNm0eU3E8bxfR76OxGMKs5FoYQrOOTJN3Uiy8P6BvKnakYwvdSoVBGh
         C7aOAFhULOY72TEDOgR/bMfLAxXxwdrnPo/UQRfI8n8BFI4XKz3D723J31d5vB0r7bOu
         h/IJZCOwLFECg8Jc1l+ZyGFE+c6r5i7IAtQL3ErM4CK83PpT9fwU0YgKo4L/FpTxSSX4
         TososkE6gEYWhJXKkBXStfjJOu8kqKL+3+kMm+7VuzhIvjjIq8IZjmnSGuXIGIBGZnj+
         F4Aw==
X-Gm-Message-State: AJcUukfSJf2i19S4xtT4K41eM9Co07KfF+Bl9WRuL4TnOHyp+6WGLs2R
        lZTD5tXlCWy/chDuCkZOkJ5rhN/l4sn/ILbetd6uKg==
X-Google-Smtp-Source: ALg8bN4Ms++XgtAySo9RhN/+Vww/k/kQKtQFp2gnEpgFrQ2ZrLOohZYVx30lw6zq9F+ocyzoy/KD9lZcZEzi5y//i2o=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr10988257qkf.107.1547742241318;
 Thu, 17 Jan 2019 08:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20190116131527.2071570-1-arnd@arndb.de> <20190116131527.2071570-5-arnd@arndb.de>
 <20190117133115.GC18351@osiris>
In-Reply-To: <20190117133115.GC18351@osiris>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 17:23:45 +0100
Message-ID: <CAK8P3a0eY17fM=-wQ0GZKiMxjiLrJaZxUeR__v1G86EfqwYGrA@mail.gmail.com>
Subject: Re: [PATCH 4/5] s390: autogenerate compat syscall wrappers
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 2:31 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> The patch below is needed as compile fix (allnoconfig).
> I will add this to your patch, no resend needed.

Ok, good catch! This is obviously the right fix.

      Arnd

> diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
> index 27ebe871692f..873e7a7794b3 100644
> --- a/arch/s390/include/asm/syscall_wrapper.h
> +++ b/arch/s390/include/asm/syscall_wrapper.h
> @@ -106,11 +106,10 @@
>         asmlinkage long __s390x_sys_##sname(void)
>
>  #define COND_SYSCALL(name)                                             \
> -       cond_syscall(__s390x_sys_##name)                                \
> -       cond_syscall(__s390_sys_##name)
> +       cond_syscall(__s390x_sys_##name)
>
>  #define SYS_NI(name)                                                   \
> -       SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers);
> +       SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);
>
>  #endif /* CONFIG_COMPAT */
>
>
