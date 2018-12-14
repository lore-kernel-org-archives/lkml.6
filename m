Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E598B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbeLNOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:39:23 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59030 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730159AbeLNOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:39:22 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBEEdKFK031212;
        Fri, 14 Dec 2018 08:39:20 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2pc7y5gvmy-1;
        Fri, 14 Dec 2018 08:39:20 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 4B7D9611C8B3;
        Fri, 14 Dec 2018 08:39:15 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Dec 2018
 14:39:14 +0000
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.142])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wBEEdESC027957;        Fri, 14 Dec 2018 14:39:14 GMT
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] mfd: madera: Remove spurious semicolon in while loop
Date:   Fri, 14 Dec 2018 14:39:14 +0000
Message-ID: <20181214143914.24393-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=859 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812140130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle warning of a spurious semicolon on the closing brace
of a while loop.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 5b58a8aea902..2a77988d0462 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -154,11 +154,11 @@ static int madera_wait_for_boot(struct madera *madera)
 	while (!(val & MADERA_BOOT_DONE_STS1) &&
 	       !ktime_after(ktime_get(), timeout)) {
 		usleep_range(MADERA_BOOT_POLL_INTERVAL_USEC / 2,
 			     MADERA_BOOT_POLL_INTERVAL_USEC);
 		regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
-	};
+	}
 
 	if (!(val & MADERA_BOOT_DONE_STS1)) {
 		dev_err(madera->dev, "Polling BOOT_DONE_STS timed out\n");
 		ret = -ETIMEDOUT;
 	}
-- 
2.11.0

