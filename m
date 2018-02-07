Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3323526-1517986861-2-15815608483552204648
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
    t=1517986860; b=RqX2mdiEPV0Gc7y6L+2wrIZ9Qk8djTpG1nm7onYLs4DFnYn
    gnmFk7se49p9LAjfFKUvf+nAvTGalxtVmh+lEh7QtpY3ZCkB0fvy3wMN4b/ZJ0sd
    Cnn2JSpUTvHTUGHnvjLex2oBqOEkKCZpiTLZagbHNkDXzW151v0uNsvftCteHiiY
    XRTuReFH/7m+zWxvoo6XRJ+7LJPfjK1rNt6b8Sh4Y/Q059LO0QJeO88/cyF1b87L
    F5v7Cqku3sjRCIEhVFF5XVjke8PQhAGle+nChMaRkJ5q0wDa7LvYbcaX90xRBgRL
    QPHXHj+3LMXIA8B4WsslKoBHy3SbI9wgiU8F21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517986860; bh=9mJW/MPXL6pT/miJFwsVxMG4xv
    SNKSmcU/LB+3ReSvA=; b=Of7sz7qPWEg8jLzAs6Gs5CRc3RiG85JLAy37x9RUnY
    16VZpL5xGAZoylfBA1EAPWHJdVmTh8u4Ij66J76tBcUb/Au44ibjXtSSOtDyoGs7
    J2SNFUBHOU+/4XHaP8j8/gbFESi5fEEKIJP9Pq1Y9pNqktj4k8XIOwHV1XStLjXJ
    lfACEfVOg/76+HCSN9H5tMZ/CvMr1V4RfiN/LrADiY40cW8tnw1L/ukAm+fJjBOP
    osonUDxj/MzgXtgQguJsESjJkLYtxvEnobSGe6zhIYjpLxTQ+rB7CQa5O8OhePi9
    KFtd7KyvwzEw94XERwT9W8vCrBfwPMBiEVF0eeamO67A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeBGHAp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 02:00:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:48001 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbeBGHAo (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Feb 2018 02:00:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000";
   d="scan'208";a="25516441"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
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
Subject: [PATCH -mm -v2] mm, swap, frontswap: Fix THP swap if frontswap enabled
Date: Wed,  7 Feb 2018 15:00:35 +0800
Message-Id: <20180207070035.30302-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huang Ying <huang.ying.caritas@gmail.com>

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

When the pages are written to swap device during swapping out in
swap_writepage(), zswap (fontswap) is tried to compress the pages
instead to improve the performance.  But zswap (frontswap) will treat
THP as normal page, so only the head page is saved.  After swapping
in, tail pages will not be restored to its original contents, so cause
the memory corruption in the applications.

This is fixed via splitting THP before writing the page to swap device
if frontswap is enabled.  To deal with the situation where frontswap
is enabled at runtime, whether the page is THP is checked before using
frontswap during swapping out too.

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

Changelog:

v2:

- Move frontswap check into swapfile.c to avoid to make vmscan.c
  depends on frontswap.
---
 mm/page_io.c  | 2 +-
 mm/swapfile.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

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
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 006047b16814..0b7c7883ce64 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -934,6 +934,9 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
 
 	/* Only single cluster request supported */
 	WARN_ON_ONCE(n_goal > 1 && cluster);
+	/* Frontswap doesn't support THP */
+	if (frontswap_enabled() && cluster)
+		goto noswap;
 
 	avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
 	if (avail_pgs <= 0)
-- 
2.15.1
