Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F955C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E050022419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gmwzv43G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E050022419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeKMENi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:13:38 -0500
Received: from m50-133.163.com ([123.125.50.133]:50823 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbeKMENh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=1kAQBFjfC7Ws6N7Wm3
        CSzo6eGWwBFWjKthgrD4evEeU=; b=Gmwzv43GLvipcae2AiMsTF89axLWIVSRES
        fVkndunJ0M6uiUztM24CE6H+NAEXAk4HpZVpnbMO+Acg9BJfIuPSRCOktYJTX+6v
        53YxbCiPngxDX91oeh7W5dfjkcjfnmAHa9s7coF6bvgbD7I+ef5tljhAV0UTTAj/
        XAQ8nIGLk=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp3 (Coremail) with SMTP id DdGowAAn9rRxwOlbdDskAA--.3624S4;
        Tue, 13 Nov 2018 02:03:42 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 3/3] dt-bindings: rtc: sd3078: add device tree documentation
Date:   Tue, 13 Nov 2018 02:03:26 +0800
Message-Id: <1542045806-32349-3-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542045806-32349-1-git-send-email-long17.cool@163.com>
References: <1542045806-32349-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: DdGowAAn9rRxwOlbdDskAA--.3624S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxAFyxKF47XrWUXF1DKFg_yoWfWFbEka
        1xZFWDJFsxXFyF9F9Yyr4ayry7Jr4IyFs7AayDKrnYy3yIv3yDKFWkX3srAr18GF4xuF98
        ur18CryvqwnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnepB7UUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbivhz8F1ZcTPtvRQABsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree documentation for the SD3078 device tree
binding is added with a short example.

Signed-off-by: zoro <long17.cool@163.com>
---
 .../devicetree/bindings/rtc/rtc-sd3078.txt         |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
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
-- 
1.7.9.5


