Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E1CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VejB+xo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA0D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJPMxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:53:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46224 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:53:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so10226110pgv.13;
        Mon, 15 Oct 2018 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/TZGKvXQpt2xPy6vQKLdpzbhrZ9LgfZpfyx1H7Zads=;
        b=VejB+xo5dnEijd3owuAPZoUWlr7dE1yok89tHGQuswN+k6tHagfm/dJF2JQisgGmnz
         gDddMmqcGZGAxZ76V6otDr3XYdrxmE0s/hpvhXhDMRsZe4VtfKpQfezMWOxjf9EXOpt4
         vMmaOUte3I4KC4CjIxEWSGZVs57eSGXCQRQZsOmaSDW5cKkok/naVxtSZyowDp86L7C/
         P3TAEx68hY+psMB5hFweh66S+T3KwFcLXyLJMLZFVyKeuO8e53Mj+53ny6ouBPM/AmMl
         jsv8zM7Q2T0pePXuS3t5rjM/BginKKpw8JJOxnwCs8pFTvLiIZVDqvsBI6lap2ekoacm
         IE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/TZGKvXQpt2xPy6vQKLdpzbhrZ9LgfZpfyx1H7Zads=;
        b=JQsl9YrJFd8FNkngR4e9mwKEk0R1v6oO9RCJzLJos19bpWlpHB3HHFPIetF3oEneiY
         ZiRsTJpTqD5doShuPxu76g1EV87GCJ7YZonAHPnqQdXyVTrE1fngCV0aJCYixywu4L4V
         ncWpIQL5PnhoicbvVwQbnrn0QGVyUodRCfB1ByTKNF5VyHIH9QMYCN2RwoQGrdZCXd6s
         LDW6hSkGKYcldNLQsQZhrEb9NQWzrAKpp+WOxsb++lrY8W/skdTh5ElbkuJJeGYxgCBA
         05FL1a8ad7sOXhC7hp4VM9i3ioKPQgJP8EEPgd3dEZOhZJQRbWYsHWsLKOhcx5gOSExl
         0iJg==
X-Gm-Message-State: ABuFfojdgJ+YQl4Mpeq2qT+sw1+klvV1DsOXxemIjuezJ/VcjTVv1wbm
        gWPUK1S5klRIsMtYPC3dkUSDBqX4
X-Google-Smtp-Source: ACcGV62z5DuSTQf2XbP9ckT+ZlMrIK6kcQlc5xO6/2Q07dnSeiu2Q+st9InMBmOy6ixK1nkvyhqO4g==
X-Received: by 2002:a62:104b:: with SMTP id y72-v6mr20655292pfi.113.1539666296445;
        Mon, 15 Oct 2018 22:04:56 -0700 (PDT)
Received: from localhost.localdomain ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id e131-v6sm19353225pfc.52.2018.10.15.22.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 22:04:55 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk header
Date:   Tue, 16 Oct 2018 14:04:26 +0900
Message-Id: <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make printk_safe_enter_irqsave()/etc macros available to the
rest of the kernel.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/printk.h      | 40 +++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h    | 37 ----------------------------------
 kernel/printk/printk_safe.c |  6 ++++--
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccfe1543..75f99441fd54 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,6 +157,46 @@ static inline void printk_nmi_direct_enter(void) { }
 static inline void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
+#ifdef CONFIG_PRINTK
+extern void printk_safe_enter(void);
+extern void printk_safe_exit(void);
+
+#define printk_safe_enter_irqsave(flags)	\
+	do {					\
+		local_irq_save(flags);		\
+		printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irqrestore(flags)	\
+	do {					\
+		printk_safe_exit();		\
+		local_irq_restore(flags);	\
+	} while (0)
+
+#define printk_safe_enter_irq()		\
+	do {					\
+		local_irq_disable();		\
+		printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irq()			\
+	do {					\
+		printk_safe_exit();		\
+		local_irq_enable();		\
+	} while (0)
+#else
+/*
+ * On !PRINTK builds we still export console output related locks
+ * and some functions (console_unlock()/tty/etc.), so printk-safe
+ * must preserve the existing local IRQ guarantees.
+ */
+#define printk_safe_enter_irqsave(flags) local_irq_save(flags)
+#define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
+
+#define printk_safe_enter_irq() local_irq_disable()
+#define printk_safe_exit_irq() local_irq_enable()
+#endif
+
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 0f1898820cba..03c10f361a15 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -32,32 +32,6 @@ int vprintk_store(int facility, int level,
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
-void __printk_safe_enter(void);
-void __printk_safe_exit(void);
-
-#define printk_safe_enter_irqsave(flags)	\
-	do {					\
-		local_irq_save(flags);		\
-		__printk_safe_enter();		\
-	} while (0)
-
-#define printk_safe_exit_irqrestore(flags)	\
-	do {					\
-		__printk_safe_exit();		\
-		local_irq_restore(flags);	\
-	} while (0)
-
-#define printk_safe_enter_irq()		\
-	do {					\
-		local_irq_disable();		\
-		__printk_safe_enter();		\
-	} while (0)
-
-#define printk_safe_exit_irq()			\
-	do {					\
-		__printk_safe_exit();		\
-		local_irq_enable();		\
-	} while (0)
 
 void defer_console_output(void);
 
@@ -65,15 +39,4 @@ void defer_console_output(void);
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 
-/*
- * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
- * semaphore and some of console functions (console_unlock()/etc.), so
- * printk-safe must preserve the existing local IRQ guarantees.
- */
-#define printk_safe_enter_irqsave(flags) local_irq_save(flags)
-#define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
-
-#define printk_safe_enter_irq() local_irq_disable()
-#define printk_safe_exit_irq() local_irq_enable()
-
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 0913b4d385de..367fcb2c39f0 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -359,16 +359,18 @@ static __printf(1, 0) int vprintk_safe(const char *fmt, va_list args)
 }
 
 /* Can be preempted by NMI. */
-void __printk_safe_enter(void)
+void printk_safe_enter(void)
 {
 	this_cpu_inc(printk_context);
 }
+EXPORT_SYMBOL_GPL(printk_safe_enter);
 
 /* Can be preempted by NMI. */
-void __printk_safe_exit(void)
+void printk_safe_exit(void)
 {
 	this_cpu_dec(printk_context);
 }
+EXPORT_SYMBOL_GPL(printk_safe_exit);
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
-- 
2.19.1

