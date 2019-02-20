Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72749C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410B52183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfBTOKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:10:50 -0500
Received: from foss.arm.com ([217.140.101.70]:58368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfBTOKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:10:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BEAEBD;
        Wed, 20 Feb 2019 06:10:50 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E0F83F690;
        Wed, 20 Feb 2019 06:10:47 -0800 (PST)
Subject: Re: [PATCH 06/13] mm: pagewalk: Add 'depth' parameter to pte_hole
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-7-steven.price@arm.com>
 <52690905-1755-46BD-940B-1EE4CEA5F795@oracle.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <76ce9f9b-eb0d-6ad5-9f57-ff3a8fa6b074@arm.com>
Date:   Wed, 20 Feb 2019 14:10:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <52690905-1755-46BD-940B-1EE4CEA5F795@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2019 11:35, William Kucharski wrote:
> 
> 
>> On Feb 15, 2019, at 10:02 AM, Steven Price <Steven.Price@arm.com> wrote:
>>
>> The pte_hole() callback is called at multiple levels of the page tables.
>> Code dumping the kernel page tables needs to know what at what depth
>> the missing entry is. Add this is an extra parameter to pte_hole().
>> When the depth isn't know (e.g. processing a vma) then -1 is passed.
>>
>> Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
>> natural numbers as levels 2/3/4.
> 
> Nit: Could you add a comment noting this for anyone wondering how to
> calculate the level numbers in the future?

Good point! I'll expand the comment in the header file.

Thanks,

Steve
