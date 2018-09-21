Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E31DECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E9121531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E9121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbeIUPfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:35:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45829 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389772AbeIUPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:35:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYmB008885;
        Fri, 21 Sep 2018 11:46:41 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38kx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B719F46;
        Fri, 21 Sep 2018 09:46:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 926E82ACC;
        Fri, 21 Sep 2018 09:46:40 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:40 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:40 +0200
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
Subject: [PATCH V2 10/27] mmc: mmci: add dma_release callback
Date:   Fri, 21 Sep 2018 11:46:04 +0200
Message-ID: <1537523181-14578-11-git-send-email-ludovic.Barre@st.com>
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

This patch adds dma_release callback at mmci_host_ops
to allow to call specific variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

# Conflicts:
#	drivers/mmc/host/mmci.h

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c          | 13 ++++++++-----
 drivers/mmc/host/mmci.h          |  2 ++
 drivers/mmc/host/mmci_qcom_dml.c |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2a433ed..562b382 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -409,6 +409,12 @@ int mmci_dma_setup(struct mmci_host *host)
 	return host->ops->dma_setup(host);
 }
 
+void mmci_dma_release(struct mmci_host *host)
+{
+	if (host->ops && host->ops->dma_release)
+		host->ops->dma_release(host);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -546,7 +552,7 @@ int mmci_dmae_setup(struct mmci_host *host)
  * This is used in or so inline it
  * so it can be discarded.
  */
-static inline void mmci_dma_release(struct mmci_host *host)
+void mmci_dmae_release(struct mmci_host *host)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 
@@ -799,13 +805,10 @@ static struct mmci_host_ops mmci_variant_ops = {
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = mmci_dmae_setup,
+	.dma_release = mmci_dmae_release,
 };
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-}
-
 static inline void mmci_dma_finalize(struct mmci_host *host,
 				     struct mmc_data *data)
 {
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 72fe02d..a05f9a2 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -279,6 +279,7 @@ struct mmci_host_ops {
 			    int err);
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
+	void (*dma_release)(struct mmci_host *host);
 };
 
 struct mmci_host {
@@ -335,4 +336,5 @@ void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
 			   int err);
 void mmci_dmae_get_next_data(struct mmci_host *host, struct mmc_data *data);
 int mmci_dmae_setup(struct mmci_host *host);
+void mmci_dmae_release(struct mmci_host *host);
 
diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
index 003c497..e3e195d 100644
--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -186,6 +186,7 @@ static struct mmci_host_ops qcom_variant_ops = {
 	.unprep_data = mmci_dmae_unprep_data,
 	.get_next_data = mmci_dmae_get_next_data,
 	.dma_setup = qcom_dma_setup,
+	.dma_release = mmci_dmae_release,
 };
 
 void qcom_variant_init(struct mmci_host *host)
-- 
2.7.4

