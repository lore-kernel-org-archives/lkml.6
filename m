Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A03C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65182087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ylUxpLvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65182087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbeKQEoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:44:30 -0500
Received: from ziggy.de (unknown [93.176.147.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408E12086C;
        Fri, 16 Nov 2018 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542393060;
        bh=hnTlZcSoHgN90xrVL83ctgDbWsmsi2Qut7xpi4Uskp8=;
        h=From:To:Cc:Subject:Date:From;
        b=ylUxpLvdViPceO8x9799lA51Coo86UvY8rpQUKz4uWFDkAUS27Y3IzHpAvOtGA7Qq
         I3mQNBtGKzS5LCfKPDSAC+Muhy5ASiSSOqbaWkcuP2qPk/SH9pdAhIJKs4TuKTz+ln
         6WyB2lcUpi7y6B9QX57edhS2TW9FE/et6IJH2b2Q=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] arm64: dts: Add uart for mt6797 EVB
Date:   Fri, 16 Nov 2018 19:30:40 +0100
Message-Id: <20181116183040.18696-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

This patch adds the pinctrl configuration for the mt6797 EVB.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/boot/dts/mediatek/mt6797-evb.dts | 2 ++
 arch/arm64/boot/dts/mediatek/mt6797.dtsi    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
index c79109c65409..237e869a5fa1 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
@@ -33,4 +33,6 @@
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index a64bb84bdec3..2b2a69c7567f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -142,6 +142,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
+		uart0_pins_a: uart0 {
+			pins0 {
+				pinmux = <MT6797_GPIO234__FUNC_UTXD0>,
+					 <MT6797_GPIO235__FUNC_URXD0>;
+			};
+		};
+
 		uart1_pins_a: uart1 {
 			pins1 {
 				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
-- 
2.19.1

