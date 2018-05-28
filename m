Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423738AbeE1LJV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423244AbeE1LJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 087/272] net: bgmac: Correctly annotate register space
Date: Mon, 28 May 2018 12:02:00 +0200
Message-Id: <20180528100248.414361265@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 16a1c0646e55c3345bce8e4edfc06ad119d27c04 ]

All the members: base, idm_base and nicpm_base should be annotated with
__iomem since they are pointers to register space. This fixes a bunch of
sparse reported warnings.

Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
Fixes: dd5c5d037f5e ("net: ethernet: bgmac: add NS2 support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bgmac.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -479,9 +479,9 @@ struct bgmac_rx_header {
 struct bgmac {
 	union {
 		struct {
-			void *base;
-			void *idm_base;
-			void *nicpm_base;
+			void __iomem *base;
+			void __iomem *idm_base;
+			void __iomem *nicpm_base;
 		} plat;
 		struct {
 			struct bcma_device *core;
