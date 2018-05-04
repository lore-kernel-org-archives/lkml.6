Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeEDRZm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:25:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43578 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeEDRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:25:40 -0400
X-Google-Smtp-Source: AB8JxZoe+nlnguxhq4bWZkX28iV+5vRl+NdlnLx0jW1E2mzoolFE5j5U5pFAQeF2egY4rW9M2MrgvQ==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] net: nixge: Address compiler warnings about signedness
Date: Fri,  4 May 2018 10:18:34 -0700
Message-Id: <20180504171834.9365-2-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504171834.9365-1-mdf@kernel.org>
References: <20180504171834.9365-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:
warning: pointer targets in passing argument 1 of
‘is_valid_ether_addr’ differ in signedness [-Wpointer-sign]
  if (mac_addr && is_valid_ether_addr(mac_addr)) {
                                      ^~~~~~~~
expected ‘const u8 * {aka const unsigned char *}’ but argument
is of type ‘const char *’
 static inline bool is_valid_ether_addr(const u8 *addr)
                    ^~~~~~~~~~~~~~~~~~~
warning: pointer targets in passing argument 2 of
‘ether_addr_copy’ differ in signedness [-Wpointer-sign]
   ether_addr_copy(ndev->dev_addr, mac_addr);
                                   ^~~~~~~~
expected ‘const u8 * {aka const unsigned char *}’ but argument
is of type ‘const char *’
 static inline void ether_addr_copy(u8 *dst, const u8 *src)

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index c41fea9253e3..b092894dd128 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1183,7 +1183,7 @@ static int nixge_probe(struct platform_device *pdev)
 	struct nixge_priv *priv;
 	struct net_device *ndev;
 	struct resource *dmares;
-	const char *mac_addr;
+	const u8 *mac_addr;
 	int err;
 
 	ndev = alloc_etherdev(sizeof(*priv));
-- 
2.17.0
