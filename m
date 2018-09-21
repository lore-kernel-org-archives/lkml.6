Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A8ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA0321531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA0321531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbeIUPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:36:07 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55499 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbeIUPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:36:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9hulp025545;
        Fri, 21 Sep 2018 11:46:43 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mmkmr37yf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C984F38;
        Fri, 21 Sep 2018 09:46:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A88742AC3;
        Fri, 21 Sep 2018 09:46:42 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:42 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:42 +0200
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
Subject: [PATCH V2 12/27] mmc: mmci: add dma_finalize callback
Date:   Fri, 21 Sep 2018 11:46:06 +0200
Message-ID: <1537523181-14578-13-git-send-email-ludovic.Barre@st.com>
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

This patch adds dma_finalize callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

# Conflicts:
#	drivers/mmc/host/mmci.h

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 14 ++++++++------
 drivers/mmc/host/mmci.h          |  3 ++-
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 10c7adc..1158d5c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -447,6 +447,12 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 	return 0;
 }
 
+void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+	if (host->ops && host->ops->dma_finalize)
+		host->ops->dma_finalize(host, data);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -626,7 +632,7 @@ static void mmci_dma_data_error(struct mmci_host *host)
 	mmci_dma_unmap(host, host->data);
 }
 
-static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	u32 status;
@@ -820,14 +826,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.dma_setup = mmci_dmae_setup,
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
+	.dma_finalize = mmci_dmae_finalize,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_finalize(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-}
-
 static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index df1826b..b793cfb 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -281,6 +281,7 @@ struct mmci_host_ops {
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
+	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
 };
 
 struct mmci_host {
@@ -339,4 +340,4 @@ void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
 void mmci_dmae_release(struct mmci_host *host);
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl);
-
+void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index e2e756c..f1fd48a 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -188,6 +188,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.dma_setup = qcom_dma_setup,
 	.dma_release = mmci_dmae_release,
 	.dma_start = mmci_dmae_start,
+	.dma_finalize = mmci_dmae_finalize,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

