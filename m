Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C078EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7411720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="rj2eRlJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7411720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeKITsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44131 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeKITr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so893203lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zUFguix2kCNSK0CZxUlW6rJjQXD2HvJV2Gi2EBFX3Oc=;
        b=rj2eRlJ+N0NYlFkeq5U7VuRzV5HysPjM6AjjbzwnxAdKKEXnF6b7FvgJ8CbM5PPC3x
         y1aa39/RSp+lTs3+iQAdKwYiE9Bn3VQm1JuxTbCpYgbJq+z3oC1bZ3gEumi1RY7CE6NN
         WMuR9rkIzBEdW2LRBQdlIWPfDjc+LosWdsBOfEMQDpfY0n60QWxOVRpIqDuz7hFzw6Tf
         tDc3VoGFhq52PYd94H3lD+M7lSLq8U3SNCet6bkOBbAP6Zjw5dYyU5Mxi4bb/4LgiBO8
         cZo8D47U2H5HU1dKT1D4mSlK60DiN6r36QXRbJTBOhkGxoD41tsmVA3zJXRDaoKLNlBl
         SIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zUFguix2kCNSK0CZxUlW6rJjQXD2HvJV2Gi2EBFX3Oc=;
        b=m+JXiqdcxCl59VMhSYqBsLDQnCXBwSs7Uw73d5h5zLwYZdp1eZAPBjrSGBBavj+88e
         eyYMfqQDxK/oVJOlI860IWoMJ82MlJNkGIDff1ft27w58a2tRyeZlDDwaYMtEaSSW3YH
         RQSWlWNnuCefoEDRVKVL3R6LnBMQ+iKwuxAPWo6RHub3Mk7J79IwJi4mjoXnWTqBspp4
         8kB0YEBE40XjqnadcD7DLSuJ5Emao+yZje5R+kZqJYi3nrS0zamS8nt+bxJ9IauCTp6P
         QHyss9ldsQ5tRahxTWROhN3a+YKucfTLJVBmHNG1YOQj9vgDF6sG0sAyOm/N4gie60TJ
         Jd0Q==
X-Gm-Message-State: AGRZ1gJBcvq4UuZcPnTv4aks4QSSWJI5d2qzA44qIsr7n8+7fOzmywie
        5aSApzVjvvU7oU/XgMIZJt5TBsJM4fQ6I3Rh
X-Google-Smtp-Source: AJdET5dgkh8l4qcWS/8C2pdE3+/rCrvTjzZlEIkoeSrR1mxmzb8N0rLrnISxU/Uscmrqf6JWrnPWpg==
X-Received: by 2002:a19:750a:: with SMTP id y10mr4925921lfe.43.1541758084255;
        Fri, 09 Nov 2018 02:08:04 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:03 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <darren@dvhart.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bhuvanesh_Surachari@mentor.com, Andy Lowe <Andy_Lowe@mentor.com>
Subject: [PATCH 09/17] futex: Rename free_pi_state() to put_pi_state()
Date:   Fri,  9 Nov 2018 11:07:37 +0100
Message-Id: <1541758065-10952-10-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 29e9ee5d48c35d6cf8afe09bdf03f77125c9ac11 upstream.

free_pi_state() is confusing as it is in fact only freeing/caching the
pi state when the last reference is gone. Rename it to put_pi_state()
which reflects better what it is doing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <darren@dvhart.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Bhuvanesh_Surachari@mentor.com
Cc: Andy Lowe <Andy_Lowe@mentor.com>
Link: http://lkml.kernel.org/r/20151219200607.259636467@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 91acb65..09f698a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -815,9 +815,12 @@ static void get_pi_state(struct futex_pi_state *pi_state)
 }
 
 /*
+ * Drops a reference to the pi_state object and frees or caches it
+ * when the last reference is gone.
+ *
  * Must be called with the hb lock held.
  */
-static void free_pi_state(struct futex_pi_state *pi_state)
+static void put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
 		return;
@@ -1959,7 +1962,7 @@ retry_private:
 		case 0:
 			break;
 		case -EFAULT:
-			free_pi_state(pi_state);
+			put_pi_state(pi_state);
 			pi_state = NULL;
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
@@ -1976,7 +1979,7 @@ retry_private:
 			 *   exit to complete.
 			 * - The user space value changed.
 			 */
-			free_pi_state(pi_state);
+			put_pi_state(pi_state);
 			pi_state = NULL;
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
@@ -2049,7 +2052,7 @@ retry_private:
 			} else if (ret) {
 				/* -EDEADLK */
 				this->pi_state = NULL;
-				free_pi_state(pi_state);
+				put_pi_state(pi_state);
 				goto out_unlock;
 			}
 		}
@@ -2058,7 +2061,7 @@ retry_private:
 	}
 
 out_unlock:
-	free_pi_state(pi_state);
+	put_pi_state(pi_state);
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
 	hb_waiters_dec(hb2);
@@ -2211,7 +2214,7 @@ static void unqueue_me_pi(struct futex_q *q)
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
-	free_pi_state(q->pi_state);
+	put_pi_state(q->pi_state);
 	q->pi_state = NULL;
 
 	spin_unlock(q->lock_ptr);
@@ -2993,7 +2996,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
-			free_pi_state(q.pi_state);
+			put_pi_state(q.pi_state);
 			spin_unlock(q.lock_ptr);
 		}
 	} else {
-- 
2.7.4

