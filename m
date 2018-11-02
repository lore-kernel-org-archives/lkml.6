Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F2EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EB020657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="Ias03UGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EB020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeKBTmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:42:40 -0400
Received: from mail.nic.cz ([217.31.204.67]:57811 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeKBTmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:42:40 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id AD17362EC4;
        Fri,  2 Nov 2018 11:35:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1541154956; bh=DdzOxMTui2MbROHT5L3bYmjWSALZgHBXkani2kDp2Jc=;
        h=From:To:Date;
        b=Ias03UGYD/BTLFrKHJ9MjWTcEKf78zvaL4NhBmLJ2QjDsDqkMZm31EepgJFTod1KS
         /ToyVqVw26S1+Rh07uHqLOPE2ErA9Nhb+5Joe6a2wgo2Mfc5603TuBxTh1NPMzaprN
         +c1QSfRlDNiF9gd9WpFOuYqagWDyzXt7leyUovtk=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 bus+gpio 2/4] dt-bindings: bus: Document moxtet bus binding
Date:   Fri,  2 Nov 2018 11:35:37 +0100
Message-Id: <20181102103539.6077-2-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181102103539.6077-1-marek.behun@nic.cz>
References: <20181102103539.6077-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree binding documentation for the Moxtet bus, a bus
via which the different modules connected to the Turris Mox router can
be configured.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/bus/moxtet.txt        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt

diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentation/devicetree/bindings/bus/moxtet.txt
new file mode 100644
index 000000000000..19a1bab61e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/moxtet.txt
@@ -0,0 +1,34 @@
+Turris Mox module configuration bus (over SPI)
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet".
+ - #address-cells	: Has to be 1
+ - #size-cells		: Has to be 0
+For other required and optional properties of SPI slave nodes please refer to
+../spi/spi-bus.txt.
+
+Required properties of subnodes:
+ - reg			: Should be position on the Moxtet bus
+
+The driver finds the devices connected to the bus by itself, but it may be
+needed to reference some of them from other parts of the device tree. In that
+case the devices can be defined as subnodes of the moxtet node.
+
+Example:
+
+	moxtet@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "cznic,moxtet";
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+		spi-cpol;
+		spi-cpha;
+
+		moxtet_sfp: moxtet-sfp@0 {
+			compatible = "cznic,moxtet-sfp";
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0>;
+		}
+	};
-- 
2.18.1

