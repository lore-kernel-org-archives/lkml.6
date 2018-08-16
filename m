Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224C8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D175520C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="i7HfLiK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D175520C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbeHPTfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:35:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43364 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404444AbeHPTfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:35:30 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/7] pinctrl: ingenic: Drop dependency on MACH_INGENIC
Date:   Thu, 16 Aug 2018 18:35:43 +0200
Message-Id: <20180816163544.9072-6-paul@crapouillou.net>
In-Reply-To: <20180816163544.9072-1-paul@crapouillou.net>
References: <20180816163544.9072-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534437355; bh=QUz6Y8Oas74tNlul5vdzZNbt3C7Do8ePw5+AoktUpFY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i7HfLiK1pzb0qkntCIL7ojJ9BJCFrCPhIoNy/eocGMo9N2r67djN1fZ/CIZlv5FGJ86yT1hLRy0DGwxDf2UtzccNuvust3b7RZFQVC5NG+7u1DW/gk53K3ztGlqxVRuSVureDj9sYcoahn+Lk1VHAL+sNaKkortU+MPLRLq938Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 20e368b8f54a..b52e16dd8a91 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -309,9 +309,9 @@ config PINCTRL_ZYNQ
 
 config PINCTRL_INGENIC
 	bool "Pinctrl driver for the Ingenic JZ47xx SoCs"
-	default y
+	default MACH_INGENIC
 	depends on OF
-	depends on MACH_INGENIC || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
-- 
2.11.0

