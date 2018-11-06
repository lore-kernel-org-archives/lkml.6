Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CCC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAB920881
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fMT+XlXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAB920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbeKFRXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:23:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40818 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeKFRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:23:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so12304015wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvQr26dE1Pd4854P54cKSVSs7jJbMx46LgtS14t7TKQ=;
        b=fMT+XlXkOnhKwIgpSl4pj78cA5sK2n/XIQihgqPKSvW5cDKzMRk5opLgY7FdpAfgPA
         QUw7Gp7fQkY5IO9lkrNWyk310asrxb+1o07EevbdOEV06wQxsaSMPLz2HLodt9s5RxWT
         P0iKlp9fbiOqBDxA59euvJ5RGiwREk7qfMM8g7xtf2zw2N18uZklUhF73W+uVDPMmbHQ
         TvNbrznW27mj5RbxfF02G9gTad0X/zjQsbHO6PPmhGFmjG1cXLn9DyX0QBi+eaB/iDsg
         HjrrEeQlEZLwniLFlxDTKkTvAT0O9T97tO/y3OJIJglEVk59/GigyIbBN+oCTPOIuDMs
         LVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvQr26dE1Pd4854P54cKSVSs7jJbMx46LgtS14t7TKQ=;
        b=TfXTJc+NLhJVIFlAYQaIJ9AoTXdVbJAw4relwUvzf3YSOfw7k0MwkePpmSWgr+M8EG
         O3zfkKrawnlK9U0oPrnQVJdxreXX+NWN8inM0kpRx6N1rYvZbT2ufKuB+CSJMChlxdjY
         pdzlxvV7bAAgDZpzE7XMP6nvY6UM6TUZJZn9OL1+HtJZIO62key1vwI4nnaZ5+gzyp55
         Cz/QpIow/6TqUdYjNRQejKh3pabTKGrkJZapH0/Y61gJxTFriWBU4SDhMXAQeWCcNbFN
         aGutsB5uNR123yVF+6obiVDZqiAGvNpxcSEN3/cIfdUUagFkC7mZXik51Dn0GDTFo7yB
         ykBA==
X-Gm-Message-State: AGRZ1gKzeihngTzAwmBAN9tGvZkHMSX9cDJn/6T+BiywQqPMglM3ucEU
        P9vE8AUGfCNSwOiFXo7yBYxL4Q==
X-Google-Smtp-Source: AJdET5dc40A9V2BoFA6iP/lgi+2NoDSxDRvtJ3hMx2kGpvQ7vQRVp6AyuZ2heUsnRYQi+ovNSa1y4w==
X-Received: by 2002:adf:cf02:: with SMTP id o2-v6mr23769258wrj.258.1541491181345;
        Mon, 05 Nov 2018 23:59:41 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id z16-v6sm918171wmc.0.2018.11.05.23.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 23:59:40 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 1/3] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Tue,  6 Nov 2018 08:59:24 +0100
Message-Id: <20181106075926.19269-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106075926.19269-1-mjourdan@baylibre.com>
References: <20181106075926.19269-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the meson vdec dts node.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.19.1

