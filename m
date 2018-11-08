Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED51ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FOrfKMg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B887920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeKICv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:51:58 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:39122 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeKICv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:51:57 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 697CB24E0A3F;
        Thu,  8 Nov 2018 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541697330; bh=qVtF7vWHWZeNlCTIaCpsKWl3dh9738MJPCMxjNuA/xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOrfKMg/qVYtBGxYJCGZ4ja94JF6vwXvTiaPTBXvM9uFSo51MvkWrobNw+nL0krtP
         Iv6Ei7B/UQMiT12nz0PomBkgvZwxjxp7jMk/L1EsRNI4EYBsVrUYrKK3zk465A5Wcg
         SnCb6YDkRkliMQGRMu1Hlb6TbL2/0LSXtB2RJ6xhGh3CTpAHvE/Anlg0WnWOIufjQs
         3N52UPltgyPISPT0LSF1cox1ulaJhzpM84CPcLK2NCNhbH+huzl40KTKXRR6wZVsWF
         OahmdZV/L1ng66fT8a/Le3l1xZGLR1eNCIDzg2Dfl3ffaLWMTelOLhClkG4aWV0MPt
         aHVI6FBceC9iw==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.19.145])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5336457AD;
        Thu,  8 Nov 2018 09:15:20 -0800 (PST)
From:   Vitor soares <vitor.soares@synopsys.com>
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
Subject: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
Date:   Thu,  8 Nov 2018 17:14:10 +0000
Message-Id: <1541697251-20392-3-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541697251-20392-1-git-send-email-soares@synopsys.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Synopsys DesignWare I3C master module

Signed-off-by: Vitor soares <soares@synopsys.com>
---
Changes in v3:
- Remove dummy characters

Changes in v2:
- Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
- Add controller version on compatible string

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100644
index 0000000..b930c09
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -0,0 +1,42 @@
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
+			reg = < 0x57 0x0 0x10>;
+			pagesize = <0x8>;
+		};
+	};
+
-- 
2.7.4


