Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0718BC43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AC52070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfADNsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:48:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37641 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbfADNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:48:11 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x04DfHAP026819;
        Fri, 4 Jan 2019 14:47:57 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pnxxc0v9k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 04 Jan 2019 14:47:57 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 308D638;
        Fri,  4 Jan 2019 13:47:57 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 131495310;
        Fri,  4 Jan 2019 13:47:57 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019
 14:47:56 +0100
Received: from localhost (10.129.4.161) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019 14:47:56
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 1/2] mailbox: stm32-ipcc: do not enable wakeup source by default
Date:   Fri, 4 Jan 2019 14:47:47 +0100
Message-ID: <1546609668-6488-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.161]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-04_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default do not enable the wakeup source.
This lets the userspace application decide whether the wakeup source
shall be enabled or not.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/mailbox/stm32-ipcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index a338bd4..7ca8a14 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -270,7 +270,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 			goto err_clk;
 		}
 
-		device_init_wakeup(dev, true);
+		device_set_wakeup_capable(dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(dev, ipcc->wkp);
 		if (ret) {
 			dev_err(dev, "Failed to set wake up irq\n");
-- 
2.7.4

