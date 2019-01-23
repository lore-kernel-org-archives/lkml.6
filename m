Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD4CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BD121019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AtGo2odd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWXHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:07:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfAWXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:07:15 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NN0Bm6028150
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:07:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=iIazPrlt7tOWnA4QOJ1iZhFr3bvbXxhMyXLj+/1AyVo=;
 b=AtGo2oddJtBfGaHVrMHnXcRqotFi4HNVwUh21Avcd03wvNjj59JfPn/fMCmBTVO/Z6hi
 wqNB2xlfeGvUSI06D3lfq4P56cmkDf0vOQcdjeKIe9nK0UEBV0ewszB4/YvXYIQskYcV
 gLq+81zWN6rBlX/e6ofhdScTgPo8mRZrxA4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q700arah0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:07:14 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 23 Jan 2019 15:06:38 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 48A96861B012; Wed, 23 Jan 2019 15:06:36 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Date:   Wed, 23 Jan 2019 15:06:34 -0800
Message-ID: <20190123230634.1815021-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected some of return values with appropriate meanings.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
index 332210e06e98..97ae341109d5 100644
--- a/drivers/misc/aspeed-lpc-ctrl.c
+++ b/drivers/misc/aspeed-lpc-ctrl.c
@@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 		unsigned long param)
 {
 	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
-	struct device *dev = file->private_data;
 	void __user *p = (void __user *)param;
 	struct aspeed_lpc_ctrl_mapping map;
 	u32 addr;
@@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 
 		/* If memory-region is not described in device tree */
 		if (!lpc_ctrl->mem_size) {
-			dev_err(dev, "Didn't find reserved memory\n");
-			return -EINVAL;
+			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");
+			return -ENXIO;
 		}
 
 		map.size = lpc_ctrl->mem_size;
@@ -134,16 +133,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 
 		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
 			if (!lpc_ctrl->pnor_size) {
-				dev_err(dev, "Didn't find host pnor flash\n");
-				return -EINVAL;
+				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find host pnor flash\n");
+				return -ENXIO;
 			}
 			addr = lpc_ctrl->pnor_base;
 			size = lpc_ctrl->pnor_size;
 		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
 			/* If memory-region is not described in device tree */
 			if (!lpc_ctrl->mem_size) {
-				dev_err(dev, "Didn't find reserved memory\n");
-				return -EINVAL;
+				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");
+				return -ENXIO;
 			}
 			addr = lpc_ctrl->mem_base;
 			size = lpc_ctrl->mem_size;
@@ -239,7 +238,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		of_node_put(node);
 		if (rc) {
 			dev_err(dev, "Couldn't address to resource for reserved memory\n");
-			return -ENOMEM;
+			return -ENXIO;
 		}
 
 		lpc_ctrl->mem_size = resource_size(&resm);
-- 
2.17.1

