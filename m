Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D85F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D85F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbeHALWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:22:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46133 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733265AbeHALWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:22:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41gSrZ57l9z9tvqF;
        Wed,  1 Aug 2018 11:37:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yFThIYM4jKcV; Wed,  1 Aug 2018 11:37:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41gSrZ4WSJz9tvq9;
        Wed,  1 Aug 2018 11:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42A128B839;
        Wed,  1 Aug 2018 11:37:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DWXSDuRMbRgn; Wed,  1 Aug 2018 11:37:31 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAD908B756;
        Wed,  1 Aug 2018 11:37:30 +0200 (CEST)
Subject: Re: [PATCH] perf tools: allow overriding MAX_NR_CPUS at compile time
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
 <20180503134037.GB8442@kernel.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <dc8f1911-fa9a-c1c8-0dd5-fd33236da69a@c-s.fr>
Date:   Wed, 1 Aug 2018 11:37:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180503134037.GB8442@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/05/2018 à 15:40, Arnaldo Carvalho de Melo a écrit :
> Em Fri, Sep 22, 2017 at 01:20:43PM +0200, Christophe Leroy escreveu:
>> After update of kernel, perf tool doesn't run anymore on my
>> 32MB RAM powerpc board, but still runs on a 128MB RAM board:
> 
> Cleaning up my inbox, found this one, simple enough, still applies,
> applied.

Did you finally apply it ? I can't see it in linux-next. Will it be 
merged into 4.19 ?

Thanks
Christophe

> 
> These all needs to be dynamicly allocated, but still, with this one can
> get a functioning tool, apply it.
> 
> - Arnaldo
>   
>> ~# strace perf
>> execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) = -1 ENOMEM (Cannot allocate memory)
>> --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
>> +++ killed by SIGSEGV +++
>> Segmentation fault
>>
>> objdump -x shows that .bss section has a huge size of 24Mbytes:
>>
>>   27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3
>>
>> With especially the following objects having quite big size
>>
>> 10205f80 l     O .bss	00140000              runtime_cycles_stats
>> 10345f80 l     O .bss	00140000              runtime_stalled_cycles_front_stats
>> 10485f80 l     O .bss	00140000              runtime_stalled_cycles_back_stats
>> 105c5f80 l     O .bss	00140000              runtime_branches_stats
>> 10705f80 l     O .bss	00140000              runtime_cacherefs_stats
>> 10845f80 l     O .bss	00140000              runtime_l1_dcache_stats
>> 10985f80 l     O .bss	00140000              runtime_l1_icache_stats
>> 10ac5f80 l     O .bss	00140000              runtime_ll_cache_stats
>> 10c05f80 l     O .bss	00140000              runtime_itlb_cache_stats
>> 10d45f80 l     O .bss	00140000              runtime_dtlb_cache_stats
>> 10e85f80 l     O .bss	00140000              runtime_cycles_in_tx_stats
>> 10fc5f80 l     O .bss	00140000              runtime_transaction_stats
>> 11105f80 l     O .bss	00140000              runtime_elision_stats
>> 11245f80 l     O .bss	00140000              runtime_topdown_total_slots
>> 11385f80 l     O .bss	00140000              runtime_topdown_slots_retired
>> 114c5f80 l     O .bss	00140000              runtime_topdown_slots_issued
>> 11605f80 l     O .bss	00140000              runtime_topdown_fetch_bubbles
>> 11745f80 l     O .bss	00140000              runtime_topdown_recovery_bubbles
>>
>> This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
>> to 1024"), because many tables are sized with MAX_NR_CPUS
>>
>> This patch gives the opportunity to redefine MAX_NR_CPUS via
>>
>> make EXTRA_CFLAGS=-DMAX_NR_CPUS=1
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   tools/perf/perf.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
>> index dc442ba21bf6..a9db563da0a9 100644
>> --- a/tools/perf/perf.h
>> +++ b/tools/perf/perf.h
>> @@ -23,7 +23,9 @@ static inline unsigned long long rdclock(void)
>>   	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
>>   }
>>   
>> +#ifndef MAX_NR_CPUS
>>   #define MAX_NR_CPUS			1024
>> +#endif
>>   
>>   extern const char *input_name;
>>   extern bool perf_host, perf_guest;
>> -- 
>> 2.13.3
