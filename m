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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496FEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0DC222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXZ2Vu+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395240AbfBMWmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395185AbfBMWmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so4414094wrg.1;
        Wed, 13 Feb 2019 14:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=hKpBmvKhY62YcE+qk2JyFeoOHJdEVTVCpq3mJ7wKHeo=;
        b=qXZ2Vu+P6kthMEkjo4iNmgotT7rvJqsgrxxwiFIZl81jupiKBpLSUH2abdTiMlSLJs
         YahkFPUw4qFNOTutD7eS0RkUg8/4x71BFfYo03YVardx8EzGJKYPhLTp7k9S+a53JLMv
         M0pdfY2WiUJrH05PCxiQNB/qHgXxlZuJ3TU+QrEu0FcGIo457jatHpc7OPuJqaa9AZl6
         RGP/Zel8+olUZCL6uwyRtRpnAnITyKhXcOeL8t64zoh8KvFaWjZqdhMCNOoDamFRVbxm
         WFsxWPvhhEzgW6QvSW1k6TbPE36aOAgqq9OpmuIO5LEScw602S7o8oXyO3Tc0d4i2nNa
         pjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=hKpBmvKhY62YcE+qk2JyFeoOHJdEVTVCpq3mJ7wKHeo=;
        b=AdeS86nrwvnGRsPWHCm6nevP1UA/TuwDy7BJ8NYP9yhi/o0e8KudH6WS91jQeuN1u8
         hsMHKWzVVHwB76L90Vf1I9Umz3EqQox+anIeGK/SSlzI32o3CY+uh/t+5enIE9Lb7Kr0
         7U0cZpUPVIXwQS8vxTMDlEDKWah+2t/5EF88fp5byXnW4yG5xjV5wGQZFKoTO6+MrRSs
         6lY9cd8ppnV3eUlfMxbTqzpuAQkVB4NNQpGVkbnUpMMQJbXIttS8+OCMs5/OEx4WQG3c
         CPZg0D3FHhpuHvh72WX7wcmXNfUVmjCXQHYVNSGc/4MaB0XIJCW6JAUhSh4uwh3NP8EB
         O0aQ==
X-Gm-Message-State: AHQUAubH1BTYgkuTh0QnDvSXKbMWOWF9yGDU9ZOehDQyCfk8BMUKdSv2
        1Mi4hGhyayO7l0icVwFSZMI=
X-Google-Smtp-Source: AHgI3IawnVj1KBrwvlzP2l4yYPQzxhp3IgPK38fpbbnsPGtbn+e/GwYjxoGB2EAAlzWjGvPfKesd0w==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr283768wrv.121.1550097750621;
        Wed, 13 Feb 2019 14:42:30 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:30 -0800 (PST)
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
Subject: [RFC PATCH v5 10/12] __wr_after_init: rodata_test: test __wr_after_init
Date:   Thu, 14 Feb 2019 00:41:39 +0200
Message-Id: <c46757d8e40a2c4269c2a5376f7d96b17b81f250.1550097697.git.igor.stoppa@huawei.com>
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

