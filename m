Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C4F2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeLWN2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:28:38 -0500
Received: from ozlabs.org ([203.11.71.1]:45771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbeLWN2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:28:06 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N38M4cw7z9sNJ; Mon, 24 Dec 2018 00:28:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8a19eeeab66dfdd7c67bc8e3048ac0064e8943d7
X-Patchwork-Hint: ignore
In-Reply-To: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org>
To:     Firoz Khan <firoz.khan@linaro.org>, linuxppc-dev@lists.ozlabs.org,
        sathnaga@linux.vnet.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org, deepa.kernel@gmail.com
Subject: Re: [v6,1/5] powerpc: add __NR_syscalls along with NR_syscalls
Message-Id: <43N38M4cw7z9sNJ@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:28:03 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 10:40:32 UTC, Firoz Khan wrote:
> NR_syscalls macro holds the number of system call exist
> in powerpc architecture. We have to change the value of
> NR_syscalls, if we add or delete a system call.
> 
> One of the patch in this patch series has a script which
> will generate a uapi header based on syscall.tbl file.
> The syscall.tbl file contains the number of system call
> information. So we have two option to update NR_syscalls
> value.
> 
> 1. Update NR_syscalls in asm/unistd.h manually by count-
>    ing the no.of system calls. No need to update NR_sys-
>    calls until we either add a new system call or delete
>    existing system call.
> 
> 2. We can keep this feature in above mentioned script,
>    that will count the number of syscalls and keep it in
>    a generated file. In this case we don't need to expli-
>    citly update NR_syscalls in asm/unistd.h file.
> 
> The 2nd option will be the recommended one. For that, I
> added the __NR_syscalls macro in uapi/asm/unistd.h along
> with NR_syscalls asm/unistd.h. The macro __NR_syscalls
> also added for making the name convention same across all
> architecture. While __NR_syscalls isn't strictly part of
> the uapi, having it as part of the generated header to
> simplifies the implementation. We also need to enclose
> this macro with #ifdef __KERNEL__ to avoid side effects.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a19eeeab66dfdd7c67bc8e3048ac0

cheers
