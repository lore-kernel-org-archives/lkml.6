Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4F921901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbfBROUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:20:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59690 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390699AbfBROUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:20:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8AE015AD;
        Mon, 18 Feb 2019 06:20:28 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1C283F589;
        Mon, 18 Feb 2019 06:20:10 -0800 (PST)
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218111421.GC8036@lakrids.cambridge.arm.com>
 <20190218125327.GT32494@hirez.programming.kicks-ass.net>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e877f289-ad3d-8b24-3602-89734aa328d5@arm.com>
Date:   Mon, 18 Feb 2019 14:20:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218125327.GT32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 12:53, Peter Zijlstra wrote:
> On Mon, Feb 18, 2019 at 11:14:23AM +0000, Mark Rutland wrote:
>>> +#ifndef pgd_large
>>> +#define pgd_large(x)0
>>> +#endif
>>> +#ifndef pud_large
>>> +#define pud_large(x)0
>>> +#endif
>>> +#ifndef pmd_large
>>> +#define pmd_large(x)0
>>> +#endif
>>
>> It might be worth a comment defining the semantics of these, e.g. how
>> they differ from p?d_huge() and p?d_trans_huge().
> 
> Yes; I took it to mean any large page mapping, so it would explicitly
> include huge and thp.

Yes your interpretation is correct. I'll add a comment explaining the
semantics.

Thanks,

Steve

