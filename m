Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3808880-1520443839-2-14289040449296497851
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520443839; b=sjkxOd990QbBVnKRc6CN0jviLaQTOJximO+3zS/GWW75YBW
    z2nzfLef7FiY9gBQ/1VybbhYZ6aJT6lSnnRCVZ9bxkAvNLYlRvyW7CoCGtZtdh3F
    +x0kWw0C4k1XTGZDdG6GuyB/wGYmCPB04UGjJ2/LxjPupO12R7sfLIXzb+lTbFoo
    2TT86v7yDJIST81FqLWJ1/DYeuaaC9DlJqHTTXjWkytgjIwynNtst6dN2EwrdiLM
    s1rlnD8GkHrdC+Qv7bTKxSi4G6t6kEJZdsQNB32jHw25UR5knej/VtZVQ0BOBcXz
    FOHwT9SjWzCAhmQxjb2lT7f1XQnJP+ICDFhruNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520443839; bh=0xak1XiPnfO08xgBpzlxSKfjE9
    kylrVrzuA3KloI4Qk=; b=skXN+m0RZibKtQ3viDtrRUi6awWIvuiuSmdjjf5Hc0
    fITmASoobEkjaOneMdgF6zpKArZza+g+VtBvjLvmAYzSN0TbaezVWI7b25BBajRp
    eKDI+oseTGkumVxSKFJNCrPctCLS3t3CdgwFX0W/sIcvTpadjMxTYEwaaDoz7SHM
    UIAafUR4n7w+a8I+JXG93u08NGt/nmhN24V9Q9XUr4R7cSiRAFP0PxHmDpPVG6gC
    HkYGIE0h7LkV5TMDFhk5o9BEXh3+5ZAWKGHkqC4imO8XvBaYfTC3CjwmMrDLRH/H
    Q0GviuGl4k7xhCTuDy1COLoXN2uMj08Rz759ArEQsDlA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeCGRag (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:30:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCGRaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 12:30:35 -0500
Date: Wed, 7 Mar 2018 09:30:36 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
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
Subject: Re: [PATCH 1/2] x86/mm: Give each mm a unique ID
Message-ID: <20180307173036.GJ7097@kroah.com>
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
 <3351ba53a3b570ba08f2a0f5a59d01b7d80a8955.1520026221.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3351ba53a3b570ba08f2a0f5a59d01b7d80a8955.1520026221.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 01:32:09PM -0800, Tim Chen wrote:
> From: Andy Lutomirski <luto@kernel.org>
> commit: f39681ed0f48498b80455095376f11535feea332
> 
> This adds a new variable to mmu_context_t: ctx_id.
> ctx_id uniquely identifies the mm_struct and will never be reused.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: linux-mm@kvack.org
> Link: http://lkml.kernel.org/r/413a91c24dab3ed0caa5f4e4d017d87b0857f920.1498751203.git.luto@kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  arch/x86/include/asm/mmu.h         | 15 +++++++++++++--
>  arch/x86/include/asm/mmu_context.h |  5 +++++
>  arch/x86/mm/tlb.c                  |  2 ++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 

Does not apply to 4.4.y :(

Can you provide a working backport for that tree?

thanks,

greg k-h
