Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeC0MFr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:05:47 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:32843 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752310AbeC0MFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:05:18 -0400
From: michaelsh@mellanox.com
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Shych <michaelsh@mellanox.com>
Subject: [PATCH v1 - resent 4/5] i2c: busses: Allow configurable adapter id for mlxcpld
Date: Tue, 27 Mar 2018 14:01:25 +0000
Message-Id: <1522159286-41779-5-git-send-email-michaelsh@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It allows mlxcpld driver to be connected to pre-defined adapter number
equal or greater than one, in order to avoid current limitation, assuming
usage of id number one only.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 7341cee9..745ed43 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -514,6 +514,8 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 	/* Check support for smbus block transaction */
 	if (val & MLXCPLD_I2C_SMBUS_BLK_BIT)
 		priv->smbus_block = true;
+	if (pdev->id >= -1)
+		mlxcpld_i2c_adapter.nr = pdev->id;
 	priv->adap = mlxcpld_i2c_adapter;
 	priv->adap.dev.parent = &pdev->dev;
 	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
-- 
2.1.4
