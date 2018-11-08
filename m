Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E4FECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CDA2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gvsTn3kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CDA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKHXAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:00:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeKHXAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:00:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so21245706wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NTes1fC4zFqHURfCa4qB/dJaJkw6Hxyqb8FVWaxI8CM=;
        b=gvsTn3kwo6B0dg5NFLV2kEouNrX38CNK51njUraX5SxuhsF3lN2HPpDQ85dN9/vjpE
         5HB5xsonZgikLXmmWh19qyJwSUc/Qu1nmbDMnq/fyFPe0uWD8eNZ5Fd9DSIuwmL1WcEH
         GxqLZyo1i1Rfa0Jx8XM5w9wuU3XGX6n6bWgVVOweCsTxzpEbRKMrdxPe2SbnbHwGzmi7
         StBVeiMwVzvH9afsAnMaRHIOpMzmopHaW790Pr0TEhxsbpe9r1KoHShFqh/nJZVxWsE2
         1JdI3EbYv/xcgg1ZJqzy2kpADk6/s2CWlIo4jWoD0EtjjozzXV5VEQM7hP27UtSnw6yI
         YguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NTes1fC4zFqHURfCa4qB/dJaJkw6Hxyqb8FVWaxI8CM=;
        b=XSr68+46GC4Fna7Jo1X+M4D+nU4vDGquUlQMTNvL1wr2//04Giqu7aZLy+t4Hw54rS
         qk9ZtyUHnHG+wmBrscRMSe9pJlHOl4xsQ+ABTU7Mfmeu8q0xXLrN7JnhvlVoDAdxntUI
         BwGscKntrMmBfC3Pv1abZ0uQy8a9tfqfElRtskzxz8Ks3fF5BcijLWTWgY7gCmXc9cQG
         gi/EdjRsHR570IYAU1AsPLysH5zCgx/hFIIQd2RHG5OlA/k94Awp2MXg8OnKmSPOiVy8
         f/d8ew+FEXE+PDqq4svfxCyazZ626iuzJLKLjSDSPX6CkdXSZaC+q27WItNqUgt0DqLX
         +KKA==
X-Gm-Message-State: AGRZ1gLnfPRtyrAFlZjTWcil0prYfNrT/52yiUqs1GLls5GOOd3zgYP1
        enHeS3mz4eDN4gl+4cFJpMHg/w==
X-Google-Smtp-Source: AJdET5f7QY/UpqCgyB0KMv7XHvG1TW+qaD3zIoAqICkCuShVsJCWPc2XE2KrgAsubp/B1h7akkxiUw==
X-Received: by 2002:adf:91c3:: with SMTP id 61-v6mr4219400wri.97.1541683480873;
        Thu, 08 Nov 2018 05:24:40 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17-v6sm2970777wrw.17.2018.11.08.05.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 05:24:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND] arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx supply
Date:   Thu,  8 Nov 2018 14:24:38 +0100
Message-Id: <1541683478-5173-1-git-send-email-narmstrong@baylibre.com>
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
index 765247b..e14e0ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -125,6 +125,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index d32cf38..ceb34af 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -78,6 +78,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af..a23252e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -155,6 +155,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 5896e8a..2602940 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -51,6 +51,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 313f88f..782e9ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -271,6 +271,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_5v>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.7.4

