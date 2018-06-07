Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HkwbMpmNGFsoCAAAmS7hNA
	; Thu, 07 Jun 2018 01:43:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B2D76089E; Thu,  7 Jun 2018 01:43:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2F23kHX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 64877601A8;
	Thu,  7 Jun 2018 01:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64877601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeFGBnX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:43:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43410 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeFGBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:43:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id j20-v6so4021191pff.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRcPTJiVa8mTVEOhxd5W3GsgBdp1HtlMNAXYyca++nM=;
        b=Z2F23kHXPf1D2iDf1/CWCJBb4UL2aiBeuJrp+jDGg9hWy2IfTg55bbTGiITGIX6XIc
         tsMwVabBBFHEERxM0xwCUVop7iwyMyiNXxZBgS+kCskfqW7tJcwUgM+AfCbHHkFgvZ3p
         Blp21pq28L4l/zlkDxMP4mlYIa1cJp629SLc2hCPZmY9siXRcdDPXkZt4FmiDa2CMJ3L
         2rLoFTz7MzKmpHtAEjjteRbi9qOGzC5OEUNJb63m1PmNpxbZkfx7UQNgoss+ZPBcbUBk
         UxnzMXRekofFdFjk4MJxltTmasGd15SaGS0KHgLny1O5BwovH/LDs7t0yogs9xyuik1f
         G5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRcPTJiVa8mTVEOhxd5W3GsgBdp1HtlMNAXYyca++nM=;
        b=o9VBYm1AS23GORoLAofC5GvTyD0EasGAjAJUHWWhmp89K0ze3axLeQb10uPUjfeBHJ
         1OozIr34woId64Zl4+2UbTBER2ctEU14s5YWxE+glzoJLJEV8rnE+Ggegc6ZRDa0n1bK
         C8rbZySXSHSxSoDXivqR35CcW43T0FbzRGMkE8V126owOnQrZcS5UuU2yAffF203SQg0
         dpOwjOtrLDeupvWKOoJ+pVNBMewOQqrB9F7m6Kgwv931VjuaavB4eHkiiWtm601aIYyj
         X77viwkFWCHB9we9x+GRKbBXRv15RntMnLxXJm7x4p439/MGE/4i6b+HT9v7J91eluq4
         3CVQ==
X-Gm-Message-State: APt69E0N+PgsYH3pPEM7ldpoHKGSYKO2yA4+i5D0ibme3FLUmzPRAcu8
        naxctQ5Cf26y8xzrf8jmHzyWbw==
X-Google-Smtp-Source: ADUXVKIqJGLeW0UcRRG22WA23kxVphZk4/kGR/xt+Tig8YXRSVIZIZW4EEW1G7QHKEnY0+oQJiv0MQ==
X-Received: by 2002:a62:1013:: with SMTP id y19-v6mr4632037pfi.166.1528335801111;
        Wed, 06 Jun 2018 18:43:21 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id w125-v6sm2218469pgb.92.2018.06.06.18.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 18:43:20 -0700 (PDT)
Date: Thu, 7 Jun 2018 11:43:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/time: Only set
 CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC64
Message-ID: <20180607114304.327c4ab5@roar.ozlabs.ibm.com>
In-Reply-To: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jun 2018 14:21:08 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> scaled cputime is only meaningfull when the processor has
> SPURR and/or PURR, which means only on PPC64.
> 
> Removing it on PPC32 significantly reduces the size of
> vtime_account_system() and vtime_account_idle() on an 8xx:
> 
> Before:
> 00000000 l     F .text	000000a8 vtime_delta
> 00000280 g     F .text	0000010c vtime_account_system
> 0000038c g     F .text	00000048 vtime_account_idle
> 
> After:
> (vtime_delta gets inlined in the two functions)
> 000001d8 g     F .text	000000a0 vtime_account_system
> 00000278 g     F .text	00000038 vtime_account_idle
> 
> In terms of performance, we also get approximatly 5% improvement on task switch:
> The following small benchmark app is run with perf stat:
> 
> void *thread(void *arg)
> {
> 	int i;
> 
> 	for (i = 0; i < atoi((char*)arg); i++)
> 		pthread_yield();
> }
> 
> int main(int argc, char **argv)
> {
> 	pthread_t th1, th2;
> 
> 	pthread_create(&th1, NULL, thread, argv[1]);
> 	pthread_create(&th2, NULL, thread, argv[1]);
> 	pthread_join(th1, NULL);
> 	pthread_join(th2, NULL);
> 
> 	return 0;
> }
> 
> Before the patch:
> 
> ~# perf stat chrt -f 98 ./sched 100000
> 
>  Performance counter stats for 'chrt -f 98 ./sched 100000':
> 
>        8622.166272      task-clock (msec)         #    0.955 CPUs utilized
>             200027      context-switches          #    0.023 M/sec
> 
> After the patch:
> 
> ~# perf stat chrt -f 98 ./sched 100000
> 
>  Performance counter stats for 'chrt -f 98 ./sched 100000':
> 
>        8207.090048      task-clock (msec)         #    0.958 CPUs utilized
>             200025      context-switches          #    0.024 M/sec
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks okay to me. Nice numbers.

> ---
>  v4:
>   - Using the correct symbol CONFIG_ARCH_HAS_SCALED_CPUTIME instead of ARCH_HAS_SCALED_CPUTIME
>   - Grouped CONFIG_ARCH_HAS_SCALED_CPUTIME related code in dedicated functions to reduce the number of #ifdefs
>   - Integrated read_spurr() directly into the related function.
>  v3: Rebased following modifications in xmon.c
>  v2: added ifdefs in xmon to fix compilation error
> 
>  arch/powerpc/Kconfig                  |   2 +-
>  arch/powerpc/include/asm/accounting.h |   4 ++
>  arch/powerpc/include/asm/cputime.h    |   1 -
>  arch/powerpc/kernel/time.c            | 111 +++++++++++++++++++++-------------
>  arch/powerpc/xmon/xmon.c              |   4 ++
>  5 files changed, 77 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b62a16e2c7cc..735398fd390d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -142,7 +142,7 @@ config PPC
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PMEM_API                if PPC64
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
> -	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
> +	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64

I wonder if we could make this depend on PPC_PSERIES or even
PPC_SPLPAR as well? (That would be for a later patch)

Thanks,
Nick
