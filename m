Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95423C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388F42081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyjpPmWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388F42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeK1S3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:29:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53968 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeK1S3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:29:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so1442534wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 23:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dHstrDpJv3Yp1o0c1yK4Vv3iJU5cSAEcnYo0kIJEv4=;
        b=tyjpPmWJhofn4UorgshkPDDKDX1rr6eWHAbQIYS2EgyV0/eZ10bZqfWUymWvdcA07V
         a01jqBUWeOMLTlksGK645ngF0foOHIARHf7eNNfq2lCfXOYVP1WXZwLzfjpWU6KqsbrO
         AgDuJngQ2+ItKjruSNXo46j1IDf9E4wzz6oZXBvpnAnqkEVzCjFZzHDfg/L0L4f+ePiK
         vMlX1jIb58Q5k5X5kpLZUD3bj5JTVJNLzBvF3q/YF59Jfc6tTklcS8vt0X0hIrohH5Hf
         1zH5K12QuFcu95m3+aw2ZBSOCEK+9Pi8FbWwVn18Wa7SNHLQbm/5J8xvUIPN02i/mSjF
         5Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dHstrDpJv3Yp1o0c1yK4Vv3iJU5cSAEcnYo0kIJEv4=;
        b=RNABtJn+9NajNFejV6POHMAqkXxinemhrsHYpq07RY7cSXo5V5Pb1Tq181llvCeLRO
         ufVDW0xCdUX7SBw2oISZzMaHqCmg0cMQO53zXITxk7fENnhsEO6F8jS2u7sWCN1WMHZx
         5c6AtC3vchPRQgs4YCk3L9Z17+o0KLba5aJuXEx4R1uXIhTItkQvpDOw+z9yn9pyEpDW
         aagmdRiYVqdPRHPhVg8jmkeZOK56rhO712rmlbsFPqN9/Muz/ZPc6IL9RA/Odo46OKK/
         /m7pZeFAAbRCfgeeNxkHrmb62wYbjJYXBLpxeIH5N9wuZslwOsjAbeXYv2yVZi8BKCWJ
         jgdw==
X-Gm-Message-State: AA+aEWa/QiDLtYqkd8W9HJpEsKEaWRSyYFPhHXa0U6IslDJBRbnwjpVm
        ekVLTtoEn2Mfig0VW8FFMdk=
X-Google-Smtp-Source: AFSGD/XUzAWvtUmPFk5XAIWUbZqY32L4DFfF0K2neeqKYEZp6tLnm/91vH4hunsx1WMY1qxdjyiHSQ==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr1777233wmj.30.1543390136727;
        Tue, 27 Nov 2018 23:28:56 -0800 (PST)
Received: from heron.blarg.de (pD9EBF509.dip0.t-ipconnect.de. [217.235.245.9])
        by smtp.gmail.com with ESMTPSA id c12sm3894519wrs.82.2018.11.27.23.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 23:28:55 -0800 (PST)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bardliao@realtek.com,
        oder_chiou@realtek.com, Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH] sound/soc/rockchip: add RT5640 codec option
Date:   Wed, 28 Nov 2018 08:28:52 +0100
Message-Id: <20181128072852.32760-1-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Firefly-RK3399 DeviceTree
(`arch/arm64/boot/dts/rockchip/rk3399-firefly.dts`) defines a
`simple-audio-card` device which selects a `realtek,rt5640` codec.
This codec however is inaccessible in the kernel configuration
(`SND_SOC_RT5640`) and thus cannot be used.

This patch adds a new configuration option named
`SND_SOC_ROCKCHIP_RT5640` which selects `SND_SOC_RT5640` and
`SND_SIMPLE_CARD`, but does nothing else.

It enables `SND_SIMPLE_CARD`, because that's what the Firefly has.
I'm not sure if there are Rockchip products which need a different
sound card driver with RT5640.

Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 sound/soc/rockchip/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 957046ac6c8c..ac2e27043107 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -42,6 +42,16 @@ config SND_SOC_ROCKCHIP_MAX98090
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  boards using the MAX98090 codec, such as Veyron.
 
+config SND_SOC_ROCKCHIP_RT5640
+	tristate "ASoC support for Rockchip boards using a RT5640 codec"
+	depends on SND_SOC_ROCKCHIP
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_RT5640
+	select SND_SIMPLE_CARD
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the RT5640 codec, such as Firefly-RK3399.
+
 config SND_SOC_ROCKCHIP_RT5645
 	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
-- 
2.19.2

