Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8893D22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8893D22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeKMUpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:45:19 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:58869 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732191AbeKMUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:45:19 -0500
X-ASG-Debug-ID: 1542106054-093b7e1e8a18d20001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id aPKaZmfca0eMSDlI (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 13 Nov 2018 18:47:35 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from arch.localdomain (10.64.6.141) by HXTBJIDCEMVIW02.hxtcorp.net
 (10.128.0.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 18:46:58 +0800
From:   Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To:     <robert.moore@intel.com>, <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name support
Date:   Tue, 13 Nov 2018 18:46:23 +0800
X-ASG-Orig-Subj: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name support
Message-ID: <254f789dee7773b938db7a204ca8800db10e4588.1542105349.git.dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.64.6.141]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1542106055
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9239 1.0000 3.4831
X-Barracuda-Spam-Score: 3.48
X-Barracuda-Spam-Status: No, SCORE=3.48 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.61719
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new naming rule is added in acpica version 20180427.
So the dsdt aml code name changes from "AmlCode" to "dsdt_aml_code".

The patch that introduces naming rules is:
https://github.com/acpica/acpica/commit/f9a88a4c1cd020b6a5475d63b29626852a0b5f37

Tested:
ACPICA release version 20180427+.
ARM64: QCOM QDF2400
GCC: 4.8.5 20150623

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 drivers/acpi/Kconfig  |  2 +-
 drivers/acpi/tables.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9705fc986da9..15ab53a52fdc 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -336,7 +336,7 @@ config ACPI_CUSTOM_DSDT_FILE
 	  See Documentation/acpi/dsdt-override.txt
 
 	  Enter the full path name to the file which includes the AmlCode
-	  declaration.
+	  or dsdt_aml_code declaration.
 
 	  If unsure, don't enter a file name.
 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a3d012b08fc5..297020bbaade 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -713,6 +713,9 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 					  table_length);
 }
 
+static void *amlcode __attribute__ ((weakref("AmlCode")));
+static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
+
 acpi_status
 acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table)
@@ -723,8 +726,11 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
 	*new_table = NULL;
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
-	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
-		*new_table = (struct acpi_table_header *)AmlCode;
+	if (!strncmp(existing_table->signature, "DSDT", 4)) {
+		*new_table = (struct acpi_table_header *)&amlcode;
+		if (!(*new_table))
+			*new_table = (struct acpi_table_header *)&dsdt_amlcode;
+	}
 #endif
 	if (*new_table != NULL)
 		acpi_table_taint(existing_table);
-- 
2.18.0

