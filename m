Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2594629-1520533408-2-6154248360882597008
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
    t=1520533407; b=VK0rVsFpzHYhyBTQvEOc3XzRpBYPEUm3VY6ticl5prwh/T2
    7QokPsfnT/Qm8czE1+l96kqEW+Pjpc7+ftwpL4iE8b0U1Sfh0amNS7rqv1r4HG/X
    M/xKJcYChmtu1oYIuGDhfNdODT0qMTCcGa+VfeRirZLGBbKJIx9hLKxCSIYUU02v
    soxqYoB/1zc0Z34AB8E3c3i/u/kBxM7Qb1h+OPYGx2PK/5SM+vyiN/Oomw7dnkHg
    8vqMAtI9P+J8hLSPjqZlzUPAS06acHkGAvtL3ArPJh1wP/dcHUTnW/hW/iGFcit3
    9P9pFx1gLr3L8hx4xmwX7g2FBPQcNwmVk1lT18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520533407; bh=d8G6+g5zE8fgfpBHYlyfH6TYM4Zmu68Qj2RATUr1kHg=; b=d
    ryqW3iUBVJy3GwIkKIpyq2kjxqsWXbyZowtOlRrsbELxjkPP3Y6gsE5iCkupLg50
    nwc0iOL68om9JPwHzB3Jp+xAqn3lbjwtY6VgPuLgoeOfMRUrafbl7mzLViCH9257
    ioo2w8R1Ru9XfuciMPeuDCRx5607HXDusg81X0el17Ci0W2HJClin6lLnFt3Oddw
    bnRt0+7pbaegGuuyifGQQFUR4mnVqO3DfySWr5ng81kwsxBZqpBwuQY29Wq3YTDz
    9kIGYtgF1eqbr2HXPlkzJUAPoCzSC4NA4mzSXu6SjH4mzcWwRHP7ByWah046/9JV
    HWgv2oUr9sqJMntfPwXGg==
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
        id S1752149AbeCHSXX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:23:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:16282 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754458AbeCHSXX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 13:23:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="23607539"
Subject: Re: [PATCH 1/2] x86/mm: Give each mm a unique ID
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
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <9b0d1195-23bd-5bf9-0dd8-b2ca29165bbb@linux.intel.com>
Date: Thu, 8 Mar 2018 10:23:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180307173036.GJ7097@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 09:30 AM, Greg Kroah-Hartman wrote:
> On Fri, Mar 02, 2018 at 01:32:09PM -0800, Tim Chen wrote:
>> From: Andy Lutomirski <luto@kernel.org>
>> commit: f39681ed0f48498b80455095376f11535feea332
>>
>> This adds a new variable to mmu_context_t: ctx_id.
>> ctx_id uniquely identifies the mm_struct and will never be reused.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Arjan van de Ven <arjan@linux.intel.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Rik van Riel <riel@redhat.com>
>> Cc: linux-mm@kvack.org
>> Link: http://lkml.kernel.org/r/413a91c24dab3ed0caa5f4e4d017d87b0857f920.1498751203.git.luto@kernel.org
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>  arch/x86/include/asm/mmu.h         | 15 +++++++++++++--
>>  arch/x86/include/asm/mmu_context.h |  5 +++++
>>  arch/x86/mm/tlb.c                  |  2 ++
>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>
> 
> Does not apply to 4.4.y :(
> 
> Can you provide a working backport for that tree?
> 

Okay. Will do.  Thanks.

Tim
