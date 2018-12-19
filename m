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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E4FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7716B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbfUXW85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeLSVfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:35:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33752 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLSVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so16167442lfc.0;
        Wed, 19 Dec 2018 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=a4GARTJCVW7jLG2/Ght7MRyZWVbd6ovvI1Dj2egfwMc=;
        b=dbfUXW85OwLBh0AWXRb7Rg53FgFGDptikU6zcwkC+hhGhlsvpnutIHcDEd/wtdlKpa
         gX4MH/CHsn+jl14fjNwSWhH36kcHsblgTScMVGeqR/Lgo1ExI/W0l9l7t+8qgqxb6Lxs
         9uLAWe2buKqBOxAkBxX5nLxALwdD06Yl594SWveM3vgTFfO4gUope5PRrGDknnG9XqeE
         Kmdl/DM/nI/lCQDdMxff3p8gPyWkDpLeVtUYmL0tQyKe0KoyjpvtXCaiaDXkpq7YlZ+9
         MRYHuQ5JpqIQdly6QAUrhwsalzo9T7OqVtc0VOq3rEevctvQTMJtK4wivWhqFOt0qfqd
         UJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=a4GARTJCVW7jLG2/Ght7MRyZWVbd6ovvI1Dj2egfwMc=;
        b=H7MkyrbgSZsKACo1K39iCapTkey1skIstdY7Vz4PUaZJUp7ByxDFagvYL7zXNmY1J/
         SzYpHJwJzJS5+o6T/7aHF6NiJrT0cInEjd/BLfVKfqcEOvHofxxCTitCJCzwIByu7m+Z
         X9jNlfu+ijfPq3ZUkoAOtuw4P7iIF7JePeOrjXXLt4yBBnYBWpsyTPtBMG7tGzw1gGvj
         I8WavoUuK0KEGWZM5BDK0MGQwUkpl1NQDJWMq2PJJO1Mo4FlMOmJqSvlxq0PwBwdB+ib
         jfM1Ah/VR30Mk0MVY5QwfdEL8kD7iFLQ/0I4uHSdD6vXgVgkOqOB0C4+jMCyUdtSatEA
         gssw==
X-Gm-Message-State: AA+aEWZIpa+4ajc/ROgK+7B5Cjgyw0WBjly0h8hp6AVeoUhEL03jDr5V
        wJ0OWGMwtsjEr0j02yAee1w=
X-Google-Smtp-Source: AFSGD/VZbcj5I0PidtfgNZ3Lh1artAeHuFU5euFIwEOUPsXo/4L+9qvccqJSpUN7B7uqhIGBhtnvLA==
X-Received: by 2002:a19:cc46:: with SMTP id c67mr13252319lfg.145.1545255249984;
        Wed, 19 Dec 2018 13:34:09 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:09 -0800 (PST)
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
Subject: [PATCH 03/12] __wr_after_init: generic header
Date:   Wed, 19 Dec 2018 23:33:29 +0200
Message-Id: <20181219213338.26619-4-igor.stoppa@huawei.com>
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

The header provides:
- the generic part of the write rare functionality for static data
- the dummy functionality, in case an arch doesn't support write rare or
  the functionality is disabled

The basic functions are:
- wr_memset(): write rare counterpart of memset()
- wr_memcpy(): write rare counterpart of memcpy()
- wr_assign(): write rare counterpart of the assignment ('=') operator
- wr_rcu_assign_pointer(): write rare counterpart of rcu_assign_pointer()

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
 include/linux/prmem.h | 142 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 include/linux/prmem.h

diff --git a/include/linux/prmem.h b/include/linux/prmem.h
new file mode 100644
index 000000000000..7b8f3a054d97
--- /dev/null
+++ b/include/linux/prmem.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * prmem.h: Header for memory protection library
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ *
+ * Support for:
+ * - statically allocated write rare data
+ */
+
+#ifndef _LINUX_PRMEM_H
+#define _LINUX_PRMEM_H
+
+#include <linux/set_memory.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+
+/**
+ * memtst() - test n bytes of the source to match the c value
+ * @p: beginning of the memory to test
+ * @c: byte to compare against
+ * @len: amount of bytes to test
+ *
+ * Returns 0 on success, non-zero otherwise.
+ */
+static inline int memtst(void *p, int c, __kernel_size_t len)
+{
+	__kernel_size_t i;
+
+	for (i = 0; i < len; i++) {
+		u8 d =  *(i + (u8 *)p) - (u8)c;
+
+		if (unlikely(d))
+			return d;
+	}
+	return 0;
+}
+
+
+#ifndef CONFIG_PRMEM
+
+static inline void *wr_memset(void *p, int c, __kernel_size_t len)
+{
+	return memset(p, c, len);
+}
+
+static inline void *wr_memcpy(void *p, const void *q, __kernel_size_t size)
+{
+	return memcpy(p, q, size);
+}
+
+#define wr_assign(var, val)	((var) = (val))
+
+#define wr_rcu_assign_pointer(p, v)	\
+	rcu_assign_pointer(p, v)
+
+#else
+
+/*
+ * If CONFIG_PRMEM is enabled, the ARCH code must provide an
+ * implementation for __wr_op()
+ */
+
+enum wr_op_type {
+	WR_MEMCPY,
+	WR_MEMSET,
+	WR_OPS_NUMBER,
+};
+
+void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
+	      enum wr_op_type op);
+
+/**
+ * wr_memset() - sets n bytes of the destination to the c value
+ * @p: beginning of the memory to write to
+ * @c: byte to replicate
+ * @len: amount of bytes to copy
+ *
+ * Returns true on success, false otherwise.
+ */
+static inline void *wr_memset(void *p, int c, __kernel_size_t len)
+{
+	return __wr_op((unsigned long)p, (unsigned long)c, len, WR_MEMSET);
+}
+
+/**
+ * wr_memcpy() - copyes n bytes from source to destination
+ * @dst: beginning of the memory to write to
+ * @src: beginning of the memory to read from
+ * @n_bytes: amount of bytes to copy
+ *
+ * Returns pointer to the destination
+ */
+static inline void *wr_memcpy(void *p, const void *q, __kernel_size_t size)
+{
+	return __wr_op((unsigned long)p, (unsigned long)q, size, WR_MEMCPY);
+}
+
+/**
+ * wr_assign() - sets a write-rare variable to a specified value
+ * @var: the variable to set
+ * @val: the new value
+ *
+ * Returns: the variable
+ *
+ * Note: it might be possible to optimize this, to use wr_memset in some
+ * cases (maybe with NULL?).
+ */
+
+#define wr_assign(var, val) ({			\
+	typeof(var) tmp = (typeof(var))val;	\
+						\
+	wr_memcpy(&var, &tmp, sizeof(var));	\
+	var;					\
+})
+
+/**
+ * wr_rcu_assign_pointer() - initialize a pointer in rcu mode
+ * @p: the rcu pointer - it MUST be aligned to a machine word
+ * @v: the new value
+ *
+ * Returns the value assigned to the rcu pointer.
+ *
+ * It is provided as macro, to match rcu_assign_pointer()
+ * The rcu_assign_pointer() is implemented as equivalent of:
+ *
+ * smp_mb();
+ * WRITE_ONCE();
+ */
+#define wr_rcu_assign_pointer(p, v) ({	\
+	smp_mb();			\
+	wr_assign(p, v);		\
+	p;				\
+})
+#endif
+#endif
-- 
2.19.1

