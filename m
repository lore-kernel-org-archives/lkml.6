Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C3C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5CE2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRfrXCFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5CE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLDMTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:19:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46170 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeLDMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:18:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so14662143ljh.13;
        Tue, 04 Dec 2018 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=NVdqMmCKQZDysvXYUM4dpuRHk0CW6y96xz6tH9NdrSw=;
        b=HRfrXCFQvzKgQhKYWkbS/im8+XnLQmGG8ccr5n3DY3AvBzv51R79u/dWJYuhk3Y/QB
         5F3PX6ti+fzfyYUTTRkeMeP2Qkk/GOPZC3dVKjWeDjWxzfaNsQWYwv8PUBhakUjEMGpC
         +3eyvJFkXoEIJcYl3HPC01uHhpdzkuhiE5IctH//w5KYZf8JD/Y7Gole7e9dz6kxhzmW
         ZC9eXZteiMUUw1lsEK1t4DghxBzJd4NJHIq3xxVBIuqzUX0poFyAOWyUxaemqKC77wOK
         Ydsd8ZfPrBokXf7ifOd5x8NzNp/7evrgARi/7ve5XNikMvobqmD29jlx6kR0upcm+wRp
         8YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=NVdqMmCKQZDysvXYUM4dpuRHk0CW6y96xz6tH9NdrSw=;
        b=hcmwnRcYAMEpKVc6dzPRQvqHlsjgKSkry0Rh/Ao44+/D9BLeI0LoBLZqBOb9RL7M2K
         zmXucjApP4B0aTxwPaA+wjFEl1tZwWt2cgR/Sif3vY1YEyq5WF+kigyVZXMJEjo2AGe2
         CeyM5huPdQFAVa0yK7PRNXuJt5HFuvv1X9CBJy7iIViJZXqGzzGWcx0xDYm+HgllTexZ
         AUvUupSi9PbNKgwbT1zOAQAdQNneWV9GuVIpkTN10WEMvrSwQEuZlIeKKesvIhaH27FE
         afgClq8S4aUrSM4fQJVf3nJ8LW5dvw8DIQ0CP99FQqhaQq7UksP8u1tGoabdcJbJOEmz
         3K9Q==
X-Gm-Message-State: AA+aEWao5hC5fdvzkVwHmm03GmXD2ZRkY0OWhJRAgbJ0OWpnp/2UsSjH
        z1VAPltGfJmWAHbBQIi/68Q=
X-Google-Smtp-Source: AFSGD/UPXTOGRAw/49T9676bvJ9/1gFe/zO9Lwr0qxwwIUQFs7TARHUmypZrYSVjqRzSte4x5ibGcg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr3119346lji.112.1543925928237;
        Tue, 04 Dec 2018 04:18:48 -0800 (PST)
Received: from localhost.localdomain (91-156-179-117.elisa-laajakaista.fi. [91.156.179.117])
        by smtp.gmail.com with ESMTPSA id h3sm2899653lfj.25.2018.12.04.04.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 04:18:47 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] __wr_after_init: lkdtm test
Date:   Tue,  4 Dec 2018 14:18:05 +0200
Message-Id: <20181204121805.4621-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204121805.4621-1-igor.stoppa@huawei.com>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that trying to modify a variable with the __wr_after_init
modifier wil lcause a crash.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 drivers/misc/lkdtm/core.c  |  3 +++
 drivers/misc/lkdtm/lkdtm.h |  3 +++
 drivers/misc/lkdtm/perms.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..73c34b17c433 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -155,6 +155,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(ACCESS_USERSPACE),
 	CRASHTYPE(WRITE_RO),
 	CRASHTYPE(WRITE_RO_AFTER_INIT),
+#ifdef CONFIG_PRMEM
+	CRASHTYPE(WRITE_WR_AFTER_INIT),
+#endif
 	CRASHTYPE(WRITE_KERN),
 	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
 	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3c6fd327e166..abba2f52ffa6 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -38,6 +38,9 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
 void __init lkdtm_perms_init(void);
 void lkdtm_WRITE_RO(void);
 void lkdtm_WRITE_RO_AFTER_INIT(void);
+#ifdef CONFIG_PRMEM
+void lkdtm_WRITE_WR_AFTER_INIT(void);
+#endif
 void lkdtm_WRITE_KERN(void);
 void lkdtm_EXEC_DATA(void);
 void lkdtm_EXEC_STACK(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 53b85c9d16b8..f681730aa652 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -9,6 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mman.h>
 #include <linux/uaccess.h>
+#include <linux/prmem.h>
 #include <asm/cacheflush.h>
 
 /* Whether or not to fill the target memory area with do_nothing(). */
@@ -27,6 +28,10 @@ static const unsigned long rodata = 0xAA55AA55;
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
+/* This is marked __wr_after_init, so it should be in .rodata. */
+static
+unsigned long wr_after_init __wr_after_init = 0x55AA5500;
+
 /*
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
@@ -104,6 +109,28 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 	*ptr ^= 0xabcd1234;
 }
 
+#ifdef CONFIG_PRMEM
+
+void lkdtm_WRITE_WR_AFTER_INIT(void)
+{
+	unsigned long *ptr = &wr_after_init;
+
+	/*
+	 * Verify we were written to during init. Since an Oops
+	 * is considered a "success", a failure is to just skip the
+	 * real test.
+	 */
+	if ((*ptr & 0xAA) != 0xAA) {
+		pr_info("%p was NOT written during init!?\n", ptr);
+		return;
+	}
+
+	pr_info("attempting bad wr_after_init write at %p\n", ptr);
+	*ptr ^= 0xabcd1234;
+}
+
+#endif
+
 void lkdtm_WRITE_KERN(void)
 {
 	size_t size;
@@ -200,4 +227,6 @@ void __init lkdtm_perms_init(void)
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 
+	/* Make sure we can write to __wr_after_init during __init */
+	wr_after_init |= 0xAA;
 }
-- 
2.19.1

