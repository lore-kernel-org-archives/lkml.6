Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD5720844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD5720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbeHAUjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:39:14 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:44559 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732223AbeHAUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:39:13 -0400
Received: from localhost.localdomain ([81.67.76.113])
        by mwinf5d86 with ME
        id Huro1y0012Sg6Vd03us41M; Wed, 01 Aug 2018 20:52:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Aug 2018 20:52:04 +0200
X-ME-IP: 81.67.76.113
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
Date:   Wed,  1 Aug 2018 20:51:27 +0200
Message-Id: <20180801185128.23440-4-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the canvas node in a syscon node.

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4dbb391b..d104b9e111fb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -423,6 +423,23 @@
 			};
 		};
 
+		dmcbus: bus@c8838000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xc8838000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
+
+			sysctrl_DMC: system-controller@0 {
+				compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";
+				reg = <0x0 0x0 0x0 0x1000>;
+
+				canvas: canvas-provider@0 {
+					compatible = "amlogic,meson-canvas";
+				};
+			};
+		};
+
 		hiubus: bus@c883c000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc883c000 0x0 0x2000>;
-- 
2.17.1

