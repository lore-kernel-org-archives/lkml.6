Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DEBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BA12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBSDoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:44:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:21339 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfBSDoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:44:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 19:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,385,1544515200"; 
   d="scan'208";a="127491915"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2019 19:44:14 -0800
Received: from [10.254.86.162] (kliang2-mobl1.ccr.corp.intel.com [10.254.86.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 58CD1580238;
        Mon, 18 Feb 2019 19:44:12 -0800 (PST)
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
To:     Steven Price <steven.price@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kirill@shutemov.name, Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218113134.GU32477@hirez.programming.kicks-ass.net>
 <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8a74c111-b099-8d18-5fb0-422909a1367a@linux.intel.com>
Date:   Mon, 18 Feb 2019 22:44:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2019 9:19 AM, Steven Price wrote:
> On 18/02/2019 11:31, Peter Zijlstra wrote:
>> On Fri, Feb 15, 2019 at 05:02:24PM +0000, Steven Price wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>>> we may come across the exotic large mappings that come with large areas
>>> of contiguous memory (such as the kernel's linear map).
>>>
>>> For architectures that don't provide p?d_large() macros, provided a
>>> does nothing default.
>>
>> Kan was going to fix that for all archs I think..
>

Yes, I'm still working on a generic function to retrieve page size.
The generic p?d_large() issue has been fixed. However, I found that the 
pgd_page() is not generic either. I'm still working on it.
I will update you on the other thread when all issues are fixed.



> The latest series I can find from Kan is still x86 specific. I'm happy
> to rebase onto something else if Kan has an implementation already
> (please point me in the right direction). Otherwise Kan is obviously
> free to base on these changes.
>

My implementation is similar as yours. I'm happy to re-base on your changes.

Could you please also add a generic p4d_large()?

Thanks,
Kan

> Steve
> 
>> See:
>>
>>    http://lkml.kernel.org/r/20190204105409.GA17550@hirez.programming.kicks-ass.net
>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>   include/asm-generic/pgtable.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>>> index 05e61e6c843f..7630d663cd51 100644
>>> --- a/include/asm-generic/pgtable.h
>>> +++ b/include/asm-generic/pgtable.h
>>> @@ -1186,4 +1186,14 @@ static inline bool arch_has_pfn_modify_check(void)
>>>   #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>>>   #endif
>>>   
>>> +#ifndef pgd_large
>>> +#define pgd_large(x)	0
>>> +#endif
>>> +#ifndef pud_large
>>> +#define pud_large(x)	0
>>> +#endif
>>> +#ifndef pmd_large
>>> +#define pmd_large(x)	0
>>> +#endif
>>> +
>>>   #endif /* _ASM_GENERIC_PGTABLE_H */
>>> -- 
>>> 2.20.1
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
