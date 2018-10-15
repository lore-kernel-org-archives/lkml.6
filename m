Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CCBC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B102086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B102086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJOJOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:14:40 -0400
Received: from mx.socionext.com ([202.248.49.38]:12481 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeJOJOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:14:40 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Oct 2018 10:31:40 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 7E9921800B2;
        Mon, 15 Oct 2018 10:31:40 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 15 Oct 2018 10:31:40 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2219E1A1210;
        Mon, 15 Oct 2018 10:31:40 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] phy: uniphier-pcie: Depend on HAS_IOMEM
Date:   Mon, 15 Oct 2018 10:31:30 +0900
Message-Id: <1539567090-10498-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses devm_ioremap_resource() which is only available when
CONFIG_HAS_IOMEM is set, so the driver depends on this option.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
index 467e814..9c85231 100644
--- a/drivers/phy/socionext/Kconfig
+++ b/drivers/phy/socionext/Kconfig
@@ -26,7 +26,8 @@ config PHY_UNIPHIER_USB3
 
 config PHY_UNIPHIER_PCIE
 	tristate "Uniphier PHY driver for PCIe controller"
-	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && HAS_IOMEM
 	default PCIE_UNIPHIER
 	select GENERIC_PHY
 	help
-- 
2.7.4

