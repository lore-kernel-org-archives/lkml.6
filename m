Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x224qlf4a76Z8Ihhqbf0jaTxp+GspFqkCLpkfV0+4OzeL2qXnCZhU3mqyERuBRnzQGCO2JM6b
ARC-Seal: i=1; a=rsa-sha256; t=1518173846; cv=none;
        d=google.com; s=arc-20160816;
        b=oUnrfMBNijlx/sKF04SnW9l8xfJ+P96DPF0MRIrR9aTLX+dwx2hF6MLsjVCmnIEtD/
         fbbzAxCzJNguPUIe4jZhkTKnycokk6A0Fd241YuNuotDDYvgDC59J/60sLYx/iplCozc
         S9OSrNu5HPXb5jcWSqGtec12udw7GyLNNq7biEZejyiXk3PBlz2NnI5WaExJd9sqK1cD
         HpglX1laA8hnjMEVeb9U3ki+n1Cthk6Ontsfu//p517USrnp9rBc9Q83TKRp8hz4mfFP
         q3Bnfb8fJU53EcUnFpMZny1+sHphxHXMqqsyC5QllXE/bUsKbiYsJFioQNL2PBMMkICb
         0LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hLToIi+DP4jPNmNeU0ymnd7CprnvN9jZpbOy4CS1x40=;
        b=CyPG1ijvIe9fCg9OfDbO3exroESn0zgJlYqGFyYhLJpzXKWJzWWpLxvtBLOd7MEO3t
         R1ErSdm1v49Gev0SJGqSxIwn6ignCEF3waaPUoMPY9Qdt3/4osewgNlIsCo/7WrkKixF
         ANoM8MT6eNhkqmD8svlON51o9tVUWDchZnsv/FdGlox90y4DXLTduvoGYSWTajascQpf
         x+Cph3loDfhjupwTWWqygCLhpzyZ7BqOBNuBo7e6DZ/Lvrei5mkIRbmNaas6nlDCuWK8
         YIoIhAkijWGd2fwIJ5x7Hewv0fuFX4NoBWyP1rHqqcpMxcYmQwgFrHVYECVCkmuzc7CK
         ZYlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XuF00p+y;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mtS6cXUH;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XuF00p+y;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mtS6cXUH;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EABE60314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	rjw@rjwysocki.net,
	robin.murphy@arm.com,
	will.deacon@arm.com,
	robdclark@gmail.com,
	iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: alex.williamson@redhat.com,
	gregkh@linuxfoundation.org,
	sboyd@codeaurora.org,
	sricharan@codeaurora.org,
	m.szyprowski@samsung.com,
	architt@codeaurora.org,
	airlied@linux.ie,
	linux-arm-msm@vger.kernel.org,
	vivek.gautam@codeaurora.org
Subject: [PATCH v8 5/6] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
Date: Fri,  9 Feb 2018 16:27:06 +0530
Message-Id: <1518173826-11759-1-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517999482-17317-6-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-6-git-send-email-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737878253050989?=
X-GMAIL-MSGID: =?utf-8?q?1591920659288791685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
clock and power requirements. This smmu core is used with
multiple masters on msm8996, viz. mdss, video, etc.
Add bindings for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v8:
 - Added the missing IOMMU_OF_DECLARE declaration for "qcom,smmu-v2"

 .../devicetree/bindings/iommu/arm,smmu.txt         | 43 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 14 +++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce12af5..169222ae2706 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,10 +17,19 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
+                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
 
+                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
+                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
+                  string that should be present along with the "qcom,smmu-v2"
+                  to facilitate SoC specific clocks/power connections and to
+                  address specific bug fixes.
+                  An example string would be -
+                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
+
 - reg           : Base address and size of the SMMU.
 
 - #global-interrupts : The number of global interrupts exposed by the
@@ -71,6 +80,23 @@ conditions.
                   or using stream matching with #iommu-cells = <2>, and
                   may be ignored if present in such cases.
 
+- clock-names:    Should be "bus", and "iface" for "qcom,smmu-v2"
+                  implementation.
+
+                  "bus" clock for "qcom,smmu-v2" is required for downstream
+                  bus access and for the smmu ptw.
+
+                  "iface" clock is required to access smmu's registers through
+                  the TCU's programming interface.
+
+- clocks:         Phandles for respective clocks described by clock-names.
+
+- power-domains:  Phandles to SMMU's power domain specifier. This is
+                  required even if SMMU belongs to the master's power
+                  domain, as the SMMU will have to be enabled and
+                  accessed before master gets enabled and linked to its
+                  SMMU.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
@@ -137,3 +163,20 @@ conditions.
                 iommu-map = <0 &smmu3 0 0x400>;
                 ...
         };
+
+	/* Qcom's arm,smmu-v2 implementation */
+	smmu4: iommu {
+		compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+		reg = <0xd00000 0x10000>;
+
+		#global-interrupts = <1>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		power-domains = <&mmcc MDSS_GDSC>;
+
+		clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+			 <&mmcc SMMU_MDP_AHB_CLK>;
+		clock-names = "bus", "iface";
+	};
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c7e924d553bd..40da3f251acf 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -119,6 +119,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -1950,6 +1951,17 @@ struct arm_smmu_match_data {
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 
+static const char * const qcom_smmuv2_clks[] = {
+	"bus", "iface",
+};
+
+static const struct arm_smmu_match_data qcom_smmuv2 = {
+	.version = ARM_SMMU_V2,
+	.model = QCOM_SMMUV2,
+	.clks = qcom_smmuv2_clks,
+	.num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
@@ -1957,6 +1969,7 @@ struct arm_smmu_match_data {
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
+	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
@@ -2319,6 +2332,7 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
 IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
 IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
+IOMMU_OF_DECLARE(qcom_smmuv2, "qcom,smmu-v2");
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
