Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0E0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4876E20833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4876E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeIIXtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:49:52 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:44664 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbeIIXtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:49:52 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 10DC6C025F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Sep 2018 20:59:16 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 973C6C0F68; Sun,  9 Sep 2018 20:59:14 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 54F75C0F62;
        Sun,  9 Sep 2018 20:59:05 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] drivers: soc: Allow building the sunxi driver without ARCH_SUNXI
Date:   Sun,  9 Sep 2018 20:58:57 +0200
Message-Id: <20180909185857.19983-1-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to build the sunxi SRAM driver without building
for the sunxi architecture. This allows selecting the driver when
building the kernel in testing environments.

In particular, this is necessary for testing of the Cedrus driver, that
selects the sunxi SRAM driver.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 113e884697fd..446166ba0bec 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -18,7 +18,7 @@ obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
-obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
+obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
-- 
2.18.0

