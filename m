Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35201C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB5C2084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KJUMMEdg";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KJUMMEdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfATCFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:05:17 -0500
Received: from node.akkea.ca ([192.155.83.177]:35728 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbfATCFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:05:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id DD3E84E2050;
        Sun, 20 Jan 2019 01:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547949541; bh=HJuftiU5le4edcxzQV0GJpsj/PoXHvCf7NygW9HXERg=;
        h=From:To:Cc:Subject:Date;
        b=KJUMMEdgwuIIF5hLVNvwU31Av/Y3mLcsrpm5RVNZT2/QU2/vfg6WpXxiQkz9zpYr8
         1ldVakmNsquzKB8KtMRuTlP4iCzed2BnNCAMLSyp+ROz2jlh3YTLERSpbXcZTNC2w+
         mhVzE5Y/uF0h/yHgk1C7S4LfxqPm9nxZzqtugbXM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1n8EOdg9YL7m; Sun, 20 Jan 2019 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id EC43C4E204B;
        Sun, 20 Jan 2019 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547949541; bh=HJuftiU5le4edcxzQV0GJpsj/PoXHvCf7NygW9HXERg=;
        h=From:To:Cc:Subject:Date;
        b=KJUMMEdgwuIIF5hLVNvwU31Av/Y3mLcsrpm5RVNZT2/QU2/vfg6WpXxiQkz9zpYr8
         1ldVakmNsquzKB8KtMRuTlP4iCzed2BnNCAMLSyp+ROz2jlh3YTLERSpbXcZTNC2w+
         mhVzE5Y/uF0h/yHgk1C7S4LfxqPm9nxZzqtugbXM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dma: imx-sdma: add the sdma engine to the imx8mq
Date:   Sat, 19 Jan 2019 18:58:48 -0700
Message-Id: <20190120015851.11797-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdma support for the imx8mq

Angus Ainslie (Purism) (3):
  dma: imx-sdma: fix NULL pointer de-reference
  dma: imx-sdma: add clock ratio 1:1 check
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 31 ++++++++++++++++
 drivers/dma/imx-sdma.c                        | 37 +++++++++++++------
 3 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.17.1

