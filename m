Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9452C23E47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9452C23E47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeGFMiy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:38:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3295 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933286AbeGFMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:38:51 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w66CTPWH014129;
        Fri, 6 Jul 2018 14:38:48 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k0dnr6eqt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:38:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A48423A;
        Fri,  6 Jul 2018 12:38:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 859B64E04;
        Fri,  6 Jul 2018 12:38:47 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Jul 2018 14:38:47
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/1] remoteproc: st_slim: replace "%p" with "%pK"
Date:   Fri, 6 Jul 2018 14:38:44 +0200
Message-ID: <1530880724-29402-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/st_slim_rproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
index 1ffb1f0..d711d94 100644
--- a/drivers/remoteproc/st_slim_rproc.c
+++ b/drivers/remoteproc/st_slim_rproc.c
@@ -195,7 +195,8 @@ static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 		}
 	}
 
-	dev_dbg(&rproc->dev, "da = 0x%llx len = 0x%x va = 0x%p\n", da, len, va);
+	dev_dbg(&rproc->dev, "da = 0x%llx len = 0x%x va = 0x%pK\n",
+		da, len, va);
 
 	return va;
 }
-- 
1.9.1

