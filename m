Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1347681-1523550219-2-12889859778810035601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523550218; b=Yhu1muRjYBBIxhX4qp8yEiOJ3Q9BEnAC43AxAEG6JJgbuYrfMd
    KjANOp/kvVL7srFqG9/d3C9LyJMdZXMVVzJuelSmdEE2OT8PWJwrGhCRrHiVYExC
    elJ3GrosVEOQKd4LtAdqQ4QSVOVF9/FfNyGTCkiJZtk7Ic33MZnECpiHqrnNU1Nc
    NUEMeiDjengP2T85RDDiPUffq5KsWHzz6Ula30li5t7lH68QgTOXeg3aOEJ+zUW+
    RxMQAr1fMzHayeThERBoNEu9AOWS/Qbb0Ve8ve1uKKzcmsdcJg8WW4Xqoq/h2nQy
    Kx/+hLibqlrEH9B04AseNPrTh1aMqx/iQgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523550218; bh=Na5JChgQwNpkZcgzE/vddctEyauVg+
    JIPPc2kS195JA=; b=KBFiTGNif1t+MFT0aISVTBTAeZBpCi0QAduvjFRc++UZ02
    aJNjDkAmrnPdu/XM5hW+OvVgxynTfNkJbPW09cfbtgjcIXnZBEMsJ/MF4C4kGgkL
    jjer2R0laLEJWqLXyYfSwRpryzTByZtKNYT4FqRVkmyExHLd81GudqZypiNb1ANT
    BKjDvDRz8ht89Mo4gtUDxSg4Jjs1npRhrsKV2HKbLiKIWIyKprDL4U6qnPPUQwW4
    6k6iuhiIZRj/gqW44C0uqL2A0WpRU9KGaea4Kv2deUvyuWfNBmFHWdW9ev+nP6MW
    mPPca9JrmHvepdHvDUrpwu+GjtWYBQ51G2M3WF0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jDkcLJMm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KBXGr673;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jDkcLJMm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KBXGr673;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJhNFUnIvaqXPXgm/4A2/HdIjP7GnGdOOSBGwHoVTtdHo3dER73Iiif1UYBqTlrABwHrJ5DugNozFszI3nVhMmilKGhP+SAYER3A4wSEs2OO7Tk3f7u8
    jTbqcPvgktGpjIofMzGe80dKdfjN1WYlHCSemx2JsjmjyXZzTRhuttV7fbX/8RASpgXFbpiqBdtYTkoiPBJqUlzy/apzLwy6foIwIfPR+2xg10YwNgDS4+8X
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=206n46q3nOkA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=dLnlp_FASMd5203LdWEA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDLQXh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 12:23:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34936 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbeDLQXg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 12:23:36 -0400
X-Google-Smtp-Source: AIpwx4+wpqXZEGebnGTl40XkDTJ3Rjzljiwaw23WW0vuOcBgcwJwltxrWeK643isWr9XHPk1Oj5qfQ==
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] block: do not use interruptible wait anywhere
Date: Thu, 12 Apr 2018 17:23:21 +0100
Message-Id: <20180412162321.3671-1-alan.christopher.jenkins@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When blk_queue_enter() waits for a queue to unfreeze, or unset the
PREEMPT_ONLY flag, do not allow it to be interrupted by a signal.

The PREEMPT_ONLY flag was introduced later in commit 3a0a529971ec
("block, scsi: Make SCSI quiesce and resume work reliably").  Note the SCSI
device is resumed asynchronously, i.e. after un-freezing userspace tasks.

So that commit exposed the bug as a regression in v4.15.  A mysterious
SIGBUS (or -EIO) sometimes happened during the time the device was being
resumed.  Most frequently, there was no kernel log message, and we saw Xorg
or Xwayland killed by SIGBUS.[1]

[1] E.g. https://bugzilla.redhat.com/show_bug.cgi?id=1553979

Without this fix, I get an IO error in this test:

# dd if=/dev/sda of=/dev/null iflag=direct & \
  while killall -SIGUSR1 dd; do sleep 0.1; done & \
  echo mem > /sys/power/state ; \
  sleep 5; killall dd  # stop after 5 seconds

The interruptible wait was added to blk_queue_enter in
commit 3ef28e83ab15 ("block: generic request_queue reference counting").
Before then, the interruptible wait was only in blk-mq, but I don't think
it could ever have been correct.

Cc: stable@vger.kernel.org
Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 block/blk-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index abcb8684ba67..5a6d20069364 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -915,7 +915,6 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 	while (true) {
 		bool success = false;
-		int ret;
 
 		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
@@ -947,14 +946,12 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		 */
 		smp_rmb();
 
-		ret = wait_event_interruptible(q->mq_freeze_wq,
+		wait_event(q->mq_freeze_wq,
 				(atomic_read(&q->mq_freeze_depth) == 0 &&
 				 (preempt || !blk_queue_preempt_only(q))) ||
 				blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
-		if (ret)
-			return ret;
 	}
 }
 
-- 
2.14.3
