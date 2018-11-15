Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF922146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF922146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbeKOX6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:58:20 -0500
Received: from ms.tdt.de ([195.243.126.94]:34332 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729010AbeKOX6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:58:18 -0500
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 9B8FC21A68;
        Thu, 15 Nov 2018 13:50:21 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v3 1/2] hwmon: (adcxx) add devictree bindings documentation
Date:   Thu, 15 Nov 2018 14:50:12 +0100
Message-Id: <20181115135013.30723-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181115135013.30723-1-fe@dev.tdt.de>
References: <20181115135013.30723-1-fe@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the devicetree bindings for the adcxx.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 Documentation/devicetree/bindings/hwmon/adcxx.txt | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adcxx.txt

diff --git a/Documentation/devicetree/bindings/hwmon/adcxx.txt b/Documentation/devicetree/bindings/hwmon/adcxx.txt
new file mode 100644
index 000000000000..a94a5fe21b6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adcxx.txt
@@ -0,0 +1,24 @@
+adcxx properties
+
+Required properties:
+- compatible: Must be one of the following:
+	- "national,adcxx1s" for adcxx1s
+	- "national,adcxx2s" for adcxx2s
+	- "national,adcxx4s" for adcxx4s
+	- "national,adcxx8s" for adcxx8s
+- reg: SPI address for chip
+
+Optional properties:
+
+- vref-supply
+  The external reference in microvolt for this device is set to this value.
+  If it does not exists the reference will be set to 3300000uV (3.3V).
+
+Example:
+
+adc@6 {
+	compatible = "national,adcxx2s";
+	reg = <6 0>;
+	spi-max-frequency = <1000000>;
+	vref-supply = <&vref>;
+};
-- 
2.11.0

