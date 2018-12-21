Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB7C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E45421906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUeoKzL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404388AbeLUSPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36082 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeLUSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:15:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so5533901ljk.3;
        Fri, 21 Dec 2018 10:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=vgb7J+uzu72a1nLgAIDJQpmIZYI0IWGcwJEvrx3eHk8=;
        b=kUeoKzL4DU9YWPEF1gNBKSCW0fL9CgdXq6jjpoupxnO4uLElST2H3S+SZCQgWimXXO
         YZMohIUO3dmUaPEpq05kR5+UYbdP8y+AIjfcy75gu+74W7d1pcqGXzRoIbVh/NgpQ4Hu
         XlT/e25pZJJetrF/oy9iRTDdIkBHVWZRayJtOBqc9NF0MTUYxKeUsVGasOcHzSVmNawK
         taKuwvPiPWuqWrhRKsjrXcBQPTXp8K6wjHW5mb0ZzblTCCVZfJb5fhn+NIqfncqQu0zm
         0/IE8fGk5PL2rlOOPxS0vZLGHddhfFG0tPSDSKOTrDWp6euS3mJKoxmuscDdf7TiCAgY
         X65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=vgb7J+uzu72a1nLgAIDJQpmIZYI0IWGcwJEvrx3eHk8=;
        b=jD3bPME0D1SrSxKbkgx6rucLuPe0nZqn2Y5McHsPjKetCS5RW0f21nbZyMLIKvbFVN
         kJWXSEHagRRc0RsUb19+nfW4tXzMQlbagMuWHNMcVbcAX6WBnum76oy6pEnV2PTpg1z9
         7T8sQ+9HN1YxnVizIDEtbpbZgrG9ooMFNvd9k4GIXMzLDvJU3ll3PwWfKYRDbLxOJ7X2
         /iiGinJZQT+S5XsFDcVXynouD+bJStRoqoXgr6peKSiaUYaOuLV0fSwJq5RUaaqeI6gR
         NFWyr7il2cuFUFVSI2xTfnoJMaS/1OGTnDSarumEoe7sbhxeRBUz+ds+N5UW2hhz4n9t
         lhrA==
X-Gm-Message-State: AA+aEWYaMq50TEHinymVMyjl3n/eLkNNm2SEBJB9PN3FjZfMxU1PgHeW
        LSUM7uSUQltwau3MVsih8Sg=
X-Google-Smtp-Source: AFSGD/XswW5dKjiUGmh9wa+v9T60QYxp3Cs4xb9Q4fBCeW4KdXwqXRGKpf7tFOWWuwHHCYc03cVqMQ==
X-Received: by 2002:a2e:21a9:: with SMTP id h41-v6mr2233605lji.103.1545416101435;
        Fri, 21 Dec 2018 10:15:01 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:15:00 -0800 (PST)
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
Subject: [PATCH 08/12] rodata_test: refactor tests
Date:   Fri, 21 Dec 2018 20:14:19 +0200
Message-Id: <20181221181423.20455-9-igor.stoppa@huawei.com>
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

