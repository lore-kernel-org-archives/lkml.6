Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F086AC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B284620851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y26lOCAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B284620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeLEJkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbeLEJku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:50 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBCC2084C;
        Wed,  5 Dec 2018 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002849;
        bh=yiEc0ZEelmk3Zy9UeReG8h3B8OUtmFhhsh09wV16ANE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y26lOCAVKfp/+XrfnQgSWi/3y5iYLLpBrGxtjlQniHBnTpv4Q1SzvmRnHqPwzM2LN
         UD7F+AEtYr5aez6Y/xsSAB1aJZckManMjp/+nBvqxl+ebEcMH2BJBZLz5wAttpF53f
         8YEiE506NeKkMy7xKJXwyJ05dxiZid33Yq6oFy2w=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 087/123] lan743x: Enable driver to work with LAN7431
Date:   Wed,  5 Dec 2018 04:35:19 -0500
Message-Id: <20181205093555.5386-87-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit 4df5ce9bc03e47d05f400e64aa32a82ec4cef419 ]

This driver was designed to work with both LAN7430 and LAN7431.
The only difference between the two is the LAN7431 has support
for external phy.

This change adds LAN7431 to the list of recognized devices
supported by this driver.

Updates for v2:
    changed 'fixes' tag to match defined format

fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 1 +
 drivers/net/ethernet/microchip/lan743x_main.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 5c3ac70abeca..aaedf1072460 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3020,6 +3020,7 @@ static const struct dev_pm_ops lan743x_pm_ops = {
 
 static const struct pci_device_id lan743x_pcidev_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SMSC, PCI_DEVICE_ID_SMSC_LAN7430) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SMSC, PCI_DEVICE_ID_SMSC_LAN7431) },
 	{ 0, }
 };
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 0e82b6368798..2d6eea18973e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -548,6 +548,7 @@ struct lan743x_adapter;
 /* SMSC acquired EFAR late 1990's, MCHP acquired SMSC 2012 */
 #define PCI_VENDOR_ID_SMSC		PCI_VENDOR_ID_EFAR
 #define PCI_DEVICE_ID_SMSC_LAN7430	(0x7430)
+#define PCI_DEVICE_ID_SMSC_LAN7431	(0x7431)
 
 #define PCI_CONFIG_LENGTH		(0x1000)
 
-- 
2.17.1

