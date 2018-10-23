Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDA5C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691182075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8qUCIMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691182075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeJXGBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34853 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbeJXGBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so2815408ljj.2;
        Tue, 23 Oct 2018 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=8LbEKOKWe/FiMlUHhmCc7voGh1W3EYnicEfE4r2R4yA=;
        b=N8qUCIMyIvLATq4CE5wE0uPw31UaGBnKbzEM90Hb/Wj5TI1WQujrJdzbDP0qxRobgM
         ZCoMs/0ZzA4kG0cqvysWLv8m1q0Btspo1GbzYx1YZcfwsBvBLB347lafqVcLjNpuD7uh
         xNIhdaCGy21A02rCV1tCtVf8Qt9OVwhnyCylb8Rw+Qqs4nwLso7hSHPYpkPb2fncfVfs
         LOb4TQscLGzNtufTiVOunV6qW8ZGAQJeeXOSVZhjwVyf+ji2DRIiXWzgsXSlLdIPe+bb
         VhYGtK5SvxmDKoY1xlMKrg9FwOYZUbMyGD6luSZZPCqmzYSTidxTHU/+LpYhnSh1CdwT
         PDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=8LbEKOKWe/FiMlUHhmCc7voGh1W3EYnicEfE4r2R4yA=;
        b=CQEJqKtQihCqiiu6m6qXvlOCdDyNenTWFTLUWWK0fR/pQprrwiHKyh4EuI5QDry1iC
         /oaD33JNnIXy0WRf4GwL2D6nDttT9UEaTWQiYo37ltJ1MMadXD1Ba68qQ3iDBXI/DqKE
         T2dN08w/mZL3tjmmwqz0pzWe5xCzmU9vpW5YcC4j2YlSrKW+Uv9eWI578grcqdRjfkAA
         xrk/gZy4+B9VArmWzzhJOZaiEeqTL8gxLoeX0eiBg4BMFvl1KQAzJGVF6FQIRyO5pwpF
         gvGQp3IxjK+Hdlfa66nTNT6W+mKgyrmk6sroRv4h8QMmkhS0NDYJGx/ASON4cX/Fu/FR
         L7sQ==
X-Gm-Message-State: ABuFfojyyXkLoC1sHqKN2nf9a1hNihnZGb/zAtluJ/gxTRbmIcHQR4IC
        e4+fV8kyDFMnFY8K4mDfYyY=
X-Google-Smtp-Source: ACcGV60VSV41bEasnudRwceqLHq3cQn21dkmbWSOYeDgxo5mc3i8TMNkXsnfHZ82wYQ9h6vmAtB3yg==
X-Received: by 2002:a2e:80d2:: with SMTP id r18-v6mr37260197ljg.100.1540330580535;
        Tue, 23 Oct 2018 14:36:20 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:20 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] prmem: pratomic-long
Date:   Wed, 24 Oct 2018 00:35:03 +0300
Message-Id: <20181023213504.28905-17-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimalistic functionality for having the write rare version of
atomic_long_t data.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-arch@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 MAINTAINERS                   |  1 +
 include/linux/pratomic-long.h | 73 +++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 include/linux/pratomic-long.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e7f7cb1682a6..9d72688d00a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9466,6 +9466,7 @@ F:	mm/test_pmalloc.c
 F:	Documentation/core-api/prmem.rst
 F:	include/linux/prlist.h
 F:	lib/test_prlist.c
+F:	include/linux/pratomic-long.h
 
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
diff --git a/include/linux/pratomic-long.h b/include/linux/pratomic-long.h
new file mode 100644
index 000000000000..8f1408593733
--- /dev/null
+++ b/include/linux/pratomic-long.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Atomic operations for write rare memory */
+#ifndef _LINUX_PRATOMIC_LONG_H
+#define _LINUX_PRATOMIC_LONG_H
+#include <linux/prmem.h>
+#include <linux/compiler.h>
+#include <asm-generic/atomic-long.h>
+
+struct pratomic_long_t {
+	atomic_long_t l __aligned(sizeof(atomic_long_t));
+} __aligned(sizeof(atomic_long_t));
+
+#define PRATOMIC_LONG_INIT(i)	{	\
+	.l = ATOMIC_LONG_INIT((i)),	\
+}
+
+static __always_inline
+bool __pratomic_long_op(bool inc, struct pratomic_long_t *l)
+{
+	struct page *page;
+	uintptr_t base;
+	uintptr_t offset;
+	unsigned long flags;
+	size_t size = sizeof(*l);
+	bool is_virt = __is_wr_after_init(l, size);
+
+	if (WARN(!(is_virt || likely(__is_wr_pool(l, size))),
+		 WR_ERR_RANGE_MSG))
+		return false;
+	local_irq_save(flags);
+	if (is_virt)
+		page = virt_to_page(l);
+	else
+		vmalloc_to_page(l);
+	offset = (~PAGE_MASK) & (uintptr_t)l;
+	base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
+	if (WARN(!base, WR_ERR_PAGE_MSG)) {
+		local_irq_restore(flags);
+		return false;
+	}
+	if (inc)
+		atomic_long_inc((atomic_long_t *)(base + offset));
+	else
+		atomic_long_dec((atomic_long_t *)(base + offset));
+	vunmap((void *)base);
+	local_irq_restore(flags);
+	return true;
+
+}
+
+/**
+ * pratomic_long_inc - atomic increment of rare write long
+ * @l: address of the variable of type struct pratomic_long_t
+ *
+ * Return: true on success, false otherwise
+ */
+static __always_inline bool pratomic_long_inc(struct pratomic_long_t *l)
+{
+	return __pratomic_long_op(true, l);
+}
+
+/**
+ * pratomic_long_inc - atomic decrement of rare write long
+ * @l: address of the variable of type struct pratomic_long_t
+ *
+ * Return: true on success, false otherwise
+ */
+static __always_inline bool pratomic_long_dec(struct pratomic_long_t *l)
+{
+	return __pratomic_long_op(false, l);
+}
+
+#endif
-- 
2.17.1

