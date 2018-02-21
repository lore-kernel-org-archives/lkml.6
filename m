Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeBUXld (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeBUXlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D589217A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: [PATCH 13/13] i2c: img-scb: Drop METAG dependency
Date: Wed, 21 Feb 2018 23:38:25 +0000
Message-Id: <20180221233825.10024-14-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that arch/metag/ has been removed, remove the METAG dependency from
the IMG SCB I2C device driver. The hardware is also present on MIPS SoCs
so the driver still has value.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: linux-metag@vger.kernel.org
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a9805c7cb305..94f419489a0b 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -635,7 +635,7 @@ config I2C_IBM_IIC
 
 config I2C_IMG
 	tristate "Imagination Technologies I2C SCB Controller"
-	depends on MIPS || METAG || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	help
 	  Say Y here if you want to use the IMG I2C SCB controller,
 	  available on the TZ1090 and other IMG SoCs.
-- 
2.13.6
