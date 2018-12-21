Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B390D21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/bllgwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404322AbeLUSOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:14:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391232AbeLUSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:14:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so5541732ljb.2;
        Fri, 21 Dec 2018 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=02CsOTWqtwZzPMlweM9pS6XE1OnLE/PPqdTJz4OZtoU=;
        b=C/bllgwWcelpTykNWYi39BnaATo8lpq89ch1ugnwfkYPRnVxve0wGvexjuxUPMzDoo
         5Jpl5b0JUZ4ZL/39R1AR2j4X3k6ukiq9RlxTBcEzcGXXAV++v3Za4nKsdMqOIzA9BnLM
         FYYV6EhXu7gS7jQm20h6QR7xCxqPqLFD8gIyXunzOdhwh2+LhS6sZVyX0ahZHFfkn3Xw
         sGSbMTE95/rO31tGYeJBOFMCsqpicf6WF5vlojY4Bfno1gSEaX5smNWCKjXFGXXiAutn
         S0s+m5efoXLUf0pB106ZUBJIrPyvf1cnpu48uQJzohHGLMXY7JXthKhEMa1N9dvbpmSr
         FT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=02CsOTWqtwZzPMlweM9pS6XE1OnLE/PPqdTJz4OZtoU=;
        b=LOFpI9VSccT71W1EYeyqdijWvWPi3qIjpjuWqd1yBjnVpGZ+t9UFoChGTykeausqUd
         8xOW1QgZKQi0DkCmkSjjSIEQczlMRtPAQfTvuYsu5sFPcTr4Ia0d3SRIWGtgYPfFey/T
         Bk3JbtotXrB4slTNks2MSpjyjG2DP4lzWVdIiiKDYR0KQT9S5V6a5EkZ5QJJPZ/6qMQI
         eI1vXG8tfjBhwSG73GZK2qO11NH1pj82bGD7RzMb/888HgVH+Rqw2MyLfrM+kcIPvAXm
         RwmGaSReRbhBLFBj22mWK1WsLnzMfY241Y/cuvAQnUCz1tYmnNMzuqyDkbeYopgew19i
         x7hA==
X-Gm-Message-State: AJcUukezXVaXRd9SR/hhMW5scIYeD9PMRIqmrZoUTLPMTE4ETRmMWYAs
        qFrnbsrBMgQ4pwCa4ZdWe84=
X-Google-Smtp-Source: ALg8bN6ADTRPD4oTDrtkd5En5+bsIvKrP+5XCjbqDTL4+Lh9yRDACXYcUUsznsEdhYFvH6hg+L2VRA==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr2252747ljb.176.1545416088161;
        Fri, 21 Dec 2018 10:14:48 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:14:47 -0800 (PST)
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
Subject: [PATCH 02/12] __wr_after_init: linker section and label
Date:   Fri, 21 Dec 2018 20:14:13 +0200
Message-Id: <20181221181423.20455-3-igor.stoppa@huawei.com>
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

