Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC482C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9336B20883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gUf27dsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9336B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIKUJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:09:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54906 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIKUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:09:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so1378105wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RQsmsBThB2HiU5fFcpahoK7bzxzFBRhYwA17fSoM3ek=;
        b=gUf27dsXjAYLpxM1GZxVYU3eUPCPi2/IZH79WgCwxr9dDwOzZgDB8CSNxDBSkDwVOB
         aMD4+EdBkQE15DW2e8XVOBm/i+TLDMmKLshmWoYiBF9N/hzcPRnYWcfhdDbe77ZpuYni
         MXp99gh82WxqGz5yo9bZpXTOuAwkV98ISO+BcdhsmPOlDB1ige68JyQacJwDJWVwa34l
         Q3n47jgx5b1tCnKjZ65DfPNxWEe4+z6TXs5xOs8CVACc/FyqBn90zTXHzUPfdG4kp0Iv
         RTxHwRsaIvHDWMY4KfWoRRqx3HiGLmEjHwWrAc0kGe/l2sRjZ+dV8pEE4HjgL3HDulSR
         YEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RQsmsBThB2HiU5fFcpahoK7bzxzFBRhYwA17fSoM3ek=;
        b=XS6KRqMYSKy8S2YjTqdJPBRzRiCSwlkeuDBxN8FPRj4fH31yfWeRHFf+uUq5cQzero
         GNwe3U3ebn+afgUoPMzNO7Yz8LLxiqkFNGf8vpqjEoKce0H0MJZEb8vtDOdS7AFESqTn
         1rynCzZjl4qjzHSP8SCBItldGFEp48L5UYinLYOr+5G1gRL80wjQkS2uwHaBIAxJFYNE
         4glTGokzSyLtjxwhuGDoCDn15UQeLExBrrRIifvkfhkuFzdtGSJAt6hE3+YLyTUmjuXC
         p3WyN1NqEZhXZwrkYP3EdLcj6cTulcQ8dEAyGxgY5iU/Gz6BufLbkAfkgl6fNc8szrql
         jHUQ==
X-Gm-Message-State: APzg51AnfmcXwxheB81qvkG3RJNXwl2SikveSlu0sG5rAsJHQB/wPy5W
        riFBM5GYg/olKijHt7Tt2CTLoQ==
X-Google-Smtp-Source: ANB0VdYC7MgsxMraS7WhRVD2IRn7/34YNhwNBTrWFN6gQZjmqVyM14HM4jmRDUqezyCpLkSyaAgMEw==
X-Received: by 2002:a1c:7fc6:: with SMTP id a189-v6mr1559911wmd.42.1536678590563;
        Tue, 11 Sep 2018 08:09:50 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id x65-v6sm618625wmg.39.2018.09.11.08.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:09:49 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Tue, 11 Sep 2018 17:09:36 +0200
Message-Id: <20180911150938.3844-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911150938.3844-1-mjourdan@baylibre.com>
References: <20180911150938.3844-1-mjourdan@baylibre.com>
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
2.18.0

