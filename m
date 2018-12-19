Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9646F2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU84YQAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeLSVe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43620 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbeLSVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so16145025lff.10;
        Wed, 19 Dec 2018 13:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=wZ8trlwQPC9hiGZKEv5EaYDHKPPRSKQ7DlpYkIOznGo=;
        b=RU84YQAA9ttAmCj5fwbw1hMbyAy79lr8StEuIYPs9nOgSexZa0zqGJhbGusOBhYRhl
         xvmpaIiQVWKWaisVJxT3EF8AjHPFUOPsMmvVf0xabzznRPYkn4Ka2csi12L5kF0hjOA2
         /YZ4p7KgF6klxJT/Fv9A5bUND4Lp9BrQt1C9Cu+DXoFZTNgZshlgaPpXxwkXJnqUg9BL
         qrMHZK/pasAsW4YC3x1UFogxA456adKKOJHz1U7syC70Xu0ShrNdgy0ATa0ffanp/ZPa
         3YqZPYKxBhicupwqEWngQsDdCleZgY4sTjVKRTlNdvj6EHnv6HhLFbg4pQZAERHbxUTH
         llTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=wZ8trlwQPC9hiGZKEv5EaYDHKPPRSKQ7DlpYkIOznGo=;
        b=p8uYXmIX3YdXB0qsFOJRTX448ckAbOHkLYX/JVyHwKVR7VSB1c171BVUO1MEkorIKW
         dbrsgmPenfTRQnoJYZWxv38OP2tTw7rCzKzCkUeyq3eu7DtSCn13a49eb+G56GyNlyMi
         qA6pvzJlFDA0C2n5+iDXCE9LXysb4iveQTi4FzRUdgk1/T0ZTzc8HHywNBuFHZDMEh8x
         Pd/jirIFdxdViTz3BzoX9zhPLxfSs6hplVBUi0uzYDzv1IvW3y54k2lKviFyhdPPv7zI
         hrSbgi63ic1g5kTmMhgW8V5uPRjuuqFCj6AQ6rH5qD1RvyiEQf/yfxtYCjmK2Xi2Ih9T
         PXdw==
X-Gm-Message-State: AA+aEWYGraro8Egk38u6GvLaTnlRC76Q9vQAAsea7uPsu1IysWv5Znc8
        PtdYSuwaihFgESjNL1ZyXeg=
X-Google-Smtp-Source: AFSGD/XdC5giLSZrQt/Kv87Ghx67drqER+B1qjvWKaiMHLOdw8yx48gU4/ChW9agrJeuwYmr+pkViQ==
X-Received: by 2002:a19:8d01:: with SMTP id p1mr12727200lfd.149.1545255261117;
        Wed, 19 Dec 2018 13:34:21 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:20 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] rodata_test: add verification for __wr_after_init
Date:   Wed, 19 Dec 2018 23:33:35 +0200
Message-Id: <20181219213338.26619-10-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219213338.26619-1-igor.stoppa@huawei.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
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

