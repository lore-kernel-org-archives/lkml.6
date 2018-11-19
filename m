Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93348213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIBcFG1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93348213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeKSUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeKSUcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:32:05 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F03206BA;
        Mon, 19 Nov 2018 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542622136;
        bh=z6QRhXORicQ9kDgje8vuxX9AoHAQ0BqOS3DpOXqT1Bc=;
        h=From:To:Cc:Subject:Date:From;
        b=LIBcFG1Rj1xngH7WGaP6udkmQMSSQ2OUrsqA4/Oik2kUdDn8b6U/yNNZuD/TQKyfl
         NpSv+wSL4dfLv6tz4I12TJhJ9QgSqw6qtIi8MXLUFwmBSQUG/NYLKzPrGtBBRLI0o2
         sKkIy6oieMmRs0yg95tM1nhe3BBJUlPWHDpfC1OM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MIPS: defconfigs: Remove obsolete ATH_CARDS
Date:   Mon, 19 Nov 2018 11:08:51 +0100
Message-Id: <1542622131-18009-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ATH_CARDS was replaced with CONFIG_WLAN_VENDOR_ATH in
commit b5c9b4f91a6f ("ath: unify Kconfig with other vendors").  Anyway
it is being selected automatically as dependency on chosen Atheros
driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/mips/configs/bcm47xx_defconfig   | 1 -
 arch/mips/configs/loongson3_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index ba800a892384..745daaec13cb 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -48,7 +48,6 @@ CONFIG_NETDEVICES=y
 CONFIG_B44=y
 CONFIG_TIGON3=y
 CONFIG_BGMAC=y
-CONFIG_ATH_CARDS=y
 CONFIG_ATH5K=y
 CONFIG_B43=y
 CONFIG_B43LEGACY=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 324dfee23dfb..e100575625cc 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -215,7 +215,6 @@ CONFIG_PPPOE=m
 CONFIG_PPPOL2TP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-CONFIG_ATH_CARDS=m
 CONFIG_ATH9K=m
 CONFIG_HOSTAP=m
 CONFIG_INPUT_POLLDEV=m
-- 
2.7.4

