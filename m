Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-208941-1524836591-2-10561324194558914467
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
    1524836591; b=UoCQNbU2v+r8aPuGvziGeZRs41tK0Ul6NgjvsxaaBm02vySrCB
    X3W0Pk/tmHSsug522KzZflUYqtmY4WRFERC1iLhKQ7dmVNdaxHGvg56EFmhH/STI
    FtR0LbZk8MVRgyou0vtPW1UMGtUBn2y7c7mt8T/rP7qK+giW2c9OC7sRcRWpqNWh
    JoBMej+PZgAio1lWc76EnuUbmqx4P3zZkwlOSUzNnnoUBvRzjKwisMH81nhk4FvQ
    jzzgRh0K179Bp47DoBRyl5xtWnP4/JF9zLDrLFmTzOXZUlHh4BCCUByB5HJC+Vlj
    /F8Bn2bU6GceskzzAzy/nkQF6d359GNa3Lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524836591;
    bh=RT2zQO1g9pJPWCr+y4aZtTJyH66M0PN0l6Kpxj7Oqrc=; b=O13qqFtCTspE
    jub8PxsScmRotE9+JALBMEzWomzRyETtkIeBZ0umV2OqxNuoNDTNLCfktrdOv2iB
    SORc6VJ1VaFC3STe79BL5i6iirEOfBoUb+p1gHv/dqE/RSOPyvQyQnm6h9ehHK2W
    qYODq3pqrl7K/NJtPMTx6/DQlCUt1/uPVAU1GR497sHXMjOdkqjWp8qS/sDktAmE
    e8ySirMEFGfdjgrrLzdNcrg5oS1czgRImWJu71GEpSUmcw08Rm9Gh5tQj7MNdYgT
    OsYvjjrM29uDfFn5itXiyUc6ItRaw4C2wreRDRcKVEEpnBgy8t4BW2zbvkqiBEZL
    5KsXG5FO2A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=R26w6jwR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=VFCuLmJZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=R26w6jwR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=VFCuLmJZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhnQM3P4B7am2eeAWnNqbHE5qO6cZdWTNZv+HYA65fTMZ+RdHwhG5nY7Hw/9hkMGbgB6eAfRci9KVE89J4u10DHpS8F8v9JpWel2QEDpTucBUJ8V0f6
    vdL0t5SOLNtOaY+IgIym1p4Jmah2rdEzr2fMyz3JnWNgVi6pvLVh1SeMzhGVOGkC25KMxy2BrHnJY2yoqbiqAsW9yH9npIp9N2JWKiQlT2ggRxDIngi6ywuE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=L7HyDPxxTiwXrpo2WSAA:9 a=QEXdDO2ut3YA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758378AbeD0NnH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:43:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758355AbeD0NnG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 09:43:06 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AB146021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
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
 <5b237058-6617-6af3-8499-8836d95f538d@codeaurora.org>
 <20180427124828.GW15462@8bytes.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <fb4771ca-694b-8a52-d239-1c730617600b@codeaurora.org>
Date: Fri, 27 Apr 2018 19:12:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427124828.GW15462@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/27/2018 6:18 PM, joro@8bytes.org wrote:
> On Fri, Apr 27, 2018 at 05:22:28PM +0530, Chintan Pandya wrote:
>> I'm bit confused here. Are you pointing to race within ioremap/vmalloc
>> framework while updating the page table or race during tlb ops. Since
>> later is arch dependent, I would not comment. But if the race being
>> discussed here while altering page tables, I'm not on the same page.
> 
> The race condition is between hardware and software. It is not
> sufficient to just remove the software references to the page that is
> about to be freed (by clearing the PMD/PUD), also the hardware
> references in the page-walk cache need to be removed with a TLB flush.
> Otherwise the hardware can use the freed (and possibly reused) page to
> establish new TLB entries.

Sure ! This is my understanding too (from arm64 context).

> 
> 
> 
> 	Joerg
> 
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
