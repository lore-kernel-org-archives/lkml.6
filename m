Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067FECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD67321531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD67321531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbeIUPfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:35:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53171 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389739AbeIUPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:35:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYV6008892;
        Fri, 21 Sep 2018 11:46:59 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38p2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 14D5831;
        Fri, 21 Sep 2018 09:46:57 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72FD12ACD;
        Fri, 21 Sep 2018 09:46:57 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:57 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:57 +0200
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
Subject: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
Date:   Fri, 21 Sep 2018 11:46:20 +0200
Message-ID: <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
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

STM32 sdmmc variant has support to:
-Indicate signal directions (only one property
for d0dir, d123dir, cmd_dir)
-Select command and data phase relation.
-Select "clock in" from an external driver.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
change v3:
-remove space at end of "st,use-ckin "

 Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++
 drivers/mmc/host/mmci.c                        | 6 ++++++
 drivers/mmc/host/mmci.h                        | 1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index e952707..d678933 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -19,6 +19,7 @@ Optional properties:
                            the ID provided by the HW
 - vqmmc-supply           : phandle to the regulator device tree node, mentioned
                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+specific for ux500 variant:
 - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
 - st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
 - st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
@@ -26,6 +27,14 @@ Optional properties:
 - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
 - st,sig-pin-fbclk       : feedback clock signal pin used.
 
+specific for sdmmc variant:
+- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
+- st,neg-edge            : data & command phase relation, generated on
+                           sd clock falling edge.
+- st,use-ckin            : use ckin pin from an external driver to sample
+                           the receive data (example: with voltage
+			   switch transceiver).
+
 Deprecated properties:
 - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
 - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d622fbb..4057456 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1708,6 +1708,12 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
 		host->pwr_reg_add |= MCI_ST_CMDDIREN;
 	if (of_get_property(np, "st,sig-pin-fbclk", NULL))
 		host->pwr_reg_add |= MCI_ST_FBCLKEN;
+	if (of_get_property(np, "st,sig-dir", NULL))
+		host->pwr_reg_add |= MCI_STM32_DIRPOL;
+	if (of_get_property(np, "st,neg-edge", NULL))
+		host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
+	if (of_get_property(np, "st,use-ckin", NULL))
+		host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
 
 	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
 		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 75b9c5c..017d9b8 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -389,6 +389,7 @@ struct mmci_host {
 	u32			pwr_reg;
 	u32			pwr_reg_add;
 	u32			clk_reg;
+	u32			clk_reg_add;
 	u32			datactrl_reg;
 	u32			busy_status;
 	u32			mask1_reg;
-- 
2.7.4

