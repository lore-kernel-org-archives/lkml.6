Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98F82184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt9djI+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfBKX2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55624 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfBKX2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so990536wmh.5;
        Mon, 11 Feb 2019 15:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ziJEcxmH0HELRYpJ/Cx0XBIGaICt7y2RQVCxbSTmAUA=;
        b=Tt9djI+4tIxxQ5z9XBIXZPNsKwfr142LlXK+hQ65M9C24x2lFzeG66B1tVAsCYEHD5
         lxkyRPZQ0d7NehS988SjU2aK0I7kZPVft7Vc+W/HY8bQPsWnifAgKghB7n90aodLDrnl
         lVPXX7q9YjeS2ulbNmlLXl6NtFYB5XvJEEgxMNocbquz7/szDVHN5yBdzXWilnSUIWV6
         5lZKYRyJD3C9KP0rHanJWixPBBH9nGwy+o8iMGvBhmhP+XMzEYm2EF0bhpt1taB4s4z5
         8y1TXoBB0V0MwKaVVuakzCSGEEpvjN4D1GunNHN9QYNv1W875CyqAi3osNxWduqQBsDv
         RurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ziJEcxmH0HELRYpJ/Cx0XBIGaICt7y2RQVCxbSTmAUA=;
        b=Qo6D65L0heKrgIIR6QcXBs2aVxSkj0lfj0HmukNXvh2C4XNmZk0sB9nRR2FU9cPsJ8
         0oHl0kzPYIGv+DOCZvO4mYoQLQt2lUmhIhZfTnvZnWSPErjtjS4h8oaI+RF/M7aGdC1G
         NeytCU8BD553i8spvyhSJOACN9s1OFcnfwqqghcyT3jf/N3Mf/1S3EAmc9eWOrtHZlHN
         I3XT1Vxw5HOxS4lXlmD5Y/o5sOzEJCNzLfIs/QmR4N7Om65nwoUUtN3IEmpaNp5HPYbO
         li1345t9RnAO0kBJwtCuobxIolLh9xjfi5YvSaXU/16bLHK//EvWj0tpdTEYVT2FQxOy
         NhIg==
X-Gm-Message-State: AHQUAuZNear/hkBImOBbs2kz0Cc9iv6r4XHBeyLTOTPZqAhLR+SqHXlA
        hlHvoBnGX6nC7QLIkTU+JJg=
X-Google-Smtp-Source: AHgI3IYd7Ah0YVUADfwQ9vu0EMe24Nxeh6S4B8+ipAqvagFO0quTn9x8ysqtHCmL+w/wBQ5gyDPMFA==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr493561wmh.126.1549927694511;
        Mon, 11 Feb 2019 15:28:14 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:13 -0800 (PST)
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
Subject: [RFC PATCH v4 03/12] __wr_after_init: x86_64: randomize mapping offset
Date:   Tue, 12 Feb 2019 01:27:40 +0200
Message-Id: <378ee1e7e4c17e3bf6e49e1fb6c7cd9abd18ccfe.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 specialized way of defining the base address for the alternate
mapping used by write-rare.

Since the kernel address space spans across 64TB and it is mapped into a
used address space of 128TB, the kernel address space can be shifted by a
random offset that is up to 64TB and page aligned.

This is accomplished by providing arch-specific version of the function
__init_wr_base()

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
 arch/x86/mm/Makefile      |  2 ++
 arch/x86/mm/prmem.c (new) | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd6e52f..66652de1e2c7 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_PRMEM)		+= prmem.o
diff --git a/arch/x86/mm/prmem.c b/arch/x86/mm/prmem.c
new file mode 100644
index 000000000000..b04fc03f92fb
--- /dev/null
+++ b/arch/x86/mm/prmem.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * prmem.c: Memory Protection Library - x86_64 backend
+ *
+ * (C) Copyright 2018-2019 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
+
+unsigned long __init __init_wr_base(void)
+{
+	/*
+	 * Place 64TB of kernel address space within 128TB of user address
+	 * space, at a random page aligned offset.
+	 */
+	return (((unsigned long)kaslr_get_random_long("WR Poke")) &
+		PAGE_MASK) % (64 * _BITUL(40));
+}
-- 
2.19.1

