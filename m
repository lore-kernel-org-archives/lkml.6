Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710BAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC1206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfAIPDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:03:04 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:55586 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731975AbfAIPDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:03:03 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 4C7BE5F7AA; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/5] ARM: dts: sun8i: r40: Add pinmux settings for UART3 on PG pingroup
Date:   Wed,  9 Jan 2019 23:02:53 +0800
Message-Id: <20190109150257.12602-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART3 on the PG pingroup on the R40 SoC is commonly used to connect the
bluetooth controller in a WiFi+Bluetooth combo chip, with the WiFi bits
also on the PG pingroup.

This patch adds two device nodes for UART3 on PG pingroup, one for the
RX/TX pins, and one for the RTS/CTS pins. Consumers can reference either
just the RX/TX pinmux setting or both, depending on the application.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 89762dbefe42..f1fcfa0bdce0 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -389,6 +389,16 @@
 				pins = "PB22", "PB23";
 				function = "uart0";
 			};
+
+			uart3_pg_pins: uart3-pg-pins {
+				pins = "PG6", "PG7";
+				function = "uart3";
+			};
+
+			uart3_rts_cts_pg_pins: uart3-rts-cts-pg-pins {
+				pins = "PG8", "PG9";
+				function = "uart3";
+			};
 		};
 
 		wdt: watchdog@1c20c90 {
-- 
2.20.1

