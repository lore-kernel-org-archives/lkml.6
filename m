Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDLOZx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:25:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33256 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:25:51 -0400
X-Google-Smtp-Source: AIpwx4/b9qftTZhiGXQDredTIBky1yB0wx84ryrwmqCxTQh2cUtS64NrvrQnHHOB0N+tLRLWfefU9w==
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: grygorii.strashko@ti.com
Cc: davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH] net: ethernet: ti: cpsw: fix tx vlan priority mapping
Date: Thu, 12 Apr 2018 17:25:40 +0300
Message-Id: <1523543140-20747-1-git-send-email-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
register and basically replaces vlan pcp field for tagged packets.
So, set it to be 1:1 mapping.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
Based on net/master

 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 3037127..74f8284 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -129,7 +129,7 @@ do {								\
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
-#define CPDMA_TX_PRIORITY_MAP	0x01234567
+#define CPDMA_TX_PRIORITY_MAP	0x76543210
 
 #define CPSW_VLAN_AWARE		BIT(1)
 #define CPSW_RX_VLAN_ENCAP	BIT(2)
-- 
2.7.4
