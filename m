Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-144836-1524833313-2-16677172961658888618
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
    1524833313; b=CsbWEY18zN78wC9oM493ExnD86zRoEFZ4I1oFVgN70Swri+EoB
    KxQDh54LA7rDBqNBKjkukQbpkZfQ1k8VWwaK35L8Lp0dHgk5WXqsWdr0ltbHLnFf
    GQdud2ZH01CseLUOeI6HKC/eDkRZOOOPOJc3av6QnkEyZ8pZMTddRzezFEAgjlCi
    hFjjoy0+GmrClVbL+AJ9SQVglKlN8zL4I18Np9YBXrCcsUxXEKOvvmzIICxSKVz8
    H3qn+6UuyT+gNd0QMLwQ0fH53P+73nB5iNp/lEASnMTFEgNkj/abdsJiHJO1bAjI
    7K5GBEYQ9wQmu/QQUT9CRyxFwduoz5lgh8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524833313; bh=w50O5cP0jQi0v+VIIEKm09cF11mAcT
    TzcJu+hlGuzjU=; b=Hatn/C8ISN2S4Sv4rHrWBQBvX8z7rjDtj9MLYMQZuKUlQK
    ryD8JfIDQ2SVVt60iUum6nYqm7WXMDlVJwhf38oWT4V3rjWdRkeGUtZRPhA22MAL
    vSlGh4JP6KZmuxdFJbeZizYvUnWbsdeC3c9RFHDtfhYnv1ViBO3w0/wNnmJ6cPnx
    NZearxYtwJ3H3urf6LkT4DAkxDm3aIlfvWrcqliX0hyThS5wHTqvfJ5KlZ6ZS3gL
    b3Wg6OwK+tk6WBdHZZHd2YHX+jJjBvH74aR/8YmX0q4ffhkTBlu5f43YqTQW/b/0
    FiesNaPY0YEl7+IPmSECaIaf74PfZk74z1Y0KBoA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=pbU7ttVc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=pbU7ttVc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCNBN5920qmgD0MO2sq1KHV9KUbx0VDiMZXNTg1klw2yvnoYM84NJeWDwUSrO7n1+p949iGkfADqcmKIJ0urPUWQhVSrnZpkEtqt1mmVPVQfK7wYhrif
    H8km5RSxtFCIkwJBXSWXujyZ6OlM7g3DJOaZlcMOWb5H3vAuK3KWSc0vMvAplDSpw+7Ck++168RUWAUMesnURiHrSx/3Ikx475gYzHGDEG/6QXpxeKeptlx6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=SD-14VuNOnQeFxEq_IUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758100AbeD0Msb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 08:48:31 -0400
Received: from 8bytes.org ([81.169.241.247]:39426 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758096AbeD0Msa (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 08:48:30 -0400
Date: Fri, 27 Apr 2018 14:48:29 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: "Kani, Toshi" <toshi.kani@hpe.com>,
        "Hocko, Michal" <MHocko@suse.com>, "hpa@zytor.com" <hpa@zytor.com>,
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
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180427124828.GW15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
 <5b237058-6617-6af3-8499-8836d95f538d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b237058-6617-6af3-8499-8836d95f538d@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 05:22:28PM +0530, Chintan Pandya wrote:
> I'm bit confused here. Are you pointing to race within ioremap/vmalloc
> framework while updating the page table or race during tlb ops. Since
> later is arch dependent, I would not comment. But if the race being
> discussed here while altering page tables, I'm not on the same page.

The race condition is between hardware and software. It is not
sufficient to just remove the software references to the page that is
about to be freed (by clearing the PMD/PUD), also the hardware
references in the page-walk cache need to be removed with a TLB flush.
Otherwise the hardware can use the freed (and possibly reused) page to
establish new TLB entries.



	Joerg
