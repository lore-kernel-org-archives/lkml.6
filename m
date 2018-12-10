Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357032082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357032082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeLJQbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:31:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:45698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbeLJQbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:31:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F215AFF9;
        Mon, 10 Dec 2018 16:31:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, agraf@suse.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] Input: raspberrypi-ts - add devicetree binding documentation
Date:   Mon, 10 Dec 2018 17:30:21 +0100
Message-Id: <20181210163036.24813-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210163036.24813-1-nsaenzjulienne@suse.de>
References: <20181210163036.24813-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree documentation for Raspberry Pi's official 7"
touchscreen.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
new file mode 100644
index 000000000000..38e22eb222e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
@@ -0,0 +1,26 @@
+Raspberry Pi 3 firmware based 7" touchscreen
+=====================================
+
+Required properties:
+ - compatible: "raspberrypi,firmware-ts"
+
+Optional properties:
+ - firmware: Reference to RPi's firmware device node
+ - touchscreen-size-x: See touchscreen.txt
+ - touchscreen-size-y: See touchscreen.txt
+ - touchscreen-inverted-x: See touchscreen.txt
+ - touchscreen-inverted-y: See touchscreen.txt
+ - touchscreen-swapped-x-y: See touchscreen.txt
+
+Example:
+
+firmware: firmware-rpi {
+	compatible = "raspberrypi,bcm2835-firmware";
+	mboxes = <&mailbox>;
+
+	ts: touchscreen {
+		compatible = "raspberrypi,firmware-ts";
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+	};
+};
-- 
2.19.2

