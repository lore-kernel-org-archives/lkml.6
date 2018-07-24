Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YZmhHUkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E9820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbeGXN7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38299 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbeGXN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so2420387wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GREtcfme2in64QICT7lyVEuNv1cb4paYqlUc4XsvUk=;
        b=YZmhHUkQs+PtGNscEDMR3Bupa4hev6beagx4ss3sJ22ekDsoUCOj3rlEQycXZUftOJ
         UIr7zsD+stt5ZADVtbjS3aJ55RQpM+R/YsP8y2SmiInfNOk5IOhAW2HCt7nw8lkDTtff
         KBDZP9FlyQcd5Pu41PqdEiT48cNF/WlNCqCZ3//gWWyD4zU6GtYcB79k/enZDZXYnC8p
         +Y/JAnfGpasDbY8RWMuqHVy5kbTFxFYAhnmtLH4PS3wvPgYp8+yS1CtkgpSXUr3lW4Ow
         3g6OvxFmpV1V6W4l/wCt1ZB4CwcH99VPdQ5wk6hBw2PAMxl4anWwHyvQfwZ2oLOO558U
         SvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GREtcfme2in64QICT7lyVEuNv1cb4paYqlUc4XsvUk=;
        b=cVrH1CIK7G8S+iIpXVQp0Ir4BB9Vs68Ppvn8XxGKOrpZ+rDPiS2qikygn6Lw/al+w2
         wT/QhZHgqgAmM0Qkip9okSFMwS6i2aaGoQw9NwvAJbnaF10cio4wIbd4homEeI5CkLWG
         zACRzQkfEkI2nbCZYOfosyR9fMcAxBkxVZsIFEycNksMCMfUJEUwqgceE6NmBXKulFal
         IaQwMcjD7UbYCrWKFaJ8mCF7ogJYQ9B/cUs38uKdhILAR6zMBLPEdpneqFioB+eTTKUL
         Pi1mMRgvo57HCevfQkBFeeB4ahKUATuWB69U4gZtGXzbCXaeI8M3wQqE3zxYmUxxvGuA
         sbAA==
X-Gm-Message-State: AOUpUlG+H4cxx71pC5/3GTyoVVaugvmPFG3T8+G7nq1jYSt0nybQFvyz
        irRtMX8/7qjrBeFzSP0Ytwxwqg==
X-Google-Smtp-Source: AAOMgpe7aNudb0/QSS5Jb9DugDCd7zDE7fITtW+JR4ZmYj6TOUMtt+BLcKdVfzPyAzra6FkgkwNE8Q==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr1879789wmf.43.1532436772712;
        Tue, 24 Jul 2018 05:52:52 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] arm64: dts: meson-axg: add vcc 5v regulator on the s400
Date:   Tue, 24 Jul 2018 14:52:26 +0200
Message-Id: <20180724125238.14567-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This regulator is controlled by a GPIO and supplies various devices
on the board, such as the lineout codec, the usb supply or the lcd
controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 09c7909a78ea..5937d8c3a6ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -104,6 +104,17 @@
 		regulator-always-on;
 	};
 
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&main_12v>;
+
+		gpio = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.17.1

