Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeCTHo5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:44:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25166 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbeCTHo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:44:56 -0400
Subject: Re: [PATCH 2/2] powerpc/mm: Trace tlbia instruction
To: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
 <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
 <20180320094320.03ae264d@balbir.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2aac79d5-6cf8-cd65-79b9-68839c537474@c-s.fr>
Date: Tue, 20 Mar 2018 08:44:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320094320.03ae264d@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/03/2018 à 23:43, Balbir Singh a écrit :
> On Mon, 19 Mar 2018 11:32:40 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> Add a trace point for tlbia (Translation Lookaside Buffer Invalidate
>> All) instruction.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/trace.h | 15 +++++++++++++++
>>   arch/powerpc/mm/mmu_decl.h       |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
>> index 33f3b479138b..d1d63b173dd7 100644
>> --- a/arch/powerpc/include/asm/trace.h
>> +++ b/arch/powerpc/include/asm/trace.h
>> @@ -202,6 +202,21 @@ TRACE_EVENT(tlbie,
>>   		__entry->r)
>>   );
>>   
>> +TRACE_EVENT(tlbia,
>> +
>> +	TP_PROTO(unsigned long lpid),
>> +	TP_ARGS(lpid),
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, lpid)
>> +		),
>> +
>> +	TP_fast_assign(
>> +		__entry->lpid = lpid;
>> +		),
>> +
>> +	TP_printk("lpid=%ld", __entry->lpid)
>> +);
> 
> 
> Do we want to call this lpid?
> 

Should we can it rs in consistence with tlbie trace ? Or just pid ?
Allthough it is not an argument used by tlbia, I think it is good to 
keep a trace of it to keep track of the reason why tlbia is called.

Christophe
