Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67328C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C500222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjIzVPkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395214AbfBMWm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55866 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395185AbfBMWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so4289340wmh.5;
        Wed, 13 Feb 2019 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=FDryqu5ur4j9ePg/wc9MnpTPYVkBg8AjJFLLJs3gfA8=;
        b=NjIzVPkQI+bCcLNEI/Rt4U85tu0DGaKik0uQCOMXvSEkO/SvlHDTcAU8+IhLk21y1p
         5m+FNp4iAWRrJ/k/DDDQZG8GEE1PO9QmTNuEZj9sZ3t8GOVxkaHS88LjJhq6BKQ7N9X3
         FJu9x7w0j1lXKAVEa9NaOLOiDSwyj28NVgD1R/mi4Ij/muEfi9+4T/7X6PO8M08gwtT4
         aaJwB93WJNH0Lk9jcLkQo1ju6chbGRcgdS0TIt45lL7EReQ2hPmGRvbjzBEH7IuKbkQK
         PTBJS9E+bupu40oKgPBcvq9VxB11GBhj6qIU7b2yqA1Ep6uVGLC5RY2njYXlBvxDI91M
         RhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=FDryqu5ur4j9ePg/wc9MnpTPYVkBg8AjJFLLJs3gfA8=;
        b=Yw2hQ/LaP+YDXt+txVaKfoPEMJ6p0qbWRXy0sb37cujzMTxqRwgW8faKS2v5U3D05C
         LANJ9VfQF5v0veXGGP2a0f9P59HqFnhTB2frFGYnrAjUp2J811zamf4stPfD6kv1I5f+
         OfJmgSiQ5hiJGJFT0VikTawmqxOD+k/lbo9/R/XVY7iovaPkmoyJRe+WYHMalPlZ2G+e
         UmxvzAb+myKT1uUjM+lcRR3LqAVUY19nyNPvFFfwetuPDtQQqJ5T2gjKIZrbBWWQtFYF
         s8x+Ug8+ve1CkXe9PN7dQzqmowH7G3rni8yHOq8YLFs/lFrEdrIjTI4q9EQ9F80q9SaQ
         /+Nw==
X-Gm-Message-State: AHQUAuYBnglnpOhBmqubHsfK+8ZZJRXQSe9vqgpxQFF55WwCmbevm79z
        ixDqKw2ncZvcFIHs10+aDhE=
X-Google-Smtp-Source: AHgI3Ia10COWxjNMWWeGUZ4kyfPoLmhHvf/GKRNqfO/0o20+P2q+df+RyfuyEETkMZNIJGOmGU8VSw==
X-Received: by 2002:a1c:e086:: with SMTP id x128mr325384wmg.10.1550097743522;
        Wed, 13 Feb 2019 14:42:23 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:22 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 08/12] __wr_after_init: lkdtm test
Date:   Thu, 14 Feb 2019 00:41:37 +0200
Message-Id: <b739e9f8f43cb9cf5843fcb2f90b569bd560fccc.1550097697.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550097697.git.igor.stoppa@huawei.com>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

