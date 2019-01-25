Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B7C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CA5217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="DpyD3Z5+";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="DpyD3Z5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfAYC4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:56:00 -0500
Received: from node.akkea.ca ([192.155.83.177]:52134 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfAYCzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:55:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id EAE3C4E2058;
        Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384938; bh=2BskzDdkFSPQ7IWwVr4w3oGtVDWNwTeYX0iWNkTP6cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DpyD3Z5+oNfU6uJs6Jgqhv8BIVvERCiRKkKcirj20uqqOybvivU8wUtay6LGulBmg
         tU2KybODiExQFDy3DbRjVf3BBeQYbzt8kRpAUvtnlk0NUrwUPu9bsWauZLAqAz2oen
         R6BR6Bi6WpX2bk2hcleGSRe7LbB/oIdErzdbi10Y=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 33bNu387GHL5; Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 0EE274E204D;
        Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384938; bh=2BskzDdkFSPQ7IWwVr4w3oGtVDWNwTeYX0iWNkTP6cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DpyD3Z5+oNfU6uJs6Jgqhv8BIVvERCiRKkKcirj20uqqOybvivU8wUtay6LGulBmg
         tU2KybODiExQFDy3DbRjVf3BBeQYbzt8kRpAUvtnlk0NUrwUPu9bsWauZLAqAz2oen
         R6BR6Bi6WpX2bk2hcleGSRe7LbB/oIdErzdbi10Y=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v4 3/5] dt-bindings: dma: fsl-imx-sdma: add fsl,imx8mq to the accepted compatible node
Date:   Thu, 24 Jan 2019 19:55:26 -0700
Message-Id: <20190125025528.15645-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mq is a slightly different variant on the imx7d

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

