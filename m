Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B40C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F1A20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F1A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeLLJ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:59:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33621 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbeLLJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:59:07 -0500
X-UUID: 17f31f2f67324714a4f79407f16a066d-20181212
X-UUID: 17f31f2f67324714a4f79407f16a066d-20181212
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 646566370; Wed, 12 Dec 2018 17:59:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 17:58:59 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 17:58:59 +0800
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
Subject: [PATCH] pinctrl: mediatek: improve dependencies for PINCTRL_MTK_MOORE
Date:   Wed, 12 Dec 2018 17:58:52 +0800
Message-ID: <d80dd05f6dbfc8fe7e85509cc00ebd8ec739b4d2.1544608681.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve dependencies for the pinctrl drivers which select
PINCTRL_MTK_MOORE as its core layer.
---
 drivers/pinctrl/mediatek/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index d8cb584..3a41dc8 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -23,6 +23,7 @@ config PINCTRL_MTK_MOORE
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GPIOLIB
+	select EINT_MTK
 	select OF_GPIO
 
 config PINCTRL_MTK_PARIS
@@ -45,14 +46,14 @@ config PINCTRL_MT2701
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
@@ -93,8 +94,8 @@ config PINCTRL_MT6797
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

