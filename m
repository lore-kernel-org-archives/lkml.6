Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DEECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8915321531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8915321531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbeIUPgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:36:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43388 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389593AbeIUPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:36:23 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9jM0S001698;
        Fri, 21 Sep 2018 11:46:51 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkn0u8a0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF4FF3A;
        Fri, 21 Sep 2018 09:46:50 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 859982ACD;
        Fri, 21 Sep 2018 09:46:50 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:50 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:50 +0200
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
Subject: [PATCH V2 19/27] mmc: mmci: add variant property to define dpsm bit
Date:   Fri, 21 Sep 2018 11:46:13 +0200
Message-ID: <1537523181-14578-20-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds datactrl variant property to define
dpsm enable bit. Needed to support the STM32 variant
(STM32 has no dpsm enable bit).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 15 ++++++++++++---
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0b4425f..761b50f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -57,6 +57,7 @@ static struct variant_data variant_arm = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.reversed_irq_handling	= true,
@@ -75,6 +76,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -93,6 +95,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 100000000,
 	.mmcimask1		= true,
@@ -112,6 +115,7 @@ static struct variant_data variant_u300 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 16,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
@@ -136,6 +140,7 @@ static struct variant_data variant_nomadik = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -163,6 +168,7 @@ static struct variant_data variant_ux500 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -195,6 +201,7 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -227,6 +234,7 @@ static struct variant_data variant_stm32 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -253,6 +261,7 @@ static struct variant_data variant_qcom = {
 	.blksz_datactrl4	= true,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_dpsm_enable	= MCI_DPSM_ENABLE,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -948,11 +957,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	BUG_ON(1 << blksz_bits != data->blksz);
 
 	if (variant->blksz_datactrl16)
-		datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
+		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
 	else if (variant->blksz_datactrl4)
-		datactrl = MCI_DPSM_ENABLE | (data->blksz << 4);
+		datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
 	else
-		datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
+		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
 
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 6e71ee77..52ff459 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -222,6 +222,7 @@ struct mmci_host;
  *		     register
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
+ * @datactrl_dpsm_enable: enable value for DPSM
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -258,6 +259,7 @@ struct variant_data {
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
+	unsigned int		datactrl_dpsm_enable;
 	bool			st_sdio;
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
-- 
2.7.4

