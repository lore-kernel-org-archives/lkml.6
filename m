Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB8FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723C620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="V67U7dTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723C620832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeK1Uyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:54:49 -0500
Received: from onstation.org ([52.200.56.107]:54244 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeK1Uyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:54:49 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id EDD0917F;
        Wed, 28 Nov 2018 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543398824;
        bh=3KFZXDuaCe8n7wv/LNLkyfMbsNdU7avkSzYETCu+Ui0=;
        h=From:To:Cc:Subject:Date:From;
        b=V67U7dTBZpR4MegjNYCex40oe3N4PczkKKIKAnJsaMof0MknFAFrt2OKJJa/qTiug
         KS4u+3bTiFFcOWo028RgxQ9FwNQ7b8LTH/OsDklaOl/If9Nk3B3Dzu81+72Ss4Z597
         9zsoNV5EQtitWSTyBPnPjnshm1EU8789X3ANcQ6s=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: msm8974-hammerhead: correct gpios property on magnetometer
Date:   Wed, 28 Nov 2018 04:53:35 -0500
Message-Id: <20181128095335.5538-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch correctly sets the gpios property for the ak8963
magnetometer's DRDY pin so that interrupts work properly.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index fe2b5524a679..551d262a044a 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -368,8 +368,7 @@
 				ak8963@f {
 					compatible = "asahi-kasei,ak8963";
 					reg = <0x0f>;
-					// Currently only works in polling mode.
-					// gpios = <&msmgpio 61 0>;
+					gpios = <&msmgpio 67 0>;
 					vid-supply = <&pm8941_lvs1>;
 					vdd-supply = <&pm8941_l17>;
 				};
-- 
2.17.2

