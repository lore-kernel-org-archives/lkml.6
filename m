Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803914-2-18401621978867143232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803913; b=KDLFWzhEF38fOWtEUS+NkcgMZkNCTUhtnHFImxCzgi8sepI
    YO49briLFCUh6XR3VDMkGsvzqt0cRzjIgWpukgxmwmw+O3KRNeMcoA6kkReueqcx
    GjcmCql+OuRA99uFBeptCFhRtuEfM6P4HsEtwBwdSvT2Po+q6apj3uPpWIC0GUSV
    Ax32QedUMkrCVYLsSQ3bMNsZJUpuThkdhpsYfIVRXbkfpeEwCFfbe4t4U5Lnevbo
    8A3/smWrEHOMYDxsPdOK9X69WWERg+ZSDK5uTjZuV+lbBCymWXIPZd1247jbbIgU
    52JygzETSK+jXWxdCJpjELXE0DGyX+hrsaIG/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803913; bh=mvfy0cVosMTSQZcKN7Q/8cqU+l
    JSLr+Y4ysob5ygI/s=; b=NEH/AAN3V9OOcSzwbkOGXpAxKtz4NOiA93WZ0Zcq7U
    eS6EJAJvIQEQvlezLjj6ypKQo9AQAEr/i1xATGOmb4Rf7hQZEViunM/bW0U80XW1
    1/5mG9Bh7GPf7pJKcqL2pa/rGWpotTNuoEBczjJfWh86vglSqWPmtR7gzcgDl+UX
    zsrsqzFQrCWaTDeuEy3BDmryAgv2K/L6LbW8xOWbse3drTOB+kwHgajDh7TpGl3v
    AHOtSSN/6KqGwHl5L4zUVYARs4Qn9Ty8k1KY46czOiqfB8Xxp4UWLBXSuaoD6u6h
    KMbsrfE2U0XRA/5Wkt4G7NOSzSj0rodN+q1TWEmTJgdA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCWLSR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:18:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbeCWKJJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciszyn <mike.marciniszyn@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 096/177] IB/hfi1: Fix softlockup issue
Date: Fri, 23 Mar 2018 10:53:44 +0100
Message-Id: <20180323094209.530333897@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tadeusz Struk <tadeusz.struk@intel.com>


[ Upstream commit 22546b741af8355cd2e16739b6af4a8f17081839 ]

Soft lockups can occur because the mad processing on different CPUs acquire
the spin lock dc8051_lock:

[534552.835870]  [<ffffffffa026f993>] ? read_dev_port_cntr.isra.37+0x23/0x160 [hfi1]
[534552.835880]  [<ffffffffa02775af>] read_dev_cntr+0x4f/0x60 [hfi1]
[534552.835893]  [<ffffffffa028d7cd>] pma_get_opa_portstatus+0x64d/0x8c0 [hfi1]
[534552.835904]  [<ffffffffa0290e7d>] hfi1_process_mad+0x48d/0x18c0 [hfi1]
[534552.835908]  [<ffffffff811dc1f1>] ? __slab_free+0x81/0x2f0
[534552.835936]  [<ffffffffa024c34e>] ? ib_mad_recv_done+0x21e/0xa30 [ib_core]
[534552.835939]  [<ffffffff811dd153>] ? __kmalloc+0x1f3/0x240
[534552.835947]  [<ffffffffa024c3fb>] ib_mad_recv_done+0x2cb/0xa30 [ib_core]
[534552.835955]  [<ffffffffa0237c85>] __ib_process_cq+0x55/0xd0 [ib_core]
[534552.835962]  [<ffffffffa0237d70>] ib_cq_poll_work+0x20/0x60 [ib_core]
[534552.835964]  [<ffffffff810a7f3b>] process_one_work+0x17b/0x470
[534552.835966]  [<ffffffff810a8d76>] worker_thread+0x126/0x410
[534552.835969]  [<ffffffff810a8c50>] ? rescuer_thread+0x460/0x460
[534552.835971]  [<ffffffff810b052f>] kthread+0xcf/0xe0
[534552.835974]  [<ffffffff810b0460>] ? kthread_create_on_node+0x140/0x140
[534552.835977]  [<ffffffff81696418>] ret_from_fork+0x58/0x90
[534552.835980]  [<ffffffff810b0460>] ? kthread_create_on_node+0x140/0x140

This issue is made worse when the 8051 is busy and the reads take longer.
Fix by using a non-spinning lock procure.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Reviewed-by: Mike Marciszyn <mike.marciniszyn@intel.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/chip.c |   86 ++++++++++++++++++++++----------------
 drivers/infiniband/hw/hfi1/hfi.h  |    7 +--
 drivers/infiniband/hw/hfi1/init.c |    2 
 3 files changed, 57 insertions(+), 38 deletions(-)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -6379,18 +6379,17 @@ static void lcb_shutdown(struct hfi1_dev
  *
  * The expectation is that the caller of this routine would have taken
  * care of properly transitioning the link into the correct state.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
  */
-static void dc_shutdown(struct hfi1_devdata *dd)
+static void _dc_shutdown(struct hfi1_devdata *dd)
 {
-	unsigned long flags;
+	lockdep_assert_held(&dd->dc8051_lock);
 
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
-	if (dd->dc_shutdown) {
-		spin_unlock_irqrestore(&dd->dc8051_lock, flags);
+	if (dd->dc_shutdown)
 		return;
-	}
+
 	dd->dc_shutdown = 1;
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
 	/* Shutdown the LCB */
 	lcb_shutdown(dd, 1);
 	/*
@@ -6401,35 +6400,45 @@ static void dc_shutdown(struct hfi1_devd
 	write_csr(dd, DC_DC8051_CFG_RST, 0x1);
 }
 
+static void dc_shutdown(struct hfi1_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_shutdown(dd);
+	mutex_unlock(&dd->dc8051_lock);
+}
+
 /*
  * Calling this after the DC has been brought out of reset should not
  * do any damage.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
  */
-static void dc_start(struct hfi1_devdata *dd)
+static void _dc_start(struct hfi1_devdata *dd)
 {
-	unsigned long flags;
-	int ret;
+	lockdep_assert_held(&dd->dc8051_lock);
 
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
 	if (!dd->dc_shutdown)
-		goto done;
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
+		return;
+
 	/* Take the 8051 out of reset */
 	write_csr(dd, DC_DC8051_CFG_RST, 0ull);
 	/* Wait until 8051 is ready */
-	ret = wait_fm_ready(dd, TIMEOUT_8051_START);
-	if (ret) {
+	if (wait_fm_ready(dd, TIMEOUT_8051_START))
 		dd_dev_err(dd, "%s: timeout starting 8051 firmware\n",
 			   __func__);
-	}
+
 	/* Take away reset for LCB and RX FPE (set in lcb_shutdown). */
 	write_csr(dd, DCC_CFG_RESET, 0x10);
 	/* lcb_shutdown() with abort=1 does not restore these */
 	write_csr(dd, DC_LCB_ERR_EN, dd->lcb_err_en);
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
 	dd->dc_shutdown = 0;
-done:
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
+}
+
+static void dc_start(struct hfi1_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_start(dd);
+	mutex_unlock(&dd->dc8051_lock);
 }
 
 /*
@@ -8418,16 +8427,11 @@ static int do_8051_command(
 {
 	u64 reg, completed;
 	int return_code;
-	unsigned long flags;
 	unsigned long timeout;
 
 	hfi1_cdbg(DC8051, "type %d, data 0x%012llx", type, in_data);
 
-	/*
-	 * Alternative to holding the lock for a long time:
-	 * - keep busy wait - have other users bounce off
-	 */
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
+	mutex_lock(&dd->dc8051_lock);
 
 	/* We can't send any commands to the 8051 if it's in reset */
 	if (dd->dc_shutdown) {
@@ -8453,10 +8457,8 @@ static int do_8051_command(
 			return_code = -ENXIO;
 			goto fail;
 		}
-		spin_unlock_irqrestore(&dd->dc8051_lock, flags);
-		dc_shutdown(dd);
-		dc_start(dd);
-		spin_lock_irqsave(&dd->dc8051_lock, flags);
+		_dc_shutdown(dd);
+		_dc_start(dd);
 	}
 
 	/*
@@ -8534,8 +8536,7 @@ static int do_8051_command(
 	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, 0);
 
 fail:
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
-
+	mutex_unlock(&dd->dc8051_lock);
 	return return_code;
 }
 
@@ -11849,6 +11850,10 @@ static void free_cntrs(struct hfi1_devda
 	dd->scntrs = NULL;
 	kfree(dd->cntrnames);
 	dd->cntrnames = NULL;
+	if (dd->update_cntr_wq) {
+		destroy_workqueue(dd->update_cntr_wq);
+		dd->update_cntr_wq = NULL;
+	}
 }
 
 static u64 read_dev_port_cntr(struct hfi1_devdata *dd, struct cntr_entry *entry,
@@ -12004,7 +12009,7 @@ u64 write_port_cntr(struct hfi1_pportdat
 	return write_dev_port_cntr(ppd->dd, entry, sval, ppd, vl, data);
 }
 
-static void update_synth_timer(unsigned long opaque)
+static void do_update_synth_timer(struct work_struct *work)
 {
 	u64 cur_tx;
 	u64 cur_rx;
@@ -12013,8 +12018,8 @@ static void update_synth_timer(unsigned
 	int i, j, vl;
 	struct hfi1_pportdata *ppd;
 	struct cntr_entry *entry;
-
-	struct hfi1_devdata *dd = (struct hfi1_devdata *)opaque;
+	struct hfi1_devdata *dd = container_of(work, struct hfi1_devdata,
+					       update_cntr_work);
 
 	/*
 	 * Rather than keep beating on the CSRs pick a minimal set that we can
@@ -12097,7 +12102,13 @@ static void update_synth_timer(unsigned
 	} else {
 		hfi1_cdbg(CNTR, "[%d] No update necessary", dd->unit);
 	}
+}
+
+static void update_synth_timer(unsigned long opaque)
+{
+	struct hfi1_devdata *dd = (struct hfi1_devdata *)opaque;
 
+	queue_work(dd->update_cntr_wq, &dd->update_cntr_work);
 	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
 }
 
@@ -12333,6 +12344,13 @@ static int init_cntrs(struct hfi1_devdat
 	if (init_cpu_counters(dd))
 		goto bail;
 
+	dd->update_cntr_wq = alloc_ordered_workqueue("hfi1_update_cntr_%d",
+						     WQ_MEM_RECLAIM, dd->unit);
+	if (!dd->update_cntr_wq)
+		goto bail;
+
+	INIT_WORK(&dd->update_cntr_work, do_update_synth_timer);
+
 	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
 	return 0;
 bail:
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -475,7 +475,7 @@ struct rvt_sge_state;
 #define HFI1_PART_ENFORCE_OUT	0x2
 
 /* how often we check for synthetic counter wrap around */
-#define SYNTH_CNT_TIME 2
+#define SYNTH_CNT_TIME 3
 
 /* Counter flags */
 #define CNTR_NORMAL		0x0 /* Normal counters, just read register */
@@ -929,8 +929,9 @@ struct hfi1_devdata {
 	spinlock_t rcvctrl_lock; /* protect changes to RcvCtrl */
 	/* around rcd and (user ctxts) ctxt_cnt use (intr vs free) */
 	spinlock_t uctxt_lock; /* rcd and user context changes */
-	/* exclusive access to 8051 */
-	spinlock_t dc8051_lock;
+	struct mutex dc8051_lock; /* exclusive access to 8051 */
+	struct workqueue_struct *update_cntr_wq;
+	struct work_struct update_cntr_work;
 	/* exclusive access to 8051 memory */
 	spinlock_t dc8051_memlock;
 	int dc8051_timed_out;	/* remember if the 8051 timed out */
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1078,11 +1078,11 @@ struct hfi1_devdata *hfi1_alloc_devdata(
 	spin_lock_init(&dd->uctxt_lock);
 	spin_lock_init(&dd->hfi1_diag_trans_lock);
 	spin_lock_init(&dd->sc_init_lock);
-	spin_lock_init(&dd->dc8051_lock);
 	spin_lock_init(&dd->dc8051_memlock);
 	seqlock_init(&dd->sc2vl_lock);
 	spin_lock_init(&dd->sde_map_lock);
 	spin_lock_init(&dd->pio_map_lock);
+	mutex_init(&dd->dc8051_lock);
 	init_waitqueue_head(&dd->event_queue);
 
 	dd->int_counter = alloc_percpu(u64);
