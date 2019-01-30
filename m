Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BBDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9662087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lviWGFZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733068AbfA3SaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:30:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732841AbfA3SaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:30:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0UIUFht079194;
        Wed, 30 Jan 2019 12:30:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548873015;
        bh=8/Ve5jGtKFD4bjrx1aYX6fb1Ri9Pdg9X4iDb7Z8QW+Q=;
        h=From:To:CC:Subject:Date;
        b=lviWGFZxrCxWVzWLxO08dXO+r25ZsEAjirBSkEe6fyUOjr0fFBXnLzVOyUjl5+QuT
         RIjKg+e6EjIcpEmTIWQ3xSMNCpW7PQYKYaTmHCUXVwAW1A6FrVHA1I5kAebGoZCi8p
         5qcrxAzouIeF3KWp2GRUAKMrdv4TA7lzpXwwEnvw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0UIUFeK070308
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 12:30:15 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 30
 Jan 2019 12:30:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 30 Jan 2019 12:30:15 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0UIUFjp012679;
        Wed, 30 Jan 2019 12:30:15 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.83.85])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0UIUEU02207;
        Wed, 30 Jan 2019 12:30:14 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH] leds: multicolor: Add sysfs interface definition
Date:   Wed, 30 Jan 2019 12:30:05 -0600
Message-ID: <20190130183005.833-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation of LED Multicolor LED class specific
sysfs attributes.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../ABI/testing/sysfs-class-led-multicolor    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor

diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
new file mode 100644
index 000000000000..19f8da9b150e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
@@ -0,0 +1,38 @@
+What:		/sys/class/leds/<led>/color/sync_enable
+Date:		January 2019
+KernelVersion:	5.0
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		Writing a 1 to this file will enable the sychronization of all
+		the defined color LEDs within the LED node.  Writing a 0 to
+		this file will disable syncing.
+
+What:		/sys/class/leds/<led>/color/sync
+Date:		January 2019
+KernelVersion:	5.0
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	write only
+		Writing a 1 to this file while sync_enable is set to 1 will
+		synchronize all defined LEDs within the LED node.  All LEDs
+		defined will be configured based on the brightness that has
+		been requested.
+
+		If sync_enable is set to 0 then writing a 1 to sync has no
+		affect on the LEDs.
+
+What:		/sys/class/leds/<led>/color/<led color>
+Date:		January 2019
+KernelVersion:	5.0
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		These files are dynamically created based on the colors defined
+		by the registrar of the class.
+		The led color(s) can be but not limited to red, green, blue,
+		white, amber and violet.  If sync is enabled then writing the
+		brightness value of the LED is deferred until a 1 is
+		written to /sys/class/leds/<led>/color/sync.  If syncing is
+		disabled then the LED brightness value will be written
+		immediately to the LED driver.
+
+		The value of the color is from 0 to
+		/sys/class/leds/<led>/max_brightness.
-- 
2.20.1.98.gecbdaf0899

