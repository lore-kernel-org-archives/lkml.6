Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50849C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD5A2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmiIU8pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBKX2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36254 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfBKX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so685486wrw.3;
        Mon, 11 Feb 2019 15:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=vgb7J+uzu72a1nLgAIDJQpmIZYI0IWGcwJEvrx3eHk8=;
        b=VmiIU8pXfiJ8oLtorDhULSxsmh+YjuTJjvlq8YuRiNowB4/1UqpCrVw5BosEBTfL6V
         lQbb1zyKnf0f37rNuOWdB/36I0sBvIypEXOaJlidU+6cLxaed7X4JobdhlwNv7l2ZOgr
         CLcpjJ/DKikqWa2/di7U6WvgXoxM13L73BBHmEh+vVp+7fBOqFY3BuY7Dsv3OewGcQn7
         wx+umnTSpRY8mM+athafH9jgbBlDHfGt5caNxzNx1BFVa2rsre/0TI78tes3g2BD6/u6
         dID0vUXju22Zkh/Kep+vSEP2+NHeXyAdLybiLgP8GoWTcJfJRcKIg6pEbmyXmkESLdcX
         RvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=vgb7J+uzu72a1nLgAIDJQpmIZYI0IWGcwJEvrx3eHk8=;
        b=ITjH4AAoFHvaUirll3xOa1NHJbGZd+Q4B+w1ww8VNMJS5YZAPQiB3eVs7w5H476uoX
         +uRzSDV192t5afaMQVziLlwjjM6WC88+OvbPBR29dpTouJULGrrDD2j5GsEiSDBr5fpi
         CUZBvnIOsJRKNXiyKtJhQYJXrVEoUg4FAWOPCaKx+LVcb1oLK+xCRXgWzTB1VW/txIh0
         dawMtsz9YyLCFxnuXIO6n59480SztoTqCWEtrX7gJ2NVMtNvX2pIcN8jp92ADlYtJVVi
         PEx53u1SakBZpP7qXki1dfEgJ5sPEmQYNccTdV6I2qo5fxzOUFxktoONMhZdWm5wRHcW
         IiYA==
X-Gm-Message-State: AHQUAuYo0p2HoTAGbWekz43Ore2wV65qXsHaqchNxESbhrgRpaJGc0Mf
        I5nLAv9Htek69EsEb6QjbWY=
X-Google-Smtp-Source: AHgI3IbQwu8eTmjbJnx/2r01oGyJDgWGHUAAfDPRDsTqvehJCmHsCuN42bxdkY5qB2bklveZMh0xdg==
X-Received: by 2002:adf:f410:: with SMTP id g16mr517807wro.246.1549927714236;
        Mon, 11 Feb 2019 15:28:34 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:33 -0800 (PST)
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
Subject: [RFC PATCH v4 09/12] __wr_after_init: rodata_test: refactor tests
Date:   Tue, 12 Feb 2019 01:27:46 +0200
Message-Id: <ff02823336ca9959ec53adc469aa113fd00e03cb.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
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

