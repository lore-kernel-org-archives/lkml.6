Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3035697-1517594077-2-3748723723521649300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517594077; b=kkK9bmenaOgmsXQhTTmX4TfTl8Se87Va2lZvr5xkIbURTBv
    uPoWmYej8RSo1mml/YqI+Z5hC4RusWEnF9zkbQDS/mtz+c3Eeiw5tnTeWABmR1Cp
    zbzr1JwwEOBoSZxUj85oDFjW3PtpVHmS4yZG+rfeOG0Lndu/hDzIyQilxfwi0MGX
    ejOjSXXIOutbllMrclcsj9MCRTGpZKeEfop6VSw3ql9AjyB436uDH4yCoP7lmlw9
    9csdiY0Du1uiBm0Ct/L2/TUU6Il8/yHhIz+onWVFxE9aTt6074T4j/aBRUIJ01jG
    q9i9QE//ch8ym70xfnBb9aZzP0pKnch8S7fU1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1517594077; bh=Q3i5j+IT7sUH6aLjWhTS8l0D19ecYoYyatxtwJM5MNw=; b=H
    4RVqdiWrMu7nQyYvBfoj0H04yW0JpVIH0AzWCGxthiJlLWYUxekj4puAjoIbvmg1
    E1Q8U5eZgUguxb8U7mK/W0wlxLwbzMYXP1Se4ySaTH9K9OwNQOv9hUXOZ10ir2ZK
    DyyG9EbFbr9SpWt1WFwcFj6SrLOkLApZHBZx+fHPWLNly8LDUhOElviJ0X7ZQaMg
    qgm7YAFI6XLlG6Hj6dQfwzDeemDybO5eM8Cn/wVL1E3t6RlBs7ajQJmkTOCMgmND
    7VXmcg9QkCmq3y/795BpVFEG/8W1j0at8rw203rHK3g2Gl+E9qAt6KBQJJS5NDUd
    7Sq+OACWEQrRxbSneKCDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cEBUlyiu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=npxfou+A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cEBUlyiu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=npxfou+A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeBBRyc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:54:32 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37768 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeBBRxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:53:33 -0500
X-Google-Smtp-Source: AH8x224AwUod1arIQOWpB+Xulqr2mV7EG6pzMt4T8byjoeJuWoFIjkZjmZQmWxuuVblhvklMHSHq1A==
Date: Fri, 2 Feb 2018 09:53:28 -0800
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joshua Miller <joshmiller@fb.com>, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] bdi: make sure congestion states are clear on free
Message-ID: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

FUSE has a bug where it fails to clear congestion states if a
connection gets aborted while congested, which can leave
nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
wait spuriously.

While the bdi owner, FUSE, is primarily responsible for clearing
congestion states before destroying bdi_writebacks, bdi layer can
ensure that congestion states are not leaked beyond bdi_writeback
lifecycle.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Joshua Miller <joshmiller@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
---
 include/linux/backing-dev.h |   14 +++++++++++++-
 mm/backing-dev.c            |    2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -220,6 +220,18 @@ static inline int bdi_sched_wait(void *w
 	return 0;
 }
 
+static inline void __wb_congested_free(struct bdi_writeback_congested *congested)
+{
+	/*
+	 * Make sure congestion states are cleared before freeing to avoid
+	 * nr_wb_congested() corruption which can lead to misbehaving
+	 * wait_iff_congested().
+	 */
+	clear_wb_congested(congested, BLK_RW_SYNC);
+	clear_wb_congested(congested, BLK_RW_ASYNC);
+	kfree(congested);
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct bdi_writeback_congested *
@@ -409,7 +421,7 @@ wb_congested_get_create(struct backing_d
 static inline void wb_congested_put(struct bdi_writeback_congested *congested)
 {
 	if (atomic_dec_and_test(&congested->refcnt))
-		kfree(congested);
+		__wb_congested_free(congested);
 }
 
 static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -509,7 +509,7 @@ void wb_congested_put(struct bdi_writeba
 	}
 
 	spin_unlock_irqrestore(&cgwb_lock, flags);
-	kfree(congested);
+	__wb_congested_free(congested);
 }
 
 static void cgwb_release_workfn(struct work_struct *work)
