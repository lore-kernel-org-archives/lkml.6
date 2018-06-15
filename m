Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AFC6EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F872208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfWv7W6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F872208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756001AbeFOJka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:40:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40791 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeFOJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:40:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so4615231pfe.7;
        Fri, 15 Jun 2018 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7stQGUpLXvpT66R3542N2aU/vqQaiwK+zjcMnliT7o0=;
        b=kfWv7W6lnRGgb2xYBxrk5lvN8GbvuntIP0AgpmJRXWw5OXdr5ILxxQQhUI3e7au9Gt
         ouJRknSB1V/zovCgx0cbZYuTx+hoZbDEZm92XSn+QGrxqHgmAL/m82Jdqinn7vKzPG0D
         rELRR7fN+qvK+1bLwwSmcHXVzc749qpisDS/oxjIhbvZA7QmHLMXuirlZvjZkW0738Xu
         jJeYj3Ef+Oh6R5Ox7uNnEGmPwCEBGXCVDRGS7usolShBbAnfwZih9+Gct0gTgC9BUw9B
         GSVNvY4sfKSD+nt2k7K93M1RAMJHGOXiOMP9j0LZgpvs0eXPzYCafChbRRLx7TabTvhl
         pxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7stQGUpLXvpT66R3542N2aU/vqQaiwK+zjcMnliT7o0=;
        b=jhbSBodqpNHxIwdP6X62gG/rKcGWMgsTboDyiN9BffjBGpAt37+UIDG4pVomOXufbu
         Hb+/4JweHm0XcwjCVn1zhI5G3z/qdz7Bimx8OobdOfYeqzT1Pvr6ZoayLaxYA0W94mf1
         3qEjp2/cz9rIW275IdZul9s93WNZIn83VoAA4JYCefHjFo4tx8oIhPs3rp97DwUQSLMX
         QSWupEYIHc7l9M3ZgSn8cu4NvQ/Ne4u5JoSo0eX/ug/gDyMTUfvhZH24u8UBO3pf7EJh
         sk0ij4zFbGHEK+IFjZG6dg+YaHK9S8ZeRcEYjqBdtxheI1IOBHRJgt7l+jsSNCofXrJj
         B4hQ==
X-Gm-Message-State: APt69E02MyfGyID8keRcMVtupReFQrS+N6I14D9FioQpyAL6sF570/7J
        2+cFjrpVnHUepwShIEarUoA=
X-Google-Smtp-Source: ADUXVKLIE+nZ7e7TmzZ9sZYNPMcCNvgpu0JUiFeIje40SBvTGSh1SOKJio22imITHWba20FxHgm/wA==
X-Received: by 2002:a62:4c04:: with SMTP id z4-v6mr1050644pfa.205.1529055625177;
        Fri, 15 Jun 2018 02:40:25 -0700 (PDT)
Received: from localhost.localdomain ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id p1-v6sm11628551pfh.58.2018.06.15.02.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:40:23 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 1/6] printk: move printk_safe macros to printk header
Date:   Fri, 15 Jun 2018 18:39:14 +0900
Message-Id: <20180615093919.559-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make printk_safe_enter_irqsave()/etc macros available to the
rest of the kernel, so we can use them in TTY and UART code.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/printk.h   | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h | 37 -------------------------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800affd8..8b4e1e667919 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -153,6 +153,46 @@ static inline void printk_nmi_enter(void) { }
 static inline void printk_nmi_exit(void) { }
 #endif /* PRINTK_NMI */
 
+#ifdef CONFIG_PRINTK
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+
+#define printk_safe_enter_irqsave(flags)	\
+	do {					\
+		local_irq_save(flags);		\
+		__printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irqrestore(flags)	\
+	do {					\
+		__printk_safe_exit();		\
+		local_irq_restore(flags);	\
+	} while (0)
+
+#define printk_safe_enter_irq()		\
+	do {					\
+		local_irq_disable();		\
+		__printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irq()			\
+	do {					\
+		__printk_safe_exit();		\
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
index 2a7d04049af4..cf4f85e53cc2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -27,46 +27,9 @@ extern raw_spinlock_t logbuf_lock;
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
 
 #else
 
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
-- 
2.17.1

