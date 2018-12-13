Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF088C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A09F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A09F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLMC2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:28:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37614 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726381AbeLMC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:28:09 -0500
X-UUID: c0a92660643d46bdae0eddd384e92c5a-20181213
X-UUID: c0a92660643d46bdae0eddd384e92c5a-20181213
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 61952231; Thu, 13 Dec 2018 10:27:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 10:27:54 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 10:27:54 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
Date:   Thu, 13 Dec 2018 10:27:50 +0800
Message-ID: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 74EC1AB088B4CA87EB1FB2653C89E3A127430D56A4982A245F8657EB419E777A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove prompts to make all pinctrl cores to non-visible symbols and
make sure the target SoCs would be coupled with the corresponding
cores.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v1:
- Revise commit message
- Change all pinctrl cores to non-visible symbols
- Drop EINT_MTK in PINCTRL_MTK_MOORE
---
 drivers/pinctrl/mediatek/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index d8cb584..1817786 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -17,7 +17,7 @@ config PINCTRL_MTK
 	select OF_GPIO
 
 config PINCTRL_MTK_MOORE
-	bool "MediaTek Moore Core that implements generic binding"
+	bool
 	depends on OF
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
@@ -26,7 +26,7 @@ config PINCTRL_MTK_MOORE
 	select OF_GPIO
 
 config PINCTRL_MTK_PARIS
-	bool "MediaTek Paris Core that implements vendor binding"
+	bool
 	depends on OF
 	select PINMUX
 	select GENERIC_PINCONF
@@ -45,14 +45,14 @@ config PINCTRL_MT2701
 config PINCTRL_MT7623
 	bool "Mediatek MT7623 pin control with generic binding"
 	depends on MACH_MT7623 || COMPILE_TEST
-	depends on PINCTRL_MTK_MOORE
-	default y
+	default MACH_MT7623
+	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT7629
 	bool "Mediatek MT7629 pin control"
 	depends on MACH_MT7629 || COMPILE_TEST
-	depends on PINCTRL_MTK_MOORE
-	default y
+	default MACH_MT7629
+	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT8135
 	bool "Mediatek MT8135 pin control"
@@ -93,8 +93,8 @@ config PINCTRL_MT6797
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
 	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MTK_MOORE
-	default y
+	default ARM64 && ARCH_MEDIATEK
+	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT8173
 	bool "Mediatek MT8173 pin control"
-- 
1.9.1

