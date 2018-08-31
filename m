Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79845C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337102083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0KSooAfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337102083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeHaM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:58:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40095 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbeHaM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:58:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so4529553wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TlhOjpl43EpRuA5yEzGXvHqeICOEPG6QYX+g5iMHpvQ=;
        b=0KSooAfUchUz6L4rUvDniYYn5OIYYCRRJzGLriihxLUZkD6XCVCvoXykt6rCoUiYbs
         D4coIkjh9BchCAx33o9GB2XURxzoAS6Bm463+lOgU0tUdpV04HfTyEWtgdYpiV9YowW5
         LOmLzNumXgO4r+fWQ7M5eZIqgBSfYmDkYlPMb4N9xxCL934IrS8i1gsXQBiypxagYvOX
         rA7RAQP2MluleNOjbv8PVTRuTg6D5lvucef9+Jk48CLcfKwxOdGqYs3veCnhHpDHXY9a
         v9e5Gu+hSm5YA5vYLvZ2DDxW0zemjhcYqZkBkXANqpRN2joVS4bXHA67+BbSCiFk4vsf
         U6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TlhOjpl43EpRuA5yEzGXvHqeICOEPG6QYX+g5iMHpvQ=;
        b=fiDOKqV25i6tCONERzQGl8P05ZNZXQIDriKwfjMInXfRZqbS4JKuw4gWJUn9R+4f4i
         M2cFAJh3DcBaQUQVChjwUlicZQ0SK8ZWmUZYy79ngxEfcp/R78zSi0tHY2H18EHSnh1I
         BHDOjXJYMYrZPK7+rCqPvCKxBJXVCzAiCSqSo0NZ4qMfLBPzXdhZ5Oj2vRfoYpU+IWXT
         1sAxuBB/Q3Y2VZVjfoGzm9VBc7C+XkcvavpjJouEtUab6N7svkpTt/AzeA33Mm8FOsmM
         SX+TVdxbPcZpsKLGy7iZG+QGWUUzhov3oF878a02Yqv+0w4v2q1xEehNxlg89Y5xc6gp
         M4eg==
X-Gm-Message-State: APzg51D+4GtgimhnJsdy+InxZWI5CFKNVk1Pc2PFGnbdmlHggMX1PBCr
        uD88Sv11XXN03/T172wTXCx9uQ==
X-Google-Smtp-Source: ANB0VdZaGQp8H4FSDbmJyy4mzlnI0mVST5etoCrIePvaBBhe9l8+tAWothU5X4FFf4cs6/7TmkEulw==
X-Received: by 2002:a1c:7d51:: with SMTP id y78-v6mr3956828wmc.37.1535705542733;
        Fri, 31 Aug 2018 01:52:22 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id v6-v6sm8920822wro.66.2018.08.31.01.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:52:21 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 4/4] ARM64: dts: meson: add vdec entries
Date:   Fri, 31 Aug 2018 10:52:05 +0200
Message-Id: <20180831085205.14760-5-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831085205.14760-1-mjourdan@baylibre.com>
References: <20180831085205.14760-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the video decoder for gxbb, gxl and gxm chips

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 11 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 98cbba6809ca..daee53a755d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -774,3 +774,14 @@
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
 	power-domains = <&pwrc_vpu>;
 };
+
+&vdec {
+	compatible = "amlogic,gxbb-vdec";
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c87a80e9bcc6..bfd65d1a8959 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -775,3 +775,14 @@
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
 	power-domains = <&pwrc_vpu>;
 };
+
+&vdec {
+	compatible = "amlogic,gxl-vdec";
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 247888d68a3a..2f356495be5e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -117,3 +117,7 @@
 &dwc3 {
 	phys = <&usb3_phy>, <&usb2_phy0>, <&usb2_phy1>, <&usb2_phy2>;
 };
+
+&vdec {
+	compatible = "amlogic,gxm-vdec";
+};
-- 
2.18.0

