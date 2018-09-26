Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEADC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC7820684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC7820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeIZOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:22:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57514 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbeIZOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:22:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KrGj0rRCz9ttSL;
        Wed, 26 Sep 2018 10:10:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Fye8mWkLmo2s; Wed, 26 Sep 2018 10:10:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KrGj0Hg5z9ttRh;
        Wed, 26 Sep 2018 10:10:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 413108B7FE;
        Wed, 26 Sep 2018 10:10:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xnC3HMXXLt-Q; Wed, 26 Sep 2018 10:10:37 +0200 (CEST)
Received: from PO15451 (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E2C348B7EB;
        Wed, 26 Sep 2018 10:10:36 +0200 (CEST)
Subject: Re: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
 <87in2tgeix.fsf@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <156d8a34-c40f-553a-0d4a-98433af1a1a2@c-s.fr>
Date:   Wed, 26 Sep 2018 10:10:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87in2tgeix.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/09/2018 à 04:48, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> In order to allow the 8xx to handle pte_fragments, this patch
>> extends the use of pte_fragments to nohash/32 platforms.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu_context.h       |  2 +-
>>   arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
>>   arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
>>   arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
>>   arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
>>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 +++++++++++++---------------
>>   arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
>>   arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
>>   arch/powerpc/mm/Makefile                     |  3 ++
>>   arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
>>   10 files changed, 57 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
>> index b2f89b621b15..7f2c37a3f99d 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>>   	return 0;
>>   }
>>   
>> -#ifndef CONFIG_PPC_BOOK3S_64
>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>>   static inline void arch_exit_mmap(struct mm_struct *mm)
>>   {
>>   }
> 
> 
> Can we do that with #ifndef arch_exit_mmap? This should handle every
> platform that doesn't use pte_frag right?

Yes we can, that means moving arch_exit_mmap() prototype in platform 
specific mmu headers, and adding there a #define arch_exit_mmap 
arch_exit_mmap

Is that your idea ?

Christophe


> 
> 
>> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
>> index 74f4edb5916e..7c77ceed71d6 100644
>> --- a/arch/powerpc/include/asm/nohash/32/mmu-40x.h
>> +++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
>> @@ -58,6 +58,7 @@ typedef struct {
>>   	unsigned int	id;
>>   	unsigned int	active;
>>   	unsigned long	vdso_base;
> 
> -aneesh
> 
