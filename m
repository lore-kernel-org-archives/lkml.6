Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeFDNn6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:43:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbeFDNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:43:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79BA460591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v12 3/5] arm64: pgtable: Add p*d_page_vaddr helper macros
To: Will Deacon <will.deacon@arm.com>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-4-git-send-email-cpandya@codeaurora.org>
 <20180604121351.GJ9482@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <28cc339e-b184-5f15-eca3-cf54e9376e01@codeaurora.org>
Date: Mon, 4 Jun 2018 19:13:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604121351.GJ9482@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/2018 5:43 PM, Will Deacon wrote:
> On Fri, Jun 01, 2018 at 06:09:16PM +0530, Chintan Pandya wrote:
>> Add helper macros to give virtual references to page
>> tables. These will be used while freeing dangling
>> page tables.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/pgtable.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 7c4c8f3..ef4047f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -580,6 +580,9 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>>   
>>   #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
>>   
>> +#define pmd_page_vaddr(pmd) __va(pmd_page_paddr(pmd))
>> +#define pud_page_vaddr(pud) __va(pud_page_paddr(pud))
> 
> Are these actually needed, or do pte_offset_kernel and pmd_offset do the
> job already?
> 

I introduced these macros for consistency across different arch.

Looking at pte_offset_kernel, it seems to use READ_ONCE() which looks
little costly for its intended use (in next patch) where we already have
dereferenced value. Do you still suggest to remove this ?

> Will
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
