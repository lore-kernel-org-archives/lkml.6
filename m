Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-201413-1517900134-2-5227217666837882982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517900133; b=jKdzSM+nTvq6hZoDRpq3zudG6YDeYk2pBadHAwu8GkBkued
    oRSzirUAeNgJpJjt38vtqz7jqPMW1W61ZgNq7kPkJs3lRao9RKxK1nzxPVEaaWnK
    ccoiUqb1FC8mqSOkryQrBKMMRKze3ohJ10g4RHaJsxmXrP61F/cZwrKhr0kKHjmG
    /19otTuWgH3zEIWqDcmuF2mcytQZkunmkE5aaR9tuCF4JrO55kxpLs1l4hG2PPYu
    nkvxA/VqSw1Pa3HqPuSeEzB1qZX1LHbTDUxwz3G+13X6iGx0HFyq7uzO/qzvrlZe
    WI3JQOPImIKOife3prtn1BghTHmTzDYYlYqF46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517900133; bh=WvlMBAvyWWXNZ/+/ZawUyz4JWX
    sfUHHn82KrdZETPo4=; b=IZGanjh1cEY9epYB4oJpHIooja439LUYcXJe9+fOE5
    Eec7FzJRegCbmcv5T14VzKGVi7h4pfjOqLGspu0daB/grm9s2Gxz9lDWknAagI1z
    pzuNz+JayHOuExmGDyC/W4LauHQfdAvTVeqep9H+4TNkBIuS97Z0mqQGJ7nub2Mt
    YttEoCRZlpXXWSnJrN/ipWQgWZd26Tb9NJk92r5ltZ8NbSa6SWfecdOWmND+7HS/
    wlMWtmKuA7Fd4G8UAvxJmZ0iOAwjvArK9CLvGOuMfdAHYitnitOCSy2opgXL2p0+
    mZy+5TmvhvbW912DLtHbgLb8UgwIYnWSIZtfC8kP+MpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBFGza (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 01:55:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:24320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbeBFGza (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 01:55:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,467,1511856000";
   d="scan'208";a="201695974"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH -mm] mm, swap, frontswap: Fix THP swap if frontswap enabled
Date: Tue,  6 Feb 2018 14:54:04 +0800
Message-Id: <20180206065404.18815-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huang Ying <ying.huang@intel.com>

It was reported by Sergey Senozhatsky that if THP (Transparent Huge
Page) and frontswap (via zswap) are both enabled, when memory goes low
so that swap is triggered, segfault and memory corruption will occur
in random user space applications as follow,

kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
 #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
 #1  0x00007fc08889c2f3 malloc (libc.so.6)
 #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
 #3  0x0000560e6005e75c n/a (urxvt)
 #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
 #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
 #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
 #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
 #8  0x0000560e6005cb55 ev_run (urxvt)
 #9  0x0000560e6003b9b9 main (urxvt)
 #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
 #11 0x0000560e6003f9da _start (urxvt)

After bisection, it was found the first bad commit is
bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped
out").

The root cause is as follow.

When the pages are written to storage device during swapping out in
swap_writepage(), zswap (fontswap) is tried to compress the pages
instead to improve the performance.  But zswap (frontswap) will treat
THP as normal page, so only the head page is saved.  After swapping
in, tail pages will not be restored to its original contents, so cause
the memory corruption in the applications.

This is fixed via splitting THP at the begin of swapping out if
frontswap is enabled.  To avoid frontswap to be enabled at runtime,
whether the page is THP is checked before using frontswap during
swapping out too.

Reported-and-tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Shaohua Li <shli@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: stable@vger.kernel.org # 4.14
Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
---
 mm/page_io.c |  2 +-
 mm/vmscan.c  | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index b41cf9644585..6dca817ae7a0 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -250,7 +250,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		unlock_page(page);
 		goto out;
 	}
-	if (frontswap_store(page) == 0) {
+	if (!PageTransHuge(page) && frontswap_store(page) == 0) {
 		set_page_writeback(page);
 		unlock_page(page);
 		end_page_writeback(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bee53495a829..d1c1e00b08bb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -55,6 +55,7 @@
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
+#include <linux/frontswap.h>
 
 #include "internal.h"
 
@@ -1063,14 +1064,23 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 					/* cannot split THP, skip it */
 					if (!can_split_huge_page(page, NULL))
 						goto activate_locked;
+					/*
+					 * Split THP if frontswap enabled,
+					 * because it cannot process THP
+					 */
+					if (frontswap_enabled()) {
+						if (split_huge_page_to_list(
+							page, page_list))
+							goto activate_locked;
+					}
 					/*
 					 * Split pages without a PMD map right
 					 * away. Chances are some or all of the
 					 * tail pages can be freed without IO.
 					 */
-					if (!compound_mapcount(page) &&
-					    split_huge_page_to_list(page,
-								    page_list))
+					else if (!compound_mapcount(page) &&
+						 split_huge_page_to_list(page,
+							page_list))
 						goto activate_locked;
 				}
 				if (!add_to_swap(page)) {
-- 
2.15.1
