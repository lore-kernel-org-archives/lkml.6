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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE57C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A779D2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGYDAnDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBKX2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53564 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfBKX2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so1006172wmb.3;
        Mon, 11 Feb 2019 15:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=hKpBmvKhY62YcE+qk2JyFeoOHJdEVTVCpq3mJ7wKHeo=;
        b=BGYDAnDXfWDwMeK5eSKfBJYIRnmsh1oPx2ZOf8HcWXdmwBIgDVTpuqYUB3KvmHH93e
         CQ/pUVW9gaxkff/ISmJHvCx/y1ksn3D2ZB0Zl1e1iyNKsyURJCuhYe/XfMWhILPIoQX+
         sOSNtcaEc0fNOG4tGaK9bLqGDsUMwDS9dEo/h/3lAczrR4Z9kaLfBvB7RrPofGWyd07Z
         87HJ77tPwwo/7W13RnoDCQDElfKTZPRyDBFxrJ719qY6wqsZ65fePWfguFZ20wyR1vzj
         2ALjxTWAWngGdiNowfrT+LbQ993RGtjwSm7r04Cwz+BFeQhqMsf1ODGAgbq7iaAYEptt
         Yxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=hKpBmvKhY62YcE+qk2JyFeoOHJdEVTVCpq3mJ7wKHeo=;
        b=AofIbnMSLmu2FSbRhz+sbuyHv+rjaccxJczLp4XwYycUMRLEKDN0MY1FHWxnQU/UtA
         xMuvbHO08czzOa3nZGHc81B3X7Vilx+r5qoSwTPjKHaZjEA9C/aOaR4N44Y4QqimDgZt
         R8qYg/Ll8KmMeEos0Zwa2CKdR0lEVONFYTQzsq4mnuTrawIxwsmIZMNhpiGHwPV4enNR
         Gp/VrmgM0tdKWrcFL7ytT2ii5WB7m5VSmNHiiWYGWWZ4XaUhlHfnXYGYEIulDqhGrWMn
         G/jSvByvtcpACElIRxEPmIRNtVXTvYSBJ7vj1rINmNDS8eixvpS8cx2uA3GONxjDZcrH
         wIuQ==
X-Gm-Message-State: AHQUAubhXg8u3IHb1ODI38SQo0xI/d7BJyw4P6yty8GhoWXcdTz+Tpf3
        nb7H1fV+ckbiORt66QFkaXE=
X-Google-Smtp-Source: AHgI3IaFcGvUdEZKnlRNCrjUqMaXRhiVC7YxDFcfeCy5/2TwxwLp1XrgFxFOCYbNVyOvJEbUKa2RjA==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr490431wmj.105.1549927717395;
        Mon, 11 Feb 2019 15:28:37 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:36 -0800 (PST)
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
Subject: [RFC PATCH v4 10/12] __wr_after_init: rodata_test: test __wr_after_init
Date:   Tue, 12 Feb 2019 01:27:47 +0200
Message-Id: <5b674df65263831006ea27edce2c08fd70ddd6b1.1549927666.git.igor.stoppa@huawei.com>
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

The write protection of the __wr_after_init data can be verified with the
same methodology used for const data.

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
 mm/rodata_test.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index e1349520b436..a669cf9f5a61 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -16,8 +16,23 @@
 
 #define INIT_TEST_VAL 0xC3
 
+/*
+ * Note: __ro_after_init data is, for every practical effect, equivalent to
+ * const data, since they are even write protected at the same time; there
+ * is no need for separate testing.
+ * __wr_after_init data, otoh, is altered also after the write protection
+ * takes place and it cannot be exploitable for altering more permanent
+ * data.
+ */
+
 static const int rodata_test_data = INIT_TEST_VAL;
 
+#ifdef CONFIG_PRMEM
+static int wr_after_init_test_data __wr_after_init = INIT_TEST_VAL;
+extern long __start_wr_after_init;
+extern long __end_wr_after_init;
+#endif
+
 static bool test_data(char *data_type, const int *data,
 		      unsigned long start, unsigned long end)
 {
@@ -59,7 +74,13 @@ static bool test_data(char *data_type, const int *data,
 
 void rodata_test(void)
 {
-	test_data("rodata", &rodata_test_data,
-		  (unsigned long)&__start_rodata,
-		  (unsigned long)&__end_rodata);
+	if (!test_data("rodata", &rodata_test_data,
+		       (unsigned long)&__start_rodata,
+		       (unsigned long)&__end_rodata))
+		return;
+#ifdef CONFIG_PRMEM
+	    test_data("wr after init data", &wr_after_init_test_data,
+		      (unsigned long)&__start_wr_after_init,
+		      (unsigned long)&__end_wr_after_init);
+#endif
 }
-- 
2.19.1

