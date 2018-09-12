Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5990C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214B20883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mV2gTWM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8214B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeILFS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:18:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42516 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeILFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:18:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id l5so330790edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FzIg/8mcOBDFgbFeakOcE/y+1TDbHxgK8RkB5AVKzk=;
        b=mV2gTWM5WiSMo8uXIwQTXPD2f9N/fGYzvtfNd0GeccEJqMGTN9QevnIVucpFRU7Mra
         SA7W1ie0wukeRFJ5DLZS2Gfxmez5nWcgphuA9ojrI74HtistNVZmDCEMs7S0wBXJWvrd
         IUzJq6cz0pkUhDWTMfxSf0IceKHfWa+WbzDphccEF025pnRIxH2YvOkFt4Ke6UgfLnTC
         ya41cI46vzSAxLRIRTAg0cXZA+C1f39ZipLBouIw/nc+f9wE7owe0ZQRhWjCWjrgE+Fc
         jvZlLeAxKOkKpN9rKPQFGfFzADlSFDokMvh+ahy9ew/CaURo2LgiacwuSZ25rvOnK+6g
         /RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FzIg/8mcOBDFgbFeakOcE/y+1TDbHxgK8RkB5AVKzk=;
        b=j29Q11oqBPxXytAUo5f6uwHost5Cqbpb7Q0BZqLi+eGyEpYDbANT7RkUGr8rxXKlGF
         wZQaLaHza0wlAoFESdVipQLXgTBi9nrdE/Smp5SauBn7TArNfXzGhGGI7swb1b823DuF
         cTBl5f/OU7JRPKUEj1QO3MhlV6peNmcJKX8tW6YLcv7bn73Hl0dEGAtcphqyLQDaWSA+
         qEouaH5rMlo1GXhP4OdCAN1CVXCMCeTyUJbe7uEMMG01dnIBjsEgIUq78YoLRp4RCTuG
         ghLtVKDq+tNCuZPHUiXTMRcrXQqQsTdw9tdvS8UuoxcX9B621IlCYomrn7HFM4YLGJZb
         0HrQ==
X-Gm-Message-State: APzg51D4F3C/g49Db19xhRAX8w7tnI7cp9QhKkGa3hhDUqd/Ftk9ykxJ
        jrJOEdar3J0zTXqpwMc11H2NDPMqnFo=
X-Google-Smtp-Source: ANB0VdZLxZRYIJgRLW9lmL0gWW02k8Rb/2VMsRq4aYzihoDejMjcVCWztuziRjtq35uUipK0kaevLA==
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr31525724edk.12.1536711432651;
        Tue, 11 Sep 2018 17:17:12 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:11 -0700 (PDT)
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
Subject: [PATCHv4 5/7] tty/ldsem: Convert to regular lockdep annotations
Date:   Wed, 12 Sep 2018 01:16:59 +0100
Message-Id: <20180912001702.18522-6-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
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

