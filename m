Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA16ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65AE20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65AE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeIQU3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:15 -0400
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:40990 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbeIQU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 65AAB83FA;
        Mon, 17 Sep 2018 15:01:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lead24_4675dfd14f318
X-Filterd-Recvd-Size: 1920
Received: from joe-laptop.perches.com (mb42736d0.tmodns.net [208.54.39.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 15:01:23 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mpt3sas: Add ioc_<level> logging macros
Date:   Mon, 17 Sep 2018 08:01:08 -0700
Message-Id: <850f37801648df45486d13ff9c11574701f01471.1537183087.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1537183087.git.joe@perches.com>
References: <cover.1537183087.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros can help identify specific logging uses and eventually
perhaps reduce object sizes.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 96dc15e90bd8..941a4faf20be 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -160,6 +160,15 @@ struct mpt3sas_nvme_cmd {
  */
 #define MPT3SAS_FMT			"%s: "
 
+#define ioc_err(ioc, fmt, ...)						\
+	pr_err("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+#define ioc_notice(ioc, fmt, ...)					\
+	pr_notice("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+#define ioc_warn(ioc, fmt, ...)						\
+	pr_warn("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+#define ioc_info(ioc, fmt, ...)						\
+	pr_info("%s: " fmt, (ioc)->name, ##__VA_ARGS__)
+
 /*
  *  WarpDrive Specific Log codes
  */
-- 
2.15.0

