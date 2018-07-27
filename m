Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9894C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627842089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627842089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbeG0SDF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:03:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16067 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbeG0SDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:03:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41cZSz7465z9ty7q;
        Fri, 27 Jul 2018 18:40:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q00rF5ueDD0k; Fri, 27 Jul 2018 18:40:19 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41cZSz6RvQz9ty76;
        Fri, 27 Jul 2018 18:40:19 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 8728144; Fri, 27 Jul 2018 18:40:23 +0200 (CEST)
Received: from 37-169-90-232.coucou-networks.fr
 (37-169-90-232.coucou-networks.fr [37.169.90.232]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 27 Jul 2018 18:40:23 +0200
Date:   Fri, 27 Jul 2018 18:40:23 +0200
Message-ID: <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Alastair D'Silva <alastair@d-silva.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in
 show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
In-Reply-To: <20180727145811.12334-5-muriloo@linux.ibm.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :

> Simplify the message format by using REG_FMT as the register format.  This
> avoids having two different formats and avoids checking for MSR_64BIT.

Are you sure it is what we want ?

Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?

Christophe


>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 4faab4705774..047d980ac776 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -311,17 +311,13 @@ static bool show_unhandled_signals_ratelimited(void)
>  static void show_signal_msg(int signr, struct pt_regs *regs, int code,
>  			    unsigned long addr)
>  {
> -	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> -		"at %08lx nip %08lx lr %08lx code %x\n";
> -	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> -		"at %016lx nip %016lx lr %016lx code %x\n";
> -
>  	if (!unhandled_signal(current, signr))
>  		return;
>
> -	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> -	       current->comm, current->pid, signr,
> -	       addr, regs->nip, regs->link, code);
> +	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
> +		" nip "REG_FMT" lr "REG_FMT" code %x\n",
> +		current->comm, current->pid, signr, addr,
> +		regs->nip, regs->link, code);
>  }
>
>  void _exception_pkey(int signr, struct pt_regs *regs, int code,
> --
> 2.17.1


