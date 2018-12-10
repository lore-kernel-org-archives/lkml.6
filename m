Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C97FC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53352081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I6sALBJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53352081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeLJJGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:06:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41002 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeLJJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:06:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so9582659wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oeULTOCMjinSO4pcUUBmFdzaevw7sbCnt/ss9FK3o1w=;
        b=I6sALBJbSf6Ws+I7JqLVMwcAtWQrE0bPZ/XjUMKIB5DaZXXLO4G0eDpjU2NWZqQiPn
         3SX9EaaZS53obN5APJNkjQ3f6hPiXY0xzyfq66655nIxKDFMWakiF43WsmgyDVwYLcVG
         D6DmDs1+9BEBsQ/Qoj/VhZG6w8WUYP3hRmBVBkyFk+Xtwt5heqM8/L1BAORcuAVkaL7i
         A4EQDbGs8CV9skqzsVsb41DGRWXgu9j4pUj1NOOBIKRfeH5Be1V7fi+U82xCopFDimgJ
         1ZmzVw2OhJGStO/n4abCHX3h10TK2EUHCvQSsnrbdzHxSsJ6abi+et1k0JIsrl6Zib+M
         6UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oeULTOCMjinSO4pcUUBmFdzaevw7sbCnt/ss9FK3o1w=;
        b=AT3a1A5wAVRVOGCWmKjxD5OU0IswPHMpFwKr9IRiQl0+HDBjr/3pwx7FNi4Vz5jHnt
         IMN5aBbgg41XviNTjPwpcgNdfWVqqw1b0u4SAEzNw19CwndDIhO38S2gowJEboEFdQd4
         YzhurmVT5RR8aERXVvMqU3Ya70OX/AadikwHWTMKmQTRLcblzt98NsdBSlrHIIzdtPkN
         AtglarNX7XZbCgcxdoYQs9eIKD+zot30InTYU/5wHVqnOfECVrW6ztiJSLGUbJhFQCw6
         XqN0yEhBvqB0Gt/rSP/eEZFbaLUnBlP7DQUiaioFt770+6CIb0D/+KhVt96oh5owj0Se
         UJtQ==
X-Gm-Message-State: AA+aEWZpQG3Urlb7GJlfsAHmUjH5gLOu1coEP85Ihn15bgfc2uZQ9mF8
        eS2j2lDfLUaHzNaj5fi4k51uAA==
X-Google-Smtp-Source: AFSGD/WJBOPUDjl+ckutJZaMe1sCrcXaNJGZkTGnLYoyGCphvlVOi0PwvL2B9J8iZ1no34lSplU4HQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr9572449wrx.302.1544432808854;
        Mon, 10 Dec 2018 01:06:48 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id 14sm15856555wmv.36.2018.12.10.01.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:06:48 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
Date:   Mon, 10 Dec 2018 10:06:39 +0100
Message-Id: <20181210090640.4495-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to simple-framebuffer-sunxi, we support different display pipelines
that the firmware is free to choose from.

This documents the "amlogic,simple-framebuffer" compatible and the
"amlogic,pipeline" extension.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
new file mode 100644
index 000000000000..122a5c005cd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
@@ -0,0 +1,33 @@
+Meson specific Simple Framebuffer bindings
+
+This binding documents meson specific extensions to the simple-framebuffer
+bindings. The meson simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "amlogic,simple-framebuffer"
+- amlogic,pipeline, one of:
+  "vpu-cvbs"
+  "vpu-hdmi"
+
+Example:
+
+chosen {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	framebuffer@0 {
+		compatible = "amlogic,simple-framebuffer",
+			     "simple-framebuffer";
+		amlogic,pipeline = "vpu-hdmi";
+		clocks = <&clkc CLKID_HDMI_PCLK>,
+			 <&clkc CLKID_CLK81>,
+			 <&clkc CLKID_GCLK_VENCI_INT0>;
+		power-domains = <&pwrc_vpu>;
+	};
+};
-- 
2.19.2

