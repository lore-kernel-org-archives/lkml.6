Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC40D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="g9HbdMuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfA1OrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:47:16 -0500
Received: from forward106o.mail.yandex.net ([37.140.190.187]:57995 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfA1OrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:47:15 -0500
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 47D8850605A0;
        Mon, 28 Jan 2019 17:47:13 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bcGlUm4jby-lCAa3TVW;
        Mon, 28 Jan 2019 17:47:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548686833;
        bh=8u1oeL2Vyb7VWqI8PW5ctvZIFSRiLJZM62UiOHad4d4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=g9HbdMuwmMPKY5wKV3UfJuGykZvHHPcyBbZPTl6RoGBYTgANTDInCuTlK5QnD01lt
         IBDIiisqDyBcuIrG2kCd9QKXeZ4a1/VFkmb8nHB3k6n1JHjjEfsbPWN1iEDFbCXmVr
         BSk9Q7eqpseTZwF1Mc88lnh+e15+uFjUI4mCf8a4=
Authentication-Results: mxback15j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id F7ornvIEEQ-l2kagpe0;
        Mon, 28 Jan 2019 17:47:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 2/2] dt-bindings: interrupt-controller: loongson ls1x intc
Date:   Mon, 28 Jan 2019 22:46:31 +0800
Message-Id: <20190128144631.31289-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128144631.31289-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190128144631.31289-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dt-bindings doc about Loongson-1 interrupt controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../loongson,ls1x-intc.txt                    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
new file mode 100644
index 000000000000..a63ed9fcb535
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
@@ -0,0 +1,24 @@
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
-- 
2.20.1

