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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C6E2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECXYO49y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbeLSVeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44904 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbeLSVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so16126729lfe.11;
        Wed, 19 Dec 2018 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=scWZE0nWnwTd+0FVwhDij4gwRZDyVIgA4bUgU9jm4Qw=;
        b=ECXYO49yQdsxme7Jgttlgkk1OXF/pQaB16kIMgz5hObs81P2rf53rdtsbq9vuqLTnT
         jX7gpNLiv7n2ncpWcBw+TV1SPHoghJKVMmyBOzVunlBAW61kLMpZr1w3iqUXJQoeIKEd
         brnyV5ix2RB7j3HEu34jkYRtexvm/NhrNxTfEAvkekM6qgJOc/YlTSrGbQY/Vl1JRFjx
         vUOH/DytpLM810A0HmxqVAf2g4zZX/YJL1WbFzWl0Mg2GTodhUeSoi+UJUiQ/AAA4RPC
         Jbrz4ug0xFFizcuiOeNzDKdpaBPg6nJAXr8izbvHwNWU2BmKHoXdLtFkNMw7Vc0D9izd
         VsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=scWZE0nWnwTd+0FVwhDij4gwRZDyVIgA4bUgU9jm4Qw=;
        b=dq6Fd/u/VGTRLsrw4pbeUsqaEMY2gsbj80DP8HOEwUfUq3fNI5yZbGJS/pQl8oOBQ9
         CeY0/AQ+k7vTV4rLMgfPQPXvEU7FtN+1Yb44U5wVkMIU/xN1g8QjtoL3QzK6lToHk4MI
         V43H0SkAiXtax1Il0CNR6+UB2/ZDoLitmxXxtGSKbGzpUlXGJvHpTmo5DwKuGN6USHPZ
         ZecU2d88eyQ3dIFHfFzMOVLAh7Dqak1wt2/+86TQ3wj5oXXAy+4j6W+o0yNI7nCFXpC5
         8/hv7He5KyDpqDt1Kt4ZO6MQx8PFLQjoqmmzlbGTaPZFt0Zwl4ANeExYrUt/VIvhkJga
         2+Mg==
X-Gm-Message-State: AA+aEWYYhjN/VsZpsQbis81wb5oHY/QxAO8+DAHm9lxOeLdZQY6/SaXC
        GS9gC7lbeIrlbEid5kUmA2g=
X-Google-Smtp-Source: AFSGD/UUnkuvBJtrj64z76vEVRzpp/gNTMhY363jcuYcBn4wBrr23AJH+tdTR+9OboCCOslwcSXVpw==
X-Received: by 2002:a19:2906:: with SMTP id p6mr5307891lfp.17.1545255248175;
        Wed, 19 Dec 2018 13:34:08 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:07 -0800 (PST)
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
Subject: [PATCH 02/12] __wr_after_init: linker section and label
Date:   Wed, 19 Dec 2018 23:33:28 +0200
Message-Id: <20181219213338.26619-3-igor.stoppa@huawei.com>
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

Introduce a section and a label for statically allocated write rare
data. The label is named "__wr_after_init".
As the name implies, after the init phase is completed, this section
will be modifiable only by invoking write rare functions.
The section must take up a set of full pages.

To activate both section and label, the arch must set CONFIG_ARCH_HAS_PRMEM

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
 arch/Kconfig                      | 15 +++++++++++++++
 include/asm-generic/vmlinux.lds.h | 25 +++++++++++++++++++++++++
 include/linux/cache.h             | 21 +++++++++++++++++++++
 init/main.c                       |  2 ++
 4 files changed, 63 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index e1e540ffa979..8668ffec8098 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -802,6 +802,21 @@ config VMAP_STACK
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
index a461150adfb1..a36f2e54f937 100644
--- a/init/main.c
+++ b/init/main.c
@@ -498,6 +498,7 @@ void __init __weak thread_stack_cache_init(void)
 void __init __weak mem_encrypt_init(void) { }
 
 void __init __weak poking_init(void) { }
+void __init __weak wr_poking_init(void) { }
 
 bool initcall_debug;
 core_param(initcall_debug, initcall_debug, bool, 0644);
@@ -734,6 +735,7 @@ asmlinkage __visible void __init start_kernel(void)
 	delayacct_init();
 
 	poking_init();
+	wr_poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
-- 
2.19.1

