Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D439ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A03F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A03F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbeGWKbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:31:47 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25501 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388217AbeGWKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:31:46 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42543720"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jul 2018 17:31:13 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id E3EEA4B65105;
        Mon, 23 Jul 2018 17:31:10 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Mon, 23 Jul 2018
 17:31:11 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v4 1/4] x86/boot: Add acpitb.h to help parse acpi tables
Date:   Mon, 23 Jul 2018 17:29:05 +0800
Message-ID: <20180723092908.32656-2-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: E3EEA4B65105.AB944
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to parse ACPI tables, reuse the head file linux/acpi.h,
so that the files in 'compressed' directory can read ACPI table
by including this head file.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpitb.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpitb.h

diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
new file mode 100644
index 000000000000..f8ab6e5b3e06
--- /dev/null
+++ b/arch/x86/boot/compressed/acpitb.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/acpi.h>
+
+#define ACPI_MAX_TABLES                128
+
+/* Function to get ACPI SRAT table pointer. */
+struct acpi_table_header *get_acpi_srat_table(void);
-- 
2.17.1



