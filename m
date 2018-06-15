Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54F820896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1t6P66d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54F820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756726AbeFOWBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:01:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39274 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756592AbeFOWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:01:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so4977053pgc.6;
        Fri, 15 Jun 2018 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yip76nidrBeZcoHtQxSUJXfWhKJWW5gFKcsU1KA1+l0=;
        b=C1t6P66dkk1q2SdQfs9vOouyhksAOZsDtFwbJm3jWCyuh9r4TwfQ/KhC97Rj54zjL0
         GCxXwHUmn+08VdhuvAWPoerqu2xPHriU16j75ZQDHhkNoeF5mop/ZVEPcF0EfP9hZoEA
         sjU4N6mMvWw48xmCIJY0mAGNFSmnqcv/hcBzcUzhb2uCOnwiq74EspGcb+68n3cRbvt3
         iW7rgMqVimxs+otqlWLLDaBLZyjty5qD/Qoc8wmNP77Lk2dJRvhlapT/ogkJmg/Rf1Uw
         pmSUOvuoH/Uhi+mes6nD2qHuLqaDbmlSuamwMsL+PcuYsWWD5k6fDl24G6QYCsR9B7H9
         gE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yip76nidrBeZcoHtQxSUJXfWhKJWW5gFKcsU1KA1+l0=;
        b=klKI4lkCHuTk2ZtC7v+8dv8aBPk4b+t7jgcoKjokLnAtIW2KHODYCizxVClCKVyj0x
         kuyI32dx16/0SJ+HBmqGa06X2IVLTRvg99NYkIv4TEI7mXUgcNRTJlkNZNlzIbrbNiO0
         M4HoaQNDaVoYnTybRJJgT6MJPV4unTaaFx6MeMvF/6t9jcG85GVWugNM/bgAVX+r8YbS
         PaBQ/YAIZqqX8TzRSJfTKUKpmYYjQ7nuhsH0HeDtBvPA4WOOZUs/ntQJ0aUn2liZAITX
         vba4f72xQONl0sGJ4ikXH30GdvJpVDtQ9Qiev+DWiVYR8n2M+YrYaqzANcFfOhRtcOGC
         fd0A==
X-Gm-Message-State: APt69E2xKGLZhQ2pbrMdRm+GkPltOmgI6n6wADcKFVLwqv/ae9wyyXUs
        KKJ4WhfbTEXMqgxsninAIZhKoFaf
X-Google-Smtp-Source: ADUXVKJ+uA9jlKaJIDjs/OdIuwdefu5IwzBDwSWyQeIuVW6+6tJWIxmV6u5Ed7MNQgWGelG71yujqA==
X-Received: by 2002:a62:c296:: with SMTP id w22-v6mr3788086pfk.92.1529100099557;
        Fri, 15 Jun 2018 15:01:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b83-v6sm20233241pfe.159.2018.06.15.15.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 15:01:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: dwc2: host: do not schedule delayed QH unnecessarily
Date:   Fri, 15 Jun 2018 15:01:31 -0700
Message-Id: <20180615220131.65402-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are ready to retry the delayed QH, we do not need to manually
scan queues and schedule them if controller is already running; we only
need to do that if SOF interrupt is masked, otherwise we'll pick them up
at the next frame.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/dwc2/hcd_queue.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index e34ad5e653501..db9e7c9d31554 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1468,6 +1468,8 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
 {
 	struct dwc2_qh *qh = from_timer(qh, t, wait_timer);
 	struct dwc2_hsotg *hsotg = qh->hsotg;
+	enum dwc2_transaction_type tr_type;
+	u32 intr_mask;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hsotg->lock, flags);
@@ -1476,19 +1478,22 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
 	 * We'll set wait_timer_cancel to true if we want to cancel this
 	 * operation in dwc2_hcd_qh_unlink().
 	 */
-	if (!qh->wait_timer_cancel) {
-		enum dwc2_transaction_type tr_type;
+	if (qh->wait_timer_cancel)
+		goto out_unlock;
 
-		qh->want_wait = false;
+	list_move(&qh->qh_list_entry, &hsotg->non_periodic_sched_inactive);
 
-		list_move(&qh->qh_list_entry,
-			  &hsotg->non_periodic_sched_inactive);
+	/* See if we should kick the controller if it was idle */
+	intr_mask = dwc2_readl(hsotg->regs + GINTMSK);
+	if (intr_mask & GINTSTS_SOF)
+		goto out_unlock;
 
-		tr_type = dwc2_hcd_select_transactions(hsotg);
-		if (tr_type != DWC2_TRANSACTION_NONE)
-			dwc2_hcd_queue_transactions(hsotg, tr_type);
-	}
+	/* The controller was idle, let's try queue our postponed work */
+	tr_type = dwc2_hcd_select_transactions(hsotg);
+	if (tr_type != DWC2_TRANSACTION_NONE)
+		dwc2_hcd_queue_transactions(hsotg, tr_type);
 
+out_unlock:
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 }
 
@@ -1722,10 +1727,6 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 
 	/* Add the new QH to the appropriate schedule */
 	if (dwc2_qh_is_non_per(qh)) {
-		/* Schedule right away */
-		qh->start_active_frame = hsotg->frame_number;
-		qh->next_active_frame = qh->start_active_frame;
-
 		if (qh->want_wait) {
 			list_add_tail(&qh->qh_list_entry,
 				      &hsotg->non_periodic_sched_waiting);
@@ -1733,6 +1734,10 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 			mod_timer(&qh->wait_timer,
 				  jiffies + DWC2_RETRY_WAIT_DELAY + 1);
 		} else {
+			/* Schedule right away */
+			qh->start_active_frame = hsotg->frame_number;
+			qh->next_active_frame = qh->start_active_frame;
+
 			list_add_tail(&qh->qh_list_entry,
 				      &hsotg->non_periodic_sched_inactive);
 		}
-- 
2.18.0.rc1.244.gcf134e6275-goog

