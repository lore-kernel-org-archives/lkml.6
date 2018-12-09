Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2862145D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5983n0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2862145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLIUbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37048 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLIUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so6521311lfh.4;
        Sun, 09 Dec 2018 12:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7NTxHD7UaCoUTgU+v8hwkvIH2LVxT97k7Jd0a6pcZY=;
        b=g5983n0Ro0+JH6CuvExtbKYfIoPtxdN6XGZzzOXnKHNiqukMlLPwBnuu29SXaYzUj8
         crXTN8Uhrb5m2619QoKVt569L3cqxEL19poQytji58YXFV69H2ottL99WYCGFhwaXbR7
         NY3aKhODkRiwXTcPFzSOjEQ5JuF1mhrYTICDYSXCHUTL5ZozT/RaXi1qd/uKLwaEURNi
         yEg8DN0B6zNNzq/tqvFWaV5YkXVDb8vy9OzB3XWi/B8XnT5xOmtf7BVe+DOvBNKXzsj5
         hjFRcQpe2RCqpYJjyb0r1cqfcWmBCsOMai/aOCpQEI10j0bf5r5/U7fycGJsZ/vgg52R
         Np5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7NTxHD7UaCoUTgU+v8hwkvIH2LVxT97k7Jd0a6pcZY=;
        b=aavBOax2XYbvzxeJIMrD/7TbcGUYQnD65n1lQgccgs5xPs3U6whSNPgyFL0uOXLzJz
         RCTKLEpVyNGIfaiw2t0Kipm22hMP9WpNp7PwyEXgspjE+6/vEbUdPVfieUAdRpcWZYS6
         FtmvqsH94OmueFOHZ/uE2ETRc5VVAY/I+ux97iaID/Rs93dh/08aWryUJMVV2eUCqj81
         /nW4/cuXkCuo3eFXEsUXKdHrI5ovyDSr/mOwEWM1UdthOqLVKLoAThaqGLlQXSPbQsE8
         gs/XDC1xLf0K3se3Pp1MIZyXrS1TPxmrh7cQ9kZ0wFNjq0V83GEw3CxQpQSXJsfgZKp7
         9lKQ==
X-Gm-Message-State: AA+aEWZ0URqk0TxUfZnhZ3UTF4MZxR0acdZ2/0ducVbTU64E22FybyRm
        sBwccLAa7CMm/Hq5RMBp4TU=
X-Google-Smtp-Source: AFSGD/W9XHkO3hY32VJpccRdUozIvd8GV/8EG/sxZO6hRHqNqAw8oyAnEcclZhi0ROdZmxbUCkTfEg==
X-Received: by 2002:a19:5510:: with SMTP id n16mr5206937lfe.68.1544387463606;
        Sun, 09 Dec 2018 12:31:03 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/21] dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
Date:   Sun,  9 Dec 2018 23:29:35 +0300
Message-Id: <20181209202950.31486-7-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
2.19.1

