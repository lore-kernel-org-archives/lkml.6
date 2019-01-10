Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8803520685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfAJPjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:39:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:30770 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfAJPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:38:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 07:38:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="309300506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2019 07:38:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3CBE8E3; Thu, 10 Jan 2019 17:38:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] APEI / ERST: Switch to use new generic UUID API
Date:   Thu, 10 Jan 2019 17:38:55 +0200
Message-Id: <20190110153855.47180-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/apei/erst.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 9953e50667ec..389d88e35ffb 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -938,17 +938,17 @@ static struct pstore_info erst_info = {
 };
 
 #define CPER_CREATOR_PSTORE						\
-	UUID_LE(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		0x64, 0x90, 0xb8, 0x9d)
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
 #define CPER_SECTION_TYPE_DMESG						\
-	UUID_LE(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
-		0x94, 0x19, 0xeb, 0x12)
+	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
+		  0x94, 0x19, 0xeb, 0x12)
 #define CPER_SECTION_TYPE_DMESG_Z					\
-	UUID_LE(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
-		0x34, 0xdd, 0xfa, 0xc6)
+	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
+		  0x34, 0xdd, 0xfa, 0xc6)
 #define CPER_SECTION_TYPE_MCE						\
-	UUID_LE(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		0x04, 0x4a, 0x38, 0xfc)
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
 
 struct cper_pstore_record {
 	struct cper_record_header hdr;
@@ -1012,7 +1012,7 @@ static ssize_t erst_reader(struct pstore_record *record)
 		rc = -EIO;
 		goto out;
 	}
-	if (uuid_le_cmp(rcd->hdr.creator_id, CPER_CREATOR_PSTORE) != 0)
+	if (!guid_equal(&rcd->hdr.creator_id, &CPER_CREATOR_PSTORE))
 		goto skip;
 
 	record->buf = kmalloc(len, GFP_KERNEL);
@@ -1024,15 +1024,12 @@ static ssize_t erst_reader(struct pstore_record *record)
 	record->id = record_id;
 	record->compressed = false;
 	record->ecc_notice_size = 0;
-	if (uuid_le_cmp(rcd->sec_hdr.section_type,
-			CPER_SECTION_TYPE_DMESG_Z) == 0) {
+	if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_DMESG_Z)) {
 		record->type = PSTORE_TYPE_DMESG;
 		record->compressed = true;
-	} else if (uuid_le_cmp(rcd->sec_hdr.section_type,
-			CPER_SECTION_TYPE_DMESG) == 0)
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_DMESG))
 		record->type = PSTORE_TYPE_DMESG;
-	else if (uuid_le_cmp(rcd->sec_hdr.section_type,
-			     CPER_SECTION_TYPE_MCE) == 0)
+	else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SECTION_TYPE_MCE))
 		record->type = PSTORE_TYPE_MCE;
 	else
 		record->type = PSTORE_TYPE_MAX;
-- 
2.20.1

