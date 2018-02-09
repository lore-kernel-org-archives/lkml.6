Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-849932-1518166206-2-3110814622908990085
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
    t=1518166206; b=fqatX5viv+52F2ECWs1hsrN523zVsk68YxJNZU/KkJ6FNp1
    /L64a3FP+g+M64iVzLyexDZu9owLXAE6kU8jV8iBXxyYggDazTjpiB9yIg4RBKD/
    gyrSX9WtR/5oPUZh+An8aR9LrrP9O8oTEMTL+/lX6gGLHL7Rsp4RFuTIa0cpJObc
    wMk3DOUkuktsfS3g31hg6Z/4QaeCj5QlGDZh0Ed0XDSu64TmQZnw1WJVYLkO37BV
    SJRnQWy5aXkCA3ChEyeVAGFAjQdEwTCloFgFQAdkdOS8DRZnWQ2sODqr8C7XCtaU
    Cj7LOrWEv8V1A50u5nQkUy0qLKjcfLNUOleK7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518166206; bh=+CUN3TmVBD2zIC2fKTJBM8yBq2
    7Rhbo3ccpO0UI/9rw=; b=JAPk7I02t4JSHgcG9Q9VJroT4iFSM6MGTqnKnYQShS
    4L9MmXzlj1igwg/NKq9n9T4fRTd4ryu1xGxOMskwEi1vSZTNB+OWns8JHRUWtBDA
    Sy7WIUty5ZDBSJmPEGPpPtvnVfKKyY7v2ZokmkVbZKA+6sc+Ly+/k6eRhFNcHSc8
    dndfwYXvaLLIyJNt9ypfIu/RV0i44COc/YaAb+20IwUXz8v0L24mUw0dBlBIk+j6
    tklpBPU6Rqymb+n4zcQgDRe40gXFMEUXVT6AJIQ/XUjKo8efz+oB14R1SN95KBUC
    MWEv9rrBaj+tuoGrlATGxzIb2ieKIO7qkZ+Jhuild1EA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeBIIuD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 03:50:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:58413 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeBIIuC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 03:50:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="16711590"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH -mm -v3] mm, swap, frontswap: Fix THP swap if frontswap enabled
Date: Fri,  9 Feb 2018 16:49:47 +0800
Message-Id: <20180209084947.22749-1-ying.huang@intel.com>
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

This is fixed via rejecting to save page in frontswap store functions
if the page is a THP.  So that the THP will be swapped out to swap
device.

Another choice is to split THP if frontswap is enabled.  But it is
found that the frontswap enabling isn't flexible.  For example, if
CONFIG_ZSWAP=y (cannot be module), frontswap will be enabled even if
zswap itself isn't enabled.

Frontswap has multiple backends, to make it easy for one backend to
enable THP support, the THP checking is put in backend frontswap store
functions instead of the general interfaces.

Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Suggested-by: Minchan Kim <minchan@kernel.org> # put THP checking in backend
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Shaohua Li <shli@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org # 4.14

Changelog:

v3:

- Fix via checking THP in frontswap backend as suggested by Minchan.

v2:

- Move frontswap check into swapfile.c to avoid to make vmscan.c
  depends on frontswap as suggested by Minchan.
---
 drivers/xen/tmem.c | 4 ++++
 mm/zswap.c         | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/xen/tmem.c b/drivers/xen/tmem.c
index bf13d1ec51f3..04e7b3b29bac 100644
--- a/drivers/xen/tmem.c
+++ b/drivers/xen/tmem.c
@@ -284,6 +284,10 @@ static int tmem_frontswap_store(unsigned type, pgoff_t offset,
 	int pool = tmem_frontswap_poolid;
 	int ret;
 
+	/* THP isn't supported */
+	if (PageTransHuge(page))
+		return -1;
+
 	if (pool < 0)
 		return -1;
 	if (ind64 != ind)
diff --git a/mm/zswap.c b/mm/zswap.c
index c004aa4fd3f4..61a5c41972db 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1007,6 +1007,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	u8 *src, *dst;
 	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
 
+	/* THP isn't supported */
+	if (PageTransHuge(page)) {
+		ret = -EINVAL;
+		goto reject;
+	}
+
 	if (!zswap_enabled || !tree) {
 		ret = -ENODEV;
 		goto reject;
-- 
2.15.1
