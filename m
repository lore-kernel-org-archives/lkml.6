Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519833978-2-1523776650504951798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833978; b=Ddx193ouabx4dG0OkPguw3RlCLNNW7st2EkOb2LwZI5Bq6t
    L+sTNBwuCPnwjlNQoqGQGfZ+mHxH6PhjCZ7a3SC8ni0jHO54DPAMIYMeFv2T/tBw
    17F/m0iJK5gexkmEAEb0DUU/gsUf1mapx6dDmdyBSzxkUjRi/BdbuDnRSHTMDSLJ
    NmK59ptQhX7qi9pqcocEmVZ73YPfzEnu9dcNsHc52FNklKaH8Ht5YL1u7f40I5E/
    XlD+sypXnoF9rddYc5VzDdHWD62YDqxLAjCktgwB/tGBLuPcqfDSvuY9ZOG6GYkX
    ISgb5J7hBFq6xwow2EXAZyF9QofzKykg4xo+bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833978; bh=ejRsUEoJyYpnf7lZFmc
    8xm43uyO6APnrwTo9F8oejSk=; b=A1QF6qcTi6WbqwYhq57zlytD+abrgNAWsJ8
    I+IO0tvq/NGE4OtkUjqhMxTm/9Jbb1r8zddQxg2KNKswupeQD99Omye9g9v12t5r
    OztVr2xCheQsgWBF1nUSiYe0kUq1cjCVxVyyoYATDwTolFZ3oPcuP2QQ5ojD9CBy
    fKSOH2gQV70qe68dhQvy0xLtvUTwaHHhubaU+hj9dtT17u6S42H0xWbJGv8W7sMp
    LX2STsQnSxyZaJnUojH1kQ4Z2gyqFnvJTU59rV8X8GYBjDgGrGf42jSzNdGlrEme
    Q8Ak1rE31smXeX4kktwyuwr4+Bf4ynRXl8EEl2tnoEg32lMIx+g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934552AbeB1QFr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34903 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932732AbeB1QFn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sinan Kaya" <okaya@codeaurora.org>,
        "Vinod Koul" <vinod.koul@intel.com>,
        "Shunyong Yang" <shunyong.yang@hxt-semitech.com>,
        "Adam Wallis" <awallis@codeaurora.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.227690932@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 083/254] dmaengine: dmatest: move callback wait queue
 to thread context
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

From: Adam Wallis <awallis@codeaurora.org>

commit 6f6a23a213be51728502b88741ba6a10cda2441d upstream.

Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
introduced a bug (that is in fact documented by the patch commit text)
that leaves behind a dangling pointer. Since the done_wait structure is
allocated on the stack, future invocations to the DMATEST can produce
undesirable results (e.g., corrupted spinlocks).

Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
out") attempted to WARN the user that the stack was likely corrupted but
did not fix the actual issue.

This patch fixes the issue by pushing the wait queue and callback
structs into the the thread structure. If a failure occurs due to time,
dmaengine_terminate_all will force the callback to safely call
wake_up_all() without possibility of using a freed pointer.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197605
Fixes: adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Adam Wallis <awallis@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/dmatest.c | 55 +++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -148,6 +148,12 @@ MODULE_PARM_DESC(run, "Run the test (def
 #define PATTERN_OVERWRITE	0x20
 #define PATTERN_COUNT_MASK	0x1f
 
+/* poor man's completion - we want to use wait_event_freezable() on it */
+struct dmatest_done {
+	bool			done;
+	wait_queue_head_t	*wait;
+};
+
 struct dmatest_thread {
 	struct list_head	node;
 	struct dmatest_info	*info;
@@ -156,6 +162,8 @@ struct dmatest_thread {
 	u8			**srcs;
 	u8			**dsts;
 	enum dma_transaction_type type;
+	wait_queue_head_t done_wait;
+	struct dmatest_done test_done;
 	bool			done;
 };
 
@@ -316,18 +324,25 @@ static unsigned int dmatest_verify(u8 **
 	return error_count;
 }
 
-/* poor man's completion - we want to use wait_event_freezable() on it */
-struct dmatest_done {
-	bool			done;
-	wait_queue_head_t	*wait;
-};
 
 static void dmatest_callback(void *arg)
 {
 	struct dmatest_done *done = arg;
-
-	done->done = true;
-	wake_up_all(done->wait);
+	struct dmatest_thread *thread =
+		container_of(arg, struct dmatest_thread, done_wait);
+	if (!thread->done) {
+		done->done = true;
+		wake_up_all(done->wait);
+	} else {
+		/*
+		 * If thread->done, it means that this callback occurred
+		 * after the parent thread has cleaned up. This can
+		 * happen in the case that driver doesn't implement
+		 * the terminate_all() functionality and a dma operation
+		 * did not occur within the timeout period
+		 */
+		WARN(1, "dmatest: Kernel memory may be corrupted!!\n");
+	}
 }
 
 static unsigned int min_odd(unsigned int x, unsigned int y)
@@ -398,9 +413,8 @@ static unsigned long long dmatest_KBs(s6
  */
 static int dmatest_func(void *data)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(done_wait);
 	struct dmatest_thread	*thread = data;
-	struct dmatest_done	done = { .wait = &done_wait };
+	struct dmatest_done	*done = &thread->test_done;
 	struct dmatest_info	*info;
 	struct dmatest_params	*params;
 	struct dma_chan		*chan;
@@ -604,9 +618,9 @@ static int dmatest_func(void *data)
 			continue;
 		}
 
-		done.done = false;
+		done->done = false;
 		tx->callback = dmatest_callback;
-		tx->callback_param = &done;
+		tx->callback_param = done;
 		cookie = tx->tx_submit(tx);
 
 		if (dma_submit_error(cookie)) {
@@ -619,21 +633,12 @@ static int dmatest_func(void *data)
 		}
 		dma_async_issue_pending(chan);
 
-		wait_event_freezable_timeout(done_wait, done.done,
+		wait_event_freezable_timeout(thread->done_wait, done->done,
 					     msecs_to_jiffies(params->timeout));
 
 		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
 
-		if (!done.done) {
-			/*
-			 * We're leaving the timed out dma operation with
-			 * dangling pointer to done_wait.  To make this
-			 * correct, we'll need to allocate wait_done for
-			 * each test iteration and perform "who's gonna
-			 * free it this time?" dancing.  For now, just
-			 * leave it dangling.
-			 */
-			WARN(1, "dmatest: Kernel stack may be corrupted!!\n");
+		if (!done->done) {
 			dmaengine_unmap_put(um);
 			result("test timed out", total_tests, src_off, dst_off,
 			       len, 0);
@@ -707,7 +712,7 @@ err_thread_type:
 		dmatest_KBs(runtime, total_len), ret);
 
 	/* terminate all transfers on specified channels */
-	if (ret)
+	if (ret || failed_tests)
 		dmaengine_terminate_all(chan);
 
 	thread->done = true;
@@ -765,6 +770,8 @@ static int dmatest_add_threads(struct dm
 		thread->info = info;
 		thread->chan = dtc->chan;
 		thread->type = type;
+		thread->test_done.wait = &thread->done_wait;
+		init_waitqueue_head(&thread->done_wait);
 		smp_wmb();
 		thread->task = kthread_create(dmatest_func, thread, "%s-%s%u",
 				dma_chan_name(chan), op, i);
