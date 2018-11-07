Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B9C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC812086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v5+T1A7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC812086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbeKGUPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:15:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45065 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:15:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id k15-v6so13872737wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81OuEak8iRgJ5nMaLrOe/NOy/Pt6PWVxK92yf9sx1Rs=;
        b=v5+T1A7fOieQmi3s/ghb1mOxwtkMmnETMeDZrg10D6kNZs30tQ1xs0rm5BbrS3nJa+
         CZkZIOZoGx73q/UkgCYqhtmLZtdeOIIYbfeaWspzOEFUpxrYXwaFcpoUZ/5ysyUblx9x
         Riu7CcmyxcSOQywxmdyjBaMRC5Hh2sUkJFzAKyJBHnBjQWE14/rZRJjOc7IjOa7NJSnu
         3r+wSTYFAPAxgfIeGC5eda/1KJ5B6++TB7gkRJgf/c+EX0dnHCGigJcT3XRzOLypwSUT
         RGu6KhZ3NaQ+hIN+8kazocDyjdwCdzTFggJ+/Vi2fWWUpLdHBE5beqdun6H3bCVK7oxV
         Sd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81OuEak8iRgJ5nMaLrOe/NOy/Pt6PWVxK92yf9sx1Rs=;
        b=Spuq3bTP4ggkheDVISZ7k8wdpTLtNYFBPtNJQVDJO+sUL7MkhulZ+SO82XwCgdlGYc
         h7qaRCUV+/Fl5iWanWkg4Pf0ad/GC6ClSe5AhMaAZOQw5ShhpbduaVT6pd5e+qfUaUA9
         fO++FYZ1BlHnlxj+SXIAWBtUtAFwCGbUTChdGwMIZic3vlVRt6eYvF6vEcZS8k/1C+dQ
         YIb2grFIfD909OkDBQHYwhx1WI55ERRQRmfANlAWG3ql6UmJqdYl1gpUXQwqIl6mwW/u
         cp40rXMJGRc8thfpeOX5IgtqvfYNXXaO5i94XFlQOkqgHdUOHwDnhIvgHnsFmxv35yDR
         FAIg==
X-Gm-Message-State: AGRZ1gI817wi+EWQxmUp+SW+Lq9r4dC82wShEmLFTkZd5+/znMJzSsqe
        B+fCdIgcOKgeDBB4QAC2MmhCdA==
X-Google-Smtp-Source: AJdET5fGerIZe5fMgMCQIhjaoWJP49g6VeAE62A5V5PsIebYm/pFd96o4KBkTcfDETZbtjkWp5LI2A==
X-Received: by 2002:adf:90d0:: with SMTP id i74-v6mr1328083wri.181.1541587553886;
        Wed, 07 Nov 2018 02:45:53 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h125-v6sm314484wmf.48.2018.11.07.02.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 02:45:53 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: meson-gxl-libretech-cc: fix GPIO lines names
Date:   Wed,  7 Nov 2018 11:45:47 +0100
Message-Id: <1541587550-17842-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patch moves the properties to the gpio nodes.

Fixes: 47884c5c746e ("ARM64: dts: meson-gxl-libretech-cc: Add GPIO lines names")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af..b4dfb9a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -163,7 +163,7 @@
 	};
 };
 
-&pinctrl_aobus {
+&gpio_ao {
 	gpio-line-names = "UART TX",
 			  "UART RX",
 			  "Blue LED",
@@ -178,7 +178,7 @@
 			  "7J1 Header Pin15";
 };
 
-&pinctrl_periphs {
+&gpio {
 	gpio-line-names = /* Bank GPIOZ */
 			  "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "",
-- 
2.7.4

