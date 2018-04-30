Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-983888-1525073488-2-8351223608085134749
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
    1525073488; b=EC1GLFeeHmk9Dxzb1FhbjUWw4yyj6RWC4r7nDoJtEwHHsPAkW5
    FFe7A76QvHX10XsUSJxySZydiRfIIr4sJVlQRebRgiyRYgY9ZG1/MTpwh5jAI6Wi
    PZpA/6bc3vnDWXNIKKzhTiXZYIvK7XDs4vmNhGmZ2mc1pA/FTyvserBWgyP2pryt
    Yi8ITCs63zT7JMlCdwJJI6C1/bmzhOH3Y8+4G1qT8xmvNz56l/MEioSprVf/x0iu
    8vDeArgkJL3RGKqYNKJFf7+iYprWuu1V+XPxtCsSfU20j7PkagfShl39VV+RfKZj
    sceIbIlbW6hAJi4s4rW9N1HVDtrSmrisbVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525073488;
    bh=YiIDGmM5ikkf35oXSHwgMpMBtvNL6q8NKPnRl2kB404=; b=Si2TJJ+0VDpG
    eb9D1Ca/M/FnuAF1Xz4WaOhxvCs6CNYtAAoTdOVHqxGaHR7vrtwYIiDPHedIgyiq
    RrGG4R1q3YyvUGRMw6hLm7wNHaFaUv67cwAf/4G1zoOKZD3yrbMgAeOhk+DwoqAl
    P9hVaymQ4Z1Zyk0ekkhgxwfV481qMnYhDIbacXqvyjeO2XMNroXFDyuOys/J8AGL
    BS8js3Pi16LyyGB2ZfQtS7dzSX95zsSXo/kubI+9GWHskRHYgW2/iuCy+PRhPJ9Y
    SQ2c72l1EzB3ki1LHd0/zqbQgJnNQRdDd2epROSZMoNHgo56p4v2V613LTwZVBxw
    QAx6lLLb1g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=ROHCmDOz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Rwv9NWnX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=ROHCmDOz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Rwv9NWnX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOerOv0ottpVCJ6BJNQYWP1P6edt+L6Bgyw+FwAbDlqFmIi5zSnuvo3ylTCcMj5HYBiDwS7nxIfPjQA5vCpwdhjWxXYGvpeaA15KlhIvuznejzgF1Na4
    5x5rr4+GTFFHmHw251hSDw3+q37tUyK3FK4tmTX9WdBI6rVeuLvPD7zBT6Jz6wRHDF2Z4OgyugFvMqLTY5vJdWbRAhCC1x8NpKdgAaecmLNuYY6pt8r144J4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=5ffDubygYwogodm5avIA:9 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeD3HbO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 03:31:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeD3HbL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 03:31:11 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1732060271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
To: "Kani, Toshi" <toshi.kani@hpe.com>,
        "joro@8bytes.org" <joro@8bytes.org>
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
 <20180427073719.GT15462@8bytes.org> <1524839460.2693.531.camel@hpe.com>
 <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
 <1524948829.2693.547.camel@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <c8c5e78a-2cb2-ca46-6521-928b6c0114c6@codeaurora.org>
Date: Mon, 30 Apr 2018 13:00:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524948829.2693.547.camel@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/29/2018 2:24 AM, Kani, Toshi wrote:
> On Sat, 2018-04-28 at 11:02 +0200, joro@8bytes.org wrote:
>> On Fri, Apr 27, 2018 at 02:31:51PM +0000, Kani, Toshi wrote:
>>> So, we can add the step 2 on top of this patch.
>>>   1. Clear pud/pmd entry.
>>>   2. System wide TLB flush <-- TO BE ADDED BY NEW PATCH
>>>   3. Free its underlining pmd/pte page.
>>
>> This still lacks the page-table synchronization and will thus not fix
>> the BUG_ON being triggered.
> 
> The BUG_ON issue is specific to PAE that it syncs at the pmd level.
> x86/64 does not have this issue since it syncs at the pgd or p4d level.
> 
>>> We do not need to revert this patch.  We can make the above change I
>>> mentioned.
>>
>> Please note that we are not in the merge window anymore and that any fix
>> needs to be simple and obviously correct.
> 
> Understood.  Changing the x86/32 sync point is risky.  So, I am going to
> revert the free page handling for PAE.

Will this affect pmd_free_pte_page() & pud_free_pmd_page() 's existence
or its parameters ? I'm asking because, I've similar change for arm64
and ready to send v9 patches.

I'm thinking to share my v9 patches in any case. If you are going to do
TLB invalidation within these APIs, my first patch will help.

> 
> Thanks,
> -Toshi
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
