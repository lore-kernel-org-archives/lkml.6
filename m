Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BC7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240320869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D240320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeIGJHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:07:42 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:39954 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeIGJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:07:42 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id D552D5FD69; Fri,  7 Sep 2018 12:19:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2 5/6] ARM: dts: sun7i: add pinmux setting for RGB888 output for LCD0
Date:   Fri,  7 Sep 2018 12:19:47 +0800
Message-Id: <20180907041948.19913-6-wens@csie.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the A20, as well as many other Allwinner SoCs, the PD pingroup has
the LCD0 RGB output functions.

Add a pinmux setting for RGB888 output from LCD0, so boards and tablets
with parallel RGB LCD panels may reference it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9c52712af241..b2c56833b0e6 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -950,6 +950,17 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD6", "PD7", "PD8", "PD9",
+				       "PD10", "PD11", "PD12", "PD13",
+				       "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21",
+				       "PD22", "PD23", "PD24", "PD25",
+				       "PD26", "PD27";
+				function = "lcd0";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.19.0.rc1

