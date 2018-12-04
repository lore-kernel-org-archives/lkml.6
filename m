Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780572146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJrCDfzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780572146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeLDKzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLDKzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36BB52146D;
        Tue,  4 Dec 2018 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920916;
        bh=yQ8DRCIUOByaV/KbRowYGVxqG+Np4kEcC5XhXouTa9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJrCDfzuM2BTH7qJS8cyb6z4B7N4/Cpi0DATjm1Jz8YEuKb4UI78QSithKlT9bieN
         6GDjj8/hUrc/vzWMFAb5/9hMlJAFTCNu8/Wty0piVADLXLT9uWLOuWf5E8iCSNQrVp
         DeEhplWMDP4a5bN6gSIqNUNkc3lX+bHWMKQB6ln8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 010/139] lan743x: Enable driver to work with LAN7431
Date:   Tue,  4 Dec 2018 11:48:11 +0100
Message-Id: <20181204103650.411502484@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |    1 +
 drivers/net/ethernet/microchip/lan743x_main.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3020,6 +3020,7 @@ static const struct dev_pm_ops lan743x_p
 
 static const struct pci_device_id lan743x_pcidev_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SMSC, PCI_DEVICE_ID_SMSC_LAN7430) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SMSC, PCI_DEVICE_ID_SMSC_LAN7431) },
 	{ 0, }
 };
 
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -548,6 +548,7 @@ struct lan743x_adapter;
 /* SMSC acquired EFAR late 1990's, MCHP acquired SMSC 2012 */
 #define PCI_VENDOR_ID_SMSC		PCI_VENDOR_ID_EFAR
 #define PCI_DEVICE_ID_SMSC_LAN7430	(0x7430)
+#define PCI_DEVICE_ID_SMSC_LAN7431	(0x7431)
 
 #define PCI_CONFIG_LENGTH		(0x1000)
 


