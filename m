Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-87399-1524829965-2-16190344188085727868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524829965; b=fcpkr/UpmY8Wnd/uyXHLdElG60QvxCOcJ4c2UlKYwBfoRG3g9L
    MhbUOPp9iLSNhK/pLcmQi+9bVPZBzA+eeKraAZUQIFQJGc1ny6Uqerwr4yH/qi7s
    QLseG+fGpM9HzNLPjPszgfppeLht/WHe3W4dD/IYlR8GayN1d+12tSy0rrIPAYMJ
    MafYkLqr6UlRiIbib4X32GKfKCE7hiBynFvkhhD9Nkc5GJwAMTaFTBHCK3yZ1ekv
    VrNDQA/a9qMWEK3N4Rg3W+uOdT8S1v45K0+dwMxug1tx3jRKEKCOJlpy9kThLQ5o
    Zg/YvF1/5wdVbJI8zYiOpDmYhZakJEZ72vsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524829965;
    bh=SC9iP6mPoOiAl+NHJquuPupCJ0ORBVetL38/ZlgM/u8=; b=U7yBYaL+AEXI
    rVQCkAJWexw5bhiOTTCvyTN6aTi/RNDG8fP6r/Zr4HvIj88AMT4DXUPYgvA73reI
    gW9rnG9/Ns+UDMeqCnyaRc60G+FjPxR+J2KwAuy1CMhqzEClulKsbo0rdo8lYtfU
    pYJrjReKoqwgSNl4t9Ry+DzJUAH8sksfMGGpvkl+QWMNo5Y7TTee7QthkxFC2fYC
    cujWOW+I0+UF0vGiCc4rOs4/e+Vvj/R0Nb1RPEzP6MZt2L0O0VDzbWfYeG+LB5VO
    2XqTEtkFVkey5FAciGrA8qAuTTc4y6t2k4rqiM2Hhvd2T6DWiSLjUkHfGzA6xTSU
    +7LM1ejQgQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=HzVsB3Zj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=gHArKzq9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=HzVsB3Zj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=gHArKzq9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBYpAJfk9NAD21C+/IxUjZabBmi1LILfU8Rf7GrTTDsemjbAxYPvhXbqGQOJOMFiHePSE15ZxzKlRiKgEwnhcXUulpJE+ORNtN3JSJl7SD/BbcNntfuw
    IPBb/PQKes1yRrFqot+T/v0iFIBRIWoxVbI1vEfFv6+WFnGwgu1xI/kNVA7Rgx0GFYuQoStRCs9Yd9DLFQpn1jSzmafoK49YDYM0iGCk0PPof1cmRYkjXYaB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tA7aZXjiAAAA:8 a=AnCRExsXPPGaeAxcvg4A:9 a=bZCRBQg3A2-ap--A:21
    a=FTms2aTC9UUC7d10:21 a=QEXdDO2ut3YA:10 a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757704AbeD0Lwm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 07:52:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeD0Lwl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 07:52:41 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8C1A6034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
To: "joro@8bytes.org" <joro@8bytes.org>,
        "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "Hocko, Michal" <MHocko@suse.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org> <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org> <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org> <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <5b237058-6617-6af3-8499-8836d95f538d@codeaurora.org>
Date: Fri, 27 Apr 2018 17:22:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427073719.GT15462@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/27/2018 1:07 PM, joro@8bytes.org wrote:
> On Thu, Apr 26, 2018 at 10:30:14PM +0000, Kani, Toshi wrote:
>> Thanks for the clarification. After reading through SDM one more time, I
>> agree that we need a TLB purge here. Here is my current understanding.
>>
>>   - INVLPG purges both TLB and paging-structure caches. So, PMD cache was
>> purged once.
>>   - However, processor may cache this PMD entry later in speculation
>> since it has p-bit set. (This is where my misunderstanding was.
>> Speculation is not allowed to access a target address, but it may still
>> cache this PMD entry.)
>>   - A single INVLPG on each processor purges this PMD cache. It does not
>> need a range purge (which was already done).
>>
>> Does it sound right to you?
> 
> The right fix is to first synchronize the changes when the PMD/PUD is
> cleared and then flush the TLB system-wide. After that is done you can
> free the page.
> 

I'm bit confused here. Are you pointing to race within ioremap/vmalloc
framework while updating the page table or race during tlb ops. Since
later is arch dependent, I would not comment. But if the race being 
discussed here while altering page tables, I'm not on the same page.

Current ioremap/vmalloc framework works with reserved virtual area for 
its own purpose. Within this virtual area, we maintain mutual 
exclusiveness by maintaining separate rbtree which is of course 
synchronized. In the __vunmap leg, we perform page table ops first and
then release the virtual area for someone else to re-use. This way, 
without taking any additional locks for page table modifications, we are
good.

If that's not the case and I'm missing something here.

Also, I'm curious to know what race you are observing at your end.


Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
