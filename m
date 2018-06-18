Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E31C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A342083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ysKV5YZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A342083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935716AbeFRRnP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934957AbeFRRnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:43:14 -0400
Received: from localhost.localdomain (adsl-84-227-236-43.adslplus.ch [84.227.236.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC9320836;
        Mon, 18 Jun 2018 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529343793;
        bh=X+DBD026pX7OLEV34xL9+fOT9CrmIkR14muPU3vRAQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysKV5YZ9UECqzwcSuVRtArtGpXxD/oMnlIsrKiZA62uSdztWEC0Ul5/sEu+0fPwq9
         63S60tq04q3R0pcHO3PrtKwF27yL39DbkAK87NkpgW0eCjeadUBbYNOcvDukr8Xi8F
         /wQvizz5Vy2kRbL0dy2+GzYvaPToetBhGenjQAkU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON address/size cells in Exynos5433
Date:   Mon, 18 Jun 2018 19:42:16 +0200
Message-Id: <20180618174216.24801-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180618174216.24801-1-krzk@kernel.org>
References: <20180618174216.24801-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decon, decon_tv and dsi nodes have only one child port so
address/size mappings are not necessary.  This fixes DTC warnings like:

    Warning (graph_child_address): /soc/decon@13800000/ports:
        graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  6 +-----
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 12 ++----------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a1e3194b7483..0a15ee513f5c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -321,11 +321,7 @@
 	status = "okay";
 
 	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
+		port {
 			tv_to_hdmi: endpoint {
 				remote-endpoint = <&hdmi_to_tv>;
 			};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 3a9b4c4b9c63..e4367fd39120 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -850,11 +850,7 @@
 			iommu-names = "m0", "m1";
 
 			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					decon_to_mic: endpoint {
 						remote-endpoint =
 							<&mic_to_decon>;
@@ -914,11 +910,7 @@
 			#size-cells = <0>;
 
 			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					dsi_to_mic: endpoint {
 						remote-endpoint = <&mic_to_dsi>;
 					};
-- 
2.14.1

