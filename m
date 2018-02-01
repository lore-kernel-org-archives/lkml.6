Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeBARK3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:10:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47171 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbeBARKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:10:20 -0500
From: Colin King <colin.king@canonical.com>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lan78xx: remove redundant initialization of pointer 'phydev'
Date: Thu,  1 Feb 2018 17:10:18 +0000
Message-Id: <20180201171018.22267-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer phydev is initialized and this value is never read, phydev
is immediately updated to a new value, hence this initialization
is redundant and can be removed

Cleans up clang warning:
drivers/net/usb/lan78xx.c:2009:21: warning: Value stored to 'phydev'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ec56ff29aac4..60a604cc7647 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2006,7 +2006,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 {
 	int ret;
 	u32 mii_adv;
-	struct phy_device *phydev = dev->net->phydev;
+	struct phy_device *phydev;
 
 	phydev = phy_find_first(dev->mdiobus);
 	if (!phydev) {
-- 
2.15.1
