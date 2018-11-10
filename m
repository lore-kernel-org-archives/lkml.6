Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8588FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCEB20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YmEHWKY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCEB20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeKJS2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:28:52 -0500
Received: from m50-138.163.com ([123.125.50.138]:42963 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbeKJS2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qJJ0xktlNmFvR7cRWT
        GJDZGiJ31I8wn+SuAFTKGsnVs=; b=YmEHWKY5qagnqV+y/i7IxyEZNwZqTg6eIX
        kAmC3HDGF0CgzLqkvOkprurmrFjv6fzL9yvugsYBoJtl3jMgZISu9FTs94h0Rq0f
        AtdqzJHtCyemiBmzNqBStnWw9m9yMgwumGLfQAZ8z6n3P6ScDy5g3Cs7lYI6ia0w
        eAz2khQOU=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp1 (Coremail) with SMTP id C9GowACH8wlKmuZbMGe2AA--.32S4;
        Sat, 10 Nov 2018 16:44:18 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zoro <long17.cool@163.com>
Subject: [PATCH 3/3] dt-bindings: rtc: sd3078: add device tree documentation
Date:   Sat, 10 Nov 2018 16:43:53 +0800
Message-Id: <1541839433-28811-3-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1541839433-28811-1-git-send-email-long17.cool@163.com>
References: <1541839433-28811-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: C9GowACH8wlKmuZbMGe2AA--.32S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DtFW3Xry8Cr1DuF4rKrg_yoW8JFW8pa
        n7CryftryIqry3Gw47K3WIv3W5Xr1kC3W29Fn2yw4vgFn5Cas5tw13trn0yF1UGr48uFWY
        qrZ8Cr15K340yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnR6wUUUUU=
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbizQP6F1c7DKJlVgAAsS
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

