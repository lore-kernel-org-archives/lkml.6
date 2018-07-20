Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A890AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588420864
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fgNUWj0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6588420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbeGTVs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:48:57 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38828 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeGTVs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:48:56 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9B81810C134B;
        Fri, 20 Jul 2018 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532120337; bh=C1oH5KKjPAB9Z31tPLmMsdyi21v2Fw6D0tV4RqHM0/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgNUWj0S5irLngTXQk15cUZUB8cP6aG19ZSLm6IS8V6CVlFD/KXHNjJk3swJAh6D7
         R6++WDO4oyW02o+fZ9ljA5CzXWQsQpg/IL9MqcoeGQaBVKsISGbn7QPESstDWyEYhV
         9Gmz7/Ll5C88KTcuMBFID6hCcLt3hmg5ZZ6KFc9QiXtHNwdDnyJ4n32oPiVkAAbVts
         LZm9T9q2dOexOvvzs/p+sggMBZ1p+MuIUx5LjeOYNVf4oIHCiDppuqdqpCzCNgr4wr
         /DAXZV4W9n3y4r+uAEUpsI/fM+kFPmdXUMMgqmmTjb12yp2todZN2hYgrWF7g1gUzs
         eYs+TSgGA1JMw==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.25.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5E7095BE0;
        Fri, 20 Jul 2018 13:58:51 -0700 (PDT)
From:   Vitor soares <Vitor.Soares@synopsys.com>
To:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com, Vitor.Soares@synopsys.com
Subject: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
Date:   Fri, 20 Jul 2018 21:57:51 +0100
Message-Id: <1532120272-17157-3-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532120272-17157-1-git-send-email-soares@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document Synopsys DesignWare I3C master DT bindings.

Signed-off-by: Vitor soares <soares@synopsys.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100644
index 0000000..7f5c8b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -0,0 +1,43 @@
+Bindings for Synopsys DesignWare I3C master block
+=================================================
+
+Required properties:
+--------------------
+- compatible: shall be "snps,dw-i3c-master"
+- clocks: shall reference the core_clk
+- clock-names: shall contain "core_clk"
+- interrupts: the interrupt line connected to this I3C master
+- reg:  Offset and length of I3C master registers
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 3
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-hz
+- i3c-scl-hz
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c-master@0x2000 {
+		compatible = "snps,dw-i3c-master";
+		#address-cells = <3>;
+		#size-cells = <0>;
+		reg = <0x02000 0x1000>;
+		interrupts = <0>;
+		clocks = <&i3cclk>;
+		clock-names = "core_clk";
+
+		eeprom@0x57{
+			compatible = "atmel,24c01";
+			reg = < 0x57 0x80000010 0x0>;
+			pagesize = <0x8>;
+		};
+	};
-- 
2.7.4


