Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x3z5N+JDHlvfdgAAmS7hNA
	; Mon, 11 Jun 2018 09:41:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6F554608B8; Mon, 11 Jun 2018 09:41:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E593F608CD;
	Mon, 11 Jun 2018 09:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E593F608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932752AbeFKJly (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:41:54 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932375AbeFKJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:41:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5B9dIZT001743;
        Mon, 11 Jun 2018 11:41:33 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jg4bwg913-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 11:41:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E37783F;
        Mon, 11 Jun 2018 09:41:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9B5724AE;
        Mon, 11 Jun 2018 09:41:32 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun
 2018 11:41:32 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun 2018 11:41:31
 +0200
From: Hugues Fruchet <hugues.fruchet@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
CC: <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>
Subject: [PATCH] media: stm32-dcmi: increase max width/height to 2592
Date: Mon, 11 Jun 2018 11:41:19 +0200
Message-ID: <1528710079-7944-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DCMI can capture 5Mp raw frames, increase limit accordingly.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 68da9ec..c55e6b5 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -90,14 +90,9 @@ enum state {
 };
 
 #define MIN_WIDTH	16U
-#define MAX_WIDTH	2048U
+#define MAX_WIDTH	2592U
 #define MIN_HEIGHT	16U
-#define MAX_HEIGHT	2048U
-
-#define MIN_JPEG_WIDTH	16U
-#define MAX_JPEG_WIDTH	2592U
-#define MIN_JPEG_HEIGHT	16U
-#define MAX_JPEG_HEIGHT	2592U
+#define MAX_HEIGHT	2592U
 
 #define TIMEOUT_MS	1000
 
@@ -844,14 +839,8 @@ static int dcmi_try_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f,
 	}
 
 	/* Limit to hardware capabilities */
-	if (pix->pixelformat == V4L2_PIX_FMT_JPEG) {
-		pix->width = clamp(pix->width, MIN_JPEG_WIDTH, MAX_JPEG_WIDTH);
-		pix->height =
-			clamp(pix->height, MIN_JPEG_HEIGHT, MAX_JPEG_HEIGHT);
-	} else {
-		pix->width = clamp(pix->width, MIN_WIDTH, MAX_WIDTH);
-		pix->height = clamp(pix->height, MIN_HEIGHT, MAX_HEIGHT);
-	}
+	pix->width = clamp(pix->width, MIN_WIDTH, MAX_WIDTH);
+	pix->height = clamp(pix->height, MIN_HEIGHT, MAX_HEIGHT);
 
 	/* No crop if JPEG is requested */
 	do_crop = dcmi->do_crop && (pix->pixelformat != V4L2_PIX_FMT_JPEG);
-- 
1.9.1
