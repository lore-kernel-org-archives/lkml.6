Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C904C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE221927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGWfQjb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbeLUSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:16:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36342 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404299AbeLUSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:14:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so4541703lfg.3;
        Fri, 21 Dec 2018 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Us5fQxnqAuf6nDTBJO2Qb2w31hoygG1FpkEKlSmx1Kw=;
        b=HGWfQjb5vbSEU703D7GDZF8gnrJ6CfP1TS1iPmRhSDLGjMliWP2OTU4t9dcTDDLFqv
         eDAU+7nNdwfcfoz6oYXjJL+HmL0C7ymB9ShJsMj23VqimbB2jkRvrjm8zuQ48p+Nfr75
         ZoN6joq84uIn/psO+3Xg9u/0iXRyuQynvLmv/HtqwPCYoNAWC5Faa76BZyDT9FID2Vfu
         dqlkXt4qfXEYfLfc8I/aX6w3fTxt+HeG3t0yKQFDxfLBtruTGAPQ/XtAuVw0DefC7wLn
         CshGs3iZ+b8H51siPqXn+F0ztDMm4FEfvmDc8DP/V0wU19fqjPIHsEMvhcM4ZSk9hHIX
         btxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Us5fQxnqAuf6nDTBJO2Qb2w31hoygG1FpkEKlSmx1Kw=;
        b=aji4ZXgOV/BzW43mkpRzDhztoN35R7QwrO9rLl+b10b7NbUKnN3xqR81t5WfECype5
         ukBfo/IF+sx6rW+uPE5QNaHIjsBYEZtSy06Rzr32lgwyhziilu9kBYb9clqcWDXDelJ8
         lfHK3glX95WaJgSz/lek7cm6NNkP+WKBycbs8gzuwqEqeAqVXpgRYE9DEe75FI/yrfJk
         UgNIbmuXHgOwvOlEJ2BSeXiuNy1fRuCqjgqx6MJQ8CA4h1AWE0YZrjdihwHzplTEJkW8
         eFlynkeSVZSXR0VbcI2DuGrP7KfQdYczsi7Bwpap017zoGSRZzIz1BH9hAWuPT5HXd0I
         SsIw==
X-Gm-Message-State: AA+aEWZJIbRtFoCRr4kjI8fLjBi4yOHnENejHXvZbD1qsRzL1U4USAxw
        l1U3E6ziVXg4/df4WSIGDHA=
X-Google-Smtp-Source: AFSGD/XRk3ffVjosi0KOa8ubOE0z0coXuuRA/SrFAZt3Qg8nlBRGeL4XEqjStoml5nY+Fgm+PFWoDQ==
X-Received: by 2002:a19:1994:: with SMTP id 142mr2105273lfz.134.1545416091776;
        Fri, 21 Dec 2018 10:14:51 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:14:51 -0800 (PST)
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
Subject: [PATCH 04/12] __wr_after_init: debug writes
Date:   Fri, 21 Dec 2018 20:14:15 +0200
Message-Id: <20181221181423.20455-5-igor.stoppa@huawei.com>
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
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 mm/Kconfig.debug | 8 ++++++++
 mm/prmem.c       | 6 ++++++
 2 files changed, 14 insertions(+)

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
diff --git a/mm/prmem.c b/mm/prmem.c
index e1c1be3a1171..51f6776e2515 100644
--- a/mm/prmem.c
+++ b/mm/prmem.c
@@ -61,6 +61,9 @@ void *wr_memcpy(void *p, const void *q, __kernel_size_t size)
 	__wr_enable(&wr_state);
 	__wr_memcpy(wr_poking_addr, q, size);
 	__wr_disable(&wr_state);
+#ifdef CONFIG_DEBUG_PRMEM
+	VM_WARN_ONCE(memcmp(p, q, size), "Failed %s()", __func__);
+#endif
 	local_irq_enable();
 	return p;
 }
@@ -92,6 +95,9 @@ void *wr_memset(void *p, int c, __kernel_size_t len)
 	__wr_enable(&wr_state);
 	__wr_memset(wr_poking_addr, c, len);
 	__wr_disable(&wr_state);
+#ifdef CONFIG_DEBUG_PRMEM
+	VM_WARN_ONCE(memtst(p, c, len), "Failed %s()", __func__);
+#endif
 	local_irq_enable();
 	return p;
 }
-- 
2.19.1

