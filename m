Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281A221715
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F8PTgheU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281A221715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeHNVaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:30:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40434 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbeHNVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:30:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so13230475wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MVYOOQhCYGhADvrRLTuMaT3SEBV+1nDnJZy3VDfId3o=;
        b=F8PTgheUuJh466LRAf9XlS8cQjrmuzkKd0zbAqLOAnrDcdsTvOwCKZ3U/44ma3Yvnx
         8OQfRCgECIaOxAOJARzvrrv7dOoPxX7IDE4d54YjTxvNnyFjKgAcnRwo0o/FzN/CRuU6
         /P8ucAnvXCg+VhnfLsvMIP2MgVaft3u9FI7kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MVYOOQhCYGhADvrRLTuMaT3SEBV+1nDnJZy3VDfId3o=;
        b=tgjUjUT9gMR7b2zEs3hFbehDN3TaXpESWDJ7FPGPGmHfCa5fKY6OuBVn7+L8TNchGX
         dy5pbQj1EQLDRh/igExcyZnkVLfDBs4HPrKBrzy0ixbm9nqPYzPm/T0dIwd+I8KfO1Qk
         BxLVtQ0udRb+f5P7sh1piMBC63Vov97hls7DkTG+q6JndQmAo1Znsz/Ud11vU7yTIxzZ
         X40rixfutQCEt9qeMin0p14DV0nb5Y70KgmpaPxNhNphk+u5zGVLh7DhWXII+kj+nnoy
         xf8ZK5nbR28GCg3wGl7EKlwgoM5rdYM9Ujn9zOjnGSa1TKYH2dQGvH+5+n0IUwNkwAhF
         jEFQ==
X-Gm-Message-State: AOUpUlF3mvULi/46qqUKP1sixrTIzSxZC6Hq9J50/DiOs1E9zCzAx0WR
        lAjZEKlojpxtQ3xzdvaZ3Ge8sQ==
X-Google-Smtp-Source: AA+uWPx250pclmUjKwiFgZvfUiAN8sY5TOxl8Aj5a5f+FYoHR3owtuz1RtiuDPoPgVmCABslLymJrg==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr11879236wma.120.1534272109898;
        Tue, 14 Aug 2018 11:41:49 -0700 (PDT)
Received: from localhost.localdomain (host47-68-dynamic.36-79-r.retail.telecomitalia.it. [79.36.68.47])
        by smtp.gmail.com with ESMTPSA id a9-v6sm26042610wrp.55.2018.08.14.11.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Aug 2018 11:41:49 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] bluetooth/{bnep,cmtp,hidp}: Remove unnecessary smp_mb__{before,after}_atomic
Date:   Tue, 14 Aug 2018 20:41:06 +0200
Message-Id: <1534272066-9366-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barriers are unneeded; wait_woken() and woken_wake_function()
already provide us with the required synchronization: remove them
and document that we're relying on the (implicit) synchronization
provided by wait_woken() and woken_wake_function().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 net/bluetooth/bnep/core.c |  7 ++++---
 net/bluetooth/cmtp/core.c | 14 ++++++++------
 net/bluetooth/hidp/core.c | 13 ++++++++-----
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 7b3965861013c..43c284158f63e 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -489,9 +489,6 @@ static int bnep_session(void *arg)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		/* Ensure session->terminate is updated */
-		smp_mb__before_atomic();
-
 		if (atomic_read(&s->terminate))
 			break;
 		/* RX */
@@ -512,6 +509,10 @@ static int bnep_session(void *arg)
 				break;
 		netif_wake_queue(dev);
 
+		/*
+		 * wait_woken() performs the necessary memory barriers
+		 * for us; see the header comment for this primitive.
+		 */
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 7f26a5a19ff6d..07cfa3249f83a 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -288,9 +288,6 @@ static int cmtp_session(void *arg)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		/* Ensure session->terminate is updated */
-		smp_mb__before_atomic();
-
 		if (atomic_read(&session->terminate))
 			break;
 		if (sk->sk_state != BT_CONNECTED)
@@ -306,6 +303,10 @@ static int cmtp_session(void *arg)
 
 		cmtp_process_transmit(session);
 
+		/*
+		 * wait_woken() performs the necessary memory barriers
+		 * for us; see the header comment for this primitive.
+		 */
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -431,9 +432,10 @@ int cmtp_del_connection(struct cmtp_conndel_req *req)
 		/* Stop session thread */
 		atomic_inc(&session->terminate);
 
-		/* Ensure session->terminate is updated */
-		smp_mb__after_atomic();
-
+		/*
+		 * See the comment preceding the call to wait_woken()
+		 * in cmtp_session().
+		 */
 		wake_up_interruptible(sk_sleep(session->sock->sk));
 	} else
 		err = -ENOENT;
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 1036e4fa1ea28..e621551712f59 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1074,6 +1074,10 @@ static int hidp_session_start_sync(struct hidp_session *session)
 static void hidp_session_terminate(struct hidp_session *session)
 {
 	atomic_inc(&session->terminate);
+	/*
+	 * See the comment preceding the call to wait_woken()
+	 * in hidp_session_run().
+	 */
 	wake_up_interruptible(&hidp_session_wq);
 }
 
@@ -1193,8 +1197,6 @@ static void hidp_session_run(struct hidp_session *session)
 		 *    thread is woken up by ->sk_state_changed().
 		 */
 
-		/* Ensure session->terminate is updated */
-		smp_mb__before_atomic();
 		if (atomic_read(&session->terminate))
 			break;
 
@@ -1228,14 +1230,15 @@ static void hidp_session_run(struct hidp_session *session)
 		hidp_process_transmit(session, &session->ctrl_transmit,
 				      session->ctrl_sock);
 
+		/*
+		 * wait_woken() performs the necessary memory barriers
+		 * for us; see the header comment for this primitive.
+		 */
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(&hidp_session_wq, &wait);
 
 	atomic_inc(&session->terminate);
-
-	/* Ensure session->terminate is updated */
-	smp_mb__after_atomic();
 }
 
 static int hidp_session_wake_function(wait_queue_entry_t *wait,
-- 
2.7.4

