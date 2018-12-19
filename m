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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C34C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC062086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsrHxLPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbeLSVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39602 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbeLSVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so16144260lfh.6;
        Wed, 19 Dec 2018 13:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=24igech0ckFrxBXxxwQUZIyc9LBZ6R5ZtTba/TaHc04=;
        b=PsrHxLPqAAOHeNu5dAOofHFnXp1bLF9bdTdCkJocLpMY34bZfpnS8iWf5Dw2UELMym
         Gs5mW3HgNBDw5r9JwJTc0Fq3/dkKkbXJS7j9ubeXSvaALWLkByds7T+R2raJoj5RB0Us
         PON54gmyVQYYU1Mhmt0vzo7LMuv0p5iO1KZA6Qk3Upr5Y64fRgaifZvHyDj0R8B9QWJl
         BH+63gFqXdkbK13Syi/DwqnOPOJoBavpGBrbHbeAijtUwGiWjznREdZkOCpw0ARGA5FE
         7YraB7oodasyYu4ih5gVedVO/3YOfqhU5mGxwIyA1M6Q8keXB3YNZROEWIyRN9g1/NkH
         hOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=24igech0ckFrxBXxxwQUZIyc9LBZ6R5ZtTba/TaHc04=;
        b=B8cUqHnH7cZ5Z1gf9Fpo9MhVxOjHS2hcd/eDRcmeqryTfmd9eM/Y66pH24ffBTBb6x
         Fnoag4ar0fn3bWion62rI5zlr0yYTRsjdW8E8OU+DyoXwFJpNBLPw6lsfHy/H9yifdVF
         on1G/K1Y/3IAPOMLVmVfHfK5WuVjkM9pLTqARUBoiLBxML3y5YWbahcawLs164Ftkvyt
         Pgbl8DMNlNpyjkQJP59xgLSIhuq0Jg+/AzNR/mQnlU8EzzI5u8IrGQmFrEpmdqZ350rJ
         rTdCsPeNuHV2sMd0O0oPfzmsMwdAOOgScLgUQ2AgclBbD+bZlYPNQZhjk+IZ0sx2PlVt
         NgRg==
X-Gm-Message-State: AA+aEWYmI7JxNInPx9wB33qCFiGjg4nOdOb+FsQiNwx23fYNgJ87qmND
        JlJelJ9bajSFNFpBSYIi/vQTKKNu0Dg=
X-Google-Smtp-Source: AFSGD/XZWonxcWlW1GBfKWAbMcZ0oFNcTXt0omhVGDk3miIbt6GEElW3TXO8yTUpmBSwSEymuJbaRw==
X-Received: by 2002:a19:910d:: with SMTP id t13mr12712428lfd.98.1545255253625;
        Wed, 19 Dec 2018 13:34:13 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:12 -0800 (PST)
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
Subject: [PATCH 05/12] __wr_after_init: x86_64: debug writes
Date:   Wed, 19 Dec 2018 23:33:31 +0200
Message-Id: <20181219213338.26619-6-igor.stoppa@huawei.com>
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

After each write operation, confirm that it was successful, otherwise
generate a warning.

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
 arch/x86/mm/prmem.c | 9 ++++++++-
 mm/Kconfig.debug    | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/prmem.c b/arch/x86/mm/prmem.c
index fc367551e736..9d98525c687a 100644
--- a/arch/x86/mm/prmem.c
+++ b/arch/x86/mm/prmem.c
@@ -60,7 +60,14 @@ void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
 		copy_to_user((void __user *)wr_poking_addr, (void *)src, len);
 	else if (op == WR_MEMSET)
 		memset_user((void __user *)wr_poking_addr, (u8)src, len);
-
+#ifdef CONFIG_DEBUG_PRMEM
+	if (op == WR_MEMCPY)
+		VM_WARN_ONCE(memcmp((void *)dst, (void *)src, len),
+			     "Failed wr_memcpy()");
+	else if (op == WR_MEMSET)
+		VM_WARN_ONCE(memtst((void *)dst, (u8)src, len),
+			     "Failed wr_memset()");
+#endif
 	unuse_temporary_mm(prev);
 	local_irq_enable();
 	return (void *)dst;
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 9a7b8b049d04..b10305cfac3c 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -94,3 +94,11 @@ config DEBUG_RODATA_TEST
     depends on STRICT_KERNEL_RWX
     ---help---
       This option enables a testcase for the setting rodata read-only.
+
+config DEBUG_PRMEM
+    bool "Verify each write rare operation."
+    depends on PRMEM
+    default n
+    help
+      After any write rare operation, compares the data written with the
+      value provided by the caller.
-- 
2.19.1

