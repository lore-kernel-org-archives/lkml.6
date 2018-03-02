Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2537421-1520026351-2-13494068599499796203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520026351; b=M0m98AjeOHHbxMdybGYQUGgVDy/K0KQX8eD06s7uOc7J++g
    STwOnjXZhG67azI/pYDg3r3Ly9lVKeXCx0LzuYOSdeYBx4VR27npSXOVhNZPmVPC
    RKjEIy5BLzp6qLYiDTSwAFTU5CBTZkzCn5A1a1jyV8bKkDKzeQhekU56AeUVwoU4
    wOW71/2vqCp5NQnQ9YgLD/Csq+0NupOD+biss66AIo6loBvg47E90v2pnvgnxRVk
    F8QM+VqjgPPybamiFwOPCe+nY1WoKt8fum325N+oRdm0a0zjzkfWPBa4KmVV32Ln
    Pm6FTT5R4YE7IRNpHNJSg8bmv83OQdpS1hU2+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520026351; bh=Tev/LUA9XNlwUhOoM5d70USP9k
    UN7yH/Ky7cvEX7R/8=; b=kkk9tg26Z5Hcz5hMnOg1sHKtAak720b0SFiUGdbz7s
    s+LXEHVF8/NEC5FxH+lRGcAQuC73UZFDkxcCgB4ZrdokQAfOWsN0s4yIS8fQoRkE
    xw/1MnnmMVhyZGQMPTcJxrTrnRwTysuPfOjSlN8q7GjozBo1Jgf6rDzRe9TpJk08
    Th/nTi8BJm3MTFZ3p6WW1dXJCHSwX4Ki9FOJ1IIHjuFJ9Xj7zai/1vxyffViufpK
    CLgSoAJaPc9Lnf+2eMtG2+8Ornd5Mq6P2jQ6l9l4SFBmXsJ0Jh8n9gKWT8nbWguy
    z1/d5HJaDOUzOqUN5eMIig6d7MJixeNwTfyk30zv82DA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbeCBVcZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 16:32:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:55419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933990AbeCBVcY (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 16:32:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="22145314"
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH 0/2] Backport IBPB on context switch to non-dumpable process 
Date: Fri,  2 Mar 2018 13:32:08 -0800
Message-Id: <cover.1520026221.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg,

I will like to propose backporting "x86/speculation: Use Indirect Branch
Prediction Barrier on context switch" from commit 18bf3c3e in upstream
to 4.9 and 4.4 stable.  The patch has already been ported to 4.14 and
4.15 stable.  The patch needs mm context id that Andy added in commit
f39681ed. I have lifted the mm context id change from Andy's upstream
patch and included it here.

Thanks.

Tim

Tim Chen (2):
  x86/mm: Give each mm a unique ID
  x86/speculation: Use Indirect Branch Prediction Barrier in context
    switch

 arch/x86/include/asm/mmu.h         | 15 +++++++++++++--
 arch/x86/include/asm/mmu_context.h |  5 +++++
 arch/x86/include/asm/tlbflush.h    |  2 ++
 arch/x86/mm/tlb.c                  | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.9.4
