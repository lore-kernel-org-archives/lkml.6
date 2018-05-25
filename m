Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966962AbeEYMW0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:22:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966601AbeEYMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:22:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8BAC60C66
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v3 05/16] mtd: rawnand: qcom: remove dt property nand-ecc-step-size
Date: Fri, 25 May 2018 17:51:33 +0530
Message-Id: <1527250904-21988-6-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM NAND controller supports only one step size (512) so
nand-ecc-step-size DT property is redundant. This property
can be removed and ecc step size can be assigned with 512 value.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v2:

 NEW CHANGE

  1. Removed the custom logic and used the helper fuction.
 drivers/mtd/nand/raw/qcom_nandc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b554fb6..b538390 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2325,15 +2325,8 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
 	bool wide_bus;
 	int ecc_mode = 1;
 
-	/*
-	 * the controller requires each step consists of 512 bytes of data.
-	 * bail out if DT has populated a wrong step size.
-	 */
-	if (ecc->size != NANDC_STEP_SIZE) {
-		dev_err(nandc->dev, "invalid ecc size\n");
-		return -EINVAL;
-	}
-
+	/* controller only supports 512 bytes of data in each step */
+	ecc->size = NANDC_STEP_SIZE;
 	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
 
 	if (ecc->strength >= 8) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
