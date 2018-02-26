Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676995-2-8901319876119975097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676995; b=g1/eziamJzy1DMiA2w9ap8uTK9FU0hH5EtWQLhdGcbxAFpC
    XUj3l8L/ye9pRoA05T805GxginnUf5GuaJ3DpPXj29x2Qc+fkOFqNKUMv/kWIbCB
    hoWCeyBw6xjHd4dXZsfbzehS9pp+GvZHeVm0M34f2uCZ40oRw3fBjxSfU9dOT0EV
    4nlRtU0iouMCBEi4WO3TRRgAeDdjOV6zFugv/t1ZWAYWiGiYskeLoXZ9cMcvxo8g
    vKxUblNaxaLodsW72xs9uBh4kYZEOKJuWvwTd4GskFtEloUJHcyRa8ofknWmfDu/
    MsGtReNnLE//TZPpt31vjKTQRKnVE6aYCk3fm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676995; bh=C8ifoOPWFiMnEPaj3dad22YrZF
    lxqxAw163Y+4tfiCs=; b=blhOdfCTgTxd5nsM5twIiS5CpeAKcBcz0LGQOfi8jd
    9A9ZxiU9degJ64QvXdMAOAAcZNK+u5oWFN4NAp41sbgYX6Xfg3i1GJw44m3s0CYD
    Ie3a+7vuYgsAAGrFVDclyEtT+KhNi5c6GfhmM8Bsn7BuDOLBCB1oFOns3poeiDg9
    WYqScb8m1dkYKKFsiWyMb7y3mwLDOvRP5QNUmwTwe8f5dD1sWFARM1AwqnFcRE8O
    dpgQduLXURsP2jBzwS/Y/g+a0GnE1wmKLEBII6K0w79kE1+xcs+31geh3bRVsrnF
    xjPXvDehaFjv24GtgdnWUtdUg1Mi0QWCD+mPg8FzWnWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeBZU3Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:29:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeBZU3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:29:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 29/64] mm, swap, frontswap: fix THP swap if frontswap enabled
Date: Mon, 26 Feb 2018 21:22:06 +0100
Message-Id: <20180226202154.695632056@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <huang.ying.caritas@gmail.com>

commit 7ba716698cc53f8d5367766c93c538c7da6c68ce upstream.

It was reported by Sergey Senozhatsky that if THP (Transparent Huge
Page) and frontswap (via zswap) are both enabled, when memory goes low
so that swap is triggered, segfault and memory corruption will occur in
random user space applications as follow,

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

After bisection, it was found the first bad commit is bd4c82c22c36 ("mm,
THP, swap: delay splitting THP after swapped out").

The root cause is as follows:

When the pages are written to swap device during swapping out in
swap_writepage(), zswap (fontswap) is tried to compress the pages to
improve performance.  But zswap (frontswap) will treat THP as a normal
page, so only the head page is saved.  After swapping in, tail pages
will not be restored to their original contents, causing memory
corruption in the applications.

This is fixed by refusing to save page in the frontswap store functions
if the page is a THP.  So that the THP will be swapped out to swap
device.

Another choice is to split THP if frontswap is enabled.  But it is found
that the frontswap enabling isn't flexible.  For example, if
CONFIG_ZSWAP=y (cannot be module), frontswap will be enabled even if
zswap itself isn't enabled.

Frontswap has multiple backends, to make it easy for one backend to
enable THP support, the THP checking is put in backend frontswap store
functions instead of the general interfaces.

Link: http://lkml.kernel.org/r/20180209084947.22749-1-ying.huang@intel.com
Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Suggested-by: Minchan Kim <minchan@kernel.org>	[put THP checking in backend]
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
Cc: <stable@vger.kernel.org>	[4.14]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/tmem.c |    4 ++++
 mm/zswap.c         |    6 ++++++
 2 files changed, 10 insertions(+)

--- a/drivers/xen/tmem.c
+++ b/drivers/xen/tmem.c
@@ -284,6 +284,10 @@ static int tmem_frontswap_store(unsigned
 	int pool = tmem_frontswap_poolid;
 	int ret;
 
+	/* THP isn't supported */
+	if (PageTransHuge(page))
+		return -1;
+
 	if (pool < 0)
 		return -1;
 	if (ind64 != ind)
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -970,6 +970,12 @@ static int zswap_frontswap_store(unsigne
 	u8 *src, *dst;
 	struct zswap_header *zhdr;
 
+	/* THP isn't supported */
+	if (PageTransHuge(page)) {
+		ret = -EINVAL;
+		goto reject;
+	}
+
 	if (!zswap_enabled || !tree) {
 		ret = -ENODEV;
 		goto reject;
