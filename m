Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8902122503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8902122503
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeKMBzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:55:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44715 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKMBzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:55:35 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gMEel-00012b-Lr; Mon, 12 Nov 2018 17:01:43 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH v2 2/2] dmaengine: imx-sdma: don't print warning when firmware is absent
Date:   Mon, 12 Nov 2018 17:01:43 +0100
Message-Id: <20181112160143.4459-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112160143.4459-1-l.stach@pengutronix.de>
References: <20181112160143.4459-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDMA firmware is optional and a usable fallabck to the internal
ROM firmware is present in the driver. There is already a message
printed informing the user that the internal firmware is used, so
there is no need to print a scary warning for what is normal operation
on most systems.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b4ec2d20e661..c2e7819cecb8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1784,7 +1784,7 @@ static int sdma_get_firmware(struct sdma_engine *sdma,
 {
 	int ret;
 
-	ret = request_firmware_nowait(THIS_MODULE,
+	ret = request_firmware_nowait_nowarn(THIS_MODULE,
 			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
 			GFP_KERNEL, sdma, sdma_load_firmware);
 
-- 
2.19.1

