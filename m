Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B408C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCD5222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT0rnd8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395171AbfBMWmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37486 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395147AbfBMWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so4383800wrs.4;
        Wed, 13 Feb 2019 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ziJEcxmH0HELRYpJ/Cx0XBIGaICt7y2RQVCxbSTmAUA=;
        b=AT0rnd8BnDyFyzfZmtZcyeTBEWOmVhTvPmEu5QNum22iV2TcKjKPwLVNWNeagC0CRy
         ctLWeeTYC/+F6/tKvEGXpJEyq+9Yz6bCFYiyBbA3twYThdmj5oAWC32/BvKKUsEGEX7o
         Ld9HklU7c97NPh13SsZ6fCE/5BMVPh9dqK1naXMrYOstuBxbrBxG+SqHXwEloEStPyvR
         ffmv8EeqFFFoGyKtg14GqIYxFVbRpPQFp2z+rCCaXp+qC/Cyh9Zji9wP1jG6KdtLhlYx
         p7hNzJkTQdZOgNlQY/A8FTBEwkpMfs3AiT9jAGZANXbmBbnzIfgztEwbiLzC+FwV2x8J
         VLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ziJEcxmH0HELRYpJ/Cx0XBIGaICt7y2RQVCxbSTmAUA=;
        b=X23Dhvaw4P+Ln+TzVY2QkIdVjOLwETcqmP5tZgrdw8gLUCi0+pkhHytcdSnBRf/26j
         lpuqqUkWkkT5mDLdnMacdOWY5O82NZUC466Jtg85gTs8Vebo1c+Y0ajBXHc1/vNyyb34
         AdZ4DU6pcvTDb7ojVA+NzcruHWNmnMIYxRFOZ3ocGTDlxpwF600ZWPP3atD0VZpeiWC5
         1hVHj/mqaIvmK+YBsaFNT46WkvIVpVudNRSX6bMzM2Ut26BcXaoUfCICpNd+9t0IxAFo
         nppVkrs1MyKzQnkirlcjTPIfnx0/A1fml99UWHXGVTVpULl/dKyQAjmWS0OXn7oXnXKD
         7aXg==
X-Gm-Message-State: AHQUAuZoWeIC3fsAo/vnkG0Ml+DjeRCh7khBJ7yl1gXc1XVl3a6DR/OO
        7jabJgD6VulZxHIMhj20Vjs=
X-Google-Smtp-Source: AHgI3IYtU8/AyDQPgRNLGyOtrkGvf7ehC6WRZeZ6D8zc6PNd3G4s/XlOJrLl2q5Ckle3r/z/jdGkyg==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr285795wrr.93.1550097729690;
        Wed, 13 Feb 2019 14:42:09 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:09 -0800 (PST)
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
Subject: [RFC PATCH v5 04/12] __wr_after_init: x86_64: randomize mapping offset
Date:   Thu, 14 Feb 2019 00:41:33 +0200
Message-Id: <4f3b363bfd20ec0d79a0b066581d72145bb65883.1550097697.git.igor.stoppa@huawei.com>
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

