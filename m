Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeBGTgT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:36:19 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45988 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:36:17 -0500
X-Google-Smtp-Source: AH8x2268rY9pIlzDUJnB17ErtgwwgaZwAdqVJ7akwi6rhwO1oorf4Gpr8acBLxNa7Qf8O5grguRZqw==
From: Mathieu Malaterre <malat@debian.org>
To: "David S . Miller" <davem@davemloft.net>
Cc: trivial@kernel.org, Mathieu Malaterre <malat@debian.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Egil Hjelmeland <privat@egil-hjelmeland.no>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: Extra '_get' in declaration of arch_get_platform_mac_address
Date: Wed,  7 Feb 2018 20:35:00 +0100
Message-Id: <20180207193501.25446-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c7f5d105495a ("net: Add eth_platform_get_mac_address() helper."),
two declarations were added:

  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
  unsigned char *arch_get_platform_get_mac_address(void);

An extra '_get' was introduced in arch_get_platform_get_mac_address, remove
it. Fix compile warning using W=1:

  CC      net/ethernet/eth.o
net/ethernet/eth.c:523:24: warning: no previous prototype for ‘arch_get_platform_mac_address’ [-Wmissing-prototypes]
 unsigned char * __weak arch_get_platform_mac_address(void)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  AR      net/ethernet/built-in.o

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/etherdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 263dbcad22fc..79563840c295 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -31,7 +31,7 @@
 #ifdef __KERNEL__
 struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
-unsigned char *arch_get_platform_get_mac_address(void);
+unsigned char *arch_get_platform_mac_address(void);
 u32 eth_get_headlen(void *data, unsigned int max_len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
-- 
2.11.0
