Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC3E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbeHGLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:21:54 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49308 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727155AbeHGLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:21:54 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7793gTt005456;
        Tue, 7 Aug 2018 04:08:30 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2kn8jkunsa-1;
        Tue, 07 Aug 2018 04:08:29 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id E1996611C8BB;
        Tue,  7 Aug 2018 04:10:10 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 7 Aug 2018
 10:08:29 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7798SXs005072;        Tue, 7 Aug 2018 10:08:28 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] mfd: madera: Add register definitions for accessory detect
Date:   Tue, 7 Aug 2018 10:08:12 +0100
Message-ID: <20180807090813.15695-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=415 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808070093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some register definitions for accessory detection, used
by the extcon driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/linux/mfd/madera/registers.h | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linux/mfd/madera/registers.h b/include/linux/mfd/madera/registers.h
index a6b7c4222c5e..977e06101711 100644
--- a/include/linux/mfd/madera/registers.h
+++ b/include/linux/mfd/madera/registers.h
@@ -1219,9 +1219,11 @@
 #define MADERA_IRQ1_STATUS_33				0x1820
 #define MADERA_IRQ1_MASK_1				0x1840
 #define MADERA_IRQ1_MASK_2				0x1841
+#define MADERA_IRQ1_MASK_6				0x1845
 #define MADERA_IRQ1_MASK_33				0x1860
 #define MADERA_IRQ1_RAW_STATUS_1			0x1880
 #define MADERA_IRQ1_RAW_STATUS_2			0x1881
+#define MADERA_IRQ1_RAW_STATUS_7			0x1886
 #define MADERA_IRQ1_RAW_STATUS_15			0x188E
 #define MADERA_IRQ1_RAW_STATUS_33			0x18A0
 #define MADERA_INTERRUPT_DEBOUNCE_7			0x1A06
@@ -1664,6 +1666,42 @@
 #define MADERA_MICB2A_ENA_SHIFT				     0
 #define MADERA_MICB2A_ENA_WIDTH				     1
 
+/* (0x0225) - HP Ctrl 1L */
+#define MADERA_RMV_SHRT_HP1L				0x4000
+#define MADERA_RMV_SHRT_HP1L_MASK			0x4000
+#define MADERA_RMV_SHRT_HP1L_SHIFT			    14
+#define MADERA_RMV_SHRT_HP1L_WIDTH			     1
+#define MADERA_HP1L_FLWR				0x0004
+#define MADERA_HP1L_FLWR_MASK				0x0004
+#define MADERA_HP1L_FLWR_SHIFT				     2
+#define MADERA_HP1L_FLWR_WIDTH				     1
+#define MADERA_HP1L_SHRTI				0x0002
+#define MADERA_HP1L_SHRTI_MASK				0x0002
+#define MADERA_HP1L_SHRTI_SHIFT				     1
+#define MADERA_HP1L_SHRTI_WIDTH				     1
+#define MADERA_HP1L_SHRTO				0x0001
+#define MADERA_HP1L_SHRTO_MASK				0x0001
+#define MADERA_HP1L_SHRTO_SHIFT				     0
+#define MADERA_HP1L_SHRTO_WIDTH				     1
+
+/* (0x0226) - HP Ctrl 1R */
+#define MADERA_RMV_SHRT_HP1R				0x4000
+#define MADERA_RMV_SHRT_HP1R_MASK			0x4000
+#define MADERA_RMV_SHRT_HP1R_SHIFT			    14
+#define MADERA_RMV_SHRT_HP1R_WIDTH			     1
+#define MADERA_HP1R_FLWR				0x0004
+#define MADERA_HP1R_FLWR_MASK				0x0004
+#define MADERA_HP1R_FLWR_SHIFT				     2
+#define MADERA_HP1R_FLWR_WIDTH				     1
+#define MADERA_HP1R_SHRTI				0x0002
+#define MADERA_HP1R_SHRTI_MASK				0x0002
+#define MADERA_HP1R_SHRTI_SHIFT				     1
+#define MADERA_HP1R_SHRTI_WIDTH				     1
+#define MADERA_HP1R_SHRTO				0x0001
+#define MADERA_HP1R_SHRTO_MASK				0x0001
+#define MADERA_HP1R_SHRTO_SHIFT				     0
+#define MADERA_HP1R_SHRTO_WIDTH				     1
+
 /* (0x0293)  Accessory_Detect_Mode_1 */
 #define MADERA_ACCDET_SRC				0x2000
 #define MADERA_ACCDET_SRC_MASK				0x2000
@@ -3766,6 +3804,19 @@
 #define MADERA_DSP1_BUS_ERR_EINT1_SHIFT			     0
 #define MADERA_DSP1_BUS_ERR_EINT1_WIDTH			     1
 
+/* (0x1845)  IRQ1_Mask_6 */
+#define MADERA_IM_MICDET2_EINT1				0x0200
+#define MADERA_IM_MICDET2_EINT1_MASK			0x0200
+#define MADERA_IM_MICDET2_EINT1_SHIFT			     9
+#define MADERA_IM_MICDET2_EINT1_WIDTH			     1
+#define MADERA_IM_MICDET1_EINT1				0x0100
+#define MADERA_IM_MICDET1_EINT1_MASK			0x0100
+#define MADERA_IM_MICDET1_EINT1_SHIFT			     8
+#define MADERA_IM_MICDET1_EINT1_WIDTH			     1
+#define MADERA_IM_HPDET_EINT1				0x0001
+#define MADERA_IM_HPDET_EINT1_MASK			0x0001
+#define MADERA_IM_HPDET_EINT1_SHIFT			     0
+#define MADERA_IM_HPDET_EINT1_WIDTH			     1
 /* (0x184E)  IRQ1_Mask_15 */
 #define MADERA_IM_SPK_OVERHEAT_WARN_EINT1		0x0004
 #define MADERA_IM_SPK_OVERHEAT_WARN_EINT1_MASK		0x0004
-- 
2.11.0

