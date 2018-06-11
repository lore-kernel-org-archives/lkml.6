Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SuypAf9FHlvaeAAAmS7hNA
	; Mon, 11 Jun 2018 09:50:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EA3A3607E4; Mon, 11 Jun 2018 09:50:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F08D60385;
	Mon, 11 Jun 2018 09:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F08D60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeFKJux (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:50:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5591 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932453AbeFKJuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:50:51 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5B9nZst008531;
        Mon, 11 Jun 2018 11:50:17 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jg4bwga54-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 11:50:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70FF031;
        Mon, 11 Jun 2018 09:50:16 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F7C724DC;
        Mon, 11 Jun 2018 09:50:16 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun
 2018 11:50:16 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun 2018 11:50:15
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
Subject: [PATCH] media: stm32-dcmi: code cleanup
Date: Mon, 11 Jun 2018 11:50:09 +0200
Message-ID: <1528710609-8501-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor non-functional fixes around comments, variable namings
and trace point enhancement.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index c55e6b5..b796334 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -249,13 +249,12 @@ static int dcmi_restart_capture(struct stm32_dcmi *dcmi)
 static void dcmi_dma_callback(void *param)
 {
 	struct stm32_dcmi *dcmi = (struct stm32_dcmi *)param;
-	struct dma_chan *chan = dcmi->dma_chan;
 	struct dma_tx_state state;
 	enum dma_status status;
 	struct dcmi_buf *buf = dcmi->active;
 
 	/* Check DMA status */
-	status = dmaengine_tx_status(chan, dcmi->dma_cookie, &state);
+	status = dmaengine_tx_status(dcmi->dma_chan, dcmi->dma_cookie, &state);
 
 	switch (status) {
 	case DMA_IN_PROGRESS:
@@ -309,10 +308,11 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 	/* Prepare a DMA transaction */
 	desc = dmaengine_prep_slave_single(dcmi->dma_chan, buf->paddr,
 					   buf->size,
-					   DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+					   DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT);
 	if (!desc) {
-		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_single failed for buffer size %zu\n",
-			__func__, buf->size);
+		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_single failed for buffer phy=%pad size=%zu\n",
+			__func__, &buf->paddr, buf->size);
 		return -EINVAL;
 	}
 
@@ -378,7 +378,6 @@ static void dcmi_process_jpeg(struct stm32_dcmi *dcmi)
 {
 	struct dma_tx_state state;
 	enum dma_status status;
-	struct dma_chan *chan = dcmi->dma_chan;
 	struct dcmi_buf *buf = dcmi->active;
 
 	if (!buf)
@@ -386,8 +385,7 @@ static void dcmi_process_jpeg(struct stm32_dcmi *dcmi)
 
 	/*
 	 * Because of variable JPEG buffer size sent by sensor,
-	 * DMA transfer never completes due to transfer size
-	 * never reached.
+	 * DMA transfer never completes due to transfer size never reached.
 	 * In order to ensure that all the JPEG data are transferred
 	 * in active buffer memory, DMA is drained.
 	 * Then DMA tx status gives the amount of data transferred
@@ -396,10 +394,10 @@ static void dcmi_process_jpeg(struct stm32_dcmi *dcmi)
 	 */
 
 	/* Drain DMA */
-	dmaengine_synchronize(chan);
+	dmaengine_synchronize(dcmi->dma_chan);
 
 	/* Get DMA residue to get JPEG size */
-	status = dmaengine_tx_status(chan, dcmi->dma_cookie, &state);
+	status = dmaengine_tx_status(dcmi->dma_chan, dcmi->dma_cookie, &state);
 	if (status != DMA_ERROR && state.residue < buf->size) {
 		/* Return JPEG buffer to V4L2 with received JPEG buffer size */
 		dcmi_buffer_done(dcmi, buf, buf->size - state.residue, 0);
-- 
1.9.1
