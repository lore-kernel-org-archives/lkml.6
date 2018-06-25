Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D12C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A70525404
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GnRMAg1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A70525404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeFYDgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:36:18 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:51434 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeFYDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:36:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w5P3YrPY012508;
        Mon, 25 Jun 2018 12:34:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w5P3YrPY012508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529897694;
        bh=8pljidgYUX4BiVggvoHWe4Yv10mAqvrnLU/gEQjDr/E=;
        h=From:To:Cc:Subject:Date:From;
        b=GnRMAg1y/eQzeN4/NnT/alKEwbsSMbu+1XjyHSLTJNBK9feymQQxlm8VuGgkMQ/uZ
         bCqM4ZVwa1Hh+CJDAfNEOTM33EKtzsjeFiR7Y5z2c8cMDahSYdl8c27fOt3I6dldHx
         79NVQ/qJlbqSuR6x3qgtLFHKw1GDIHvaWiFMn1xzPL/XE8QUJb0vqj2UBDZBVNz8We
         O4vYX7uyzsLAYvo7F+ivMsWt/5sA3KD3gkTXF7ZMoDHlxyO584zN0ZfDvk9Cpof5zX
         6RXL8DcVbOcNQbJpbwc7hboYnSGZ4cgDnT3V+oMjRZeYP2rDUd4AGtdwY0xGICmt86
         D0SCQkH/FcSLg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: uniphier: select RESET_CONTROLLER
Date:   Mon, 25 Jun 2018 12:34:44 +0900
Message-Id: <1529897685-15029-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UniPhier platform highly relies on the reset controller.
Select RESET_CONTROLLER to enable it forcibly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index 779235a..e661d26 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -9,6 +9,7 @@ config ARCH_UNIPHIER
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
+	select RESET_CONTROLLER
 	help
 	  Support for UniPhier SoC family developed by Socionext Inc.
 	  (formerly, System LSI Business Division of Panasonic Corporation)
-- 
2.7.4

