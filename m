Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED17B2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED17B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeH2SpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:45:01 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58102 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeH2SpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:45:01 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="19719005"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 07:47:43 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 07:47:42 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <florian.meier@koalo.de>,
        <cristian.birsan@microchip.com>
Subject: [PATCH 2/2] ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board
Date:   Wed, 29 Aug 2018 17:47:27 +0300
Message-ID: <20180829144727.13757-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
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
index f4a98c85340a..8ac3ec1f36e5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -210,6 +210,7 @@ micron	Micron Technology Inc.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
+mikroe		MikroElektronika d.o.o.
 mosaixtech	Mosaix Technologies, Inc.
 motorola	Motorola, Inc.
 moxa	Moxa Inc.
-- 
2.17.1

