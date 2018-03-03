Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520035998-2-14161866152588485805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520035997; b=ldjD6YwN4yBke+SuT9TMtyHgxi/IW1KvLn4SYYwlO9tN2pV
    swDbl3YBJC81JkVnYvmRGj/B4BWX4z7jdAwEavVaejtdLKrN5NHfPMlKunyoST+j
    o8ICp0nE4iqmfWI0bva86fgHQmt3fskMc36RO3vytcWZ2gQ6zmpFsDim8yeKX6Os
    sxk9JsA1MBwqUH1I05MfzKTPh7heBVRYxZP1MBh5Kg97G1joS80Z7hbBMorRZ+48
    rFZh4uWbmFxnu43qU4rpOg6y7qoVSD4iJUFMeHbAKX2CQxsL9oAB6kFlllZGnz0W
    KK/M/L1sCnNxsOSHYNvlwdkoVugOHp9sWFNfaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1520035997; bh=bJbZE1UvO4xOP3qSgbcteZ2x1BoBwAR1f1p
    Al9CcMFc=; b=XKEEGOH/hCPtkaxLG9hKNUQppujnd8Ow7My57ulaoP5watK1zc8
    iLZwZDOfB5N1yRIU7iE871d2zhVXHaosTJQ0KngoIhv+y27IuWc4ZZP5I7KkfzW8
    7grFd+tNF6dT6tZ8Cbg6ysshmNXDbOYWZbf3Ow/6wszF86VkZ9J76ya8BKihpg5K
    lnNNyvCxoQwR1WAn+++kcs1ysPJJBvk8N6aPXsFapZs7b0xnjKJQs0pnWWJHRTyB
    PkHD8lPtbVnKXKGBLhtCFeb6hMlSEx1PZbL/xveOugR7fStGG2UlaDiM9sXbou2b
    ZfyEUWeGwasiMILoaYq6NCZg74/3NPq/0dQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935028AbeCCANN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 19:13:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935244AbeCCAMr (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 19:12:47 -0500
From: Daniel Vacek <neelx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/2] mm/memblock: hardcode the end_pfn being -1
Date: Sat,  3 Mar 2018 01:12:25 +0100
Message-Id: <1ca478d4269125a99bcfb1ca04d7b88ac1aee924.1520011944.git.neelx@redhat.com>
In-Reply-To: <cover.1520011944.git.neelx@redhat.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com>
In-Reply-To: <cover.1520011944.git.neelx@redhat.com>
References: <cover.1520011944.git.neelx@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just a clean up. It aids preventing to handle the special end case
in the next commit.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: stable@vger.kernel.org
---
 mm/memblock.c   | 13 ++++++-------
 mm/page_alloc.c |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5a9ca2a1751b..2a5facd236bb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1101,13 +1101,12 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r->nid;
 }
 
-unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
-						      unsigned long max_pfn)
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 {
 	struct memblock_type *type = &memblock.memory;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
-	phys_addr_t addr = PFN_PHYS(pfn + 1);
+	phys_addr_t addr = PFN_PHYS(++pfn);
 
 	do {
 		mid = (right + left) / 2;
@@ -1118,15 +1117,15 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
 				  type->regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn + 1 is valid */
-			return min(pfn + 1, max_pfn);
+			/* addr is within the region, so pfn is valid */
+			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
-		return max_pfn;
+		return -1UL;
 	else
-		return min(PHYS_PFN(type->regions[right].base), max_pfn);
+		return PHYS_PFN(type->regions[right].base);
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb416723538f..f2c57da5bbe5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5361,7 +5361,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
 			 * on our next iteration of the loop.
 			 */
-			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
+			pfn = memblock_next_valid_pfn(pfn) - 1;
 #endif
 			continue;
 		}
-- 
2.16.2
