Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADC1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D628220839
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D628220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeGQQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:39:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:39:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6CC692639CB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, heiko@sntech.de,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 1/5] arm64: defconfig: Enable sound support for Samsung Chromebook Plus.
Date:   Tue, 17 Jul 2018 18:06:06 +0200
Message-Id: <20180717160610.26501-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Rockchip sound driver with MAX98357A/RT5514/DA7219 codecs
needed for the Samsung Chromebook Plus.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/configs/defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9a186f6af8a..4917641060b1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -447,9 +447,20 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
+CONFIG_SND_SOC_ROCKCHIP=m
+CONFIG_SND_SOC_ROCKCHIP_I2S=m
+CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
+CONFIG_SND_SOC_ROCKCHIP_RT5645=m
+CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
+CONFIG_SND_SOC_DA7219=m
+CONFIG_SND_SOC_MAX98357A=m
+CONFIG_SND_SOC_RL6231=m
+CONFIG_SND_SOC_RT5514=m
+CONFIG_SND_SOC_RT5514_SPI=m
+CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-- 
2.18.0

