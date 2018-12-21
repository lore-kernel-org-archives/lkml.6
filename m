Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61174C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CFD21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/5eitQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404405AbeLUSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32865 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404368AbeLUSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:15:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so4560225lfc.0;
        Fri, 21 Dec 2018 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=hKpBmvKhY62YcE+qk2JyFeoOHJdEVTVCpq3mJ7wKHeo=;
        b=P/5eitQzqF4I/oTbSibobHwdzXYLEAMNbcNPfzS3a+ykbj4p7coiugUW2F9rjhhWMm
         lsNPk+KqhR4DNi7n4YQ0kjs7Hs/SgxhRaox/StG8MhP71NOi8+e3TtzbjmB19jA/2erO
         D1y8WK3jRyhpp8TdwUQv12RC02VyzLYGSD3rsfMZvW7goTHwYSCO6SmBy4GXZ0BuOa11
         RbKHrcsnPGoXvCQgHf47Vp8mmIlUEp5jwiXap9+Z0uadOJtZti8Z/5aspb3g9vpmjCuE
         lKXA6AazVT+48O79fX+xuYZAoJVE5lK4GhgfGVWRtbwUwyRsRiB64G/B57fD3b0NkLNj
         8nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=hKpBmvKhY62YcE+qk2JyFeoOHJdEVTVCpq3mJ7wKHeo=;
        b=pHbzbmREFwEmeGA8XtyVRxNqAqS0jjh699uw/fko8MsNGWQYkam0Qz5h5+OQb33EuF
         aNql2eA2gR9NS+6ewGr3G22fxPf9oF9IxKTGgKO3SJf7ToQ0DB6SMICxIN9Me8xD8UHL
         8T9ArCVZSUu6fQBs26hj0ULOe6z6uEXZLk35dsoqV6wvH+SvPrnFbO/V3YgBIXGInfKX
         27jqiuWM/F7wQ742L0Kq/eoIYZ1ykcUuSc4K0dfcgjpl+tW+1jYeB+C82R26lmtjJ7L6
         eQP/vXhVIpygsHlRXCf6G5c6UQ3Sy2yoABOyRcmCV2lKhWh9UTAGloxzckczpjxIJDbm
         8PDg==
X-Gm-Message-State: AA+aEWaz6Ql3KANU/wOuqSmuveGpOwuT1Xr7mmffWRyNhfvoyMi8SWg0
        oRveHYrgLh/TTaxd7Qj8mYA=
X-Google-Smtp-Source: AFSGD/W1G6Tq7n+hJWkNQlncfqgelqo0DV4gS71OAhO90oATObuU+4gfeMRLnUh0qrb9WRHlqlsVGQ==
X-Received: by 2002:a19:2106:: with SMTP id h6mr1979270lfh.29.1545416103579;
        Fri, 21 Dec 2018 10:15:03 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:15:02 -0800 (PST)
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
Subject: [PATCH 09/12] rodata_test: add verification for __wr_after_init
Date:   Fri, 21 Dec 2018 20:14:20 +0200
Message-Id: <20181221181423.20455-10-igor.stoppa@huawei.com>
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

