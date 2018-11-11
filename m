Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B33CC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF36221527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF36221527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeKLFUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:20:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51061 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeKLFUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:20:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8DBE1207CF; Sun, 11 Nov 2018 20:31:15 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 64382206A7;
        Sun, 11 Nov 2018 20:31:15 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: rtc: add generic bindings
Date:   Sun, 11 Nov 2018 20:31:13 +0100
Message-Id: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic binding documentation for the RTC subsystem.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
new file mode 100644
index 000000000000..221b7da50aca
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -0,0 +1,30 @@
+Generic device tree bindings for Real Time Clock devices
+========================================================
+
+This document describes generic bindings which can be used to describe Real Time
+Clock devices in a device tree.
+
+Required properties
+-------------------
+
+- compatible : name of RTC device following generic names recommended practice.
+
+For other required properties e.g. to describe register sets,
+clocks, etc. check the binding documentation of the specific driver.
+
+Optional properties
+-------------------
+
+- start-year : if provided, the default hardware range supported by the RTC is
+               shifted so the first usable year is the specified one.
+
+The following properties may not be supported by all drivers. However, if a
+driver wants to support one of the below features, it should adapt the bindings
+below.
+- trickle-resistor-ohms : Selected resistor for trickle charger. Should be given
+                          if trickle charger should be enabled
+- trickle-diode-disable : Do not use internal trickle charger diode Should be
+                          given if internal trickle charger diode should be
+                          disabled
+- wakeup-source :         Enables wake up of host system on alarm
+
-- 
2.19.1

