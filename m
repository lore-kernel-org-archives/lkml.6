Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE52C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3121E20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZwHPPUyI";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZwHPPUyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAWPYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:24:03 -0500
Received: from node.akkea.ca ([192.155.83.177]:52754 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:23:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id D70034E205C;
        Wed, 23 Jan 2019 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548257025; bh=nMsfxlWOKkuuXC8N8pVOYuRYBKhgbVC5Ie8hZF94QDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZwHPPUyIXHnOmniDVlY3eCbVeBdZf/4u1ctf5o53nhDY/aIY5Hnrw2U6mqYwHNFkq
         cXCT5G8QaiHLpgGukUTXhLWqyD9tsYnKfjxbOqVdU9g6jgZwR9KWJCYYS1T316VKk5
         Xc+jp7hiroBSdkuYv9VJxDOEAmGJv+cn0PZFMNvU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1PFiLSgp4hqp; Wed, 23 Jan 2019 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id F1B5C4E204D;
        Wed, 23 Jan 2019 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548257025; bh=nMsfxlWOKkuuXC8N8pVOYuRYBKhgbVC5Ie8hZF94QDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZwHPPUyIXHnOmniDVlY3eCbVeBdZf/4u1ctf5o53nhDY/aIY5Hnrw2U6mqYwHNFkq
         cXCT5G8QaiHLpgGukUTXhLWqyD9tsYnKfjxbOqVdU9g6jgZwR9KWJCYYS1T316VKk5
         Xc+jp7hiroBSdkuYv9VJxDOEAmGJv+cn0PZFMNvU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v3 3/5] dt-bindings: dma: fsl-imx-sdma: add imx8mq compatible string
Date:   Wed, 23 Jan 2019 08:23:08 -0700
Message-Id: <20190123152310.11680-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123152310.11680-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "fsl,imx8mq-sdma" to the list of accepted compatible strings.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
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

