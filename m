Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F7C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2A42082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ql0hWQ7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2A42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJCHF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:05:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:18261 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCHF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:05:56 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w930IZSm018610;
        Wed, 3 Oct 2018 09:18:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w930IZSm018610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538525916;
        bh=Wt6G8ZeSYrKtvD+pNRyGm7Wrgc+fksBXDT61kEbPZWI=;
        h=From:To:Cc:Subject:Date:From;
        b=ql0hWQ7gR6s344VyukmIr3AP1O+C+icSrxVLUmBnVkPvS+cHFfSsyfvwTlv0uRgOv
         xo9CKKSvnOpt8W9TUjs8zAuX6jd1qrU2aNy1N2e2HwQf3K3zmkTMYFwTwZwbj7upbb
         srBytokuRZzsEJzSzl0vVbtoV1RpQiNWdPV8mx+CmXxMG6VPEH6q7ZnwFNDPVje+SG
         wrD87CrbMxpduUWk+ulz9wR3L72iIa3YCnaeOrFX6w0qsQVw2p3sptrMzrqAZj7Xz0
         aOWuZ+IDYCTuI9yajw7AoNu5zjISPw3ShIPJxtcErtjsBoCtcFcvCDZ02rsS3ttMdh
         YKOqlpW9Ar3Rw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable CONFIG_MMC_UNIPHIER
Date:   Wed,  3 Oct 2018 09:18:22 +0900
Message-Id: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UniPhier SD controller driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444..0d56568 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -771,6 +771,7 @@ CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
+CONFIG_MMC_UNIPHIER=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
-- 
2.7.4

