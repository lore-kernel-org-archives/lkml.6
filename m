Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CF7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17AD20881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gy5fFWpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeGXN7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45094 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeGXN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so4013247wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JF4KYbfyyrHF4hNmFCqjiaDZt8KzLJb+8PFQp5qxrj8=;
        b=gy5fFWpqsJdyckhkfN5bsvi13woRtOzcz0o5HyJJX/Tfo3eBHgyH3eyIUw/4VsQbtu
         h4tSwrtXxgmzTvAvcnEJ6sUrZQla066GdYzOP9UfMJxGv5pH1wtIhN0PCpaWXBeqQi2/
         Ec5EbbuwAFttvLrk9/V8pVzyyAVdMj+dYn5Pu8Y39ffx/3zpHN+zZ0uebb4j4nPR6MzL
         2z0OsNUKVMWzlBOwjuVc4fk0FqVFXmYuOPog1lUJdhj5fZpveZIu6NqwDPEJmkMHZoXI
         OCONQ/rxM63LKl2JLbUj8f6NpGfJg29PATff2AL01ieqiy4xzYNwobVOFFprPsIsON22
         97YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JF4KYbfyyrHF4hNmFCqjiaDZt8KzLJb+8PFQp5qxrj8=;
        b=bU35Wz3wBp8hpwRGUPtGPODFF1/v13QU/pW+qJeTwNPdBohHfGWYduqJBuVkwoVu1L
         MHRB/ABda6Bsml4XZ3gT8e2oE0TlmqRC99FmBPSsZcUd/F2D4Nlj5BtfLWPXEHXKdvag
         tdpuG4uoIXkBvO5CyLku9cES/KHRbmSDG9k5vVHljsm2AvmdGi5BG2mPizEYftgrJxmn
         XtxdYbdi4riVF+haplkWqUlRB3P1jO94qMgfv23H7vTTKaXh6ay+8zQ/3Pz0COkN1fxd
         ItBlsHaTIFbP4a2fmob8LrI/36G6KMHtZWC7zx9nopwOfOedZD3U8Z4j/P1D5d2Rsztc
         HAMw==
X-Gm-Message-State: AOUpUlEbjF47q4mFfJoUOMy8nIKL8jGd1IVE0MkRaZpNqli1XQ3O/DI+
        MowFMLijCLxXJtb3QPrcEbXFBg==
X-Google-Smtp-Source: AAOMgpehcpI8PNsetfDD7S6afxwcleXgtJmqHZbVBtotqUwphCIvN7AnuChtNataE0Di/8TRXKUTlw==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr11167785wro.279.1532436773840;
        Tue, 24 Jul 2018 05:52:53 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] arm64: dts: meson-axg: add usb power regulator
Date:   Tue, 24 Jul 2018 14:52:27 +0200
Message-Id: <20180724125238.14567-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb power regulator is supplied by the vcc 5v regulator and
controlled by a GPIO. This will be needed to enable usb.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 5937d8c3a6ed..7489b88f27d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -115,6 +115,17 @@
 		enable-active-high;
 	};
 
+	usb_pwr: regulator-usb_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.17.1

