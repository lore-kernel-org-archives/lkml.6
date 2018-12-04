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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D3C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB1D20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3RY5vky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB1D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLDMSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:18:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33596 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeLDMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:18:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so14708135ljd.0;
        Tue, 04 Dec 2018 04:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=WBnbM87FYiZB144WHH+WIErpqzF5ZNVsWJfotUGC/To=;
        b=E3RY5vkybSvPTIG8UuGMwEVOwkUplL0AFDj1MN9T0ROLaaMBhx3o6sL9qiBqK8cDpF
         lHokL4Goz61X1sMwWX2rqe8g+i/xkU80XCiz6Keo5mY+N2QwkuztsW8I1TLYVZ36cJL0
         cH3fN77tAZGhRIwFjGT/udN/UU2XaH/2piLYSuFcG9+mF0rVBDyJkSqRWN10wU0RGVLp
         g/U3CKeZCh+PdGUKf8B7AMY64oqIvcBkpDi5JA5HxCI6tSjMn8oOG8MbP/CCJI23fOqP
         OzTixarbLeKA4neW+891Bwfc31u1LhGzMb0feY22cbNyFQTUMEWbsqO2Kl8cBZC+/vvy
         QAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=WBnbM87FYiZB144WHH+WIErpqzF5ZNVsWJfotUGC/To=;
        b=tt48kyoff7pEIyg4FEPYKGDQ2vzW3/6CTRYpTsS7iSN2waDsDBTyPYo/TXSMOqflko
         jtJFZi+yQuinUrstRazjnDM83Walk//lomVvw8xeVNsfbHUH0zotgm1yWV8FdMkdrSSg
         vOJJIAKeGCST4belywHEMuvPuCGRu6UcaS9YtlWfBKK1xWJ7OMVaMk9hKpuEjdS0V5KH
         /31zHs7Iz9Hhd+pXn2WZBF8UG4l3V30dbAAFy50hGe6Qgp1VcWA8a2YKvwTnCJjmLbkx
         cnIgm47W/TGBcMFyIPzNWTbS0hLMnJMpgwsKGzOyI1WT6k4/jx+ScjIE/F7YaAAth6/2
         Fihg==
X-Gm-Message-State: AA+aEWYdSqZYoLzYIxye2nGkXoKy1hfffX63GJBL30MqJeGTtxlSKSsH
        bEJQXpDvDjpjk6u93qTxehA=
X-Google-Smtp-Source: AFSGD/Uz5k3knHQnWYcPn5vvfo8l7N0tmCpAv9nXtZVRKiyo8X/OPZgpu0935A98/eCYHI1LGa7rXQ==
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr12190962ljj.98.1543925925285;
        Tue, 04 Dec 2018 04:18:45 -0800 (PST)
Received: from localhost.localdomain (91-156-179-117.elisa-laajakaista.fi. [91.156.179.117])
        by smtp.gmail.com with ESMTPSA id h3sm2899653lfj.25.2018.12.04.04.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 04:18:44 -0800 (PST)
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
Subject: [PATCH 4/6] rodata_test: add verification for __wr_after_init
Date:   Tue,  4 Dec 2018 14:18:03 +0200
Message-Id: <20181204121805.4621-5-igor.stoppa@huawei.com>
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

The write protection of the __wr_after_init data can be verified with the
same methodology used for const data.

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
 mm/rodata_test.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 3c1e515ca9b1..a98d088ad9cc 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -16,7 +16,19 @@
 
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
+static int wr_after_init_test_data __wr_after_init = INIT_TEST_VAL;
+extern long __start_wr_after_init;
+extern long __end_wr_after_init;
 
 static bool test_data(char *data_type, const int *data,
 		      unsigned long start, unsigned long end)
@@ -60,6 +72,9 @@ void rodata_test(void)
 {
 	if (test_data("rodata", &rodata_test_data,
 		      (unsigned long)&__start_rodata,
-		      (unsigned long)&__end_rodata))
+		      (unsigned long)&__end_rodata) &&
+	    test_data("wr after init data", &wr_after_init_test_data,
+		      (unsigned long)&__start_wr_after_init,
+		      (unsigned long)&__end_wr_after_init))
 		pr_info("all tests were successful\n");
 }
-- 
2.19.1

