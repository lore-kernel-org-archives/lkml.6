Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CAEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B41208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e5uzcbnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B41208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeH1Ekf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:40:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36988 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeH1Ekf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:40:35 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S0p0Sb018613;
        Mon, 27 Aug 2018 19:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535417460;
        bh=CbrxiMJK6QPOdoVkUZCH4GqdGA9cpeNw2W9tDbs/KLQ=;
        h=From:To:CC:Subject:Date;
        b=e5uzcbnBjnt4hl5pEBnorxHX2pD1ytc4tclDRHiWHVfm6evmiYJxKghfeyL5cTpFc
         Og/KWoqbguf5n+gLCf60YVWSM7KilrSTGmXeZRmW6QnXDszb2cj9e9NCJv7qOs/bfB
         HE9DMUa8yzz2ugYVzml0zPnAlySZYSW02G9yChbc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S0p07l026197;
        Mon, 27 Aug 2018 19:51:00 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 19:50:59 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 19:50:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S0oxIC005283;
        Mon, 27 Aug 2018 19:50:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <tony@atomide.com>, <linux-clk@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
Date:   Mon, 27 Aug 2018 19:50:56 -0500
Message-ID: <20180828005056.27326-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3_ARCH uses TISCI for clocks as well. Enable the same
for the driver support.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Ref: https://patchwork.kernel.org/patch/10447677/

Since ARCH_K3 only got integrated in v4.19-rc1, rebased to v4.19-rc1 tag..

 drivers/clk/Makefile         | 1 +
 drivers/clk/keystone/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a84c5573cabe..ed344eb717cc 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-y					+= imgtec/
 obj-$(CONFIG_ARCH_MXC)			+= imx/
 obj-$(CONFIG_MACH_INGENIC)		+= ingenic/
+obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
 obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
index 7e9f0176578a..b04927d06cd1 100644
--- a/drivers/clk/keystone/Kconfig
+++ b/drivers/clk/keystone/Kconfig
@@ -7,7 +7,7 @@ config COMMON_CLK_KEYSTONE
 
 config TI_SCI_CLK
 	tristate "TI System Control Interface clock drivers"
-	depends on (ARCH_KEYSTONE || COMPILE_TEST) && OF
+	depends on (ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST) && OF
 	depends on TI_SCI_PROTOCOL
 	default ARCH_KEYSTONE
 	---help---
-- 
2.15.1

