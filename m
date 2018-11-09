Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E79C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DFF20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="h8Q84lQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DFF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeKITtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:49:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43409 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeKITr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so899525lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EYoAjzGaY4FvHdpr/HKzz2g2r+DxPIHvtVtvR0g1ef4=;
        b=h8Q84lQNU2qUHq651h2IjiRjzELBLsowOafxFz8bW/KXlvIjv9P7nCs4dGPLuYJdFN
         2hPg1z+g/G7yNACd9K7O/FHH2J0GbYu8c99/5qmAhj9C1yR99VXYamOywDXCBLzxW4ly
         gBHxPogbjjBsFm7FLvzvl6VQc6WppcDhNqGFzhiwWP9Zx4kbELSJM0id9x6pJZhbGEEO
         T7FQ0o4Ea2OSf9EA3mOHAFwVYUMQbtOS7t6NoQltT5Zpn96nvrwzcfcuG64c221kHPbD
         eEThjs+TD2Xod8MggiN/yIG820zp4LrV+7itMgRT/gRKncSV9l3+/S337hldWvlcDOhR
         J/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EYoAjzGaY4FvHdpr/HKzz2g2r+DxPIHvtVtvR0g1ef4=;
        b=mo0cwBSZQJBwU+X4BIiduD0ehJnCSnWNWLFqUpxQGyRKpOrpHs4ku+xsmyid4ZxYbw
         fxYI9Xls07oWILpESU1BFgt2Esk5HtltmvG8QUevFMyf979nL5U6LI6+8VdpQog+ovr0
         15lxKa4KalssmKGQuhowyXTJIOu7/lfJO+0WhnslMZUwo5tcfzbTERuvPYE562BXrmNO
         JrKBzLWyEDT2s5rC25CkAsS3nhb7xcYYPK9Gx/pdTTnbKZ1C22Oej+i48BkzixPYyzHp
         3cb4qISvngnJWXX60vwsJkiIPUY351OQ1XWKRZjFIMoBtrHGNSFxK2JDmvnp15wZVC9l
         wELA==
X-Gm-Message-State: AGRZ1gLUZq3CNEt7v6FUOf8o2Of48k7vL3MaQdxk1zkyfv19rd/Hw5Qe
        rwRSbJfEVcoAfpXG9tf0yZkYjbKpj02fwJ7e
X-Google-Smtp-Source: AJdET5d9LAy9RTPTZZda88nhgfpDC+2cZw5wOBtAt8UQ+PS/GYHr6Wv5DCxoAOThnwPqV+GJwiGtJg==
X-Received: by 2002:a19:2a9a:: with SMTP id q26mr4654429lfq.94.1541758081784;
        Fri, 09 Nov 2018 02:08:01 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:01 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/17] futex: Cleanup refcounting
Date:   Fri,  9 Nov 2018 11:07:35 +0100
Message-Id: <1541758065-10952-8-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit bf92cf3a5100f5a0d5f9834787b130159397cb22 upstream.

Add a put_pit_state() as counterpart for get_pi_state() so the refcounting
becomes consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.801778516@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Conflicts:
	kernel/futex.c
Tested-by:Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 52e3678..9d7d462 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -799,7 +799,7 @@ static int refill_pi_state_cache(void)
 	return 0;
 }
 
-static struct futex_pi_state * alloc_pi_state(void)
+static struct futex_pi_state *alloc_pi_state(void)
 {
 	struct futex_pi_state *pi_state = current->pi_state_cache;
 
@@ -809,6 +809,11 @@ static struct futex_pi_state * alloc_pi_state(void)
 	return pi_state;
 }
 
+static void get_pi_state(struct futex_pi_state *pi_state)
+{
+	WARN_ON_ONCE(!atomic_inc_not_zero(&pi_state->refcount));
+}
+
 /*
  * Must be called with the hb lock held.
  */
@@ -850,7 +855,7 @@ static void free_pi_state(struct futex_pi_state *pi_state)
  * Look up the task based on what TID userspace gave us.
  * We dont trust it.
  */
-static struct task_struct * futex_find_get_task(pid_t pid)
+static struct task_struct *futex_find_get_task(pid_t pid)
 {
 	struct task_struct *p;
 
@@ -1097,7 +1102,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 		goto out_einval;
 
 out_attach:
-	atomic_inc(&pi_state->refcount);
+	get_pi_state(pi_state);
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	*ps = pi_state;
 	return 0;
@@ -2019,8 +2024,12 @@ retry_private:
 		 * of requeue_pi if we couldn't acquire the lock atomically.
 		 */
 		if (requeue_pi) {
-			/* Prepare the waiter to take the rt_mutex. */
-			atomic_inc(&pi_state->refcount);
+			/*
+			 * Prepare the waiter to take the rt_mutex. Take a
+			 * refcount on the pi_state and store the pointer in
+			 * the futex_q object of the waiter.
+			 */
+			get_pi_state(pi_state);
 			this->pi_state = pi_state;
 			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
 							this->rt_waiter,
-- 
2.7.4

