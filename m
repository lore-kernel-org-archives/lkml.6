Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79DBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEB921727
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEB921727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeHHHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:43:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:4068 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbeHHHn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:43:27 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Aug 2018 14:25:33 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9A543600AA;
        Wed,  8 Aug 2018 14:25:33 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 8 Aug 2018 14:25:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1C39A40372;
        Wed,  8 Aug 2018 14:25:33 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EA7A2120448;
        Wed,  8 Aug 2018 14:25:32 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 1/7] media: uniphier: add DT bindings documentation for UniPhier HSC
Date:   Wed,  8 Aug 2018 14:25:13 +0900
Message-Id: <20180808052519.14528-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808052519.14528-1-suzuki.katsuhiro@socionext.com>
References: <20180808052519.14528-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT binding documentation for UniPhier HSC which is
MPEG2-TS input/output and demux subsystem.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v1:
  - Fix mistakes of spelling
  - Rename uniphier,hsc.txt -> socionext,uniphier-hsc.txt
---
 .../bindings/media/socionext,uniphier-hsc.txt | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/socionext,uniphier-hsc.txt

diff --git a/Documentation/devicetree/bindings/media/socionext,uniphier-hsc.txt b/Documentation/devicetree/bindings/media/socionext,uniphier-hsc.txt
new file mode 100644
index 000000000000..7a91046091e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/socionext,uniphier-hsc.txt
@@ -0,0 +1,38 @@
+Socionext UniPhier HSC (High-speed Stream Controller)
+
+The Socionext UniPhier HSC subsystem consists of MPEG2-TS input/output and
+demultiplexer cores in the same register space.
+
+This interface supports TS serial signals (clock, valid, sync, data) from
+external demodulators.
+
+Required properties:
+- compatible      : should be one of the following:
+		    "socionext,uniphier-ld11-hsc"
+		    "socionext,uniphier-ld20-hsc"
+- reg             : offset and length of the register set for the device.
+- interrupts      : should contain DMA and TSI error interrupt.
+- pinctrl-names   : should be "default".
+- pinctrl-0       : defined TS serial signal pins for external demodulators.
+- clock-names     : should include the following entries:
+                    "hsc", "stdmac"
+- clocks          : a list of phandle, should contain an entry for each
+                    entry in clock-names.
+- reset-names     : should include the following entries:
+                    "hsc", "stdmac"
+- resets          : a list of phandle, should contain an entry for each
+                    entry in reset-names.
+
+Example:
+	hsc {
+		compatible = "socionext,uniphier-ld20-hsc";
+		reg = <0x5c000000 0x100000>;
+		interrupts = <0 100 4>, <0 101 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hscin2_s>,
+			    <&pinctrl_hscin3_s>;
+		clock-names = "stdmac", "hsc";
+		clocks = <&sys_clk 8>, <&sys_clk 9>;
+		reset-names = "stdmac", "hsc";
+		resets = <&sys_rst 8>, <&sys_rst 9>;
+	};
-- 
2.18.0

