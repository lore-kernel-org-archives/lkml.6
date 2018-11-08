Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D88C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C902C2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C902C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKHTtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:49:00 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43720 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbeKHTtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:49:00 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA8A9Cej021141;
        Thu, 8 Nov 2018 04:14:07 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2nm92cgmv4-1;
        Thu, 08 Nov 2018 04:14:06 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 50BE9611C8B8;
        Thu,  8 Nov 2018 04:17:17 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 8 Nov 2018
 10:14:06 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wA8AE55t028949; Thu,
 8 Nov 2018 10:14:05 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH 2/6] regulator: lochnagar: Move driver to binding from DT
Date:   Thu, 8 Nov 2018 10:14:01 +0000
Message-ID: <20181108101405.14062-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811080089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on review comments on the MFD driver, move the child drivers for
the Lochnagar MFD over to binding through device tree.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Mark, I would maybe hold on merging this one until discussions
on this version of the patch chain are done, just incase we
decide to go back to the single DT entry.

Thanks,
Charles

 drivers/regulator/lochnagar-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 182198246479f..d08fe830b39c1 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -222,7 +222,7 @@ static int lochnagar_regulator_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	int ret, i;
 
-	config.dev = lochnagar->dev;
+	config.dev = dev;
 	config.regmap = lochnagar->regmap;
 	config.driver_data = lochnagar;
 
@@ -241,9 +241,15 @@ static int lochnagar_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id lochnagar_of_match[] = {
+	{ .compatible = "cirrus,lochnagar-regulator" },
+	{},
+};
+
 static struct platform_driver lochnagar_regulator_driver = {
 	.driver = {
 		.name = "lochnagar-regulator",
+		.of_match_table = of_match_ptr(lochnagar_of_match),
 	},
 
 	.probe = lochnagar_regulator_probe,
-- 
2.11.0

