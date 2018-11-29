Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4907E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4907E21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeK3IX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:23:26 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1359 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbeK3IXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:23:25 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wATL9OHB011927;
        Thu, 29 Nov 2018 22:16:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nxw02wub4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 29 Nov 2018 22:16:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5DA413E2;
        Thu, 29 Nov 2018 22:16:04 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E83E592C;
        Thu, 29 Nov 2018 21:16:33 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov
 2018 22:16:33 +0100
Received: from localhost (10.129.6.191) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov 2018 22:16:32
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/2] remoteproc: replace bool from struct rproc by u8
Date:   Thu, 29 Nov 2018 22:16:19 +0100
Message-ID: <1543526180-55934-2-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543526180-55934-1-git-send-email-loic.pallardy@st.com>
References: <1543526180-55934-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.191]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_13:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Post [1] and checkpatch tool indicate that usage of bool type
in structure is now no more allowed/advised.
This patch replaces bool by unsigned char (u8) and reorders
struct rproc fields to avoid padding.

[1] https://lkml.org/lkml/2017/11/21/384

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 include/linux/remoteproc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 507a2b524208..b6660088949f 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -452,15 +452,15 @@ struct rproc_dump_segment {
  * @index: index of this rproc device
  * @crash_handler: workqueue for handling a crash
  * @crash_cnt: crash counter
- * @recovery_disabled: flag that state if recovery was disabled
  * @max_notifyid: largest allocated notify id.
  * @table_ptr: pointer to the resource table in effect
  * @cached_table: copy of the resource table
  * @table_sz: size of @cached_table
- * @has_iommu: flag to indicate if remote processor is behind an MMU
- * @auto_boot: flag to indicate if remote processor should be auto-started
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
+ * @recovery_disabled: flag that state if recovery was disabled
+ * @has_iommu: flag to indicate if remote processor is behind an MMU
+ * @auto_boot: flag to indicate if remote processor should be auto-started
  */
 struct rproc {
 	struct list_head node;
@@ -485,15 +485,15 @@ struct rproc {
 	int index;
 	struct work_struct crash_handler;
 	unsigned int crash_cnt;
-	bool recovery_disabled;
 	int max_notifyid;
 	struct resource_table *table_ptr;
 	struct resource_table *cached_table;
 	size_t table_sz;
-	bool has_iommu;
-	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	u8 recovery_disabled;
+	u8 has_iommu;
+	u8 auto_boot;
 };
 
 /**
-- 
2.7.4

