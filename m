Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E722081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E722081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeKHFzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:55:23 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:34190 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeKHFzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:55:22 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8D62C19F5AF;
        Wed,  7 Nov 2018 21:23:16 +0100 (CET)
Subject: [PATCH 9/9] arm64: defconfig: Drop redundant sound codec options
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Message-ID: <8fa3ac06-aec1-1a27-b166-1c68b56a26ac@free.fr>
Date:   Wed, 7 Nov 2018 21:19:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_RK3399_GRU_SOUND selects SND_SOC_DA7219, SND_SOC_MAX98357A,
SND_SOC_RT5514, SND_SOC_RT5514_SPI.

SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_RT5645.

SND_SOC_RL6231 is pulled in for SND_SOC_RT5514 and SND_SOC_RT5645.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 75d5ed7ea53d..4910b76f1002 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -499,12 +499,6 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
-CONFIG_SND_SOC_DA7219=m
-CONFIG_SND_SOC_MAX98357A=m
-CONFIG_SND_SOC_RL6231=m
-CONFIG_SND_SOC_RT5514=m
-CONFIG_SND_SOC_RT5514_SPI=m
-CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-- 
2.17.1
