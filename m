Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2972080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KegQ2IEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2972080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeLLUwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42508 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so9434071pfr.9;
        Wed, 12 Dec 2018 12:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FKM4LRemwvTIhAkZE8YXR98dvGdEFBr7fGQqgFFRso=;
        b=KegQ2IEtO59NJQ4kpE2qSbYdTLx/95cFRSEy61bIa4LNn/1kbe+ZUZXKEgRwYzQju4
         G4NQ658VzQcd+sfD6bKqralBesX/m8r4QjtTSNlp7wJpiC3yfCuMFKchjUn4GT85o2lA
         XYN9O7Yg/+8pxV4OPN2QV0oQEG9W9GCaIJxCIjYyR7mR6H6YORHa8jMWKnf1w2KBAssU
         r0095D/9XPYG/kmGHKC6gY49ucBMEGWW42mlUVciLFHZ2fLpQ5bYCLw1kYC8B5V78goV
         d8CCzQ/QVTUtml4qKK00oTXm7i06tQSsIyunUXw3DcSNAmPA6aAS4YW/pB+QOsCjlBGB
         5abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FKM4LRemwvTIhAkZE8YXR98dvGdEFBr7fGQqgFFRso=;
        b=Jw+scD3Ny1vDhCp9ucm0LZyq/m3h0lU/VEzseo4DNC4rLsfVKJxre4yy1z5OVFp9Di
         ZZpyKRhNXhG5JnQeby1ViMwXatEa7xETEjsKKSHRJPvNaRBwsTetZXAmnv+oAaHHd8pc
         Da2DRNwF3WsqRv3BOusyVVVQifNGD6iqcj8youG4mV5L486T8F6r3ueURD0fVGF3ZOoO
         HUI/6KyRpUw9mwnW1inavVvTKqq3LG6q75lNjs0QiN1oKCIZC88ZI+F82W7qzx0pKllv
         L8ufnGpScrSxSSb+jiO+OowlXvFcMFMpBPylu3YzMX9+C11giAvh0EQTepfDfw/OYtLS
         VkSw==
X-Gm-Message-State: AA+aEWarHmK9vyIon8FnSZIuSV9l/Bcu9NBhAyU00S3nfWL/4wTzV1AK
        zpe6T4qdovtFJ/Nsoib5fno=
X-Google-Smtp-Source: AFSGD/VUKnoUXfA1kAw+mJ2ozF6tG3ol8GBldP/nqzyrdqXEwVXAk/5nvclaaX+5fNWylhKMFaE/Lg==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr21355962pfn.153.1544647956261;
        Wed, 12 Dec 2018 12:52:36 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/24] dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
Date:   Wed, 12 Dec 2018 23:38:49 +0300
Message-Id: <20181212203907.23461-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting GART and Memory Controller wasn't a good decision that was made
back in the day. Given that the GART driver wasn't ever been used by
anything in the kernel, we decided that it will be better to correct the
mistakes of the past and merge two bindings into a single one. As a result
there is a DT ABI change for the Memory Controller that allows not to
break newer kernels using older DT and not to break older kernels using
newer DT, that is done by changing the 'compatible' of the node to
'tegra20-mc-gart' and adding a new-required clock property. The new clock
property also puts the tegra20-mc binding in line with the bindings of the
later Tegra generations.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
 .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
 2 files changed, 19 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
deleted file mode 100644
index 099d9362ebc1..000000000000
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-NVIDIA Tegra 20 GART
-
-Required properties:
-- compatible: "nvidia,tegra20-gart"
-- reg: Two pairs of cells specifying the physical address and size of
-  the memory controller registers and the GART aperture respectively.
-
-Example:
-
-	gart {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
index 7d60a50a4fa1..e55328237df4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
@@ -1,26 +1,37 @@
 NVIDIA Tegra20 MC(Memory Controller)
 
 Required properties:
-- compatible : "nvidia,tegra20-mc"
-- reg : Should contain 2 register ranges(address and length); see the
-  example below. Note that the MC registers are interleaved with the
-  GART registers, and hence must be represented as multiple ranges.
+- compatible : "nvidia,tegra20-mc-gart"
+- reg : Should contain 2 register ranges: physical base address and length of
+  the controller's registers and the GART aperture respectively.
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - mc: the module's clock input
 - interrupts : Should contain MC General interrupt.
 - #reset-cells : Should be 1. This cell represents memory client module ID.
   The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>
   or in the TRM documentation.
+- #iommu-cells: Should be 0. This cell represents the number of cells in an
+  IOMMU specifier needed to encode an address. GART supports only a single
+  address space that is shared by all devices, therefore no additional
+  information needed for the address encoding.
 
 Example:
 	mc: memory-controller@7000f000 {
-		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
-		interrupts = <0 77 0x04>;
+		compatible = "nvidia,tegra20-mc-gart";
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
+		interrupts = <GIC_SPI 77 0x04>;
 		#reset-cells = <1>;
+		#iommu-cells = <0>;
 	};
 
 	video-codec@6001a000 {
 		compatible = "nvidia,tegra20-vde";
 		...
 		resets = <&mc TEGRA20_MC_RESET_VDE>;
+		iommus = <&mc>;
 	};
-- 
2.20.0

