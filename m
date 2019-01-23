Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A692C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEF221019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="DLIbR9h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfAWGag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:30:36 -0500
Received: from forward101j.mail.yandex.net ([5.45.198.241]:50307 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfAWGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:30:35 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 01:30:34 EST
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id D5D251BE2B77;
        Wed, 23 Jan 2019 09:24:16 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9UkbvXeKt9-OGbC6YYn;
        Wed, 23 Jan 2019 09:24:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548224656;
        bh=Cy3YfTKVedlMOPcvsbreKGh2HuxKAuYCCTP2n4egK9M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=DLIbR9h5f8jdGehQ0Z1Wj84eRl4Ij+DkJvcT/zQfxFBcW/1pU4MTWQlR7gvXbhmSa
         wki5066+2MeLspx30SiKpUpYz4/gntkELHdUq7IsWjFAuVQGZlZNd/hHZS/Ohet4QD
         t9fg/iVMGZnUrC0Q0hZXZGfSln36vRxki3+/pUQo=
Authentication-Results: mxback3j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id uW0qtCYwDN-O9Pi3Uqw;
        Wed, 23 Jan 2019 09:24:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: interrupt-controller: loongson ls1x intc
Date:   Wed, 23 Jan 2019 14:23:35 +0800
Message-Id: <20190123062341.8957-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123062341.8957-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190123062341.8957-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dt-bindings doc about Loongson-1 interrupt controller

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../loongson,ls1x-intc.txt                    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
new file mode 100644
index 000000000000..afa8fec45f88
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
@@ -0,0 +1,28 @@
+Loongson ls1x Interrupt Controller
+
+Required properties:
+
+- compatible : should be "ingenic,<socname>-intc". Valid strings are:
+    loongson,ls1b-intc
+    loongson,ls1c-intc
+
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- interrupts : Specifies the CPU interrupts the controller is connected to,
+    - For ls1b, it must have 4 interrupts.
+    - For ls1c, it must have 5 interrupts.
+
+Example:
+
+intc: interrupt-controller@1fd01040 {
+	compatible = "loongson,ls1c-intc";
+	reg = <0x1fd01040 0x78>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	interrupt-parent = <&cpu_intc>;
+	interrupts = <2>, <3>, <4>, <5>, <6>;
+};
\ No newline at end of file
-- 
2.20.1

