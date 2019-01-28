Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78BC282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B8F21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b8CU70kt";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="AWjjoniX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfA1GJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:09:11 -0500
Received: from node.akkea.ca ([192.155.83.177]:59408 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfA1GIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:08:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 477074E2056;
        Mon, 28 Jan 2019 06:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655730; bh=QmIBLVdbJ3X4Zs3xnT5fPDB4oumJvEdRGSTkpTuJ1IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b8CU70ktiDkZpcm+wWRJIw9jpU6z7PbEOGA0NIg0BCGT6Ww1gQD5/ILOB8xbkj8qj
         LLix5RnXTd2KCOuQq/l2Z6wLh26Hks5Rd8r+NeoifT3ktqrIGerQcc/BF1MJFeeO/S
         MSPzVEvPWVe83MXYBbL9Nw5sggzWnXPa+1cQAKTQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B6J09s486Qe7; Mon, 28 Jan 2019 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 36A2C4E204B;
        Mon, 28 Jan 2019 06:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655729; bh=QmIBLVdbJ3X4Zs3xnT5fPDB4oumJvEdRGSTkpTuJ1IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AWjjoniXOD+Z+ZSRmsENhUdOWO3cDG9GAwi9la/RH6b42yLiSxm2qL07VJz4ZQiwZ
         W1AqqpjfBE8fbKUA0ezQwoWJm2B4wC+7mBFSTFARXChp+cnlPKejmHvFm7wE9t2a7p
         GCwUZcsbc8M6tKyYhiqSPkJNcl0ir4m8+x39fKuc=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v5 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible parts
Date:   Sun, 27 Jan 2019 23:08:37 -0700
Message-Id: <20190128060840.31695-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128060840.31695-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is identical to the imx7d.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 757fad2fbfae..c4db4fe6bcc9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -578,6 +578,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
+	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
 		/* sentinel */
 	}
@@ -592,6 +595,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx7d, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
-- 
2.17.1

