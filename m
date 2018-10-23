Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95223C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E892075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtoyO3mZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E892075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeJXGBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33335 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeJXGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so2820304ljz.0;
        Tue, 23 Oct 2018 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=9TeBZENTG4lUlljtOFNGnausIJ9loexqClGDhlY00q0=;
        b=JtoyO3mZ13IGzAbCIgy6S5RYsmImtY6hfg34KQRQ2X3TR1VVri5yBZ/LUjBcD0TzXa
         0s8L1kB/YwwSuVWbA3820PquvwCu3SkJCcO1geuaAaOGfUNh9JAvXkHX3kScSRePUVzs
         LpBgTT1JYuKJ1aT49DAJUFExgxQPahyLwVz4BPku8ogRZBoPGO9RswhALPMjDi8XbttO
         OjGxJeSt7f0J7GWI7q5EdlapOM+CLE2SPmDyplRRclUZ20Yaw/5nyVtaOA6eSk9/RtMb
         rtjjIO80ygFKzuE+VuAYK60mF+XSs2WkRVh4yBh7Fgr9V0xTBNIf9zkz+/Qr1wr90r6X
         Paxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=9TeBZENTG4lUlljtOFNGnausIJ9loexqClGDhlY00q0=;
        b=FpbpxAwKLEmXDfy/uazfjNkN09RAySspZSohBqTcu4iXtmC2aQtKMhDXc/Ra1GDii2
         BHiyx9U6/xtEGzVTYeaRnhcc5BUVHal6lv2MaYdXfk33b37E7oVBSl/N9It92+NVYLIH
         caQApND1Fz3MkJSTTKqsreI+GsrAD0GxVfEpy/ahbLx+3dYv9a84LrASIV3YKq+3b4XA
         LwwVVV+3XQ9IFJOPmIWIWr7k+FhlFN1IAZWKf42BsnHYqugbaxBsDqWVU1plQb+sac1/
         mNb3ZfwbGcWNhB3dyB299lywXOASss2L9VXk/l4BCuBt1o+CsWlskz8q+dx+u8GdxTM0
         sYbg==
X-Gm-Message-State: AGRZ1gKoPdcecuDUbP/fzxSXc4eLBkHDFL0bUAkMBrFEd8luG31rfW98
        Qb79rW9hJOLfVeEiwA0vcPc=
X-Google-Smtp-Source: AJdET5fm/SfTwnUQw/H/6N0AMH3Waqo8igwVte/fLnkcWUycwtZsZmlgduLgWV39YuSoalp0uJ0pjw==
X-Received: by 2002:a2e:84c5:: with SMTP id q5-v6mr5777858ljh.65.1540330564560;
        Tue, 23 Oct 2018 14:36:04 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:03 -0700 (PDT)
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] prmem: shorthands for write rare on common types
Date:   Wed, 24 Oct 2018 00:34:52 +0300
Message-Id: <20181023213504.28905-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrappers around the basic write rare functionality, addressing several
common data types found in the kernel, allowing to specify the new
values through immediates, like constants and defines.

Note:
The list is not complete and could be expanded.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Pavel Tatashin <pasha.tatashin@oracle.com>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 MAINTAINERS                |   1 +
 include/linux/prmemextra.h | 133 +++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 include/linux/prmemextra.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e566c5d09faf..df7221eca160 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9459,6 +9459,7 @@ M:	Igor Stoppa <igor.stoppa@gmail.com>
 L:	kernel-hardening@lists.openwall.com
 S:	Maintained
 F:	include/linux/prmem.h
+F:	include/linux/prmemextra.h
 F:	mm/prmem.c
 
 MEMORY MANAGEMENT
diff --git a/include/linux/prmemextra.h b/include/linux/prmemextra.h
new file mode 100644
index 000000000000..36995717720e
--- /dev/null
+++ b/include/linux/prmemextra.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * prmemextra.h: Shorthands for write rare of basic data types
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ *
+ */
+
+#ifndef _LINUX_PRMEMEXTRA_H
+#define _LINUX_PRMEMEXTRA_H
+
+#include <linux/prmem.h>
+
+/**
+ * wr_char - alters a char in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_char(const char *dst, const char val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_short - alters a short in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_short(const short *dst, const short val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_ushort - alters an unsigned short in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_ushort(const unsigned short *dst, const unsigned short val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_int - alters an int in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_int(const int *dst, const int val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_uint - alters an unsigned int in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_uint(const unsigned int *dst, const unsigned int val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_long - alters a long in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_long(const long *dst, const long val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_ulong - alters an unsigned long in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_ulong(const unsigned long *dst, const unsigned long val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_longlong - alters a long long in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_longlong(const long long *dst, const long long val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+/**
+ * wr_ulonglong - alters an unsigned long long in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_ulonglong(const unsigned long long *dst,
+			  const unsigned long long val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+
+#endif
-- 
2.17.1

