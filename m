Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF020B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Xh6Q/oPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfBAGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:23:12 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:56138 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfBAGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:23:12 -0500
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 2656B4202B0E;
        Fri,  1 Feb 2019 09:23:09 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 6JmBleADWY-N9P49G3u;
        Fri, 01 Feb 2019 09:23:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002189;
        bh=ALTjAKukM1Aw16UCP8HKXZJ/PqI9UtcZ2YYK+kCo8HA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Xh6Q/oPnzu48P/SexI1seHxpkyN8OL2UqUlqKZFVV4dGoN4LnrKh51W/ufo5ki98p
         yp/jlZ5O7D45DwKcVR1woDuzRTjmWXKgl0M94IKuz4KNbTp6kTL4tmY/6GE3qHj+b1
         aP9QMiXBDldbuiWjxSWQCtcUkDyYASkkno27wMH0=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0W2FVbEhhw-N01ebTAB;
        Fri, 01 Feb 2019 09:23:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/2] dt-bindings: interrupt-controller: loongson ls1x intc
Date:   Fri,  1 Feb 2019 14:22:36 +0800
Message-Id: <20190201062236.17903-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201062236.17903-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190201062236.17903-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dt-bindings doc about Loongson-1 interrupt controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../loongson,ls1x-intc.txt                    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
new file mode 100644
index 000000000000..9385f8b55109
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
@@ -0,0 +1,25 @@
+Loongson ls1x Interrupt Controller
+
+Required properties:
+
+- compatible : should be "loongson,ls1x-intc". Valid strings are:
+
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+- interrupts : Specifies the CPU interrupt the controller is connected to.
+
+Example:
+
+intc: interrupt-controller@1fd01040 {
+	compatible = "loongson,ls1x-intc";
+	reg = <0x1fd01040 0x18>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	interrupt-parent = <&cpu_intc>;
+	interrupts = <2>;
+};
+
-- 
2.20.1

