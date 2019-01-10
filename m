Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E27C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF312173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfAJNt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:49:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:62999 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728810AbfAJNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:24 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADgDuf012608;
        Thu, 10 Jan 2019 14:49:21 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ptt12b5yb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:49:21 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5829734;
        Thu, 10 Jan 2019 13:49:20 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 398E3504D;
        Thu, 10 Jan 2019 13:49:20 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:49:19 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:49:18
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 1/7] remoteproc: correct rproc_mem_entry_init() comments
Date:   Thu, 10 Jan 2019 14:49:05 +0100
Message-ID: <1547128151-44077-2-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
References: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add alloc parameter description and correct comment
about release one.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 54ec38fc5dca..c1a66e25b173 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -900,7 +900,8 @@ EXPORT_SYMBOL(rproc_add_carveout);
  * @dma: dma address
  * @len: memory carveout length
  * @da: device address
- * @release: memory carveout function
+ * @alloc: memory carveout allocation function
+ * @release: memory carveout release function
  * @name: carveout name
  *
  * This function allocates a rproc_mem_entry struct and fill it with parameters
-- 
2.7.4

