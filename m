Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835789-2-723699527278886172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835788; b=ud/gfDfDA2IW12f0WcBcbkr89fTmWRuKYl/2BGWvfMKmIBv
    Dbr1VM6rOfZwSlsETfguKPSXfVLS4y3hQtDGjmQ4gJwooAkFq9Nb+GjMcnHpgyTB
    fKId2CMiVjxtVi77wZt8c2i7IqzcPcHjt8hNK5kntfCRQWqpfHuMCO42uDzEmQJS
    go4zcefB1lKAkSKh/G6Xp6ayFzGRmyuXGmGLh85JNnA0aZ0alfkLr43AweBNCUw4
    ntWksxfhAbuZ0uNXPR/oG41EdrNGQul0iJk2Q+E2Yr0txvOtquM3KcFcKv3m2He0
    GnFwWVPZyUYcwfcalEEvlXe4kbTy4KcTT0eKS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835788; bh=3Pz6YHuOrRaf9QDLRV1
    qp9Z6H4h1LTTw0zDodGLm8e8=; b=NQAXtjfqbkJs/LwoZW8E2pyt1tnLuASSs5c
    /g2eKyj6XQIEdxZgKJ08zNbaioTGJ79jAfJJnobh3T1fbtt5U+nFMk/dVuC228++
    qiUTz63dosKcx/U+RXflZOqqYHnE92hqJou+FLjYRwRkgSq4z5Ho8BGGn+k2A3+L
    e+mbYQDM/htXozYJRzhkUpCN7rC7mfrB1dwLnrk6vB7/2scLaRwImuEMcIuwL72p
    ZcoFrH0cbCwm1tKg4Qet/S6DXKdGgOpTLpSTERwEL+G6DkhDeAxPtX+qgFjVENeb
    X0IuxoLQxDPyyueKX4viDXuuvYzY2rkxNieXdFhUDj8qp4Tbneg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeB1QFC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34852 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752602AbeB1QE7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@fb.com>,
        "Ming Lei" <ming.lei@canonical.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.172925287@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 234/254] blk-mq: fix race between timeout and freeing
 request
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@canonical.com>

commit 0048b4837affd153897ed1222283492070027aa9 upstream.

Inside timeout handler, blk_mq_tag_to_rq() is called
to retrieve the request from one tag. This way is obviously
wrong because the request can be freed any time and some
fiedds of the request can't be trusted, then kernel oops
might be triggered[1].

Currently wrt. blk_mq_tag_to_rq(), the only special case is
that the flush request can share same tag with the request
cloned from, and the two requests can't be active at the same
time, so this patch fixes the above issue by updating tags->rqs[tag]
with the active request(either flush rq or the request cloned
from) of the tag.

Also blk_mq_tag_to_rq() gets much simplified with this patch.

Given blk_mq_tag_to_rq() is mainly for drivers and the caller must
make sure the request can't be freed, so in bt_for_each() this
helper is replaced with tags->rqs[tag].

[1] kernel oops log
[  439.696220] BUG: unable to handle kernel NULL pointer dereference at 0000000000000158^M
[  439.697162] IP: [<ffffffff812d89ba>] blk_mq_tag_to_rq+0x21/0x6e^M
[  439.700653] PGD 7ef765067 PUD 7ef764067 PMD 0 ^M
[  439.700653] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC ^M
[  439.700653] Dumping ftrace buffer:^M
[  439.700653]    (ftrace buffer empty)^M
[  439.700653] Modules linked in: nbd ipv6 kvm_intel kvm serio_raw^M
[  439.700653] CPU: 6 PID: 2779 Comm: stress-ng-sigfd Not tainted 4.2.0-rc5-next-20150805+ #265^M
[  439.730500] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011^M
[  439.730500] task: ffff880605308000 ti: ffff88060530c000 task.ti: ffff88060530c000^M
[  439.730500] RIP: 0010:[<ffffffff812d89ba>]  [<ffffffff812d89ba>] blk_mq_tag_to_rq+0x21/0x6e^M
[  439.730500] RSP: 0018:ffff880819203da0  EFLAGS: 00010283^M
[  439.730500] RAX: ffff880811b0e000 RBX: ffff8800bb465f00 RCX: 0000000000000002^M
[  439.730500] RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000000^M
[  439.730500] RBP: ffff880819203db0 R08: 0000000000000002 R09: 0000000000000000^M
[  439.730500] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000202^M
[  439.730500] R13: ffff880814104800 R14: 0000000000000002 R15: ffff880811a2ea00^M
[  439.730500] FS:  00007f165b3f5740(0000) GS:ffff880819200000(0000) knlGS:0000000000000000^M
[  439.730500] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b^M
[  439.730500] CR2: 0000000000000158 CR3: 00000007ef766000 CR4: 00000000000006e0^M
[  439.730500] Stack:^M
[  439.730500]  0000000000000008 ffff8808114eed90 ffff880819203e00 ffffffff812dc104^M
[  439.755663]  ffff880819203e40 ffffffff812d9f5e 0000020000000000 ffff8808114eed80^M
[  439.755663] Call Trace:^M
[  439.755663]  <IRQ> ^M
[  439.755663]  [<ffffffff812dc104>] bt_for_each+0x6e/0xc8^M
[  439.755663]  [<ffffffff812d9f5e>] ? blk_mq_rq_timed_out+0x6a/0x6a^M
[  439.755663]  [<ffffffff812d9f5e>] ? blk_mq_rq_timed_out+0x6a/0x6a^M
[  439.755663]  [<ffffffff812dc1b3>] blk_mq_tag_busy_iter+0x55/0x5e^M
[  439.755663]  [<ffffffff812d88b4>] ? blk_mq_bio_to_request+0x38/0x38^M
[  439.755663]  [<ffffffff812d8911>] blk_mq_rq_timer+0x5d/0xd4^M
[  439.755663]  [<ffffffff810a3e10>] call_timer_fn+0xf7/0x284^M
[  439.755663]  [<ffffffff810a3d1e>] ? call_timer_fn+0x5/0x284^M
[  439.755663]  [<ffffffff812d88b4>] ? blk_mq_bio_to_request+0x38/0x38^M
[  439.755663]  [<ffffffff810a46d6>] run_timer_softirq+0x1ce/0x1f8^M
[  439.755663]  [<ffffffff8104c367>] __do_softirq+0x181/0x3a4^M
[  439.755663]  [<ffffffff8104c76e>] irq_exit+0x40/0x94^M
[  439.755663]  [<ffffffff81031482>] smp_apic_timer_interrupt+0x33/0x3e^M
[  439.755663]  [<ffffffff815559a4>] apic_timer_interrupt+0x84/0x90^M
[  439.755663]  <EOI> ^M
[  439.755663]  [<ffffffff81554350>] ? _raw_spin_unlock_irq+0x32/0x4a^M
[  439.755663]  [<ffffffff8106a98b>] finish_task_switch+0xe0/0x163^M
[  439.755663]  [<ffffffff8106a94d>] ? finish_task_switch+0xa2/0x163^M
[  439.755663]  [<ffffffff81550066>] __schedule+0x469/0x6cd^M
[  439.755663]  [<ffffffff8155039b>] schedule+0x82/0x9a^M
[  439.789267]  [<ffffffff8119b28b>] signalfd_read+0x186/0x49a^M
[  439.790911]  [<ffffffff8106d86a>] ? wake_up_q+0x47/0x47^M
[  439.790911]  [<ffffffff811618c2>] __vfs_read+0x28/0x9f^M
[  439.790911]  [<ffffffff8117a289>] ? __fget_light+0x4d/0x74^M
[  439.790911]  [<ffffffff811620a7>] vfs_read+0x7a/0xc6^M
[  439.790911]  [<ffffffff8116292b>] SyS_read+0x49/0x7f^M
[  439.790911]  [<ffffffff81554c17>] entry_SYSCALL_64_fastpath+0x12/0x6f^M
[  439.790911] Code: 48 89 e5 e8 a9 b8 e7 ff 5d c3 0f 1f 44 00 00 55 89
f2 48 89 e5 41 54 41 89 f4 53 48 8b 47 60 48 8b 1c d0 48 8b 7b 30 48 8b
53 38 <48> 8b 87 58 01 00 00 48 85 c0 75 09 48 8b 97 88 0c 00 00 eb 10
^M
[  439.790911] RIP  [<ffffffff812d89ba>] blk_mq_tag_to_rq+0x21/0x6e^M
[  439.790911]  RSP <ffff880819203da0>^M
[  439.790911] CR2: 0000000000000158^M
[  439.790911] ---[ end trace d40af58949325661 ]---^M

Signed-off-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
[bwh: Backported to 3.16:
 - Flush state is in struct request_queue, not struct blk_flush_queue
 - Flush request cloning is done in blk_mq_clone_flush_request() rather
   than blk_kick_flush()
 - Drop changes in bt{,_tags}_for_each()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/blk-flush.c  | 15 ++++++++++++++-
 block/blk-mq-tag.c |  4 ++--
 block/blk-mq-tag.h | 12 ++++++++++++
 block/blk-mq.c     | 16 +---------------
 block/blk.h        |  6 ++++++
 5 files changed, 35 insertions(+), 18 deletions(-)

--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -73,6 +73,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-tag.h"
 
 /* FLUSH/FUA sequences */
 enum {
@@ -224,7 +225,12 @@ static void flush_end_io(struct request
 	unsigned long flags = 0;
 
 	if (q->mq_ops) {
+		struct blk_mq_hw_ctx *hctx;
+
+		/* release the tag's ownership to the req cloned from */
 		spin_lock_irqsave(&q->mq_flush_lock, flags);
+		hctx = q->mq_ops->map_queue(q, q->flush_rq->mq_ctx->cpu);
+		blk_mq_tag_set_rq(hctx, q->flush_rq->tag, q->orig_rq);
 		q->flush_rq->tag = -1;
 	}
 
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -85,4 +85,16 @@ static inline void blk_mq_tag_idle(struc
 	__blk_mq_tag_idle(hctx);
 }
 
+/*
+ * This helper should only be used for flush request to share tag
+ * with the request cloned from, and both the two requests can't be
+ * in flight at the same time. The caller has to make sure the tag
+ * can't be freed.
+ */
+static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
+		unsigned int tag, struct request *rq)
+{
+	hctx->tags->rqs[tag] = rq;
+}
+
 #endif
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -310,6 +310,9 @@ void blk_mq_clone_flush_request(struct r
 	flush_rq->tag = orig_rq->tag;
 	memcpy(blk_mq_rq_to_pdu(flush_rq), blk_mq_rq_to_pdu(orig_rq),
 		hctx->cmd_size);
+	orig_rq->q->orig_rq = orig_rq;
+
+	blk_mq_tag_set_rq(hctx, orig_rq->tag, flush_rq);
 }
 
 inline void __blk_mq_end_io(struct request *rq, int error)
@@ -520,20 +523,9 @@ void blk_mq_kick_requeue_list(struct req
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
-static inline bool is_flush_request(struct request *rq, unsigned int tag)
-{
-	return ((rq->cmd_flags & REQ_FLUSH_SEQ) &&
-			rq->q->flush_rq->tag == tag);
-}
-
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
-	struct request *rq = tags->rqs[tag];
-
-	if (!is_flush_request(rq, tag))
-		return rq;
-
-	return rq->q->flush_rq;
+	return tags->rqs[tag];
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -462,6 +462,12 @@ struct request_queue {
 	struct list_head	flush_queue[2];
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
+
+	/*
+	 * flush_rq shares tag with this rq, both can't be active
+	 * at the same time
+	 */
+	struct request		*orig_rq;
 	spinlock_t		mq_flush_lock;
 
 	struct list_head	requeue_list;
