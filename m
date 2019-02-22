Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3959020823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBVJfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:35:40 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34316 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:35:39 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 8AB1E3C013F;
        Fri, 22 Feb 2019 10:35:37 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TAm_lc9KVK2t; Fri, 22 Feb 2019 10:35:27 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 7DEF13C00C6;
        Fri, 22 Feb 2019 10:35:27 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 22 Feb
 2019 10:35:27 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <horms+renesas@verge.net.au>, Jiada Wang <jiada_wang@mentor.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH] arm64: dts: renesas: r8a7796: remove unneeded sound #address/size-cells
Date:   Fri, 22 Feb 2019 10:34:59 +0100
Message-ID: <1550828099-3109-1-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

commit 78bc93b3ffb2 ("arm64: dts: renesas: r8a7796: Add address
properties to rcar_sound port nodes") added missing #address-cells
and #size-cells for sound ports.
But, these are based on platform, not on SoC. This patch cleanups it.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts  |  1 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |  1 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi            | 11 -----------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index b4f9567..2aefa53 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -68,6 +68,7 @@
 	ports {
 		/* rsnd_port0 is on salvator-common */
 		rsnd_port1: port@1 {
+			reg = <1>;
 			rsnd_endpoint1: endpoint {
 				remote-endpoint = <&dw_hdmi0_snd_in>;
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
index 8860be6..fa4ef7c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
@@ -69,6 +69,7 @@
 	ports {
 		/* rsnd_port0 is on salvator-common */
 		rsnd_port1: port@1 {
+			reg = <1>;
 			rsnd_endpoint1: endpoint {
 				remote-endpoint = <&dw_hdmi0_snd_in>;
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 0648d12..cc601d9 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2162,17 +2162,6 @@
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 			};
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				port@0 {
-					reg = <0>;
-				};
-				port@1 {
-					reg = <1>;
-				};
-			};
 		};
 
 		audma0: dma-controller@ec700000 {
-- 
2.7.4

