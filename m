Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F22C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD02220841
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD02220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeHJKWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:22:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38406 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeHJKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:22:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fo2Ei-0001cd-Lc; Fri, 10 Aug 2018 07:53:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mlxsw: remove unused arrays mlxsw_i2c_driver_name and mlxsw_pci_driver_name
Date:   Fri, 10 Aug 2018 08:53:28 +0100
Message-Id: <20180810075328.26400-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Arrays mlxsw_i2c_driver_name and mlxsw_pci_driver_name are defined
but never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: 'mlxsw_i2c_driver_name' defined but not used
warning: 'mlxsw_pci_driver_name' defined but not used

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 2 --
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index 25f9915ebd82..11a664eb5ce7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -46,8 +46,6 @@
 #include "core.h"
 #include "i2c.h"
 
-static const char mlxsw_i2c_driver_name[] = "mlxsw_i2c";
-
 #define MLXSW_I2C_CIR2_BASE		0x72000
 #define MLXSW_I2C_CIR_STATUS_OFF	0x18
 #define MLXSW_I2C_CIR2_OFF_STATUS	(MLXSW_I2C_CIR2_BASE + \
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index fc4557245ff4..ce9157aeb0aa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -53,8 +53,6 @@
 #include "port.h"
 #include "resources.h"
 
-static const char mlxsw_pci_driver_name[] = "mlxsw_pci";
-
 #define mlxsw_pci_write32(mlxsw_pci, reg, val) \
 	iowrite32be(val, (mlxsw_pci)->hw_addr + (MLXSW_PCI_ ## reg))
 #define mlxsw_pci_read32(mlxsw_pci, reg) \
-- 
2.17.1

