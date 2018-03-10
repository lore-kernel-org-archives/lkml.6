Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1867236-1520643885-2-14846858041183979516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520643883; b=nTYA6mstR3C8t5Y3FUbY+cm8ji74Uk3PfcKRpgrBviHPdQo
    T6o+ojhjrDdRVc4VjVTWKnL1E8jI8XCWsSE3f4FKTIRPztLEMEou5RmoPttKJK9n
    S+g7S1zToW8Fy384qA5qDtAx/5m9dLhRjotTYyfaqWOCiMq5TJcsqT+CUMlcx5TW
    bbRynqa9z6u2qXjYFqv9hrP5Rj63/9tKceLQVAEeZCDzbENRTWFOAbXNiTgxIsTj
    MSmy2VfIuMkcnUQFkCmaQ0i4J8JVVz2pJPGGd44xpIcIDFzrCi61mJM5Y6vnafGV
    Y5+mTWsom59WStgr79Pij1Ag2RIF05md79ErCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520643883; bh=gge8sJmlcIpAgj5HIVsr5eFFa7udHtV/2eqrY37LWWQ=; b=W
    v/V1X9k/KQQ4Ii3pJMPpNVzaONbKaXqxdpV0BfdO68+j9SPZG4i19r6ba67tAuhX
    CiV2CLzd00AjgBAsCXCmp9hUB5n2ntM/0E8ZTWbLCW9MWLae2cIXSSSbEORfPkar
    Zwfyrp84pxS/OyaH09NGG+q/FC3+evEGn5pInNLUi3z5rEi9fs3JRvO8ZlFHtuwE
    biIj+hO6o7lBmoeiMVINdAiFScp3lNKEj5srxwcJFilzlUoduqvgc7ZdHKrZH8Sc
    Yu+bfRoLB61t3JoQlk3zazYP4nqR5Eqhvvs7CLNi+Pw/zmwnZ0v4RlgM22IJW9UA
    7//2GCjfHFj88IMT7RnRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeCJBEl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 20:04:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:51841 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932666AbeCJBEk (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 20:04:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,448,1515484800";
   d="scan'208";a="23980107"
Subject: Re: [PATCH 1/2] x86/mm: Give each mm a unique ID
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>, ak@linux.intel.com,
        karahmed@amazon.de, pbonzini@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
 <3351ba53a3b570ba08f2a0f5a59d01b7d80a8955.1520026221.git.tim.c.chen@linux.intel.com>
 <20180307173036.GJ7097@kroah.com>
 <9b0d1195-23bd-5bf9-0dd8-b2ca29165bbb@linux.intel.com>
Message-ID: <8322b21f-5ee7-41a6-7897-d73faa0ece27@linux.intel.com>
Date: Fri, 9 Mar 2018 17:04:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9b0d1195-23bd-5bf9-0dd8-b2ca29165bbb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 10:23 AM, Tim Chen wrote:
> On 03/07/2018 09:30 AM, Greg Kroah-Hartman wrote:
>> On Fri, Mar 02, 2018 at 01:32:09PM -0800, Tim Chen wrote:
>>> From: Andy Lutomirski <luto@kernel.org>
>>> commit: f39681ed0f48498b80455095376f11535feea332
>>>
>>> This adds a new variable to mmu_context_t: ctx_id.
>>> ctx_id uniquely identifies the mm_struct and will never be reused.
>>>
>>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>>> Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
>>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Arjan van de Ven <arjan@linux.intel.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Rik van Riel <riel@redhat.com>
>>> Cc: linux-mm@kvack.org
>>> Link: http://lkml.kernel.org/r/413a91c24dab3ed0caa5f4e4d017d87b0857f920.1498751203.git.luto@kernel.org
>>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> ---
>>>  arch/x86/include/asm/mmu.h         | 15 +++++++++++++--
>>>  arch/x86/include/asm/mmu_context.h |  5 +++++
>>>  arch/x86/mm/tlb.c                  |  2 ++
>>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>>
>>
>> Does not apply to 4.4.y :(
>>
>> Can you provide a working backport for that tree?
>>
> 
> Okay. Will do.  Thanks.
> 


Greg,

I actually found that there are a number of dependent IBPB related patches that haven't been
backported yet to 4.4:

    x86/cpufeatures: Add AMD feature bits for Speculation Control
    (cherry picked from commit 5d10cbc91d9eb5537998b65608441b592eec65e7)

    x86/msr: Add definitions for new speculation control MSRs
    (cherry picked from commit 1e340c60d0dd3ae07b5bedc16a0469c14b9f3410)

    x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support
    (cherry picked from commit 20ffa1caecca4db8f79fe665acdeaa5af815a24d)

    x86/cpufeatures: Clean up Spectre v2 related CPUID flags
    (cherry picked from commit 2961298efe1ea1b6fc0d7ee8b76018fa6c0bcef2)

And probably and a few more.
You have plans to backport these patches?

Tim
