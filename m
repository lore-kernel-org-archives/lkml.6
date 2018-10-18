Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE30C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2271B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2271B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJRMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:36:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60156 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeJRMgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:36:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42bGVg0t0Fz9ttBQ;
        Thu, 18 Oct 2018 06:37:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id d6mWIti8UK_J; Thu, 18 Oct 2018 06:37:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42bGVg0GC9z9ttBP;
        Thu, 18 Oct 2018 06:37:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 961A58B75E;
        Thu, 18 Oct 2018 06:37:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bhsoszzXT9TN; Thu, 18 Oct 2018 06:37:32 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 180858B74C;
        Thu, 18 Oct 2018 06:37:31 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Add missing include <asm/stacktrace.h>
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20181017192558.8039-1-malat@debian.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <373dd30b-70d1-5e06-c55e-45f8f6763edf@c-s.fr>
Date:   Thu, 18 Oct 2018 06:37:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017192558.8039-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/10/2018 à 21:25, Mathieu Malaterre a écrit :
> In commit 88b0fe175735 ("powerpc: Add show_user_instructions()") the
> function show_user_instructions was added.
> 
> This commit adds an include of header file <asm/stacktrace.h> to provide
> the missing function prototype. Silence the following gcc warning
> (treated as error with W=1):
> 
>    arch/powerpc/kernel/process.c:1302:6: error: no previous prototype for ‘show_user_instructions’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

This is already fixed, see 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c9386bfd37d37f29588de9ea9add455510049c33

Christophe

> ---
>   arch/powerpc/kernel/process.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index bb6ac471a784..1c64491e9702 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -65,6 +65,7 @@
>   #include <asm/livepatch.h>
>   #include <asm/cpu_has_feature.h>
>   #include <asm/asm-prototypes.h>
> +#include <asm/stacktrace.h>
>   
>   #include <linux/kprobes.h>
>   #include <linux/kdebug.h>
> 
