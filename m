Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE69AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B51223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BzEpZI3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B51223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeKNAJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:09:08 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33708 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeKNAJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:09:08 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 05E3710C122B;
        Tue, 13 Nov 2018 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542118249; bh=Fs/UzeFcjUV735cWD/c9lCpjOq0MBxfkMnuFd/sOxrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzEpZI3KJlXe3Cdi73CqmAQtJG+yeRa3Af/L4MISlIBO6991TEoBbupWVDDjPigOR
         wbN5w464xsktllQ4UXtWpbHrpXlTJriSft47aJtOKDx/UKCTLGx99sPySR7lgKu3yP
         8cV3/4kNYGVfqsnZ2nOjvS5so+UEBpiyaEa0rDnKjL04XKyVvrxRsx8OwXf9Oy1vyi
         ii6+4Il+n8PHOziw2Hp2WDJPb+BVOm4yFQEARM0XPAp3M4JVve4l2SYrS5zK+xe8SZ
         HcxQpDPCsrgL9CUE0Mxm73ovzNdBrYfS6lrzN5gS0Wdj0JK9TkNwKllsAp8xmz7ULT
         408lDcMvyPMFg==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.19.128])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4CD6256D8;
        Tue, 13 Nov 2018 06:10:42 -0800 (PST)
From:   Vitor Soares <vitor.soares@synopsys.com>
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
        vitor.soares@synopsys.com, geert@linux-m68k.org,
        linus.walleij@linaro.org, Xiang.Lin@synaptics.com,
        linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com,
        peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com
Subject: [PATCH v4 2/3] dt-binding: i3c: Document Synopsys DesignWare I3C
Date:   Tue, 13 Nov 2018 14:09:52 +0000
Message-Id: <1542118193-24925-3-git-send-email-vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
References: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Synopsys DesignWare I3C master module

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Change email soares@synopsys.com to vitor.soares@synopsys.com
- Add Rob Herring R-b

Changes in v3:
- Remove dummy characters

Changes in v2:
- Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
- Add controller version on compatible string

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100644
index 0000000..5020eb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -0,0 +1,41 @@
+Bindings for Synopsys DesignWare I3C master block
+=================================================
+
+Required properties:
+--------------------
+- compatible: shall be "snps,dw-i3c-master-1.00a"
+- clocks: shall reference the core_clk
+- interrupts: the interrupt line connected to this I3C master
+- reg: Offset and length of I3C master registers
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
+	i3c-master@2000 {
+		compatible = "snps,dw-i3c-master-1.00a";
+		#address-cells = <3>;
+		#size-cells = <0>;
+		reg = <0x02000 0x1000>;
+		interrupts = <0>;
+		clocks = <&i3cclk>;
+
+		eeprom@57{
+			compatible = "atmel,24c01";
+			reg = <0x57 0x0 0x10>;
+			pagesize = <0x8>;
+		};
+	};
-- 
2.7.4


