Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA09C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1439204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1439204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeIFVQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:16:55 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:62957 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeIFVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:16:54 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w86Ge4bb013327;
        Fri, 7 Sep 2018 01:40:04 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Fri, 07 Sep 2018 01:40:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from localhost.localdomain (7.161.151.153.ap.dti.ne.jp [153.151.161.7])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w86GdwsM013297
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 7 Sep 2018 01:40:04 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: add i2s and spdif endpoint of rk3328
Date:   Fri,  7 Sep 2018 01:39:56 +0900
Message-Id: <20180906163956.20667-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds port and endpoint of i2s and spdif nodes for rk3328.
Because to use modern sound card interface such as audio-graph-card.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index d3ef6566325e..41f0a20b73ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -179,7 +179,13 @@
 		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac 11>, <&dmac 12>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
+
+		i2s0_p0: port@0 {
+			i2s0_p0_0: endpoint {
+			};
+		};
 	};
 
 	i2s1: i2s@ff010000 {
@@ -190,7 +196,13 @@
 		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac 14>, <&dmac 15>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
+
+		i2s1_p0: port@0 {
+			i2s1_p0_0: endpoint {
+			};
+		};
 	};
 
 	i2s2: i2s@ff020000 {
@@ -201,7 +213,13 @@
 		clock-names = "i2s_clk", "i2s_hclk";
 		dmas = <&dmac 0>, <&dmac 1>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
+
+		i2s2_p0: port@0 {
+			i2s2_p0_0: endpoint {
+			};
+		};
 	};
 
 	spdif: spdif@ff030000 {
@@ -214,7 +232,13 @@
 		dma-names = "tx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdifm2_tx>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
+
+		spdif_p0: port@0 {
+			spdif_p0_0: endpoint {
+			};
+		};
 	};
 
 	pdm: pdm@ff040000 {
-- 
2.18.0

