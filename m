Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119F1625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D47F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZCi2H7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D47F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeG3TZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:25:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51062 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeG3TZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:25:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so293771wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wng3zApiM+xj8GHhmdBpTTRIMZARgG9HeLga6fV+adE=;
        b=AZCi2H7MlFWGDr10Pple9CoofOelu6LivZQ1D6hKeLazMQbR61WGwl30RLEan+eWJi
         MfuVJVQEewvuaOxZB+lFDpIHsyQ3x1PuvicKQw+/wUCHB+qoZpxJUtIYjmNRwoT/8qTh
         oxGVeZ3g6De+oIVYtQDby82m35cA7zV3X9X4Urtm+tYHpcY7IJPs/NjBiZtnTB1z2aZF
         RV8yccHUhsZkPWeEbGDcdip3Yh3BwH4rwSRuoMWPtV4pee3nO+DFHcih0QHQp6qByNG7
         II67VUlAdiV7bT2YP/xgPjICv/yrLU/lNMyZs3blGm/ZbQFDKtcD1h6kfJzZosM+dr9d
         5SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wng3zApiM+xj8GHhmdBpTTRIMZARgG9HeLga6fV+adE=;
        b=cEFNYS21BJZsf4KeshZI4s3vivpXzvQAPLyoF6LwP0Zo5jyI18DtIneYPMZJ7CvvBO
         TpsYEbTF0DJjLzy5keFGDVyLLIvJOB6k7WDQgZrmSoiPx8WxpsilQjHnqMJkFBFPDEF3
         XnJTCvUcgsD5Tpj3JG/D9r7rauzAIbF0FdIwuXtlIjCiccRCbypT7XQALbwRyxIThaDl
         ktGbg5s6E6fBAspv5z/R6/M2wekqNGvTKjVkLcTnJ7TXDLC3jd53bW6TILgY0JHWOvQ7
         zUu23pHHzDQs6WYm2h4ZjnLpzn7JuHIumcPsxmP57gkqYpd45Q1hW9Jcj82izSqGuML/
         VQeg==
X-Gm-Message-State: AOUpUlFqiDGXj+RC4RwzXMkiOwyGr23+g4jfR1GfXwIeqGFQosWpv7IS
        Zv+/2uiAgCOnOwf9pUqJ2c4Ih0lD
X-Google-Smtp-Source: AAOMgpcca20qpY6Y5WRVP9LpSZ+mdv7N5yN8cygp6Azdq13yz1ANjeEv8rjKQmHToDNBTKgoG8Yy0w==
X-Received: by 2002:a1c:1bc2:: with SMTP id b185-v6mr200670wmb.160.1532972964135;
        Mon, 30 Jul 2018 10:49:24 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t135-v6sm287228wme.0.2018.07.30.10.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:49:23 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:49:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fixes
Message-ID: <20180730174921.GA1807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: c0dc373a780f4ec63e45a573b9551763abd8cd1a locking/pvqspinlock/x86: Use LOCK_PREFIX in __pv_queued_spin_unlock() assembly code

A paravirt UP-patching fix, and an I2C MUX driver lockdep warning fix.

Thanks,

	Ingo

------------------>
Peter Rosin (2):
      locking/rtmutex: Allow specifying a subclass for nested locking
      i2c/mux, locking/core: Annotate the nested rt_mutex usage

Waiman Long (1):
      locking/pvqspinlock/x86: Use LOCK_PREFIX in __pv_queued_spin_unlock() assembly code


 arch/x86/include/asm/qspinlock_paravirt.h |  2 +-
 drivers/i2c/i2c-core-base.c               |  2 +-
 drivers/i2c/i2c-mux.c                     |  4 ++--
 include/linux/rtmutex.h                   |  7 +++++++
 kernel/locking/rtmutex.c                  | 29 +++++++++++++++++++++++++----
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 9ef5ee03d2d7..159622ee0674 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -43,7 +43,7 @@ asm    (".pushsection .text;"
 	"push  %rdx;"
 	"mov   $0x1,%eax;"
 	"xor   %edx,%edx;"
-	"lock cmpxchg %dl,(%rdi);"
+	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
 	"cmp   $0x1,%al;"
 	"jne   .slowpath;"
 	"pop   %rdx;"
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 301285c54603..15c95aaa484c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -624,7 +624,7 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 static void i2c_adapter_lock_bus(struct i2c_adapter *adapter,
 				 unsigned int flags)
 {
-	rt_mutex_lock(&adapter->bus_lock);
+	rt_mutex_lock_nested(&adapter->bus_lock, i2c_adapter_depth(adapter));
 }
 
 /**
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 300ab4b672e4..29646aa6132e 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -144,7 +144,7 @@ static void i2c_mux_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
 		return;
 	i2c_lock_bus(parent, flags);
@@ -181,7 +181,7 @@ static void i2c_parent_lock_bus(struct i2c_adapter *adapter,
 	struct i2c_mux_priv *priv = adapter->algo_data;
 	struct i2c_adapter *parent = priv->muxc->parent;
 
-	rt_mutex_lock(&parent->mux_lock);
+	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
 	i2c_lock_bus(parent, flags);
 }
 
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 1b92a28dd672..6fd615a0eea9 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -106,7 +106,14 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+#define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
+#else
 extern void rt_mutex_lock(struct rt_mutex *lock);
+#define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
+#endif
+
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *timeout);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f014be7a4b8..2823d4163a37 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1465,6 +1465,29 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 		rt_mutex_postunlock(&wake_q);
 }
 
+static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
+{
+	might_sleep();
+
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/**
+ * rt_mutex_lock_nested - lock a rt_mutex
+ *
+ * @lock: the rt_mutex to be locked
+ * @subclass: the lockdep subclass
+ */
+void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
+{
+	__rt_mutex_lock(lock, subclass);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
+#endif
+
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 /**
  * rt_mutex_lock - lock a rt_mutex
  *
@@ -1472,12 +1495,10 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+	__rt_mutex_lock(lock, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
+#endif
 
 /**
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
