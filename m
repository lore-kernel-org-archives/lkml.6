Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE921927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loRWo9kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404377AbeLUSPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36869 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404341AbeLUSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:15:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so4531991lfj.4;
        Fri, 21 Dec 2018 10:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=FDryqu5ur4j9ePg/wc9MnpTPYVkBg8AjJFLLJs3gfA8=;
        b=loRWo9kckttxn0cbJ+fMhQo8mYzlWi1+DZ1LXwFHcvwUSOVJ7CH068lDje4y/JF8Rm
         4KOSZXWkx+GDi83Ss3j76Km/WDo3QRA8iGTHbvMD1tBfIvX/IpsjoNyU60bgIC7H6aNc
         0kBRzwFWNpYFLT2X6pm/bNv3LhJUf+HMOG+dIa/LB5yvNOXBi7Ls8K0Ar0gdU8qKJGun
         N3+2efRoBPjH04D5aCWvEDNEiR8FxJXj9Y0Ng1Hstx4puvluHFXXOSSJ+qFnFNo4fQdC
         eA9q1xhmUFd5GVFJy0cmj2ZHDEO+vtXqkZ+C292gQrBJc+4K3eR4TBgWTZ4XrLWVP2gV
         mZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=FDryqu5ur4j9ePg/wc9MnpTPYVkBg8AjJFLLJs3gfA8=;
        b=ZvUsSk/jr/W/AMuQl1YGkd47M3/vgwZ2KfMRUrnGRmhk5aS2XCq2YXpS0xTtiz3cr3
         Zi7Fg+h9Q1El3gLhCs/npd+SLtdLrMUi8c+hPAJoEHW0lHbtWlyxcaguYGk7fCcORfBq
         M0sn7JgqQhL+kZxc2pPTxsW7bMAeY6xu5POQuj7FLub+2PZ8gfihuxKUZ+6QSOeRiK0V
         PrUUAIAHt1onnWXajMSlQQN7mVi10S8tCCHKou3GslkcCSEGVJqXyT0cHYkJPcGhj+uz
         fcYFR4GxbG2a7mqHWlc1GoRaZc0EaaVHrofH2xzl31Jyeb20SWg2jVkZJ8Kajh0aendL
         8Q4g==
X-Gm-Message-State: AA+aEWZu3W9hMWibgD26nuLM0ohhkzBThLLDgpI7KsPbqJm9A7wtVGFF
        nqt9LPzB7M6DqO6/9umskAU=
X-Google-Smtp-Source: AFSGD/VCXWhv1t5F5g9bAmEpbvcLcqmHx5RI8DK/pE5oqUo9y/6mbZGVq6pEeFsgUHszWM65/sjQlg==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr1960679lff.141.1545416098906;
        Fri, 21 Dec 2018 10:14:58 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:14:58 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] __wr_after_init: lkdtm test
Date:   Fri, 21 Dec 2018 20:14:18 +0200
Message-Id: <20181221181423.20455-8-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221181423.20455-1-igor.stoppa@huawei.com>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that trying to modify a variable with the __wr_after_init
attribute will cause a crash.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
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

