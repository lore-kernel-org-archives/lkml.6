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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B7DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2754E222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIR5bn/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395225AbfBMWme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33284 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395202AbfBMWm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so2934471wmb.0;
        Wed, 13 Feb 2019 14:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=vgb7J+uzu72a1nLgAIDJQpmIZYI0IWGcwJEvrx3eHk8=;
        b=MIR5bn/fwd0D9N8Om1k7o8c/GCTN6LB0C3GeABYZt+IdgyaeK88/xnCr2afThsQtba
         OdrxjaKohAGefxP47UJqddJuo1wL6QROIgYS0nqcNKVXavRx0k4ynvja67Sso2VpdoLb
         z9j+1xtt6Ba4iqVJyiEtsV6kVv2f6na8AIvyf5kQBP+bHJANL/fMnSMajCnjT+s2x5We
         S0NgnOqmddtMsILaxMaOff7AK5WqJx2F8sVI6dC5yeP3exfq/e0MKp75IrcRWN3PIgcX
         a55clojZ32DlpLA7ve3dKZwubnysbhMO49f7OxiSBhfj+QUGvfT6whA+F8zobwRBMXHz
         Re+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=vgb7J+uzu72a1nLgAIDJQpmIZYI0IWGcwJEvrx3eHk8=;
        b=Yal/o9RwUYvmMC2Gic5Y1QK0qLW48FAnlZzwKGPxl2O6krtDh0MdCkx9HdPtgZoWXl
         yruHb4KyooGQdXAwPw/jCUcG3r9VljE3VFMmzCxi3CBpJRzkzKxsTBVA18jHQbdgr9ou
         /zxiYK5+zvUDPYUWrVqiIlyV3IToqHwsMse2RTNwwW18R7X2VucbAHUHKYRjtx23NLQC
         tcQ43T+1C1wjcERhF6kcYUDYnguJLipeTNkJAULfhIR/waGKk1XJL3HzrWRGW6Uqm4c3
         CTBc0QPXK3iNqao/n7EgR2iR8TrSwCUu0qfpyzBXCa0lszij57brOyCAqIUsraDsxpjv
         /uYw==
X-Gm-Message-State: AHQUAubHFFTvsnNwxws4LB+qi/NWx3YOJGmTIwMfRhQ5w3OrwZ+a+ISY
        M5aW3cUCNH5rjSOeV3ADH7U=
X-Google-Smtp-Source: AHgI3IY/qpx9bIN8m/MToJYg7+VC1FFLoWbQiBQL48Q2ZmiFFaSGSIEBHj0CtX918v3oqTB9pREW7w==
X-Received: by 2002:a1c:14:: with SMTP id 20mr259551wma.91.1550097747249;
        Wed, 13 Feb 2019 14:42:27 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:26 -0800 (PST)
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
Subject: [RFC PATCH v5 09/12] __wr_after_init: rodata_test: refactor tests
Date:   Thu, 14 Feb 2019 00:41:38 +0200
Message-Id: <826811306c45f5735b83b169017b40f563f21fba.1550097697.git.igor.stoppa@huawei.com>
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

Refactor the test cases, in preparation for using them also for testing
__wr_after_init memory, when available.

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
 mm/rodata_test.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index d908c8769b48..e1349520b436 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -14,44 +14,52 @@
 #include <linux/uaccess.h>
 #include <asm/sections.h>
 
-static const int rodata_test_data = 0xC3;
+#define INIT_TEST_VAL 0xC3
 
-void rodata_test(void)
+static const int rodata_test_data = INIT_TEST_VAL;
+
+static bool test_data(char *data_type, const int *data,
+		      unsigned long start, unsigned long end)
 {
-	unsigned long start, end;
 	int zero = 0;
 
 	/* test 1: read the value */
 	/* If this test fails, some previous testrun has clobbered the state */
-	if (!rodata_test_data) {
-		pr_err("test 1 fails (start data)\n");
-		return;
+	if (*data != INIT_TEST_VAL) {
+		pr_err("%s: test 1 fails (init data value)\n", data_type);
+		return false;
 	}
 
 	/* test 2: write to the variable; this should fault */
-	if (!probe_kernel_write((void *)&rodata_test_data,
-				(void *)&zero, sizeof(zero))) {
-		pr_err("test data was not read only\n");
-		return;
+	if (!probe_kernel_write((void *)data, (void *)&zero, sizeof(zero))) {
+		pr_err("%s: test data was not read only\n", data_type);
+		return false;
 	}
 
 	/* test 3: check the value hasn't changed */
-	if (rodata_test_data == zero) {
-		pr_err("test data was changed\n");
-		return;
+	if (*data != INIT_TEST_VAL) {
+		pr_err("%s: test data was changed\n", data_type);
+		return false;
 	}
 
 	/* test 4: check if the rodata section is PAGE_SIZE aligned */
-	start = (unsigned long)__start_rodata;
-	end = (unsigned long)__end_rodata;
 	if (start & (PAGE_SIZE - 1)) {
-		pr_err("start of .rodata is not page size aligned\n");
-		return;
+		pr_err("%s: start of data is not page size aligned\n",
+		       data_type);
+		return false;
 	}
 	if (end & (PAGE_SIZE - 1)) {
-		pr_err("end of .rodata is not page size aligned\n");
-		return;
+		pr_err("%s: end of data is not page size aligned\n",
+		       data_type);
+		return false;
 	}
+	pr_info("%s tests were successful", data_type);
+	return true;
+}
 
-	pr_info("all tests were successful\n");
+void rodata_test(void)
+{
+	test_data("rodata", &rodata_test_data,
+		  (unsigned long)&__start_rodata,
+		  (unsigned long)&__end_rodata);
 }
-- 
2.19.1

