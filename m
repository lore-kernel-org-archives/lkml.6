Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CFBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1876220892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="QHRh+ukP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1876220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeKITsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33130 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeKITsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so1119228ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8GXvqfbsM2L9TM+GbC5eobUASKoV7d0APs3WHT2n/s=;
        b=QHRh+ukP+d7zKlzZzRa0dKoD1cKIzMLl+KcK85OA4cuSKxdFLyW5WBzcl2/IfhdZGC
         k0dSwsS003kfT/312EFPz+z+44nJcMIOV0OkYdPaNTWFGnMwNszKnCMtj+EkNZ2/E6o2
         qrMv5mZKuA2jLmUkprOAPyJ4xBPUjMfHUaUxPjM3IEaobQqMbxjB/dpu4OkZWi3fm8NE
         Yco+zoclbt/gci7hKo5CZ0V8hEsHN4oy3X3zOez4+aS1V3wV5iOkjEwXE6XTnuDrhj2l
         PZ23wg4QDltHc/23Kx8D1aDEqr7GOaCmGbPbPoYXcu9uOWYzjOe6zswVr7r7pFJK7db5
         leeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8GXvqfbsM2L9TM+GbC5eobUASKoV7d0APs3WHT2n/s=;
        b=r2Z7M3QSRQvIuwCAMHiI3zLkTnkTypA3qEkWHIyVffnGD8KIoCHzPb5uUbxwwj+PN1
         zJ8OwV20omTez7Xu5IATpy9/t5GLf8G2vMicngrleU7Ux3mNmXCXGqEPGjzrMl6Uwf9k
         UCiXKJopDz22xOCAYIS6FV5P0xFY3gXTQ0+0wzxb5hrKtgrgJ/PnJC+URGD4HXwyjyCx
         U0ey7HXl2mpDj7i41qc0ddBTp0uycVqoaud4cwi9N8akQzVLnaoDFPlhy3kkVjdX+eMW
         QdhFesQd0d90zlYbYRpvyROlxCE6/1XnMQf0I2O1YYAhSB8iY3xbRQM1OUju3UFZdIbW
         C6yw==
X-Gm-Message-State: AGRZ1gJ9kjcO/aMAzZMHmRxmMMWJdcxUc4LdphkRBZyRYE/lMarIO+Em
        cxD9gCpAMGfRkykjRSr2doXkBc6ouL9tkn5G
X-Google-Smtp-Source: AJdET5fcAKFE4AqjQmnIlYbduUm/AdMfiwXpi3VsZb+0U8QsV7uyDZQ0KxhNDQwP2mPUjxT7Chv7UQ==
X-Received: by 2002:a2e:117:: with SMTP id 23-v6mr5046157ljb.131.1541758090344;
        Fri, 09 Nov 2018 02:08:10 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:09 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 14/17] futex: Futex_unlock_pi() determinism
Date:   Fri,  9 Nov 2018 11:07:42 +0100
Message-Id: <1541758065-10952-15-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit bebe5b514345f09be2c15e414d076b02ecb9cce8 upstream.

The problem with returning -EAGAIN when the waiter state mismatches is that
it becomes very hard to proof a bounded execution time on the
operation. And seeing that this is a RT operation, this is somewhat
important.

While in practise; given the previous patch; it will be very unlikely to
ever really take more than one or two rounds, proving so becomes rather
hard.

However, now that modifying wait_list is done while holding both hb->lock
and wait_lock, the scenario can be avoided entirely by acquiring wait_lock
while still holding hb-lock. Doing a hand-over, without leaving a hole.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104152.112378812@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 1cc40dd..14d270e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1395,15 +1395,10 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	WAKE_Q(wake_q);
 	int ret = 0;
 
-	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
-	if (!new_owner) {
+	if (WARN_ON_ONCE(!new_owner)) {
 		/*
-		 * Since we held neither hb->lock nor wait_lock when coming
-		 * into this function, we could have raced with futex_lock_pi()
-		 * such that we might observe @this futex_q waiter, but the
-		 * rt_mutex's wait_list can be empty (either still, or again,
-		 * depending on which side we land).
+		 * As per the comment in futex_unlock_pi() this should not happen.
 		 *
 		 * When this happens, give up our locks and try again, giving
 		 * the futex_lock_pi() instance time to complete, either by
@@ -2807,15 +2802,18 @@ retry:
 		if (pi_state->owner != current)
 			goto out_unlock;
 
+		get_pi_state(pi_state);
 		/*
-		 * Grab a reference on the pi_state and drop hb->lock.
+		 * Since modifying the wait_list is done while holding both
+		 * hb->lock and wait_lock, holding either is sufficient to
+		 * observe it.
 		 *
-		 * The reference ensures pi_state lives, dropping the hb->lock
-		 * is tricky.. wake_futex_pi() will take rt_mutex::wait_lock to
-		 * close the races against futex_lock_pi(), but in case of
-		 * _any_ fail we'll abort and retry the whole deal.
+		 * By taking wait_lock while still holding hb->lock, we ensure
+		 * there is no point where we hold neither; and therefore
+		 * wake_futex_pi() must observe a state consistent with what we
+		 * observed.
 		 */
-		get_pi_state(pi_state);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
 
 		ret = wake_futex_pi(uaddr, uval, pi_state);
-- 
2.7.4

