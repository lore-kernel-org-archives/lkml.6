Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C51C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE1B2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfABGpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:45:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35403 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfABGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:45:21 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1geaHD-0003um-NG; Wed, 02 Jan 2019 06:45:16 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     hkallweit1@gmail.com
Cc:     nic_swsd@realtek.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] r8169: Add support for new Realtek Ethernet
Date:   Wed,  2 Jan 2019 14:45:07 +0800
Message-Id: <20190102064507.32122-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two new Realtek Ethernet devices which are re-branded r8168h.
Add the IDs to to support them.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/realtek/r8169.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 99bc3de906e2..66a3f3bf7835 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -205,6 +205,8 @@ enum cfg_version {
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
+	{ PCI_VDEVICE(REALTEK,	0x2502), RTL_CFG_1 },
+	{ PCI_VDEVICE(REALTEK,	0x2600), RTL_CFG_1 },
 	{ PCI_VDEVICE(REALTEK,	0x8129), RTL_CFG_0 },
 	{ PCI_VDEVICE(REALTEK,	0x8136), RTL_CFG_2 },
 	{ PCI_VDEVICE(REALTEK,	0x8161), RTL_CFG_1 },
-- 
2.17.1

