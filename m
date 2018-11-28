Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CD1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905502086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bCYY/i3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905502086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeK1OF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:05:58 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:16860 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeK1OF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:05:58 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAS34MMH018735;
        Wed, 28 Nov 2018 12:04:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAS34MMH018735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543374263;
        bh=3H39t+FuAV/tUPPcUnPVdmpvI0H9cA+kc7v5fEtkJQc=;
        h=From:To:Cc:Subject:Date:From;
        b=bCYY/i3eri4IJiha8wFAG5cQ28VvqVMgvsRAqiiVvnhhSr331LdS2GehDUjz+H54s
         tDYAg8yc5g6UROzxWLdSuXml4j01fgx6kf57lOQyOU616s8dkT4YDFunYx9yW1pKaB
         QdSjyl0tUrDEqrA3fV4yWoIc2D30xwKGxs8HdUr203gI/WSAA2546mLeAFogmcCo8j
         UmZXVmqYgVVrb3V9F4soS2xd1XfS61AeGI2d7zE9PR+4+Ghy5t/LpCkN23hkCYmKBN
         ftO1WsV5m3WQ0LmJ1dnpUGWv27yE6DqopXVnUBo01uGNlm+LwXLQbklCZqOrjXPPRq
         s90N+XFTv64pQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC
Date:   Wed, 28 Nov 2018 12:04:03 +0900
Message-Id: <1543374243-29475-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
for accelerating the SD/eMMC controller drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The insertion context was decided by savedefconfig on next-20181127.


 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af623..715da88 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -862,6 +862,7 @@ CONFIG_STM32_DMA=y
 CONFIG_STM32_DMAMUX=y
 CONFIG_STM32_MDMA=y
 CONFIG_TEGRA20_APB_DMA=y
+CONFIG_UNIPHIER_MDMAC=y
 CONFIG_XILINX_DMA=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_DW_DMAC=y
-- 
2.7.4

