Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1157C282CF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D05E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="bsEb3EEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfA2DFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:05:25 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:34984 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfA2DFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:05:23 -0500
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 7753818C0B57;
        Tue, 29 Jan 2019 06:05:21 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 5CZoZ9cEAH-5LBmS9en;
        Tue, 29 Jan 2019 06:05:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548731121;
        bh=8u1oeL2Vyb7VWqI8PW5ctvZIFSRiLJZM62UiOHad4d4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=bsEb3EEbVPMqtO06ms3zCW16DJvqVUzT/AatvCl3d4T7ouF6wnea6yVkkqIdcnx3S
         2wSkTgSt9kbDUYkR+XyDYo/EwLOw/L09HsjKDaG/W1B+Bmv8iGhdF1V3w/J6RltOu+
         FUmHlhXF83gpqxwlms6CHOrLIEuvMOnqJ2+nk5jM=
Authentication-Results: mxback9j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xt9oXyCTqZ-5GweeD16;
        Tue, 29 Jan 2019 06:05:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 2/2] dt-bindings: interrupt-controller: loongson ls1x intc
Date:   Tue, 29 Jan 2019 11:05:01 +0800
Message-Id: <20190129030501.29791-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129030501.29791-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190129030501.29791-1-jiaxun.yang@flygoat.com>
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

