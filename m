Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1698546-1524906148-2-10406365941539816275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524906148; b=Oeks1tQTeuno8k7IwKhYFCGGXkby0T5/QfAmzt9i8c/v5q1CQP
    tpiEcNT9at6QCpoA8DSDyH6kAaqiP9DEgMCsLA+Ru6R2BTRTN++RKB/wAtNqzHqn
    j9myqubmxUHVwoR6TfnV6RwZsdqhIKPAG8YR8zzfg8hRGgY1p02/3HknOuHBiwn6
    XkhPR99/PJTjs6rUB1qz1Ha1F09bmagP2BfrdvNIB8ANfz1pRSivWu9iMXi8Zk3j
    5IZbMZX+0daPIPhBl3LbOc4/f5OzUEMb3cbhEpFv2Q5LgA5xUQCGVQMg9yfnd7hS
    9mcKTa53gntR6snqf2+rbtjeU+Rg33sjVb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524906148; bh=RtyIm5GZ+LVP2VAsaf+1Qmh/ZSwpO6
    qUrS9rsauB9Ck=; b=VhDSGeVQ6/ijpmIRoozDiKWqlRGUsg0wASBa6DZ2SYv0KP
    +pLWivB/wk8RVWa6jF/idU35iNn8mKPZYVzfuEb5q3xQLocrb41OSHcR7p+FRuPo
    IqcVs/Q5ZEaAjQNu0UC6JgwUHJHJcienDI5XoaakZ5EOHhfOyUEhAx6hX7AA6uBQ
    HN2ag1eRoffzX0x+LidfUoDgafAmXutC5cjDsxyB1yO1t86IzoOC0ABO2NGfuKqE
    71DAEA5HHvpNbxGVGhYWdrXPp5VB+54WkjDv9dlXS7U0VT6Kinri5pqwGrSB2tv5
    oNlWUtv4w2qikU0uriQeot3B0sVJw96sZkIERRsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=B978+4bm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=B978+4bm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH37OqDytkgID2SlMiwFGpW9iFjwfkNxXlgAiXl9N9qjxEH2TKPUzAIBGQTCiNmh8+k1zc0Qc1WIhJDPLSjJF9ENHR/AWD3uPhvpVFQyhJIaaRCLokZ8
    g/o5lQU9W0Da0uwQZoQw51vRcLuC2iC144ze25EnWFYACfkwjcWdeFKvvgJ03/djRxpIQtfRN9Aj8y77i5nUXmwsqu8Fi4jehX6wNOYg0OiOEldz0vauHJU2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=h116-fA8RKNBJDk72LQA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759646AbeD1JCY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 05:02:24 -0400
Received: from 8bytes.org ([81.169.241.247]:50440 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759592AbeD1JCW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 05:02:22 -0400
Date: Sat, 28 Apr 2018 11:02:17 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
 <1524839460.2693.531.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524839460.2693.531.camel@hpe.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 02:31:51PM +0000, Kani, Toshi wrote:
> So, we can add the step 2 on top of this patch.
>  1. Clear pud/pmd entry.
>  2. System wide TLB flush <-- TO BE ADDED BY NEW PATCH
>  3. Free its underlining pmd/pte page.

This still lacks the page-table synchronization and will thus not fix
the BUG_ON being triggered.

> We do not need to revert this patch.  We can make the above change I
> mentioned.

Please note that we are not in the merge window anymore and that any fix
needs to be simple and obviously correct.


Thanks,

	Joerg
