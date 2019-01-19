Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C00C0031C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD092086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JXxhXQKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfASDpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:45:39 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49396 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbfASDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 22:45:39 -0500
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0J3jVnQ007493
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 12:45:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0J3jVnQ007493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547869532;
        bh=GmXcVg56/uy4EXsHvS3OpOX4Tq5rsuK7nLrJEUMmhfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXxhXQKeGiNqRdWKMs07D6XGBPh4t+kofoEtXFeA7qY+O9I8zFqtOEKRMwsqDX4Tc
         X1u5Vg/jtQ4kdXD2AD3rG1y30Q+Q2biiAyZdaujUtieeExEh/Ex3P3sEiz4JHaKv4E
         +1xqUAOcxo8xponw8EKhA89GaKZycLZv9K18SQYmua6PGJb4hvn//FCjRIcE+bFStK
         dQXoN/chaGYwCzasw4AawKEKynp/suf8q0ib39y1YkSw3P87VnexUllHqr7nQqFuNS
         MUPUAmqtaai++nX9IUmf3fGyZ5k7IKjMjkLS5f/aYaEvcvDS6qtCdVqH+6QbFAnDlp
         sheTH4anKRXgA==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id h128so3514392vkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 19:45:32 -0800 (PST)
X-Gm-Message-State: AJcUukd9kpsoZ8MzeQ76DxfhjB3P/jGQCopfDFBD7KnbBTfsdt5Lhqx3
        H+rgo5QxNPOFQxX8PDh8bIPUI1ZHZTLmvDwXtcQ=
X-Google-Smtp-Source: ALg8bN7ZGFaB/Nw1ZFyZkyYobPx6HU9H8wxgHrPHpk2faygYiBBU9Pd0xgDvPOBSZolhe7AlXD+V/pzwadN/L1fdBRA=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr8320663vkd.74.1547869531293;
 Fri, 18 Jan 2019 19:45:31 -0800 (PST)
MIME-Version: 1.0
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 19 Jan 2019 12:44:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_GHpqKC3bC_-eC+64Kn+h2md70NpshUHUUN0kNQa0cQ@mail.gmail.com>
Message-ID: <CAK7LNAR_GHpqKC3bC_-eC+64Kn+h2md70NpshUHUUN0kNQa0cQ@mail.gmail.com>
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS macro
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 1:02 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> A common pattern found in header files is a function declaration dependent
> on a CONFIG_ option being enabled, followed by an empty function for when
> that option isn't enabled. This boilerplate code can often take up a lot
> of space and impact code readability.
>
> This series introduces a STUB_UNLESS macro that simplifies header files as
> follows:
>
> STUB_UNLESS(CONFIG_FOO, [body], prototype)
>
> This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
> to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
> inline' followed by an empty function body. Where optional argument 'body'
> is present then 'body' will be used as the function body, intended to allow
> simple return statements. Using the macro results in hunks such as this:
>
> -#ifdef CONFIG_HAVE_HW_BREAKPOINT
> -extern void hw_breakpoint_thread_switch(struct task_struct *next);
> -extern void ptrace_hw_copy_thread(struct task_struct *task);
> -#else
> -static inline void hw_breakpoint_thread_switch(struct task_struct *next)
> -{
> -}
> -static inline void ptrace_hw_copy_thread(struct task_struct *task)
> -{
> -}
> -#endif
> +STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> +void hw_breakpoint_thread_switch(struct task_struct *next));
> +
> +STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> +void ptrace_hw_copy_thread(struct task_struct *task));
>
> This may or may not be considered as more desirable than the status quo.
>
> This series updates arm64 and perf to use the macro as an example.
>
> Andrew Murray (3):
>   kconfig.h: abstract empty functions with STUB_UNLESS macro
>   cpufreq: update headers to use STUB_UNLESS macro
>   arm64: update headers to use STUB_UNLESS macro
>
>  arch/arm64/include/asm/acpi.h           | 38 +++++++++-------------
>  arch/arm64/include/asm/alternative.h    |  6 +---
>  arch/arm64/include/asm/cpufeature.h     |  6 +---
>  arch/arm64/include/asm/cpuidle.h        | 18 +++--------
>  arch/arm64/include/asm/debug-monitors.h | 10 ++----
>  arch/arm64/include/asm/fpsimd.h         | 57 +++++++++++++--------------------
>  arch/arm64/include/asm/hw_breakpoint.h  | 16 +++------
>  arch/arm64/include/asm/kasan.h          |  9 ++----
>  arch/arm64/include/asm/numa.h           | 19 ++++-------
>  arch/arm64/include/asm/ptdump.h         | 13 +++-----
>  arch/arm64/include/asm/signal32.h       | 29 +++++------------
>  include/linux/cpufreq.h                 | 21 ++++--------
>  include/linux/kconfig.h                 | 31 ++++++++++++++++++
>  13 files changed, 110 insertions(+), 163 deletions(-)
>
> --
> 2.7.4
>

Honestly, I am not a big fan of shorting the code
for the purpose of shorting.


This patch series is based on the assumption
the first argument is "defined or undefined".
In other words, it cannot handle tristate CONFIG option.


But, if you go this way, could you make
it work in a more generic manner?

And, decouple this from <linux/kconfig.h>



For example, see the following cases:

https://github.com/torvalds/linux/blob/v5.0-rc2/include/acpi/button.h#L7

https://github.com/torvalds/linux/blob/v5.0-rc2/include/linux/firmware.h#L42




The latter is a good example.

In many cases, the kernel headers look like this:


#ifdef CONFIG_FOO

  { large block of prototype declaration }

#else

  { large block of nop stubs }

#endif


So, this approach shifts "duplication of prototype"
into "duplication of conditional part".


-- 
Best Regards
Masahiro Yamada
