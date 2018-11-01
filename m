Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331AFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23C62064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TWrlQ88e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23C62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeKAJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:39 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41482 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeKAJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:38 -0400
Received: by mail-ed1-f48.google.com with SMTP id c25-v6so876166edt.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhI++D9l9Tw9qvqOVGEphWbNGOXNC4cnwmRw0qkUnqI=;
        b=TWrlQ88eQj9m2yGUw72u43ZwTpk4k2cpQJduIm/D8tDDBX8ltolOf69MsudVTvHmP2
         vfZ+StBZNT+5e814+dZN6+fQd4gWn8zJX2QZkr5awxFl5lw2urB1T585VXpIeo8laNEU
         rKTpdxGrTmY9HapvrDH69e1RBVItlfNAaecfyepaNa/zdHfi91L0Qf1ovLA+/jyWQOb0
         A2ZnKb6X7ya2WAY9qRaAkD5XRyNmOyMrfuzv5HzPtaDn2HKQuJp6yu5VWbSMoYTxx38h
         qEJPVK6OSZ/xMC4UfmMthdcpZFCPlt7lCoYRFKHxvqlIv4uHcDh/EYZHnTaZGLKFQMfS
         v52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhI++D9l9Tw9qvqOVGEphWbNGOXNC4cnwmRw0qkUnqI=;
        b=BqjDn8VvH3jPUOOcRGLPepgLgKxCVZIXhm8IVhdUyLUHdGaGNzE2yrkiFjhg0+bSbE
         E/7TyfnyunIFV67M0qZv0fdi3GKzhZWerNQi9tAi6Pdkn9o5WDyJH6a02e8/I9R0djNR
         l8HZv89fUzWTgvW0TRVJ4hHfvXfHQf+qg4WDWV/mE85d0Sg3LfqsfDJBY4nY0uqq6WLO
         q878kX3O0Z30R4aHzFMknz4OYvOExgp7JdE3T28yMbpqaZgNlW+mOw+hEJY8JjeQOemb
         AkzNAg68pCPttEga0AMPriQFItqdlGESrlwyIHiU6crEHQ95uaEw76SN+lsAc5Udqbnh
         S7JA==
X-Gm-Message-State: AGRZ1gLb0D+OFNdhh8dGM8UE5piRBNkTptMODwOvgxtkMoS0x6U11mW8
        A6ocbLyKnijMCVIQzqn3FI+5ndqzTfc=
X-Google-Smtp-Source: AJdET5ebWK+z4QwLrBRnfs5uVsbMAzrUsiANmBMRjUKxbcj85EHhLp5voYMVcRWNr/g4cRCCCITfQQ==
X-Received: by 2002:a50:a938:: with SMTP id l53-v6mr3751672edc.30.1541031903178;
        Wed, 31 Oct 2018 17:25:03 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:25:02 -0700 (PDT)
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
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv6 5/7] tty/ldsem: Convert to regular lockdep annotations
Date:   Thu,  1 Nov 2018 00:24:50 +0000
Message-Id: <20181101002452.5483-6-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

For some reason ldsem has its own lockdep wrappers, make them go away.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldsem.c | 51 +++++++++++------------------------------
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
2.19.1

