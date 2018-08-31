Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD47C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBCE2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBCE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeHaVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:23:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23118 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeHaVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:23:15 -0400
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="19891699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 10:14:47 -0700
Received: from rob-ult-m19940.mchp-main.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 10:14:46 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <florian.meier@koalo.de>,
        <cristian.birsan@microchip.com>
Subject: [PATCH v2 2/2] ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board
Date:   Fri, 31 Aug 2018 20:14:36 +0300
Message-ID: <20180831171436.13360-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831171436.13360-1-codrin.ciubotariu@microchip.com>
References: <20180831171436.13360-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - adjusted "mikroe" position in vendor-prefixes.txt;

 .../bindings/sound/mikroe,mikroe-proto.txt    | 23 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt

diff --git a/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
new file mode 100644
index 000000000000..912f8fae11c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
@@ -0,0 +1,23 @@
+Mikroe-PROTO audio board
+
+Required properties:
+  - compatible: "mikroe,mikroe-proto"
+  - dai-format: Must be "i2s".
+  - i2s-controller: The phandle of the I2S controller.
+  - audio-codec: The phandle of the WM8731 audio codec.
+Optional properties:
+  - model: The user-visible name of this sound complex.
+  - bitclock-master: Indicates dai-link bit clock master; for details see simple-card.txt (1).
+  - frame-master: Indicates dai-link frame master; for details see simple-card.txt (1).
+
+(1) : There must be the same master for both bit and frame clocks.
+
+Example:
+	sound {
+		compatible = "mikroe,mikroe-proto";
+		model = "wm8731 @ sama5d2_xplained";
+		i2s-controller = <&i2s0>;
+		audio-codec = <&wm8731>;
+		dai-format = "i2s";
+        };
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..f26bf667e530 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -235,6 +235,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
-- 
2.17.1

