Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C54BECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249A62145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="PuzEzhrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249A62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeIYQyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:54:05 -0400
Received: from onstation.org ([52.200.56.107]:38404 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbeIYQyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:54:03 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id B3288187;
        Tue, 25 Sep 2018 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1537872426;
        bh=U1Y2hZMAIugzKdBzZ9gpXgYsPRlNK7XuKZvBm8nDXNM=;
        h=From:To:Cc:Subject:Date:From;
        b=PuzEzhrngwr49sheUbuRdQBJUCtrxyI8NcyHnrVUTWVblF+Fufef4oPeEnwc3xRLp
         Uy3sv3aU0LyGOGlxRqEubpEePDHxdOulUC6EKdQ5lXNnUgGBFQudXcKiMJq2vrdAf0
         x9sEPyVHJqK2LdSGjoqHDEW0HqWxxtjqvI2va3Nw=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frank.rowand@sony.com,
        masneyb@onstation.org
Subject: [PATCH ARM-next] ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value
Date:   Tue, 25 Sep 2018 06:46:51 -0400
Message-Id: <20180925104651.16596-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commits used IRQ_TYPE_NONE since that matched what was
already in the file and I do not have access to the datasheets for
these devices. After these patches were submitted, commit dcf145011400
("ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value")
changed all of these values to IRQ_TYPE_LEVEL_HIGH. This patch corrects
the IRQ type for these two commits:

commit bd9392507588 ("ARM: dts: qcom: msm8974-hammerhead: add device
tree bindings for ALS / proximity")

commit fe8d81fe7d9a ("ARM: dts: qcom: msm8974-hammerhead: add device
tree bindings for mpu6515") 

Prior to these patches, I was having issues with the bmp280 sensor
returning temperature / pressure skipped errors, however these errors
have gone away with these patches.

Patches were tested on a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 84e1fee1bf1a..a808973f9dc7 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -719,7 +719,7 @@
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9925000 0x1000>;
-			interrupts = <0 97 IRQ_TYPE_NONE>;
+			interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -754,7 +754,7 @@
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9968000 0x1000>;
-			interrupts = <0 106 IRQ_TYPE_NONE>;
+			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
-- 
2.17.1

