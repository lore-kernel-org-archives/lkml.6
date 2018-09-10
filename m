Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98593C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076AF2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 04:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=terinstock-com.20150623.gappssmtp.com header.i=@terinstock-com.20150623.gappssmtp.com header.b="ED4Drxct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076AF2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=terinstock.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeIJJQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:16:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38039 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeIJJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:16:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id t84-v6so7927212pgb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=terinstock-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:user-agent:user-agent
         :mime-version:content-transfer-encoding;
        bh=0GJT8aUy4iqr6EgmOSFrj5tBnAsNbu81CXu4t5FtCh4=;
        b=ED4Drxct0U2JjHU6lUDoVh5gNGhUZttSkOPPPyfNfIfOyq4wWo5k3m8JtZ+kJJ/Nk5
         8wDV+3f1fjHb9fo0Z+inByfoZecjgOF2IM1mcaUZqvLvHnZ/FmpKx0N63A26SSnACfGZ
         /InksnyDXozFMzuxyF/mNRNfPvZ8/Sjf4sMfIKr1kdQ55E+M4GafYgMzd4pqMbUTfwsw
         ToVJ8608wAKqYG7Ef7J/KQI2AP3iRQ47/0wQ+03KiaVltRWkHMvAhSuVOr8UiDki9wEB
         FexOuWsyd58DZQhDy7gwLhHWn+7wdKEcpCkH6U1UcwwFQSxjSzf5orYDQOuPV4Eizeqz
         9pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :user-agent:mime-version:content-transfer-encoding;
        bh=0GJT8aUy4iqr6EgmOSFrj5tBnAsNbu81CXu4t5FtCh4=;
        b=rZiKGTeflWyoNZllgpmz03qbOR3u0QV2g1fp6saOW/AKTyELFkFiSQPTSJ4lanPFKA
         WHVH8SHSeS32q+vMmQsvwcLeb0wkZ3g20A5JnsscIvM09eI/wfeu2Ctd/0dfjPVih1xv
         iLCIzHoWY9cxIR+r7iIU3tnofP1j2iT6C0hfL05PLAbTWJtyUb3n1OGDF+x2z/LRJcp0
         JCL9g+cWEjkgBsKx+9auhHeThKKtglpQ114MlV0pJVfKDCdUl2Wp7XHAZytYPPkL+c06
         GcfoEWzIiafLdvF8zTkGEfZ8FJgouhyMi/cf6ptzeRrY7tgnC3Fz+qnIK1z+UaZl+GZJ
         Mp3Q==
X-Gm-Message-State: APzg51Adc0l0Yr3FQmr0gxLIF/mSqLk6jnookcWLLj7eyexOlWhyOgIU
        UgNxQP7b2pG2IxH0Yrkj5Xao
X-Google-Smtp-Source: ANB0VdYvpozOSTBq5YSNbyCgul67QfHlbDeKrDwljTlzIgtcgmj6midqhx6KWhBS/1bApo5+2K003A==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr21789584pfb.241.1536553473579;
        Sun, 09 Sep 2018 21:24:33 -0700 (PDT)
Received: from rincon.localdomain ([136.24.13.23])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26998021pfi.60.2018.09.09.21.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 21:24:32 -0700 (PDT)
Date:   Sun, 09 Sep 2018 21:24:31 -0700
From:   Terin Stock <terin@terinstock.com>
To:     linux-usb@vger.kernel.org
Cc:     dianders@chromium.org, jwerner@chromium.org, dtor@chromium.org,
        hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc2: host: use hrtimer for NAK retries
Message-ID: <153655347149.19910.4781444209586693527.stgit@Rincon.localdomain>
User-Agent: mail v14.9.11
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the wait delay utilize the high resolution timer API to allow for
more precisely scheduled callbacks.

A previous commit added a 1ms retry delay after multiple consecutive
NAKed transactions using jiffies. On systems with a low timer interrupt
frequency, this delay may be significantly longer than specified,
resulting in misbehavior with some USB devices.

This scenario was reached on a Raspberry Pi 3B with a Macally FDD-USB
floppy drive (identified as 0424:0fdc Standard Microsystems Corp.
Floppy, based on the USB97CFDC USB FDC). With the relay delay, the drive
would be unable to mount a disk, replying with NAKs until the device was
reset.

Using ktime, the delta between starting the timer (in dwc2_hcd_qh_add)
and the callback function can be determined. With the original delay
implementation, this value was consistently approximately 12ms. (output
in us).

    <idle>-0     [000] ..s.  1600.559974: dwc2_wait_timer_fn: wait_timer delta: 11976
    <idle>-0     [000] ..s.  1600.571974: dwc2_wait_timer_fn: wait_timer delta: 11977
    <idle>-0     [000] ..s.  1600.583974: dwc2_wait_timer_fn: wait_timer delta: 11976
    <idle>-0     [000] ..s.  1600.595974: dwc2_wait_timer_fn: wait_timer delta: 11977

After converting the relay delay to using a higher resolution timer, the
delay was much closer to 1ms.

    <idle>-0     [000] d.h.  1956.553017: dwc2_wait_timer_fn: wait_timer delta: 1002
    <idle>-0     [000] d.h.  1956.554114: dwc2_wait_timer_fn: wait_timer delta: 1002
    <idle>-0     [000] d.h.  1957.542660: dwc2_wait_timer_fn: wait_timer delta: 1004
    <idle>-0     [000] d.h.  1957.543701: dwc2_wait_timer_fn: wait_timer delta: 1002

The floppy drive operates properly with delays up to approximately 5ms,
and sends NAKs for any delays that are longer.

Fixes: 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")
Signed-off-by: Terin Stock <terin@terinstock.com>
---
 drivers/usb/dwc2/hcd.h       |    2 +-
 drivers/usb/dwc2/hcd_queue.c |   19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index 5502a501f516..93483dc37801 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -366,7 +366,7 @@ struct dwc2_qh {
 	u32 desc_list_sz;
 	u32 *n_bytes;
 	struct timer_list unreserve_timer;
-	struct timer_list wait_timer;
+	struct hrtimer wait_timer;
 	struct dwc2_tt *dwc_tt;
 	int ttport;
 	unsigned tt_buffer_dirty:1;
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 301ced1618f8..60caf8e0b762 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -59,7 +59,7 @@
 #define DWC2_UNRESERVE_DELAY (msecs_to_jiffies(5))
 
 /* If we get a NAK, wait this long before retrying */
-#define DWC2_RETRY_WAIT_DELAY (msecs_to_jiffies(1))
+#define DWC2_RETRY_WAIT_DELAY 1*1E6L
 
 /**
  * dwc2_periodic_channel_available() - Checks that a channel is available for a
@@ -1464,10 +1464,12 @@ static void dwc2_deschedule_periodic(struct dwc2_hsotg *hsotg,
  * qh back to the "inactive" list, then queues transactions.
  *
  * @t: Pointer to wait_timer in a qh.
+ *
+ * Return: HRTIMER_NORESTART to not automatically restart this timer.
  */
-static void dwc2_wait_timer_fn(struct timer_list *t)
+static enum hrtimer_restart dwc2_wait_timer_fn(struct hrtimer *t)
 {
-	struct dwc2_qh *qh = from_timer(qh, t, wait_timer);
+	struct dwc2_qh *qh = container_of(t, struct dwc2_qh, wait_timer);
 	struct dwc2_hsotg *hsotg = qh->hsotg;
 	unsigned long flags;
 
@@ -1491,6 +1493,7 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
 	}
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
+	return HRTIMER_NORESTART;
 }
 
 /**
@@ -1521,7 +1524,8 @@ static void dwc2_qh_init(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh,
 	/* Initialize QH */
 	qh->hsotg = hsotg;
 	timer_setup(&qh->unreserve_timer, dwc2_unreserve_timer_fn, 0);
-	timer_setup(&qh->wait_timer, dwc2_wait_timer_fn, 0);
+	hrtimer_init(&qh->wait_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	qh->wait_timer.function = &dwc2_wait_timer_fn;
 	qh->ep_type = ep_type;
 	qh->ep_is_in = ep_is_in;
 
@@ -1690,7 +1694,7 @@ void dwc2_hcd_qh_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 	 * won't do anything anyway, but we want it to finish before we free
 	 * memory.
 	 */
-	del_timer_sync(&qh->wait_timer);
+	hrtimer_cancel(&qh->wait_timer);
 
 	dwc2_host_put_tt_info(hsotg, qh->dwc_tt);
 
@@ -1716,6 +1720,7 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 {
 	int status;
 	u32 intr_mask;
+	ktime_t delay;
 
 	if (dbg_qh(qh))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
@@ -1734,8 +1739,8 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 			list_add_tail(&qh->qh_list_entry,
 				      &hsotg->non_periodic_sched_waiting);
 			qh->wait_timer_cancel = false;
-			mod_timer(&qh->wait_timer,
-				  jiffies + DWC2_RETRY_WAIT_DELAY + 1);
+			delay = ktime_set(0, DWC2_RETRY_WAIT_DELAY);
+			hrtimer_start(&qh->wait_timer, delay, HRTIMER_MODE_REL);
 		} else {
 			list_add_tail(&qh->qh_list_entry,
 				      &hsotg->non_periodic_sched_inactive);

