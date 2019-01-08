Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DFC2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfAHLjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:39:46 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3285 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfAHLjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:39:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43Yqzz6ZNvz9v07s;
        Tue,  8 Jan 2019 12:39:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4a2XvDqdHHTh; Tue,  8 Jan 2019 12:39:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43Yqzz5zPPz9v06w;
        Tue,  8 Jan 2019 12:39:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 077688B7DA;
        Tue,  8 Jan 2019 12:39:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bFOq3zBNxzcH; Tue,  8 Jan 2019 12:39:44 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A61BD8B7D7;
        Tue,  8 Jan 2019 12:39:44 +0100 (CET)
Subject: Re: [PATCH] powerpc/irq: drop arch_early_irq_init()
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <dc0760e25a38ce64dd6cfde78b717c8e4a601a1e.1546947335.git.christophe.leroy@c-s.fr>
Message-ID: <bd521390-8925-2ed5-c694-84789c358504@c-s.fr>
Date:   Tue, 8 Jan 2019 12:39:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <dc0760e25a38ce64dd6cfde78b717c8e4a601a1e.1546947335.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, forgot to actually copy Thomas.

Le 08/01/2019 à 12:37, Christophe Leroy a écrit :
> arch_early_irq_init() does nothing different than
> the weak arch_early_irq_init() in kernel/softirq.c
> 
> Fixes: 089fb442f301 ("powerpc: Use ARCH_IRQ_INIT_FLAGS")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/kernel/irq.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 916ddc4aac44..bb299613a462 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -827,11 +827,6 @@ int irq_choose_cpu(const struct cpumask *mask)
>   }
>   #endif
>   
> -int arch_early_irq_init(void)
> -{
> -	return 0;
> -}
> -
>   #ifdef CONFIG_PPC64
>   static int __init setup_noirqdistrib(char *str)
>   {
> 
