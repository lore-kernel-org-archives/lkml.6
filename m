Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20BA2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20BA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeKTCVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:21:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38821 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbeKTCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:21:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so49326542qkg.5;
        Mon, 19 Nov 2018 07:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKVycHfx9VTyJfwD26xokE+/t85CmcDhT6zn9T7WMW8=;
        b=YKQMNoRNTo1dZBOjYeC3fB4S7a0QTaNViDStennrWoiPPsGK1oKx8a06Z0GygejPwF
         VhOJi9v1uI7ygdjPLaDVEk3zhebWcuGBzXLui6SiUNa/G5uIfIZ6XwGgZcOQz0Yz54hd
         fh1f5mgqYtfMDlbzqvARS3cXhkf/Kw/XzFKh7uu5aCxJpL430nzvJBEzQqHrgm1HqiNC
         5SIbEtptk0/7t6TzNdFyL/TLtF17IFK2SeiHWkwbTdbUjSY2+w90ChHQflvx3HhKteRY
         UlLQB7CzV0cPpndZIwH2u5nMiuSEGhedQ8L7+4KPHvee3DtmLyVvtjsKDj1p9JK8jXhR
         Yc2w==
X-Gm-Message-State: AGRZ1gK+/D69YI593GapyPzolFYlmT1HyS5mJe+cnd4gJD/aepNRKcpa
        TayaWN3MtOknkXq1QgnzWMsA/MAjy5FCnxQKkHo=
X-Google-Smtp-Source: AJdET5eeZflQQnKevaRUjecuFpzfTcHB0FNkGNZkkbT+jXVXZzZVyLGpoFMdqN5TaSsNg7YTeUFdHJ9gtynGYBjzZAQ=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr19976776qkf.107.1542643069437;
 Mon, 19 Nov 2018 07:57:49 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 16:57:32 +0100
Message-ID: <CAK8P3a2+W64=-pFaGyN27fdYOSpOrS7oRAzvZqaJUakB0aXtCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mips: add +1 to __NR_syscalls in uapi header
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> All other architectures are hold a value for __NR_syscalls will
> be equal to the last system call number +1.
>
> But in mips architecture, __NR_syscalls hold the value equal to
> total number of system exits in the architecture. One of the
> patch in this patch series will genarate uapi header files.
>
> In order to make the implementation common across all architect-
> ures, add +1 to __NR_syscalls, which will be equal to the last
> system call number +1.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

The patch looks correct to me, and is a nice cleanup, but I found a
couple of things remaining that could be done slightly better.

> diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
> index c68b8ae..16f21c3 100644
> --- a/arch/mips/include/asm/unistd.h
> +++ b/arch/mips/include/asm/unistd.h
> @@ -15,11 +15,11 @@
>  #include <uapi/asm/unistd.h>
>
>  #ifdef CONFIG_MIPS32_N32
> -#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
> +#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
>  #elif defined(CONFIG_64BIT)
> -#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
> +#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls - 1)
>  #else
> -#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
> +#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
>  #endif

I suppose these can simply get removed, there are no users of NR_syscalls
in MIPS kernels.

> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 7f3dfdb..add4301 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -410,13 +410,13 @@ unsigned long __init arch_syscall_addr(int nr)
>  unsigned long __init arch_syscall_addr(int nr)
>  {
>  #ifdef CONFIG_MIPS32_N32
> -       if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
> +       if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
>                 return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
>  #endif
> -       if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
> +       if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls - 1)
>                 return (unsigned long)sys_call_table[nr - __NR_64_Linux];
>  #ifdef CONFIG_MIPS32_O32
> -       if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
> +       if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
>                 return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
>  #endif

Here I would drop the '-1' and instead replace the '<=' with '<' for
better readability

> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index 91d3c8c..a9b895f 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -23,7 +23,7 @@
>  #include <asm/asm-offsets.h>
>
>  /* Highest syscall used of any syscall flavour */
> -#define MAX_SYSCALL_NO __NR_O32_Linux + __NR_O32_Linux_syscalls
> +#define MAX_SYSCALL_NO __NR_O32_Linux + __NR_O32_Linux_syscalls - 1

This is also unused as of commit 2957c9e61ee9 ("[MIPS] IRIX: Goodbye and
thanks for all the fish"), eight years ago, so I'd remove this as well.

I'd suggest doing one patch for the removal of the unused macros, and another
patch for the other changes.

       Arnd
