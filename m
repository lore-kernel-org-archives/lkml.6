Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320520815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7320520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeKRMIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 07:08:36 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:45331 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKRMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 07:08:36 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wAI1npIS026591;
        Sun, 18 Nov 2018 03:49:53 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-64-5bf0c53d6d48
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 01.D4.03682.D35C0FB5; Sun, 18 Nov 2018 03:49:50 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wAI1nnne000479;
        Sun, 18 Nov 2018 03:49:49 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 18 Nov 2018 03:49:49 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] riscv: add asm/unistd.h UAPI header
Organization: FORTH
In-Reply-To: <20181108190239.29633-1-david.abdurachmanov@gmail.com>
References: <20181108190239.29633-1-david.abdurachmanov@gmail.com>
Message-ID: <853e56348a89887d31b6b1866eed6d38@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LpjmZU1rU7+iHaYHOXrMXW37PYLf5OOsZu
        8ed2G6vF5V1z2Cy2fW5hs3iy8AyTxe7eFlaLzRMWsDpwePz+NYnR43DHF3aPnbPusnvcubaH
        zWPzknqPnd8b2D0uNV9n9/i8SS6AI4rLJiU1J7MstUjfLoEr42X3H6aCmYYVHb93szcwvlHv
        YuTkkBAwkbj4ai9LFyMXh5DAEUaJI5OnQzmHGCX2v57GDlFlKjF7bycjiM0rIChxcuYTFhCb
        WcBCYuqV/YwQtrxE89bZzF2MHBwsAqoS59viQcJsApoS8y8dBCsXETCXOP28kQ2ivJFJ4uGC
        epByYQFriaMXtEHC/ALCEp/uXmQFsTkFnCWeztkGNl1IwEniw/ELTBAXuEjMmbWPBeIyFYkP
        vx+AXSkqoCzx4sR01gmMQrOQHDoLyaGzkBy6gJF5FaNAYpmxXmZysV5aflFJhl560SZGcLzM
        9d3BeG6B/SFGAQ5GJR7eikfvooVYE8uKK3OBwcLBrCTCO3PNh2gh3pTEyqrUovz4otKc1OJD
        jNIcLErivIdfhAcJCaQnlqRmp6YWpBbBZJk4OKUaGOt+Rb/IT3fZqidWrP/02qFFP38vvWp4
        02ym7cdtW060BT0wYtf8fqrD5t332GtrWMVXcM6SkX5iG61obL2V90J5V+2csvqVLqlMbVzV
        d/scbOfuPV29/+6ZzslBog7/HOYHObJM/ud0N3OOTMLLyB45gVKhg5VC7G7c/KWCenY9xo0v
        n4mLKLEUZyQaajEXFScCACETVWyTAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Στις 2018-11-08 21:02, David Abdurachmanov έγραψε:
> Marcin Juszkiewicz reported issues while generating syscall table for 
> riscv
> using 4.20-rc1. The patch refactors our unistd.h files to match some 
> other
> architectures.
> 
> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT only for 
> 64-bit
> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
> - Adjust kernel asm/unistd.h
> 
> So now asm/unistd.h UAPI header should show all syscalls for riscv.
> 
> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
> generated asm/unistd.h UAPI header thus user didn't see:
> 
> - __NR_riscv_flush_icache
> - __NR_newfstatat
> - __NR_fstat
> 
> which are supported by riscv kernel.
> 
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: 67314ec7b025 ("RISC-V: Request newstat syscalls")
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  arch/riscv/include/asm/unistd.h        |  5 ++--
>  arch/riscv/include/uapi/asm/syscalls.h | 29 ------------------
>  arch/riscv/include/uapi/asm/unistd.h   | 41 ++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 32 deletions(-)
>  delete mode 100644 arch/riscv/include/uapi/asm/syscalls.h
>  create mode 100644 arch/riscv/include/uapi/asm/unistd.h
> 
> diff --git a/arch/riscv/include/asm/unistd.h 
> b/arch/riscv/include/asm/unistd.h
> index eff7aa9aa163..fef96f117b4d 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -13,10 +13,9 @@
> 
>  /*
>   * There is explicitly no include guard here because this file is 
> expected to
> - * be included multiple times.  See uapi/asm/syscalls.h for more info.
> + * be included multiple times.
>   */
> 
> -#define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SYS_CLONE
> +
>  #include <uapi/asm/unistd.h>
> -#include <uapi/asm/syscalls.h>
> diff --git a/arch/riscv/include/uapi/asm/syscalls.h
> b/arch/riscv/include/uapi/asm/syscalls.h
> deleted file mode 100644
> index 206dc4b0f6ea..000000000000
> --- a/arch/riscv/include/uapi/asm/syscalls.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2017-2018 SiFive
> - */
> -
> -/*
> - * There is explicitly no include guard here because this file is 
> expected to
> - * be included multiple times in order to define the syscall macros 
> via
> - * __SYSCALL.
> - */
> -
> -/*
> - * Allows the instruction cache to be flushed from userspace.  Despite 
> RISC-V
> - * having a direct 'fence.i' instruction available to userspace (which 
> we
> - * can't trap!), that's not actually viable when running on Linux 
> because the
> - * kernel might schedule a process on another hart.  There is no way 
> for
> - * userspace to handle this without invoking the kernel (as it doesn't 
> know the
> - * thread->hart mappings), so we've defined a RISC-V specific system 
> call to
> - * flush the instruction cache.
> - *
> - * __NR_riscv_flush_icache is defined to flush the instruction cache 
> over an
> - * address range, with the flush applying to either all threads or 
> just the
> - * caller.  We don't currently do anything with the address range, 
> that's just
> - * in there for forwards compatibility.
> - */
> -#ifndef __NR_riscv_flush_icache
> -#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> -#endif
> -__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> diff --git a/arch/riscv/include/uapi/asm/unistd.h
> b/arch/riscv/include/uapi/asm/unistd.h
> new file mode 100644
> index 000000000000..1f3bd3ebbb0d
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2018 David Abdurachmanov 
> <david.abdurachmanov@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or 
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see 
> <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifdef __LP64__
> +#define __ARCH_WANT_NEW_STAT
> +#endif /* __LP64__ */
> +
> +#include <asm-generic/unistd.h>
> +
> +/*
> + * Allows the instruction cache to be flushed from userspace.  Despite 
> RISC-V
> + * having a direct 'fence.i' instruction available to userspace (which 
> we
> + * can't trap!), that's not actually viable when running on Linux 
> because the
> + * kernel might schedule a process on another hart.  There is no way 
> for
> + * userspace to handle this without invoking the kernel (as it doesn't 
> know the
> + * thread->hart mappings), so we've defined a RISC-V specific system 
> call to
> + * flush the instruction cache.
> + *
> + * __NR_riscv_flush_icache is defined to flush the instruction cache 
> over an
> + * address range, with the flush applying to either all threads or 
> just the
> + * caller.  We don't currently do anything with the address range, 
> that's just
> + * in there for forwards compatibility.
> + */
> +#ifndef __NR_riscv_flush_icache
> +#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> +#endif
> +__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)

You are copying content from arch/riscv/include/uapi/asm/syscalls.h to
arch/riscv/include/uapi/asm/unistd.h without keeping the copyright of
the original contributor (in this case SiFive). Also since you use
SPDX-License-Identifier, you don't have to put the GPLv2 preamble there.

Other than that I can also verify that this patch fixes compilation for 
RV32.

Regards,
Nick
