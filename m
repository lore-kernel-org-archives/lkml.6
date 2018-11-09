Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0425C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8161E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="wCft4ba8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8161E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeKITsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36336 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeKITsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id s15-v6so1105791lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhq63+mLeuttN6OGbrbzxdPD+3AxLCwBPd2GAkXXdGs=;
        b=wCft4ba8nahu+31ys7zOS2fagLcvOK/gs770ISesoJ4A/z9yFr+PG3YwVyI+m+VbCL
         7K0huJnz/tROGMgmNEkop8Me96Q0ww6ZbFHUvIBMvv3kpKfwhPAjnZ6NzvxPbttKNOeb
         q7OQOaenPGDEy/dMspaQL74aJMZo8YDCVw2bdjg8Tw88XYyq80HE9o+QtmFGl8IL2Y9o
         tOArD9YIWTojP/+Rp6Lg+IwUjEZKu/GAEPZ7J0dVoYD90152tQPWFyOPp20/+7d+HAqO
         GFalikWA4xtpaqcZvkzn55/pyLZu6irz9k82qtaWMjn1GrrUBGXtK9eIcd3c2JkhVaZ4
         xLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fhq63+mLeuttN6OGbrbzxdPD+3AxLCwBPd2GAkXXdGs=;
        b=JJeIMpJr5DaILStbQrrS9YYoymfjzSBVqk2fu2pwID2Y+a6GFPjFmJRymPhg05HACE
         9hLO0hrpp5F5IRlAa30z3sK3f9AaMbakRslEg8Xrg2RUqHIuS5euL7NcM0ZF+Q2NU+Wd
         q/RQknRrQzFtBqYMLn10CJu/RFOQsiBtUkzbJoogBkW6AypuGPMI4HdJUXcmbHMw2JDm
         wOfbIg6N+A1OvGyTs70OIhkGU2jRQbSVdlhKdrvoZ/NDKMNh4v6DATCwkcwfrxrFFvDK
         24xl7BLssDUwUJP7z09iloDVs1XoFRIZ9mk3HQ69Cx8jQfPy6BSUaSjMjZtz10Qt9Rry
         q1qQ==
X-Gm-Message-State: AGRZ1gKm1utaJUD0LxMa1o+fTPdO+Cm7hG5ZALgOBwIdSRQg7DNeHzN+
        yyw0xn9oGxE5NPA5pLdGiI8YxvNwyPBKhmX6
X-Google-Smtp-Source: AJdET5e7J+4w8bu6KVfUnXEYlrLAUDKtcDFY51Tx37lyMii6B14Z+uvXN+W+kJluuZ+l33wRKNONLQ==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr5750900ljh.139.1541758086653;
        Fri, 09 Nov 2018 02:08:06 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:06 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/17] futex,rt_mutex: Introduce rt_mutex_init_waiter()
Date:   Fri,  9 Nov 2018 11:07:39 +0100
Message-Id: <1541758065-10952-12-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 50809358dd7199aa7ce232f6877dd09ec30ef374 upstream.

Since there's already two copies of this code, introduce a helper now
before adding a third one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.950039479@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c                  |  5 +----
 kernel/locking/rtmutex.c        | 12 +++++++++---
 kernel/locking/rtmutex_common.h |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 7054ca3..4d70fd7 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2969,10 +2969,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * The waiter is allocated on our stack, manipulated by the requeue
 	 * code while we sleep on uaddr.
 	 */
-	debug_rt_mutex_init_waiter(&rt_waiter);
-	RB_CLEAR_NODE(&rt_waiter.pi_tree_entry);
-	RB_CLEAR_NODE(&rt_waiter.tree_entry);
-	rt_waiter.task = NULL;
+	rt_mutex_init_waiter(&rt_waiter);
 
 	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, VERIFY_WRITE);
 	if (unlikely(ret != 0))
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 28c1d40..8778ac3 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1151,6 +1151,14 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 				   next_lock, NULL, task);
 }
 
+void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
+{
+	debug_rt_mutex_init_waiter(waiter);
+	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	RB_CLEAR_NODE(&waiter->tree_entry);
+	waiter->task = NULL;
+}
+
 /**
  * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
@@ -1233,9 +1241,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	unsigned long flags;
 	int ret = 0;
 
-	debug_rt_mutex_init_waiter(&waiter);
-	RB_CLEAR_NODE(&waiter.pi_tree_entry);
-	RB_CLEAR_NODE(&waiter.tree_entry);
+	rt_mutex_init_waiter(&waiter);
 
 	/*
 	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 2441c2d..d16de236 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -103,6 +103,7 @@ extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
 extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 				  struct task_struct *proxy_owner);
+extern void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-- 
2.7.4

