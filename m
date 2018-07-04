Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C586C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3715721738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3715721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934652AbeGDLuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:50:20 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49478 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933972AbeGDLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:50:16 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 6bqE1y00a3XaVaC01bqE98; Wed, 04 Jul 2018 13:50:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0005pt-El; Wed, 04 Jul 2018 13:50:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0007Jn-Cr; Wed, 04 Jul 2018 13:50:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] net: ethernet: sfc: Make subdir logic consistent with other vendors
Date:   Wed,  4 Jul 2018 13:50:13 +0200
Message-Id: <20180704115013.28078-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115013.28078-1-geert+renesas@glider.be>
References: <20180704115013.28078-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both SFC and SFC_FALCON depend on NET_VENDOR_SOLARFLARE, hence use the
latter to decide whether to descend into the sfc subdirectory.
Move the rule to descend into sfc/falcon to the sfc subdirectory.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/Makefile     | 3 +--
 drivers/net/ethernet/sfc/Makefile | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 0c3ab7efff8c9ddb..22555e7fa752c67e 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -80,8 +80,7 @@ obj-$(CONFIG_NET_VENDOR_SAMSUNG) += samsung/
 obj-$(CONFIG_NET_VENDOR_SEEQ) += seeq/
 obj-$(CONFIG_NET_VENDOR_SILAN) += silan/
 obj-$(CONFIG_NET_VENDOR_SIS) += sis/
-obj-$(CONFIG_SFC) += sfc/
-obj-$(CONFIG_SFC_FALCON) += sfc/falcon/
+obj-$(CONFIG_NET_VENDOR_SOLARFLARE) += sfc/
 obj-$(CONFIG_NET_VENDOR_SGI) += sgi/
 obj-$(CONFIG_NET_VENDOR_SMSC) += smsc/
 obj-$(CONFIG_NET_VENDOR_SOCIONEXT) += socionext/
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 3bac58d0f88b20f8..c5c297e78d068f41 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -6,3 +6,5 @@ sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o siena_sriov.o ef10_sriov.o
 
 obj-$(CONFIG_SFC)	+= sfc.o
+
+obj-$(CONFIG_SFC_FALCON) += falcon/
-- 
2.17.1

