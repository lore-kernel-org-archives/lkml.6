Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A6C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8769A205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8769A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJBSxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:53:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36023 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727810AbeJBSxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:53:15 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w92C4Rqi012840;
        Tue, 2 Oct 2018 14:10:07 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mu1bjsnw8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:10:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19AC934;
        Tue,  2 Oct 2018 12:10:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F24D72A3C;
        Tue,  2 Oct 2018 12:10:06 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:10:06 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Oct 2018
 14:10:06 +0200
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
Subject: [PATCH V4 23/25] mmc: mmci: add stm32 sdmmc registers
Date:   Tue, 2 Oct 2018 14:09:25 +0200
Message-ID: <1538482167-13819-24-git-send-email-ludovic.Barre@st.com>
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

This patch adds stm32 sdmmc specific registers.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1520289..583021e 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -23,6 +23,14 @@
 #define MCI_ST_DATA31DIREN	(1 << 5)
 #define MCI_ST_FBCLKEN		(1 << 7)
 #define MCI_ST_DATA74DIREN	(1 << 8)
+/*
+ * The STM32 sdmmc does not have PWR_UP/OD/ROD
+ * and uses the power register for
+ */
+#define MCI_STM32_PWR_CYC	0x02
+#define MCI_STM32_VSWITCH	BIT(2)
+#define MCI_STM32_VSWITCHEN	BIT(3)
+#define MCI_STM32_DIRPOL	BIT(4)
 
 #define MMCICLOCK		0x004
 #define MCI_CLK_ENABLE		(1 << 8)
@@ -50,6 +58,19 @@
 #define MCI_QCOM_CLK_SELECT_IN_FBCLK	BIT(15)
 #define MCI_QCOM_CLK_SELECT_IN_DDR_MODE	(BIT(14) | BIT(15))
 
+/* Modified on STM32 sdmmc */
+#define MCI_STM32_CLK_CLKDIV_MSK	GENMASK(9, 0)
+#define MCI_STM32_CLK_WIDEBUS_4		BIT(14)
+#define MCI_STM32_CLK_WIDEBUS_8		BIT(15)
+#define MCI_STM32_CLK_NEGEDGE		BIT(16)
+#define MCI_STM32_CLK_HWFCEN		BIT(17)
+#define MCI_STM32_CLK_DDR		BIT(18)
+#define MCI_STM32_CLK_BUSSPEED		BIT(19)
+#define MCI_STM32_CLK_SEL_MSK		GENMASK(21, 20)
+#define MCI_STM32_CLK_SELCK		(0 << 20)
+#define MCI_STM32_CLK_SELCKIN		(1 << 20)
+#define MCI_STM32_CLK_SELFBCK		(2 << 20)
+
 #define MMCIARGUMENT		0x008
 
 /* The command register controls the Command Path State Machine (CPSM) */
@@ -72,6 +93,15 @@
 #define MCI_CPSM_QCOM_CCSDISABLE	BIT(15)
 #define MCI_CPSM_QCOM_AUTO_CMD19	BIT(16)
 #define MCI_CPSM_QCOM_AUTO_CMD21	BIT(21)
+/* Command register in STM32 sdmmc versions */
+#define MCI_CPSM_STM32_CMDTRANS		BIT(6)
+#define MCI_CPSM_STM32_CMDSTOP		BIT(7)
+#define MCI_CPSM_STM32_WAITRESP_MASK	GENMASK(9, 8)
+#define MCI_CPSM_STM32_NORSP		(0 << 8)
+#define MCI_CPSM_STM32_SRSP_CRC		(1 << 8)
+#define MCI_CPSM_STM32_SRSP		(2 << 8)
+#define MCI_CPSM_STM32_LRSP_CRC		(3 << 8)
+#define MCI_CPSM_STM32_ENABLE		BIT(12)
 
 #define MMCIRESPCMD		0x010
 #define MMCIRESPONSE0		0x014
@@ -130,6 +160,8 @@
 #define MCI_ST_SDIOIT		(1 << 22)
 #define MCI_ST_CEATAEND		(1 << 23)
 #define MCI_ST_CARDBUSY		(1 << 24)
+/* Extended status bits for the STM32 variants */
+#define MCI_STM32_BUSYD0	BIT(20)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
@@ -175,11 +207,32 @@
 #define MCI_ST_SDIOITMASK	(1 << 22)
 #define MCI_ST_CEATAENDMASK	(1 << 23)
 #define MCI_ST_BUSYENDMASK	(1 << 24)
+/* Extended status bits for the STM32 variants */
+#define MCI_STM32_BUSYD0ENDMASK	BIT(21)
 
 #define MMCIMASK1		0x040
 #define MMCIFIFOCNT		0x048
 #define MMCIFIFO		0x080 /* to 0x0bc */
 
+/* STM32 sdmmc registers for IDMA (Internal DMA) */
+#define MMCI_STM32_IDMACTRLR	0x050
+#define MMCI_STM32_IDMAEN	BIT(0)
+#define MMCI_STM32_IDMALLIEN	BIT(1)
+
+#define MMCI_STM32_IDMABSIZER		0x054
+#define MMCI_STM32_IDMABNDT_SHIFT	5
+#define MMCI_STM32_IDMABNDT_MASK	GENMASK(12, 5)
+
+#define MMCI_STM32_IDMABASE0R	0x058
+
+#define MMCI_STM32_IDMALAR	0x64
+#define MMCI_STM32_IDMALA_MASK	GENMASK(13, 0)
+#define MMCI_STM32_ABR		BIT(29)
+#define MMCI_STM32_ULS		BIT(30)
+#define MMCI_STM32_ULA		BIT(31)
+
+#define MMCI_STM32_IDMABAR	0x68
+
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK | MCI_DATACRCFAILMASK | MCI_CMDTIMEOUTMASK | \
 	MCI_DATATIMEOUTMASK | MCI_TXUNDERRUNMASK | MCI_RXOVERRUNMASK |	\
@@ -190,6 +243,9 @@
 	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
 	 MCI_TXFIFOHALFEMPTYMASK)
 
+#define MCI_IRQ_PIO_STM32_MASK \
+	(MCI_RXFIFOHALFFULLMASK | MCI_TXFIFOHALFEMPTYMASK)
+
 #define NR_SG		128
 
 #define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
-- 
2.7.4

