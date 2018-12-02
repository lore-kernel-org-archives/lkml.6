Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BDC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D92D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsWJOX1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D92D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeLBVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35793 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeLBVXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so10161530wrb.2;
        Sun, 02 Dec 2018 13:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgAUgZMYJZIjzRzJK9ypNa/fl9KY0ic1eUS2w2DfDF0=;
        b=KsWJOX1kMXTN80csaT5pPTEjQrx3VGGFOkan/bulTcciI/fs5Gd6Bq5+7MQj/EhBzG
         ZDV/X3f3cbWYzoiJlkztlQRKq0Asn1DSH/gkWPRtM/REYGHD83t5J5dAB2jxKSXf/0m9
         8lWqSdRt0o1t/T3LlI9KNbR3ouNNC3ZEtXXAHEA1ufpIZrEPkG+V3Fzq5BylH4EMIXKZ
         Aug7gujK8oWxHBJXSENhl7yIisztp4XT32LhhBOW7LkpXcjJj+q33NGJCJpPkUHDvjZ2
         1pn2GggsZiHum3TZZBMFwSKr7KWd6NM03165FhwUH246TmUcPJX9+XeckNHCU/obweW7
         Xxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgAUgZMYJZIjzRzJK9ypNa/fl9KY0ic1eUS2w2DfDF0=;
        b=OkTqeZVw16bDmLiq4KNYHKq6DPf9c0R4F1obTuztIihOOAJDLrUUZr7rDvEcP4eVvH
         EoPlpilkc3tXMclh01Qs6wtVQ5kR43fZ56h88EsSsrIi5KrsDFJvDnmYuJGAJQkynLQQ
         737LQLRi/d0Be/kqEjJu9vw9/ajkxPn3yf/isa7ElSlORG+uQkCeOWUQHfFIsl84IrV0
         HOA4hcfpHxK3FADdGIvIaC/ssQLZ1nR/gyMG2nMyyVrsHTCQaXYrvX2OmTPR8lcWkKkN
         tqZXZLV7VLmbZFTRxaKPED3OvBbininNE0wlNbI06xZ0jMZrt+XaQtHPJhQmFfb2CcPe
         SVJA==
X-Gm-Message-State: AA+aEWagwRQTp6guAdlATRZz6NgfVctbuvG1ce+DszWELVzWVt6rlZ1J
        OGlfjiWnzZbnDgPviDstYzOZJeuAJ50=
X-Google-Smtp-Source: AFSGD/VGtijuXWwQ+C02/bsi4yr+HAVA7HQj8jMz2mHPV6Dge5x2BZL/rumzO+6MJvMGiSAsX1ag2A==
X-Received: by 2002:adf:d4c9:: with SMTP id w9mr11737329wrk.119.1543785819180;
        Sun, 02 Dec 2018 13:23:39 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:38 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 05/10] ARM: dts: suniv: f1c100s: Add support for DMA
Date:   Mon,  3 Dec 2018 00:23:12 +0300
Message-Id: <7978afbd9bb4a114e84df44c129d86e784659915.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s now has DMA support. Enable it under device
tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index aff5f90..4c96a9e 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
 #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+#include <dt-bindings/dma/sun4i-a10.h>
 
 / {
 	#address-cells = <1>;
@@ -65,6 +66,16 @@
 			};
 		};
 
+		dma: dma-controller@1c02000 {
+			compatible = "allwinner,suniv-f1c100s-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <18>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <2>;
+		};
+
+
 		ccu: clock@1c20000 {
 			compatible = "allwinner,suniv-f1c100s-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.7.4

