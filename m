Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C21CC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6B2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="X7QkXQ4O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="X7QkXQ4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfATCcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:32:02 -0500
Received: from node.akkea.ca ([192.155.83.177]:36276 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbfATCcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:32:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 937A14E2050;
        Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547951521; bh=U3u1ymfYif5svjWWDk0JiwVizRuEI3eEjAatwNEEO7A=;
        h=From:To:Cc:Subject:Date;
        b=X7QkXQ4OhFqZ9nUvw3Cn0kukA5mfmmEIYQarVNLQJl46PEdPg+XEi12+65k/RmWiu
         hrhtNOKm5l4xH1T/V0PnDo2A7PsJNTUppaXbIUy9/RMGxAIVZK8xhWneZdrPGBAm59
         ierLZbkvMVbCYxcLGgoJf7WV7jDK1nF1zfcnW6VA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6LG6ktte-aVq; Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id A4FA24E204B;
        Sun, 20 Jan 2019 02:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547951521; bh=U3u1ymfYif5svjWWDk0JiwVizRuEI3eEjAatwNEEO7A=;
        h=From:To:Cc:Subject:Date;
        b=X7QkXQ4OhFqZ9nUvw3Cn0kukA5mfmmEIYQarVNLQJl46PEdPg+XEi12+65k/RmWiu
         hrhtNOKm5l4xH1T/V0PnDo2A7PsJNTUppaXbIUy9/RMGxAIVZK8xhWneZdrPGBAm59
         ierLZbkvMVbCYxcLGgoJf7WV7jDK1nF1zfcnW6VA=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 0/3] dma: imx-sdma: add the sdma engine to the imx8mq
Date:   Sat, 19 Jan 2019 19:31:47 -0700
Message-Id: <20190120023150.17138-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdma support for the imx8mq

Changes since V1

Fixed to build against v5.0-rc2

Angus Ainslie (Purism) (3):
  dma: imx-sdma: fix NULL pointer de-reference
  dma: imx-sdma: add clock ratio 1:1 check
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 31 ++++++++++++++++
 drivers/dma/imx-sdma.c                        | 37 +++++++++++++------
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.17.1

