Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB24ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364D620840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG5jOd3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364D620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeKID20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeKID20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:28:26 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08D320827;
        Thu,  8 Nov 2018 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541699510;
        bh=rBdiDcXhGABoXowC2nl0Oxd/IOB5n6ZwwrLs1n2op7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG5jOd3GDH6FMKSAz3mz3k+JFqryij7okWaa6+Zn8/3hootG0miDCruqXP4u468RR
         uTsF8GAQytOIMXLdEsqlDNV0dA4y7ZOMVl0sXw1y/c9J2udLaDY4MkDNI67Wgu7yUc
         UlCslax+ZvPTwSD5B/sCAWc+KJoX3y9J25gpA1fU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 03/18] arm64: dts: qcom: qcs404: Add reserved-memory regions
Date:   Thu,  8 Nov 2018 23:20:34 +0530
Message-Id: <20181108175049.7090-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108175049.7090-1-vkoul@kernel.org>
References: <20181108175049.7090-1-vkoul@kernel.org>
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
index b77d1198ba79..58aa1f989089 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -73,6 +73,47 @@
 		method = "smc";
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
 	soc: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.14.4

