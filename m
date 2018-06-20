Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5242C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDC208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q//zNFI4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q//zNFI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFDC208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbeFTIpQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:45:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbeFTIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A809360B11; Wed, 20 Jun 2018 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479689;
        bh=65wAojS4gA+9CrJw99QgkrL4ZkxgQFvd9rJZw+YoL5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q//zNFI4tHKdsXAxOipfMYBsbnejabtwXj3HzU2af/BbiQkDetiXwkp6DHUiDD8Pw
         QX8UnEPgPoIaFqIGGCjx1OA49qKAdSDV1h0OLH3NXV71EfMFg9C9BTcjThVlk9VgxX
         slg5AIPNxnK7UF0/7JHhXeYay4PQmHTDh1zwMM88=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05A51605FF;
        Wed, 20 Jun 2018 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479689;
        bh=65wAojS4gA+9CrJw99QgkrL4ZkxgQFvd9rJZw+YoL5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q//zNFI4tHKdsXAxOipfMYBsbnejabtwXj3HzU2af/BbiQkDetiXwkp6DHUiDD8Pw
         QX8UnEPgPoIaFqIGGCjx1OA49qKAdSDV1h0OLH3NXV71EfMFg9C9BTcjThVlk9VgxX
         slg5AIPNxnK7UF0/7JHhXeYay4PQmHTDh1zwMM88=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05A51605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v4 04/15] mtd: rawnand: qcom: remove dt property nand-ecc-step-size
Date:   Wed, 20 Jun 2018 12:57:31 +0530
Message-Id: <1529479662-4026-5-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM NAND controller supports only one step size (512) so
nand-ecc-step-size DT property is redundant. This property
can be removed and ecc step size can be assigned with 512 value.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:

 1. Minor change in comment
    (s/512 bytes of data in each step/512 bytes data steps)

* Changes from v2:

 NEW CHANGE

  1. Removed the custom logic and used the helper fuction.
 drivers/mtd/nand/raw/qcom_nandc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 6a5519f..bf80a61 100644
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
+	/* controller only supports 512 bytes data steps */
+	ecc->size = NANDC_STEP_SIZE;
 	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
 
 	if (ecc->strength >= 8) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

