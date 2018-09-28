Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48550C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDF420C0A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0puoQ/fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDF420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeI1Uxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:53:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbeI1Uxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:53:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so2451531wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jB5yG7vnPoz0naWS+wWp8I2sA55oi3H10WcvhiLckU=;
        b=0puoQ/fnFauHBVHBpyTWxfZhCBr1quSY1OFkY66NlCv3Uy00uORLQzAju7otlGlov+
         6XCvr9xAXqRK8h87qdRVt1AN4Cv+NPuvJUi8fiHPZWYCE8Cx3v4uwN49X0KJMo3R9Skt
         hUn/dX4+LzlIBD7wEvxI6o64sBNFR2iEMnfpU4FIzUQbanKF2PHkOoqNeCXJf8C369NA
         sro18C448WuyBziXfdIPLkWRyXSOC1pjiouRR86pp8kk4mdoT3E4TqUKoa5t1lDEBLiz
         80RvBqB6EDaUk/K4/xaXSANk3t5ts7KAMi76pe1NsU1654rp5KbDUH74q4C+NvShORaI
         H1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jB5yG7vnPoz0naWS+wWp8I2sA55oi3H10WcvhiLckU=;
        b=Os9vZ1uD5JuTdu8K7b8iFaK3nC7CzpaIQvuTF9NFtBiWg8XzKu1hmEEj6CdFY5z64q
         s9sMyDYkuNJdk14cByjr6iA6MJjeSwQUoPuqRmtCxFbUbJBqX1DWFSPxSo+Sl3UcG/Xt
         9mCCYKUudNocnnW55FddvUiII5wrsu8RWIK9I0t1XhKwx8PnTxYJ23otWdIH5VmDh0hE
         dGLNGKnuah1FPNdxaM5WKx/L/G9A22x/s6dLDjIFeLEpS+2WQWka+f5TUi5+IKgdUNNU
         ilm2aeKFi/XfiZv5BR3sH3b//WRlEP/WO7peYH/SQQaNLt+wpupKoBFCZq+ZIrpxOgOc
         u2aA==
X-Gm-Message-State: ABuFfogKBA8lYnWTitI1fkvFX8qMoSS9UdFQEpk/+Pek4U09AjHXEmCG
        ckgbmu5UFFXvE3COlAc6RQ+r6Q==
X-Google-Smtp-Source: ACcGV63PAR/+uIGuaE7diogwFOvEzVb8KGXTXIIyyTd2vZKb2s82KpDSZNkxODj2774QiipaqDaVig==
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr1967821wmg.47.1538144968709;
        Fri, 28 Sep 2018 07:29:28 -0700 (PDT)
Received: from localhost.localdomain (ip-123.net-89-3-157.rev.numericable.fr. [89.3.157.123])
        by smtp.gmail.com with ESMTPSA id w72-v6sm6827477wrc.52.2018.09.28.07.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:29:27 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Fri, 28 Sep 2018 16:28:14 +0200
Message-Id: <20180928142816.4311-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928142816.4311-1-mjourdan@baylibre.com>
References: <20180928142816.4311-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the meson vdec dts node.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../bindings/media/amlogic,vdec.txt           | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt

diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
new file mode 100644
index 000000000000..aabdd01bcf32
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
@@ -0,0 +1,71 @@
+Amlogic Video Decoder
+================================
+
+The video decoding IP lies within the DOS memory region,
+except for the hardware bitstream parser that makes use of an undocumented
+region.
+
+It makes use of the following blocks:
+
+- ESPARSER is a bitstream parser that outputs to a VIFIFO. Further VDEC blocks
+then feed from this VIFIFO.
+- VDEC_1 can decode MPEG-1, MPEG-2, MPEG-4 part 2, MJPEG, H.263, H.264, VC-1.
+- VDEC_HEVC can decode HEVC and VP9.
+
+Both VDEC_1 and VDEC_HEVC share the "vdec" IRQ and as such cannot run
+concurrently.
+
+Device Tree Bindings:
+---------------------
+
+VDEC: Video Decoder
+--------------------------
+
+Required properties:
+- compatible: value should be different for each SoC family as :
+	- GXBB (S905) : "amlogic,gxbb-vdec"
+	- GXL (S905X, S905D) : "amlogic,gxl-vdec"
+	- GXM (S912) : "amlogic,gxm-vdec"
+- reg: base address and size of he following memory-mapped regions :
+	- dos
+	- esparser
+- reg-names: should contain the names of the previous memory regions
+- interrupts: should contain the following IRQs:
+	- vdec
+	- esparser
+- interrupt-names: should contain the names of the previous interrupts
+- amlogic,ao-sysctrl: should point to the AOBUS sysctrl node
+- amlogic,canvas: should point to a canvas provider node
+- clocks: should contain the following clocks :
+	- dos_parser
+	- dos
+	- vdec_1
+	- vdec_hevc
+- clock-names: should contain the names of the previous clocks
+- resets: should contain the parser reset
+- reset-names: should be "esparser"
+
+Example:
+
+vdec: video-decoder@c8820000 {
+	compatible = "amlogic,gxbb-vdec";
+	reg = <0x0 0xc8820000 0x0 0x10000>,
+	      <0x0 0xc110a580 0x0 0xe4>;
+	reg-names = "dos", "esparser";
+
+	interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+		     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "vdec", "esparser";
+
+	amlogic,ao-sysctrl = <&sysctrl_AO>;
+	amlogic,canvas = <&canvas>;
+
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
-- 
2.19.0

