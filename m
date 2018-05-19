Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeESWzR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:55:17 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38522 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeESWzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:55:14 -0400
X-Google-Smtp-Source: AB8JxZpvh7VdMIdzsMW4Guyfy7c4XE+akAjX/opQiyaxGRuqXb31SGKmYQcdNR9cFQCPDCJ7jvCycA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Extend platform data to include DSA ports
Date: Sat, 19 May 2018 15:55:10 -0700
Message-Id: <20180519225510.23820-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a means for !OF platforms to supply their DSA platform data
configuration using the dsa_platform_data structure.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/platform_data/b53.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/platform_data/b53.h b/include/linux/platform_data/b53.h
index 69d279c0da96..8eaef2f2b691 100644
--- a/include/linux/platform_data/b53.h
+++ b/include/linux/platform_data/b53.h
@@ -20,8 +20,12 @@
 #define __B53_H
 
 #include <linux/kernel.h>
+#include <net/dsa.h>
 
 struct b53_platform_data {
+	/* Must be first such that dsa_register_switch() can access it */
+	struct dsa_chip_data cd;
+
 	u32 chip_id;
 	u16 enabled_ports;
 
-- 
2.14.1
