Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A390222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htxDPkLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395141AbfBMWmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfBMWmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so4359402wrs.8;
        Wed, 13 Feb 2019 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=kjAa+t6wY/NU2SY0EM7WFSE8Fn53OhOBDHc4ci8NYm0=;
        b=htxDPkLVivpCFTEypIPdGV2Vzcy/7XwcJiFvkwrG1psnxGi0fwBH5MLtVcas4TkNf5
         2COfLAp/A9wWDZh7H5gt102tb7USgrH5kt07OADZ62iZ43snyIC276rQR5VrT/1El2/W
         xjBunUpUkSW+Qh91l934BeWTDHAQcJWiFP/kYDazdDd4vbtSNU+FJAvWw+fLPq7EvfFU
         Arlb671GTpQ1x/rP/Cvm4uNqUkB4YrSanMLjKsj5w2WO7E0A83BivOFJjTGARHAfpbCF
         WRHIGFlgf5iu7w8wz8WdPjUo1vptVV3XpP9jWK9oNCS8+VV96xSKRv+x4spertOFgrkH
         24iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=kjAa+t6wY/NU2SY0EM7WFSE8Fn53OhOBDHc4ci8NYm0=;
        b=HsjikadcsaTeN4OK2BFZsPrYu8mAotItENpFm8tRbeRogWzwCIdlnZLT9Lv7sOFPig
         XtvW3+J7Ya+yNvV+ud7/zm+T1AJBeGhv2DUEsxCzmUf1ioujlzO9yAR107Jtaj5QL26p
         FdBJdp3WNQUnxYV1t/7S9I1XdMZkJ32+DrHtX+lPCp08ssX9kEg37VScN2WR4pI4twIN
         DwE8ICXm97FDhNys6w/w5eOc5MTodhzIvEfFI4sVv7ZOPN6o6H+KpVvRNlYirLDoF6ud
         oVYQcpDTsG0mITlgKDumvB+t6mGCwkDrmkilepuOZZCqYtL8ReNYvTFFZxgqnS9TYFIv
         ypSA==
X-Gm-Message-State: AHQUAuZLUc4hn5VgXGedr4wsbACKCRZYWhNqT9yvZpvq2tZ1EPKzGnf7
        lA5dB54gFGA9hSa69TR4l1U=
X-Google-Smtp-Source: AHgI3IZj/GseIu78wPoR51yZNgKKZ1+PWmXGjgVTEqwtadfMaSne4o21po7GtJbpbfy7KQjSsZdPYA==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr322496wrj.320.1550097722567;
        Wed, 13 Feb 2019 14:42:02 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:01 -0800 (PST)
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
Subject: [RFC PATCH v5 02/12] __wr_after_init: linker section and attribute
Date:   Thu, 14 Feb 2019 00:41:31 +0200
Message-Id: <c4c7df22ab55956bd8b0fee8bb38c3f543b478a0.1550097697.git.igor.stoppa@huawei.com>
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

Introduce a linker section and a matching attribute for statically
allocated write rare data. The attribute is named "__wr_after_init".
After the init phase is completed, this section will be modifiable only by
invoking write rare functions.
The section occupies a set of full pages, since the granularity
available for write protection is of one memory page.

The functionality is automatically activated by any architecture that sets
CONFIG_ARCH_HAS_PRMEM

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
 arch/Kconfig                      | 15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h | 25 +++++++++++++++++++++++++
 include/linux/cache.h             | 21 +++++++++++++++++++++
 init/main.c                       |  3 +++
 4 files changed, 64 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..b0b6d176f1c1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -808,6 +808,21 @@ config VMAP_STACK
 	  the stack to map directly to the KASAN shadow map using a formula
 	  that is incorrect if the stack is in vmalloc space.
 
+config ARCH_HAS_PRMEM
+	def_bool n
+	help
+	  architecture specific symbol stating that the architecture provides
+	  a back-end function for the write rare operation.
+
+config PRMEM
+	bool "Write protect critical data that doesn't need high write speed."
+	depends on ARCH_HAS_PRMEM
+	default y
+	help
+	  If the architecture supports it, statically allocated data which
+	  has been selected for hardening becomes (mostly) read-only.
+	  The selection happens by labelling the data "__wr_after_init".
+
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..ddb1fd608490 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -311,6 +311,30 @@
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+/*
+ * Allow architectures to handle wr_after_init data on their
+ * own by defining an empty WR_AFTER_INIT_DATA.
+ * However, it's important that pages containing WR_RARE data do not
+ * hold anything else, to avoid both accidentally unprotecting something
+ * that is supposed to stay read-only all the time and also to protect
+ * something else that is supposed to be writeable all the time.
+ */
+#ifndef WR_AFTER_INIT_DATA
+#ifdef CONFIG_PRMEM
+#define WR_AFTER_INIT_DATA(align)					\
+	. = ALIGN(PAGE_SIZE);						\
+	__start_wr_after_init = .;					\
+	. = ALIGN(align);						\
+	*(.data..wr_after_init)						\
+	. = ALIGN(PAGE_SIZE);						\
+	__end_wr_after_init = .;					\
+	. = ALIGN(align);
+#else
+#define WR_AFTER_INIT_DATA(align)					\
+	. = ALIGN(align);
+#endif
+#endif
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -332,6 +356,7 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
+		WR_AFTER_INIT_DATA(align) /* wr after init */	\
 		KEEP(*(__vermagic))	/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..09bd0b9284b6 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -31,6 +31,27 @@
 #define __ro_after_init __attribute__((__section__(".data..ro_after_init")))
 #endif
 
+/*
+ * __wr_after_init is used to mark objects that cannot be modified
+ * directly after init (i.e. after mark_rodata_ro() has been called).
+ * These objects become effectively read-only, from the perspective of
+ * performing a direct write, like a variable assignment.
+ * However, they can be altered through a dedicated function.
+ * It is intended for those objects which are occasionally modified after
+ * init, however they are modified so seldomly, that the extra cost from
+ * the indirect modification is either negligible or worth paying, for the
+ * sake of the protection gained.
+ */
+#ifndef __wr_after_init
+#ifdef CONFIG_PRMEM
+#define __wr_after_init \
+		__attribute__((__section__(".data..wr_after_init")))
+#else
+#define __wr_after_init
+#endif
+#endif
+
+
 #ifndef ____cacheline_aligned
 #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
 #endif
diff --git a/init/main.c b/init/main.c
index c86a1c8f19f4..965e9fbc5452 100644
--- a/init/main.c
+++ b/init/main.c
@@ -496,6 +496,8 @@ void __init __weak thread_stack_cache_init(void)
 
 void __init __weak mem_encrypt_init(void) { }
 
+void __init __weak wr_init(void) { }
+
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
 
@@ -713,6 +715,7 @@ asmlinkage __visible void __init start_kernel(void)
 	cred_init();
 	fork_init();
 	proc_caches_init();
+	wr_init();
 	uts_ns_init();
 	buffer_init();
 	key_init();
-- 
2.19.1

