Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeEOXsk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:48:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44168 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeEOXse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:48:34 -0400
X-Google-Smtp-Source: AB8JxZp2CcSCYnaaeeyQccgFDYb0yyQFaxDj9xyyoBnmF+Ig1mGJFQ1yaVpHD7wg5y8G6FoqKeGBeQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/3] net: ethernet: freescale: Allow FEC with COMPILE_TEST
Date: Tue, 15 May 2018 16:48:24 -0700
Message-Id: <20180515234825.11240-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515234825.11240-1-f.fainelli@gmail.com>
References: <20180515234825.11240-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale FEC driver builds fine with COMPILE_TEST, so make that
possible.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 6e490fd2345d..a580a3dcbe59 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -22,7 +22,7 @@ if NET_VENDOR_FREESCALE
 config FEC
 	tristate "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
 	depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
-		   ARCH_MXC || SOC_IMX28)
+		   ARCH_MXC || SOC_IMX28 || COMPILE_TEST)
 	default ARCH_MXC || SOC_IMX28 if ARM
 	select PHYLIB
 	imply PTP_1588_CLOCK
-- 
2.14.1
