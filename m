Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B5C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9118A20989
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adirat-com.20150623.gappssmtp.com header.i=@adirat-com.20150623.gappssmtp.com header.b="cGz0S9CA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfA0U21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:28:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40765 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfA0U21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:28:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so15798610wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adirat-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PLSrAY77YXMqD8mCsNFYfXnusW2BtN7ecVfaVQTgoU=;
        b=cGz0S9CAtUtmJN7kwaeJtGy23OlBQgTs4ncjxDDEFMihU8dxT3YXmNVsUuCP5XrOxY
         TpTWzL2MSM++DN7ZSNdFgoCDtkSFxDfdjBMrr8+vN9qYwM1AnTtV3Ak/IAKrwgJbSlci
         4f96zpHUwqD7PJeD6PetfgejbHb/aIeGBDUQ7FEgK58XYx4IW57guUx2LieDAb4CS8LH
         2khYHaDB0zWExf13liXxUBqc64dCXcWTDtwIWW0EFgPeLHd3GgT37081aQg8AsqTbXW/
         NYOk2F1U+8+2cEPi6UBGacF2Kw3QuehlsSm+09CcGKcSACnkb12LbbNrxqhJDEB1f7q+
         Bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7PLSrAY77YXMqD8mCsNFYfXnusW2BtN7ecVfaVQTgoU=;
        b=oFe+lwfBByFR1bp7FECoAIT1cayGMzHijHfpBCqSgrbm9CnXHfmwxqK0waUFgN/OFt
         70ok2IY093v2F/C+ePEOepjk9OMJpMbhI+TzgXB9ReYZLHCS7TsWisi/OLwJDlTf9o5G
         r8VzI1wTUeM65ZJj+2v/OChwGMs7U6rmuJFhTmCWeDFsgUuGJgoqH8138Vmzadsich8G
         +C4OrPag9h5xbL5u02ECall48r4JAU9AmvaKOpQrSA7A8Imqxf7kB6Ee+qtP3PiQ/XQ7
         VFrmF1tl73f3QAV0YSkmOYS97r7xm08mEHXcENxyouoHlm1d0kVfvVo9EmRPnIe889fA
         hzsw==
X-Gm-Message-State: AJcUukcpAQ/6+xDuNvYasqQhNNzelHkTDPy1upRJocnhNR3sEED+CwM+
        B/EbPUYt3NmYkvQEmVHDDJsyJLr3rtBnsw==
X-Google-Smtp-Source: ALg8bN41P1eQpZMTWiYQJEO6/bSLTQvFStJ37D29f6N3zeUPvOyR8UqBVpHaxjLzi/s+7fUilKDKng==
X-Received: by 2002:adf:f009:: with SMTP id j9mr18892547wro.170.1548620905352;
        Sun, 27 Jan 2019 12:28:25 -0800 (PST)
Received: from iwork.lan ([188.24.59.111])
        by smtp.gmail.com with ESMTPSA id k19sm187868249wre.5.2019.01.27.12.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:28:24 -0800 (PST)
From:   Ioan-Adrian Ratiu <adi@adirat.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [RFC][PATCH] Revert "ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs"
Date:   Sun, 27 Jan 2019 22:28:13 +0200
Message-Id: <20190127202813.29493-1-adi@adirat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bea8a160c621d19f7f78b13e14e03f4b8e44cd4b.

Contrary to what the commit message says, on my rpi 3 b v1.2 changing
the polarity causes the exact behaviour this commit intends to fix, as
described at the referenced link below (wlan0 disapears).

With reset-gpios = ... GPIO_ACTIVE_HIGH, brcmfmac errors in dmesg:

[    7.977512] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
[    7.977623] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
[    7.978007] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
[    7.978377] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
[    7.978724] brcmfmac: brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
[    7.978734] brcmfmac: brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed w/status -110
[    7.978747] brcmfmac: brcmf_cfg80211_get_channel: chanspec failed (-110)
[    7.982817] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
[    7.982880] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
[    7.983255] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame

The only solution I currently have is to revert and everything works
as expected and as before changing the polarity.

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index 93762244be7f..4adb85e66be3 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -31,7 +31,7 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 89e6fd547c75..c318bcbc6ba7 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -26,7 +26,7 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
2.20.1

