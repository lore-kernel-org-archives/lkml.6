Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-14183-1520980993-2-16461142598725163345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520980993; b=pTI3mBp8lr/lNqQcfBXXJux58kaz0p5AH3A9ZYjF9Zg2AlH
    8mIRiN9Weomau9BrEFF9WPepk84UCw5oXUcv4AhHLlzCwIC0Ay6/fmpG0ziRaGAI
    I7148iekEmo8Dnqvq2b8szgCqjIxdMZUhizTqdyROJMTLM90ueh4RFhQu+ZTXeet
    WjbR2ic5Zw88qI2DnYFkIQ1a7cUZM2QDk0j12yuH66p0CAMvoK0aJTqjAzXtydSF
    PZRDEmFN3mTbJpDHJCIGafjHY5NzcjhVY+Keu1HT0zPImnKRvRHosXw49ROHH8mv
    AGn9+3CID+GYAcaQznaFKCMnPj6tV9cKcrkhWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520980993; bh=Xl0TsfsQIO/pxgcFVZpmVxmSv8
    OqjFE1VjyUVlRjdhE=; b=oGIxCT/kbfgl7ibCZe1lpnaPqMmJC2ZQls4uH8wjxP
    9ecnhNe0IDkiWehFijHq0DMBTQocBrrBzVhgKtcvKiVmZLThgXIIxS5Nu8E6Egjb
    Yh1b0u0UFFuwq9vkfIKeFwvhnfnf9NU0JrVq0Vewb3nlkRXXd08O9qeyHwrJCy7R
    gpW+FHzuWJJkoVu+KBN/7MxBNxv4gnYEKZ0mdHBbGPNpJeWeJU/GioyshXtVEVjg
    1Ia0oYfhGmX0/yKW/C75OoBB9i3x2UOGmhLJJlYwZ4LgxGizfmsrkfCJVCB9P0hO
    5/R941KbOYDT4bc2kkRuaE8FJsyegyG9wTvDvDfSXlSw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeCMWnL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 18:43:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932205AbeCMWnK (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Mar 2018 18:43:10 -0400
From: Daniel Vacek <neelx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Daniel Vacek <neelx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
Date: Tue, 13 Mar 2018 23:42:40 +0100
Message-Id: <20180313224240.25295-1-neelx@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some architectures (reported on arm64) commit 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
causes a boot hang. This patch fixes the hang making sure the alignment
never steps back.

Link: http://lkml.kernel.org/r/0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com
Fixes: 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
---
 mm/page_alloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3d974cb2a1a1..e033a6895c6f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5364,9 +5364,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			 * is not. move_freepages_block() can shift ahead of
 			 * the valid region but still depends on correct page
 			 * metadata.
+			 * Also make sure we never step back.
 			 */
-			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
+			unsigned long next_pfn;
+
+			next_pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
 					~(pageblock_nr_pages-1)) - 1;
+			if (next_pfn > pfn)
+				pfn = next_pfn;
 #endif
 			continue;
 		}
-- 
2.16.2
