Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3DBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D137243FE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D137243FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934634AbeGDMTd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:19:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933621AbeGDMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:19:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fagkr-0008U1-S4; Wed, 04 Jul 2018 12:19:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Allen Pais <allen.lkml@gmail.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] epic100: remove redundant variable 'irq'
Date:   Wed,  4 Jul 2018 13:19:29 +0100
Message-Id: <20180704121929.9113-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable 'irq' is being assigned but is never used hence it is
and can be removed.

Cleans up clang warning:
warning: variable 'irq' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/smsc/epic100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/epic100.c b/drivers/net/ethernet/smsc/epic100.c
index 949aaef390b6..15c62c160953 100644
--- a/drivers/net/ethernet/smsc/epic100.c
+++ b/drivers/net/ethernet/smsc/epic100.c
@@ -321,7 +321,6 @@ static int epic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	static int card_idx = -1;
 	void __iomem *ioaddr;
 	int chip_idx = (int) ent->driver_data;
-	int irq;
 	struct net_device *dev;
 	struct epic_private *ep;
 	int i, ret, option = 0, duplex = 0;
@@ -338,7 +337,6 @@ static int epic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ret = pci_enable_device(pdev);
 	if (ret)
 		goto out;
-	irq = pdev->irq;
 
 	if (pci_resource_len(pdev, 0) < EPIC_TOTAL_SIZE) {
 		dev_err(&pdev->dev, "no PCI region space\n");
-- 
2.17.1

