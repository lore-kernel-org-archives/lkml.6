Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463212148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Y5cF4xMq";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="jkTgbNeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfA1GJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:09:06 -0500
Received: from node.akkea.ca ([192.155.83.177]:59428 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfA1GIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:08:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 053574E2058;
        Mon, 28 Jan 2019 06:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655731; bh=okZKtmM0iwQ8WWQf1CT/2bd9GBMAsXjPAUMBFfJblu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y5cF4xMqb7J1HzrKzEUwgBWCbc5RRycT1HS2pHfEYkFxDfVsew4WaCWKRxCh57Out
         aFGTjfFm9G0Rd6I1+DqrCZmXELQJ0lJf1p6kS9wlZAr80M8ZHKUzLP3RmsPqWhyBTG
         AQLqQ+y5oCslqxpkLSt7L888zz2hJ3VR6Vl1H/x8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HrXjpxVBtMrp; Mon, 28 Jan 2019 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 0FECB4E204D;
        Mon, 28 Jan 2019 06:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655730; bh=okZKtmM0iwQ8WWQf1CT/2bd9GBMAsXjPAUMBFfJblu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jkTgbNeoegCbsf/hISPeMkt4dpusg1xExfvtXKuleXn72uvRh6TbwdNu4Hu3TgidE
         sXrri3JzTYK1WkGE8WDCYp1JgNpCeUX900b16m6cN0QCgi7SaxfP/ucYaUEch574Ez
         sKJzrqmuuwfSND6t4qs6lo5t5zAZW2GXwZnto9M8=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v5 3/5] dt-bindings: dma: fsl-imx-sdma: add fsl,imx8mq to the accepted compatible node
Date:   Sun, 27 Jan 2019 23:08:38 -0700
Message-Id: <20190128060840.31695-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128060840.31695-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an fsl,imx8mq compatible string

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..9d8bbac27d8b 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx8mq-sdma"
   The -to variants should be preferred since they allow to determine the
   correct ROM script addresses needed for the driver to work without additional
   firmware.
-- 
2.17.1

