Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4594B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="hgPaeVZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfAVPyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:54:47 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:35693 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728886AbfAVPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:54:46 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 10:54:44 EST
Received: from mxback16g.mail.yandex.net (mxback16g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:316])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 13B765980743;
        Tue, 22 Jan 2019 18:46:23 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback16g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 313qSiJdMK-kMZqsANZ;
        Tue, 22 Jan 2019 18:46:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548171983;
        bh=Cy3YfTKVedlMOPcvsbreKGh2HuxKAuYCCTP2n4egK9M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=hgPaeVZBQjvsKGLI97fLxxUAlMxpB6FqbXW0Jud/4KdoC1KEj+9PZGDWsldN/Ht3A
         i9tSaAUDGP0YTcOvpVaa+LBwELL/EcnQQweIBOhVig/uC1nNJETOsm9AfNLrgObc+N
         qftLiSrccIMdIysJpIxHi6L37KgeUhrUQFBGnIKE=
Authentication-Results: mxback16g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id h0vAak8Ad8-kH48AfkH;
        Tue, 22 Jan 2019 18:46:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paul.burton@mips.com,
        devicetree@vger.kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] dt-bindings: interrupt-controller: loongson ls1x intc
Date:   Tue, 22 Jan 2019 23:45:57 +0800
Message-Id: <20190122154557.22689-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
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

