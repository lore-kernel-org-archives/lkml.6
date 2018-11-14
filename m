Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1406BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E7D22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cq1f3510"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E7D22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbeKNTVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:21:10 -0500
Received: from m50-134.163.com ([123.125.50.134]:37072 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732467AbeKNTVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=NhZM58T3+VKFam2l8+
        /NZo+NTPvx7EQDhGqqaRZih78=; b=cq1f3510JDQ/7fRWYa89XbkeW//ziYyTzY
        MEK0pXQ8Vr2zm/3TV97uX4saIl+ifngylvpYIt9kfxm90kSc97GBubVkWDPe/E4p
        QbgczYQz/IoKawP6hoAmJuyuFpIQ6ouFOwNUhqCQks7i2QEA0rOns3vxjKElLbcK
        vGAXCLMCs=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp4 (Coremail) with SMTP id DtGowAA3d+NH6Otbo1cIAA--.1752S4;
        Wed, 14 Nov 2018 17:18:08 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 3/3] dt-bindings: rtc: sd3078: add device tree documentation
Date:   Wed, 14 Nov 2018 17:17:57 +0800
Message-Id: <1542187077-9488-3-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542187077-9488-1-git-send-email-long17.cool@163.com>
References: <1542187077-9488-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: DtGowAA3d+NH6Otbo1cIAA--.1752S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW3JF1Duw4fZr4rWr13twb_yoWfWrbEka
        1xZFWDJFs8XFyF9Fyvyr43Ary3Ar4IyFs7AayDKrnYy3yIv3yDKFWkJ343Ar18Gr4xuF98
        ur48CryvqwnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86MKJUUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/xtbBFRD+F1XldkhFBQAAsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree documentation for the SD3078 device tree
binding is added with a short example.

Signed-off-by: zoro <long17.cool@163.com>
---
 .../devicetree/bindings/rtc/rtc-sd3078.txt         |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sd3078.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
new file mode 100644
index 0000000..676cee8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
@@ -0,0 +1,13 @@
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
-- 
1.7.9.5


