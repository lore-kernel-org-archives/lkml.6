Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F5F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NPUGQJaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfAQKCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:02:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:02:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so10287988wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uoPwbzVmG0pBQc6Fwdx/UP9yYpRHZ47Q7K07lERNqk=;
        b=NPUGQJaw4kZBQYuNueE0TOpGQ4x55G34jfUjvfSA86luMICgsgBwyI/Kz4fAr/2s+a
         b3AAcABP5foCeiXTZaG2p+hBk5oorN3aFpolQliIAiBo6ScVl7LvuYgb5/ScpWy+xz3s
         QQGnzaL6eLL24OW+5h7KAZV2A5WXtrHP+GwDLdCPIv6yXHih6IaCZmeVlclnid/aCh8B
         TuD2B/qT3p8Emh0w4f+13g4orC83BkqavRYRV8Rvbv1iX4Wh7A2WNNt7XYmid0nNf6hc
         cBG2LKgbJFZiCK4VFeJOkpj4yiyWX1lZRKj0p4WxXb2F7YcePDnPQjADZnrRajF/UQSY
         6EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uoPwbzVmG0pBQc6Fwdx/UP9yYpRHZ47Q7K07lERNqk=;
        b=C01iC/G75R9WSnHRCZyPJpLjCwTSYv0OojpqcEG+ouXIWQxg6cYk5dZP9lO45vu/IC
         JchvdbI1PTqHpbchctQDDt4YwynVVdauhwMqlY9BPpCfVBJTslHUu+WMfHQYcTP1UE0s
         HGReRgBn3qsfE4M1n+5Zh6fW0a0+WKqSYjKpp+XoyyVrygGY4I4eS2OWe6s6IWqJIOwP
         sXjZY3KgoMBx7vh7c5OpreDMuVye00Q4bCDx4QN2P3VWOJGnvbMf8nRG66YEa/Wm6CMc
         tJXDw8Ej9HKw2ouNsULVypL5O2ANtFAg5vC9Z4Qu36zo0YixHBr/QPtvB6aRB8XM+DE3
         TVLQ==
X-Gm-Message-State: AJcUukfVFJSnVqWFNN91FENqCgm1fUK44DH+qfZZHttziI6Pw85bwJ6g
        pnTQBWGx5czPV9l3+G1YpyS5cA==
X-Google-Smtp-Source: ALg8bN4tVyNpfVLViPQ5T6QpaxT+xLmF982ZuRYczgIq4JM57KieEv6D9bsniU15Fhbhe7JbKtCeyQ==
X-Received: by 2002:adf:f401:: with SMTP id g1mr11581670wro.103.1547719363455;
        Thu, 17 Jan 2019 02:02:43 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id t199sm23557992wmt.1.2019.01.17.02.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:02:42 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH] arm64: dts: meson-axg: add efuse device
Date:   Thu, 17 Jan 2019 11:02:34 +0100
Message-Id: <20190117100234.30989-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efuse to the AXG family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index ae336cb34e29..0e0abb1a03e2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -111,6 +111,14 @@
 		compatible = "amlogic,meson-gxbb-sm";
 	};
 
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		clocks = <&clkc CLKID_EFUSE>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		read-only;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.20.1

