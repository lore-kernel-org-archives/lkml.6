Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0743C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212F23FDC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5212F23FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeGFFgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:36:52 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:37604 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932323AbeGFFgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:36:03 -0400
Received: from localhost.localdomain (pD95EF57F.dip0.t-ipconnect.de [217.94.245.127])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 7321628DBF9;
        Fri,  6 Jul 2018 05:35:59 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 2/5] dt-bindings: w1: document bindings for ds2760 battery monitor
Date:   Fri,  6 Jul 2018 07:35:49 +0200
Message-Id: <20180706053552.11438-3-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706053552.11438-1-daniel@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the devicetree bindings for Maxim's ds2760 battery
monitors.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/power/supply/maxim,ds2760.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
new file mode 100644
index 000000000000..55967a0bee11
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
@@ -0,0 +1,26 @@
+Devicetree bindings for Maxim DS2760
+====================================
+
+The ds2760 is a w1 slave device and must hence have its sub-node in DT
+under a w1 bus master node.
+
+The device exposes a power supply, so the details described in
+Documentation/devicetree/bindings/power/supply/power_supply.txt apply.
+
+Required properties:
+- compatible: must be "maxim,ds2760"
+
+Optional properties:
+- power-supplies:	Refers to one or more power supplies connected to
+			this battery.
+- maxim,pmod-enabled:	This boolean property enables the DS2760 to enter
+			sleep mode when the DQ line goes low for greater
+			than 2 seconds and leave sleep Mode when the DQ
+			line goes high.
+- maxim,cache-time-ms:	Time im milliseconds to cache the data for. When
+			this time expires, the values are read again from
+			the hardware. Defaults to 1000.
+- rated-capacity-microamp-hours:
+			The rated capacity of the battery, in mAh.
+			If not specified, the value stored in the
+			non-volatile chip memory is used.
-- 
2.17.1

