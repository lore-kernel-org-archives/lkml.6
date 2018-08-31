Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F06C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBDB20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t7sWQrK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBDB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeHaM6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:58:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50999 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeHaM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:58:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so4455004wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5ZXPohegRsBDzKYcCxu+5kCCIl+B1D8BkaNxL0J9FM=;
        b=t7sWQrK9FNzN90zApanyst/lB3P60bjy+mLr9HXGT72Y8VKDfT9iMidEUERnI9B0q2
         QmUoOm4/fuZc0tVFRE/TDNWCJnMejfAIGBUzLO7aOCooXH7GLf26/c9PlaDokZH8sDu3
         DljsVkVjnKcZDCSv1KNoFnHlTdNywS397KWcFCe7a/fLPDhaaUhMElApOHFxHUnfHxEr
         QdEoXnAk8sJ3RMqW61xlWvX44o41xisKUUW4G5YpaWO3V+DOmXjrO1lpPKtN77mugxzc
         /DNk3gPrGCoXeXlGWh5tSo9BwGib3zC/XdweqQqv4e0jl5O1yFWJBZPIyIrWwwLCOU6n
         NpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5ZXPohegRsBDzKYcCxu+5kCCIl+B1D8BkaNxL0J9FM=;
        b=sGYmoHvlC9mcOf4A3drTc0fXiDOD8dZr3Ru4ucGqk5TLJbbOxj5qf5/0p2ZgdP0mb3
         HeDvQg6mgncjoCRyRuhTn8s97szPcf1MOEryjFX1duxjeoadqV0PneJ640gxXZHpx655
         Gzl/p4B7ySGmtzThIA/u0Q3Dd3Ea3cQaHUruwzBEQZHgeHpOatwBvSnCIooykS+dY0lg
         PzvpWQyvrAfAlXwsN60FFS0+pbzqQqjtgjXy1AA6DaRXNf+BQaBDXarvJNCBBAHdDy+X
         rIjqwlJWI2PZzwb86Gn3VU9UmVY373CpuR7r9C2Uck6UzaSIhBc4k2aJtY/A+wrJgoQ0
         NvIQ==
X-Gm-Message-State: APzg51BpFRJ2Ndp45A4N02hMuhXllHB+cfKUYj7VLThPGYvsQTkETn29
        UIdZ9RLL1fY8wyMcMeKWn+VTFQ==
X-Google-Smtp-Source: ANB0VdZuF2Z7oZcRpfLKWARsOTyA5nGz1TCHpIWSS0Z2P3l2YaVafaLKCfGWu96XREgGQhau7HcxfQ==
X-Received: by 2002:a1c:c147:: with SMTP id r68-v6mr4167561wmf.161.1535705537430;
        Fri, 31 Aug 2018 01:52:17 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id v6-v6sm8920822wro.66.2018.08.31.01.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:52:16 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Fri, 31 Aug 2018 10:52:02 +0200
Message-Id: <20180831085205.14760-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831085205.14760-1-mjourdan@baylibre.com>
References: <20180831085205.14760-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the meson vdec dts node.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../bindings/media/amlogic,vdec.txt           | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt

diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
new file mode 100644
index 000000000000..c6450f2e7f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
@@ -0,0 +1,63 @@
+Amlogic Video Decoder
+================================
+
+The VDEC IP is composed of the following blocks :
+
+- ESPARSER is a bitstream parser that outputs to a VIFIFO. Further VDEC blocks
+then feed from this VIFIFO.
+- VDEC_1 can decode MPEG-1, MPEG-2, MPEG-4 part 2, H.263, H.264.
+- VDEC_2 is used as a helper for corner cases like H.264 4K on older SoCs.
+It is not handled by this driver.
+- VDEC_HCODEC is the H.264 encoding block. It is not handled by this driver.
+- VDEC_HEVC can decode HEVC and VP9.
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
+- interrupts: should contain the vdec and esparser IRQs.
+- amlogic,ao-sysctrl: should point to the AOBUS sysctrl node
+- amlogic,canvas: should point to a canvas provider node
+- clocks: should contain the following clocks :
+	- dos_parser
+	- dos
+	- vdec_1
+	- vdec_hevc
+- clock-names: should contain the names of the previous clocks
+- resets: should contain the parser reset.
+- reset-names: should be "esparser".
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
2.18.0

