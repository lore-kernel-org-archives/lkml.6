Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A24C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC42085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ri2FIKBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAC42085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbeKFBm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:42:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38434 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbeKFBm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:42:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so10191019wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4uyWeo8VH8aDyDAssC9XP1TtDmsglQ0YQ5hzMn0SFcU=;
        b=Ri2FIKBrRMHTFC0sXQFe2wspf7GstHwLl3l0CDhpcZiU4hPjoggtocIc+BqRHPPqt1
         avN27qW4c1hUnMIh6GR/nPXglBwdiia0vSYRRP+18l+kwwis943GQijR2YxaRoRoBsyC
         vB82FNN/YtuD2T+sgYPUvYg7NjNCzlknJxZlwLr+sUrVhSTiSOZ8ld8hHii3epRuP8nU
         xZVLxaA+KWuJeFayeL5nvykc8+rTfO0WG7UXV1ygEwEs4bpJ4pmPKIVAQ/f41PjLKWl6
         a7KngONl9Aazk5OF21Obkn+L3T4n14rR93sFCLXfDmlfHTlvDMN2IlTmPxlskGkGB6z4
         9kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4uyWeo8VH8aDyDAssC9XP1TtDmsglQ0YQ5hzMn0SFcU=;
        b=s3/7qqaZAhDD0F5IHzzt6d2jDFjwjPDuvUYSa0BGueyqeACJS7qSX8XIoeowvBMIfu
         8PkN6qaU3+VzO+VuDvc4lFgekPEDexVJewXFc8P4y+65evKSl78+PiPQ5N4L8lo/4aL1
         3LJa+x2Ln6TVucd/JIeL5WyODaRL4NLDsPfPSQdxA3Y6LbSXl71Vk6Q6xhIF5O//RevH
         kdCNqyfRxKLngYW2BLu1BRWZKDsMZ8NXUoQwYqKWhOKjeMOnuYKM2F29nZdo3+OBTwfo
         YWG5/Umy1CVoSpTof1K6Nqe+Eei6HjSPT89SMlQ+EGdefmx4XsAsmrYIN8Dbb+hCB7sC
         KCVA==
X-Gm-Message-State: AGRZ1gLSdhIfV3h7h5RHxG0jyOCHYpZFL8GH0L0PdxbPraO4yT0s+yAZ
        oE/4eEHVWrpHoxoeHNAY5WyXdg==
X-Google-Smtp-Source: AJdET5fLAgHVPKw4Q08bqiF7SlnReDDndUF0GYUpZfp0iRCznYU9RLT/aUzUsxv9+fvWoCtwKgAH+g==
X-Received: by 2002:a5d:5012:: with SMTP id e18-v6mr18577484wrt.99.1541434921030;
        Mon, 05 Nov 2018 08:22:01 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 109-v6sm26013802wrb.81.2018.11.05.08.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 08:22:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx supply
Date:   Mon,  5 Nov 2018 17:21:57 +0100
Message-Id: <1541434917-18126-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hdmi_5v regulator must be enabled to provide power to the physical HDMI
PHY and enables the HDMI 5V presence loopback for the monitor.

Fixes: b409f625a6d5 ("ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 765247b..eb8eec8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -125,6 +125,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	phy-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index d32cf38..69c28c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -78,6 +78,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	phy-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af..86a7be8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -155,6 +155,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	phy-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 5896e8a..8a39d95 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -51,6 +51,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	phy-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 313f88f..50d2be1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -271,6 +271,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	phy-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.7.4

