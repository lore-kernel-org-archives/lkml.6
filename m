Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE0C64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65000208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM7D1hzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65000208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJAFXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33256 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJAFXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id o21-v6so8487911lfe.0;
        Sun, 30 Sep 2018 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4TafnpHkH2faESp2tE6d5tEh7fBURhSyO0Kw0ygz3g=;
        b=rM7D1hzvo1Ns1gS6UCjONNj4YfEPiwcnkPW+nRTucQ3lYilW4Vzg2PlEudWV7i7Trl
         jP3e5j9UldjlmtvgDjxRvO7ovKt/XzNLMSCO5vOLNGruHElmhD1j/MRycb5a7LWePLrf
         gRmRVQwTjHXDJ5grxqC6AVhZpcg8tELZuHN0pJuPqzUbasMfFLvtttTMysQG1OQW5zy4
         PjupbxCs+QY9Ee5MNQgivoyVVt4QdVfFLrmRGvNGb8KVQIyxx5GEz9nLpaDm9wuYCN0P
         zFuarlCu804dE8Xzb7E5Xlr0279ARrBMhp3zI60091gT133UoGWoacuUn1agMh6Wv2z/
         qajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4TafnpHkH2faESp2tE6d5tEh7fBURhSyO0Kw0ygz3g=;
        b=al82x1x2TmlhLw/0Y9fBaF7YXbYLLl0Ptm1pKtN/z5oAH9lgmsJyyGyyl+sif/+2O2
         eU0b3XZFN/hNSIIn9Jneeh6jiIYLECRmVHn9py5pCpSavVCPHDBE/K1n9ZXn5TNFaJ2t
         KrlCOK7uLJhqaoKvZrIPQD+3YHvEi+M3IEI+/M4uqKD7xqN+XC8eHLGxV8dLS3TB8rXh
         Ikb/2EtPy1002bCooFDa382iGz6bjOCFA3qtKVm4plST803pVSz3elVbLvCZHd7WrH4u
         p8T3tFaLoAJyv3/gMg67Tu5mt1DBgi0wLAAdX+ub6PmrSHZkDbIVHcQy52XxgTALdDl8
         +pvw==
X-Gm-Message-State: ABuFfoi94saful7vgmEg+BiTsKzrFjBeRnFC40Mn5xS0FhX2W4PQfFk3
        r/zpfBr2uTazX1TaOKUfxRo=
X-Google-Smtp-Source: ACcGV61pMbg4hvkq+NM1ZlN//dL1iCr/py8lwo21cSQSoEnCCvbDCgJG20KuJxfHkx0SpDACn4oGyg==
X-Received: by 2002:a19:7391:: with SMTP id h17-v6mr4199055lfk.140.1538347739823;
        Sun, 30 Sep 2018 15:48:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/21] dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
Date:   Mon,  1 Oct 2018 01:48:18 +0300
Message-Id: <20180930224833.28809-7-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
2.19.0

