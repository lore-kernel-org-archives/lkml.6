Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A19C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57F20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LTBtrkkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B57F20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503185AbeKWU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:59:19 -0500
Received: from m50-133.163.com ([123.125.50.133]:45245 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503170AbeKWU7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=NhZM58T3+VKFam2l8+
        /NZo+NTPvx7EQDhGqqaRZih78=; b=LTBtrkktlYQm1DOwKmHoMirwLognUxpfRn
        UnNU3F6lGI8NRpt/2JvB4hoT4UQ/OHGzWdQVJergO7sJnAWTxnZ+OY4OyDitprGO
        RX8/8IbNtRfN0haSWaqhOEaakTEJyoTSHIJO895TWr0JKHS6CY1A/EbuyhHfesDy
        Jecyanvjs=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp3 (Coremail) with SMTP id DdGowACHQbYM0_dbILFRAA--.19S4;
        Fri, 23 Nov 2018 18:15:09 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, robh@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 3/3] dt-bindings: rtc: sd3078: add device tree documentation
Date:   Fri, 23 Nov 2018 18:14:44 +0800
Message-Id: <1542968084-3982-3-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542968084-3982-1-git-send-email-long17.cool@163.com>
References: <1542968084-3982-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: DdGowACHQbYM0_dbILFRAA--.19S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW3JF1Duw4fZr4rWr13twb_yoWfWrbEka
        1xZFWDJFs8XFyF9Fyvyr43Ary3Ar4IyFs7AayDKrnYy3yIv3yDKFWkJ343Ar18Gr4xuF98
        ur48CryvqwnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8P8n5UUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/xtbBFQ0IF1Xldr0WyAAAsi
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


