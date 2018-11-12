Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F24CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2C921722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PCuiXjFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2C921722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeKLPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:53:03 -0500
Received: from m50-134.163.com ([123.125.50.134]:38150 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeKLPxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qJJ0xktlNmFvR7cRWT
        GJDZGiJ31I8wn+SuAFTKGsnVs=; b=PCuiXjFRpxBbayQk5MKdn6B+y2RUef9lfT
        OyARI/vwUqlLHH+hePTh2UJ4XeFH3GkWm1dGOOl6fxbWnjSSz9kWXnj/sYu1BbwP
        CEXkeclme1v5Pjvy8q4sceJIdm0YzUSa/dait7AN5rlkOEOqT+p+bFht0TtsZmZ2
        vJOWb64l4=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp4 (Coremail) with SMTP id DtGowAAXHkZsE+lb52OQAQ--.34S4;
        Mon, 12 Nov 2018 13:45:43 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 3/4] dt-bindings: rtc: sd3078: add device tree documentation
Date:   Mon, 12 Nov 2018 13:45:14 +0800
Message-Id: <1542001514-8167-3-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542001514-8167-1-git-send-email-long17.cool@163.com>
References: <1542001514-8167-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: DtGowAAXHkZsE+lb52OQAQ--.34S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DtFW3Xry8Cr1DuF4rKrg_yoW8JFW8pa
        n7CryftryIqry3Gw47K3WIv3W5Xr1kC3W29Fn2yw4vgFn5Cas5tw13trn0yF1UGr48uFWY
        qrZ8Cr15K340yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzjgcUUUUU=
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiDQf8F1QHKm7fngAAs3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree documentation for the SD3078 device tree
binding is added with a short example.

Signed-off-by: zoro <long17.cool@163.com>
---
 .../devicetree/bindings/rtc/rtc-sd3078.txt         |   15 +++++++++++++++
 MAINTAINERS                                        |    1 +
 2 files changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sd3078.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
new file mode 100644
index 0000000..9b45c8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
@@ -0,0 +1,15 @@
+SD3078 Real Time Clock
+============================
+
+Required properties:
+- compatible: Should contain "whwave,sd3078".
+- reg: I2C address for chip.
+
+Example:
+
+sd3078: sd3078@32 {
+       compatible = "whwave,sd3078";
+       reg = <0x32>;
+};
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 002fcd7..50c038d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16130,6 +16130,7 @@ M:	Zoro Li <long17.cool@163.com>
 L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-sd3078.c
+F:	Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
 
 WIIMOTE HID DRIVER
 M:	David Herrmann <dh.herrmann@googlemail.com>
-- 
1.7.9.5


