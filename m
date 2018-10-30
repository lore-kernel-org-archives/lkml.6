Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691AAC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D99E20831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqePLD/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D99E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJ3TEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJ3TEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:04:24 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9197E20827;
        Tue, 30 Oct 2018 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894294;
        bh=R3ytHRTSyKgOw9TgLbuNHckf6iwiLa3tm7fYtUybiNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqePLD/E4lU42R6h+Tf+c5LZ+qBta1O22SGOjXU8DXeqY10+Jmjx3wj82kriGnHFz
         bFkdR7on3+yEjlF/O6uHLCmmoQGJW0yMiQRnv2PLH5MI3DVNksjprpwwz3R9Xp+/Uu
         FAqkFl+tu57giexCiOUW6qt9yw1SAOC2GdLVydPw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 02/17] arm64: dts: qcom: qcs404: Add reserved-memory regions
Date:   Tue, 30 Oct 2018 15:40:53 +0530
Message-Id: <20181030101108.11041-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181030101108.11041-1-vkoul@kernel.org>
References: <20181030101108.11041-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the reserved memory regions in QCS404

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 1bfc272b70e2..28e066927b50 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -18,6 +18,47 @@
 		reg = <0 0x0 0 0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		memory@85600000 {
+			reg = <0 0x85600000 0 0x90000>;
+			no-map;
+		};
+
+		smem_region: memory@85f00000 {
+			reg = <0 0x85f00000 0 0x200000>;
+			no-map;
+		};
+
+		memory@86100000 {
+			reg = <0 0x86100000 0 0x300000>;
+			no-map;
+		};
+
+		wlan_fw_mem: memory@86400000 {
+			reg = <0 0x86400000 0 0x1c00000>;
+			no-map;
+		};
+
+		adsp_fw_mem: memory@88000000 {
+			reg = <0 0x88000000 0 0x1a00000>;
+			no-map;
+		};
+
+		cdsp_fw_mem: memory@89a00000 {
+			reg = <0 0x89a00000 0 0x600000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8a000000 {
+			reg = <0 0x8a000000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.14.4

