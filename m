Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDFBnu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:43:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40879 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDFBns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:43:48 -0400
X-Google-Smtp-Source: AIpwx49krAFbMrgkpaX7zWm8e5L1PiJLPBcTdJ5XG4vDhUdZ4cdZfq4P4dwQBVYWCD5z+mMZMidSUA==
From: Wenhua Shi <march511@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] make net_gso_ok return false when gso_type is zero(invalid)
Date: Fri,  6 Apr 2018 03:43:39 +0200
Message-Id: <20180406014340.1562-1-march511@gmail.com>
X-Mailer: git-send-email 2.11.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wenhua Shi <march511@gmail.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf44503e..1f26cbcf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4187,7 +4187,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 	BUILD_BUG_ON(SKB_GSO_ESP != (NETIF_F_GSO_ESP >> NETIF_F_GSO_SHIFT));
 	BUILD_BUG_ON(SKB_GSO_UDP != (NETIF_F_GSO_UDP >> NETIF_F_GSO_SHIFT));
 
-	return (features & feature) == feature;
+	return feature && (features & feature) == feature;
 }
 
 static inline bool skb_gso_ok(struct sk_buff *skb, netdev_features_t features)
-- 
2.11.0
