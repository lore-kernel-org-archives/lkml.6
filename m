Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D971C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7222089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7222089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJBSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:53:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:19441 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727434AbeJBSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:04 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C8ckb013527;
        Tue, 2 Oct 2018 14:09:43 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6gsk0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:09:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDDB631;
        Tue,  2 Oct 2018 12:09:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC5F02A3C;
        Tue,  2 Oct 2018 12:09:42 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:42 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:09:42 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V4 01/25] mmc: mmci: Change struct members from bool to u8
Date:   Tue, 2 Oct 2018 14:09:03 +0200
Message-ID: <1538482167-13819-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

Recent versions of checkpatch have a new warning based on a documented
preference of Linus to not use bool in structures due to wasted space and
the size of bool is implementation dependent.  For more information, see
the email thread at https://lkml.org/lkml/2017/11/21/384

fix checkpatch --strict issues:
-CHECK: Avoid using bool structure members because of possible alignment
 issues - see: https://lkml.org/lkml/2017/11/21/384
-WARNING: Avoid using bool as bitfield. Prefer bool bitfields as
 unsigned int or u<8|16|32>

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 21aaf9a..01e6c6b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -248,24 +248,24 @@ struct variant_data {
 	unsigned int		data_cmd_enable;
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
-	bool			st_sdio;
-	bool			st_clkdiv;
-	bool			blksz_datactrl16;
-	bool			blksz_datactrl4;
+	u8			st_sdio:1;
+	u8			st_clkdiv:1;
+	u8			blksz_datactrl16:1;
+	u8			blksz_datactrl4:1;
 	u32			pwrreg_powerup;
 	u32			f_max;
-	bool			signal_direction;
-	bool			pwrreg_clkgate;
-	bool			busy_detect;
+	u8			signal_direction:1;
+	u8			pwrreg_clkgate:1;
+	u8			busy_detect:1;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
-	bool			pwrreg_nopower;
-	bool			explicit_mclk_control;
-	bool			qcom_fifo;
-	bool			qcom_dml;
-	bool			reversed_irq_handling;
-	bool			mmcimask1;
+	u8			pwrreg_nopower:1;
+	u8			explicit_mclk_control:1;
+	u8			qcom_fifo:1;
+	u8			qcom_dml:1;
+	u8			reversed_irq_handling:1;
+	u8			mmcimask1:1;
 	u32			start_err;
 	u32			opendrain;
 	void (*init)(struct mmci_host *host);
@@ -290,7 +290,7 @@ struct mmci_host {
 	struct mmc_data		*data;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
-	bool			singleirq;
+	u8			singleirq:1;
 
 	spinlock_t		lock;
 
@@ -304,7 +304,7 @@ struct mmci_host {
 	u32			datactrl_reg;
 	u32			busy_status;
 	u32			mask1_reg;
-	bool			vqmmc_enabled;
+	u8			vqmmc_enabled:1;
 	struct mmci_platform_data *plat;
 	struct mmci_host_ops	*ops;
 	struct variant_data	*variant;
@@ -330,7 +330,7 @@ struct mmci_host {
 	struct dma_chan		*dma_tx_channel;
 	struct dma_async_tx_descriptor	*dma_desc_current;
 	struct mmci_host_next	next_data;
-	bool			dma_in_progress;
+	u8			dma_in_progress:1;
 
 #define dma_inprogress(host)	((host)->dma_in_progress)
 #endif
-- 
2.7.4

