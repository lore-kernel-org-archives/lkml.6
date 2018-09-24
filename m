Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBEE21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUN+J5+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBEE21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeIXGqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so8312693pfh.2;
        Sun, 23 Sep 2018 17:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jwig3gR4KuZu0LsKNX4C9XVq74klR1l14Mz0aRWZXhE=;
        b=vUN+J5+M1MN3GMRH4asx+EAJafNw4dNxG5dKZf1snWTVSwIh2OHUybe7Jfo9ZUW1HI
         dWIe5Bysnqp8FO8xZXNj6cKcms2jrFfECdRY/TbG2H7/sFaXZ+OlHcqlkIaT8rCwYG/m
         hLtN2nfPiQPTKDRKD0z7Mgml9Fc9Idkz2rIcx3yfe6Z+IUYp18TbqK962XqKkDQKiYwn
         yA+M8V+9kMgcC2N4BmuJaqZfFsuyKbScQ/1oezD7AO/bulOs/twwbew8tEH/JIzDoV9j
         kF9OQKe7s7wsy0tf13S4gBkUPFUx8ZDDNzz8u291+ewHqPhv15uYJ5f5BSfifGUA7gR4
         uD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jwig3gR4KuZu0LsKNX4C9XVq74klR1l14Mz0aRWZXhE=;
        b=bFieqdQx7rsBQ99Z0lPfspU5+cBxogd4md87L7ezT42x4ru2mrfpKfIN3gLpP6wNAP
         UoRKMZG69rMvbzcIi7qP7+Gq5Mpho2tH5OjyZSVmIVWqhiJkIycHK+Ujr+4DW/U9Lqz9
         eaakWDSqJSKTU+5/dEr2IdrbZSSZ11hSB9PKTwSasdF5E43JTxgkIJZhe3hswHWJ3Op7
         t8/YsMncEqltGNYkh2oPDlMUDMl4OA8RJ8SqSmnTsZqSG3DXLQoEoTmITukMOSOmumKE
         WOEGMMYYDX3lffE2IcmeLip7RGxoSgU9MH/ojq5XfC6/dCrf5bt9B3Y1T0FafqUqGzbX
         B2Ug==
X-Gm-Message-State: ABuFfohHfb3dvikYIzrcLb0BZrUID880Zx7cgiSEIX+dKn41pRPXh3YP
        JS4cWGE8RCXU8Cy8W7+Vb6Q=
X-Google-Smtp-Source: ACcGV63pUUAntWuhmn5g2fY34gtzUqvNNwlneupvoagQSM/7hMhtWMifC7VbrNnEqOjt4aQIchTmug==
X-Received: by 2002:a65:4c43:: with SMTP id l3-v6mr7327138pgr.451.1537749993374;
        Sun, 23 Sep 2018 17:46:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/20] dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
Date:   Mon, 24 Sep 2018 03:41:39 +0300
Message-Id: <20180924004153.8232-7-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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

