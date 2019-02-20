Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3E2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfBTN5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:57:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58138 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfBTN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:57:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4327DEBD;
        Wed, 20 Feb 2019 05:57:02 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42E883F690;
        Wed, 20 Feb 2019 05:56:59 -0800 (PST)
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kirill@shutemov.name,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218113134.GU32477@hirez.programming.kicks-ass.net>
 <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
 <8a74c111-b099-8d18-5fb0-422909a1367a@linux.intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f8bdd4b9-e078-c1fc-9b15-1ed7a844e673@arm.com>
Date:   Wed, 20 Feb 2019 13:56:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8a74c111-b099-8d18-5fb0-422909a1367a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 03:44, Liang, Kan wrote:
> 
> 
> On 2/18/2019 9:19 AM, Steven Price wrote:
>> On 18/02/2019 11:31, Peter Zijlstra wrote:
>>> On Fri, Feb 15, 2019 at 05:02:24PM +0000, Steven Price wrote:
>>>> From: James Morse <james.morse@arm.com>
>>>>
>>>> Exposing the pud/pgd levels of the page tables to walk_page_range()
>>>> means
>>>> we may come across the exotic large mappings that come with large areas
>>>> of contiguous memory (such as the kernel's linear map).
>>>>
>>>> For architectures that don't provide p?d_large() macros, provided a
>>>> does nothing default.
>>>
>>> Kan was going to fix that for all archs I think..
>>
> 
> Yes, I'm still working on a generic function to retrieve page size.
> The generic p?d_large() issue has been fixed. However, I found that the
> pgd_page() is not generic either. I'm still working on it.
> I will update you on the other thread when all issues are fixed.
> 
> 
> 
>> The latest series I can find from Kan is still x86 specific. I'm happy
>> to rebase onto something else if Kan has an implementation already
>> (please point me in the right direction). Otherwise Kan is obviously
>> free to base on these changes.
>>
> 
> My implementation is similar as yours. I'm happy to re-base on your
> changes.
> 
> Could you please also add a generic p4d_large()?

Sure, I'll include that in the next posting.

Thanks,

Steve
