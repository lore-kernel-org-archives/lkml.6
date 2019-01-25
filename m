Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F59C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2DA217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qdFIlRMW";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="aM4wCKqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfAYCzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:55:42 -0500
Received: from node.akkea.ca ([192.155.83.177]:52108 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfAYCzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:55:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 370A74E2056;
        Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384938; bh=EtaCZgEa0SNQFQDgpxE1KPj6YO295TP++Zo3L+XFaTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qdFIlRMW1W+KCgkaHSCBQ6PE6fBD4Z06/f/u/aq4SJGGkr2cP3lOynXV21trgiqBd
         cPiZC07yGvKf0ORIZWyy9ctA9qTTzwM5Ew0fklzLzzZolX4TlT2DUJDG8ONfEHtqTT
         H87BcPUsZwevAok3X5W+5Tzwbn2WdvLxgxWf0D78=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yvU4zLEy14rj; Fri, 25 Jan 2019 02:55:37 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 4E4FD4E204B;
        Fri, 25 Jan 2019 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384937; bh=EtaCZgEa0SNQFQDgpxE1KPj6YO295TP++Zo3L+XFaTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aM4wCKqkCR6LGo/bXqkAy3mMCmyFbiBGGQ2Y5HnFd4ZWetQdBM4sHcHRSo+0qhNmQ
         I55ROY1ZVhOFEUda/aW0fqME2WbZwSS6A6EJ7e6yVrI+PAcuaiHjO8U/5a1/LdoBE7
         bLd2ZWJKW4c5ZD1tdY+E5V+UDf5jivXxKTJ7CXUc=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v4 2/5] dmaengine: imx-sdma: add imx8mq sdma compatible parts
Date:   Thu, 24 Jan 2019 19:55:25 -0700
Message-Id: <20190125025528.15645-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is identical to the imx7d data structures but we need to
be able to differentiate that the imx8mq has 2 sdma controllers.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5e5ef0b5a973..ec6fb48f387a 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -556,6 +556,12 @@ static struct sdma_driver_data sdma_imx7d = {
 	.script_addrs = &sdma_script_imx7d,
 };
 
+static struct sdma_driver_data sdma_imx8mq = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx7d,
+};
+
 static const struct platform_device_id sdma_devtypes[] = {
 	{
 		.name = "imx25-sdma",
@@ -578,6 +584,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
+	}, {
+		.name = "imx8mq-sdma",
+		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
 		/* sentinel */
 	}
@@ -592,6 +601,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
-- 
2.17.1

