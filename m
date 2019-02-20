Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA30E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oJ1ysyAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfBTOAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:00:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:14161 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfBTOAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:00:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444K4y27Bxz9v1sm;
        Wed, 20 Feb 2019 15:00:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oJ1ysyAB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vsIyKQq7uP3j; Wed, 20 Feb 2019 15:00:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444K4y0wDRz9tytY;
        Wed, 20 Feb 2019 15:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550671250; bh=l2Kfp0ntAhfmzSV1LpY3r8+PYSArHohnOEgSuMVpmA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oJ1ysyABl+p02mEI3bIVPajP7S6a2g/5eC0d5JxBoYEY1cTHUPDwYQvF0UTuN43xJ
         GU1rb55DKciQP5D8kbJokJkMGvbW2/MbisxQPa94h4vIJ6YljJjuHC0bDy2+c4l7tS
         4zO7BSxQedOlj+mEAecfq2hsPYkb6JLORWfhxR2k=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C1958B83A;
        Wed, 20 Feb 2019 15:00:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GhqVACHw-eFX; Wed, 20 Feb 2019 15:00:51 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 371C78B812;
        Wed, 20 Feb 2019 15:00:51 +0100 (CET)
Subject: Re: [PATCH] powerpc: Move page table dump files in a dedicated
 subdirectory
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr>
 <87d0nm7f8l.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0f371616-0ab6-fe96-852a-323159c58572@c-s.fr>
Date:   Wed, 20 Feb 2019 15:00:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87d0nm7f8l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/02/2019 à 14:37, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> This patch moves the files related to page table dump in a
>> dedicated subdirectory.
>>
>> The purpose is to clean a bit arch/powerpc/mm by regrouping
>> multiple files handling a dedicated function.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/Kconfig.debug                                   |  4 ----
>>   arch/powerpc/mm/Makefile                                     | 10 +---------
>>   arch/powerpc/mm/ptdump/Makefile                              |  9 +++++++++
>>   arch/powerpc/mm/{ => ptdump}/dump_bats.c                     |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c            |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c      |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c  |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c          |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h          |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_sr.c                       |  0
>>   11 files changed, 10 insertions(+), 13 deletions(-)
>>   create mode 100644 arch/powerpc/mm/ptdump/Makefile
>>   rename arch/powerpc/mm/{ => ptdump}/dump_bats.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_sr.c (100%)
> 
> I'd like to shorten the file names as well, now that they're namespaced
> in the ptdump directory, how about:
> 
>   arch/powerpc/Kconfig.debug                                             |  4 ----
>   arch/powerpc/mm/Makefile                                               | 10 +---------
>   arch/powerpc/mm/{dump_linuxpagetables-8xx.c => ptdump/8xx.c}           |  2 +-
>   arch/powerpc/mm/ptdump/Makefile                                        |  9 +++++++++
>   arch/powerpc/mm/{dump_bats.c => ptdump/bats.c}                         |  0
>   arch/powerpc/mm/{dump_linuxpagetables-book3s64.c => ptdump/book3s64.c} |  2 +-
>   arch/powerpc/mm/{dump_hashpagetable.c => ptdump/hashpagetable.c}       |  0
>   arch/powerpc/mm/{dump_linuxpagetables.c => ptdump/ptdump.c}            |  2 +-
>   arch/powerpc/mm/{dump_linuxpagetables.h => ptdump/ptdump.h}            |  0
>   arch/powerpc/mm/{dump_sr.c => ptdump/segment_regs.c}                   |  0
>   arch/powerpc/mm/{dump_linuxpagetables-generic.c => ptdump/shared.c}    |  2 +-

Yes good idea. Do you want a v2 or will you do it ?

Christophe

> 
> 
> cheers
> 
