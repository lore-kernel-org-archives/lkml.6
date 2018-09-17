Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7509AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1120C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ok0SDNqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD1120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeIRFWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:22:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43366 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIRFWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so364033edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FzIg/8mcOBDFgbFeakOcE/y+1TDbHxgK8RkB5AVKzk=;
        b=Ok0SDNqoJAaYlsk9mwpzJZwA6cqR1MVxRea7TRSECRr48sZQwtQZHX2nrghOY7j7Lz
         c0EZYTOyz2UQqtxKU/+aP8REz8xhUGhDsxLTPjtqCG4ooQlOt+LQIU1ZtIEJStOkOiVw
         2Dnais4F5oYT/aHbpYCaUyHhoDOTR+ScKBImt+1NTKJebr7rYl0dOra0Dz8H3WI0DVRz
         XR3gRosadR6jDXAOmvB5bHypKHxPiLJM/rfpVCISAova9XOh9oufc1M1UVkwtR8U/xh/
         CwWzMkPL6brofXuynqPyBinl5qtnmFeUDMjx8W2k+AFiUHgNovsJMUZF5y5hvr9sBwrb
         P84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FzIg/8mcOBDFgbFeakOcE/y+1TDbHxgK8RkB5AVKzk=;
        b=To6b40C3dGCq5SsGEv9fDEgTjWtRIqx7/CpHC3NZ0RG+QwTpQWW/tdplCmHDYSLYml
         CmDbKEHuJnsnB6sJdcZO2jbhuTuAt5DyQSwfONTFuqx5zRDFx40FQvpMu0FltFbP/mky
         HI4YKdxYtTA+Tq7IICTkKHB16p65iEYZM43h2GNNHWY1TSZPNphVSNg0LRuRx3kYIzJv
         u+DvL8Tx77pHDB+DEkOE2N8NM8RayS/u99wc7KMILERGhb1+PdS6KYHD7TVOj734qYUZ
         vx3odphOnQ20jxvEMPYB2vHVAWcFvyK99CdokmqLdyhvwiviK6wTQehzVyXNIFbGVs4F
         hrew==
X-Gm-Message-State: APzg51CiY3PTFDx1r6fbZvfogX66phEv4dGNEVx+HN2Err97cYF73K+V
        9cviLuKD1N97S74S/oWSnJS6HJ86j60=
X-Google-Smtp-Source: ANB0VdYozspt7jMc6KG894krDMOKrJp/b4LYoONJZTxuOEfYAkMlj+AmsNIIZ/eHE3LQV0GyL2yTMg==
X-Received: by 2002:a50:c8c3:: with SMTP id k3-v6mr47084754edh.193.1537228387643;
        Mon, 17 Sep 2018 16:53:07 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:06 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCHv5 5/7] tty/ldsem: Convert to regular lockdep annotations
Date:   Tue, 18 Sep 2018 00:52:56 +0100
Message-Id: <20180917235258.5719-6-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

For some reason ldsem has its own lockdep wrappers, make them go away.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldsem.c | 51 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index b989ca26fc78..d4d0dbf4a6d9 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -34,29 +34,6 @@
 #include <linux/sched/task.h>
 
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __acq(l, s, t, r, c, n, i)		\
-				lock_acquire(&(l)->dep_map, s, t, r, c, n, i)
-# define __rel(l, n, i)				\
-				lock_release(&(l)->dep_map, n, i)
-#define lockdep_acquire(l, s, t, i)		__acq(l, s, t, 0, 1, NULL, i)
-#define lockdep_acquire_nest(l, s, t, n, i)	__acq(l, s, t, 0, 1, n, i)
-#define lockdep_acquire_read(l, s, t, i)	__acq(l, s, t, 1, 1, NULL, i)
-#define lockdep_release(l, n, i)		__rel(l, n, i)
-#else
-# define lockdep_acquire(l, s, t, i)		do { } while (0)
-# define lockdep_acquire_nest(l, s, t, n, i)	do { } while (0)
-# define lockdep_acquire_read(l, s, t, i)	do { } while (0)
-# define lockdep_release(l, n, i)		do { } while (0)
-#endif
-
-#ifdef CONFIG_LOCK_STAT
-# define lock_stat(_lock, stat)		lock_##stat(&(_lock)->dep_map, _RET_IP_)
-#else
-# define lock_stat(_lock, stat)		do { } while (0)
-#endif
-
-
 #if BITS_PER_LONG == 64
 # define LDSEM_ACTIVE_MASK	0xffffffffL
 #else
@@ -320,17 +297,17 @@ static int __ldsem_down_read_nested(struct ld_semaphore *sem,
 {
 	long count;
 
-	lockdep_acquire_read(sem, subclass, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	count = atomic_long_add_return(LDSEM_READ_BIAS, &sem->count);
 	if (count <= 0) {
-		lock_stat(sem, contended);
+		lock_contended(&sem->dep_map, _RET_IP_);
 		if (!down_read_failed(sem, count, timeout)) {
-			lockdep_release(sem, 1, _RET_IP_);
+			rwsem_release(&sem->dep_map, 1, _RET_IP_);
 			return 0;
 		}
 	}
-	lock_stat(sem, acquired);
+	lock_acquired(&sem->dep_map, _RET_IP_);
 	return 1;
 }
 
@@ -339,17 +316,17 @@ static int __ldsem_down_write_nested(struct ld_semaphore *sem,
 {
 	long count;
 
-	lockdep_acquire(sem, subclass, 0, _RET_IP_);
+	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	count = atomic_long_add_return(LDSEM_WRITE_BIAS, &sem->count);
 	if ((count & LDSEM_ACTIVE_MASK) != LDSEM_ACTIVE_BIAS) {
-		lock_stat(sem, contended);
+		lock_contended(&sem->dep_map, _RET_IP_);
 		if (!down_write_failed(sem, count, timeout)) {
-			lockdep_release(sem, 1, _RET_IP_);
+			rwsem_release(&sem->dep_map, 1, _RET_IP_);
 			return 0;
 		}
 	}
-	lock_stat(sem, acquired);
+	lock_acquired(&sem->dep_map, _RET_IP_);
 	return 1;
 }
 
@@ -372,8 +349,8 @@ int ldsem_down_read_trylock(struct ld_semaphore *sem)
 
 	while (count >= 0) {
 		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_READ_BIAS)) {
-			lockdep_acquire_read(sem, 0, 1, _RET_IP_);
-			lock_stat(sem, acquired);
+			rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
+			lock_acquired(&sem->dep_map, _RET_IP_);
 			return 1;
 		}
 	}
@@ -398,8 +375,8 @@ int ldsem_down_write_trylock(struct ld_semaphore *sem)
 
 	while ((count & LDSEM_ACTIVE_MASK) == 0) {
 		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_WRITE_BIAS)) {
-			lockdep_acquire(sem, 0, 1, _RET_IP_);
-			lock_stat(sem, acquired);
+			rwsem_acquire(&sem->dep_map, 0, 1, _RET_IP_);
+			lock_acquired(&sem->dep_map, _RET_IP_);
 			return 1;
 		}
 	}
@@ -413,7 +390,7 @@ void ldsem_up_read(struct ld_semaphore *sem)
 {
 	long count;
 
-	lockdep_release(sem, 1, _RET_IP_);
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 
 	count = atomic_long_add_return(-LDSEM_READ_BIAS, &sem->count);
 	if (count < 0 && (count & LDSEM_ACTIVE_MASK) == 0)
@@ -427,7 +404,7 @@ void ldsem_up_write(struct ld_semaphore *sem)
 {
 	long count;
 
-	lockdep_release(sem, 1, _RET_IP_);
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 
 	count = atomic_long_add_return(-LDSEM_WRITE_BIAS, &sem->count);
 	if (count < 0)
-- 
2.13.6

