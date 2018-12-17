Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2569F206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="kAHuyEoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbeLQPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:37:14 -0500
Received: from mail.nic.cz ([217.31.204.67]:51557 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387522AbeLQPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:37:13 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 49D4662441;
        Mon, 17 Dec 2018 16:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545061031; bh=hc48vW+mxpr+k+AbY5U1UYIuztcvntIdAD0DSzDFjjE=;
        h=From:To:Date;
        b=kAHuyEoeNjmVvr6dGkJfAfNPgssk/KMQTjWPim8Rvk5wJKOis8DZVTM5bgqUn/EYF
         hZJlGAAlFEdWOT1Kvl5XHp14K8gAMrvyvQXOa72JuzEEWMkvn/w/Yh0/oQUT8ESrhU
         kLXw4D6Kk8X/vI3J4PntmZ3pk8sBjkL/0pBE5DwI=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: mailbox: Document armada-37xx-rwtm-mailbox binding
Date:   Mon, 17 Dec 2018 16:37:05 +0100
Message-Id: <20181217153706.25873-2-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181217153706.25873-1-marek.behun@nic.cz>
References: <20181217153706.25873-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree binding documentation for the rWTM BIU mailbox
driver on the Armada 37xx SOC (EspressoBin, Turris Mox).

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../mailbox/armada-37xx-rwtm-mailbox.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt b/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
new file mode 100644
index 000000000000..2d182d61eb3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
@@ -0,0 +1,16 @@
+* rWTM BIU Mailbox driver for Armada 37xx
+
+Required properties:
+- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"
+- reg : 	physical base address of the mailbox and length of memory mapped
+		region
+- interrupts:	the IRQ line for the mailbox
+- #mbox-cells:	must be 1
+
+Example:
+	rwtm: mailbox@b0000 {
+		compatible = "marvell,armada-37xx-rwtm-mailbox";
+		reg = <0xb0000 0x100>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <1>;
+	};
-- 
2.18.1

