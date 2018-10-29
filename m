Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E00C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE75520827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MXxHC3NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE75520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeJ2S4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:56:14 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52024 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeJ2S4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:56:14 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A55D124E11D9;
        Mon, 29 Oct 2018 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540807695; bh=phjko0jtuT6j1BfmPp1BrOqGMXeisx6dltmwoGSyPTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXxHC3NCwpEF7qluLDf/KTpmGjl39NvkTT/qYa7+xcLSEneu+Xv5Z72mgUdkuQ3qQ
         NKS/Bdkwst5IIoXMRj6OkpdaUSvk6dHZYiJCQI81ZfDEf/gUdIMjBfu73A7zF1d3KH
         ccZB7N4L0j0qCrby+l36e1k72hF0UW42urFb6A8AksrkbC4bpyL6vLV/LZ0ybLYUhC
         p7os5TxVs1KGg4DGSWH6H8JaRvaVrgK1u2ueqtX8nktKuap3tI2x27HM03iM6nKMP0
         NYezYj+ZiBp1dKdmIJhSPtp1HfyeB0TdDY3CsWBqP2fV5bexZYwkkTNRLLUte1g9lQ
         8Cxy91pIn7gyA==
Received: from localhost.localdomain (soares-e7470.internal.synopsys.com [10.225.2.39])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5FFFD54D7;
        Mon, 29 Oct 2018 03:08:06 -0700 (PDT)
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
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Subject: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
Date:   Mon, 29 Oct 2018 10:06:57 +0000
Message-Id: <1540807618-13246-3-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540807618-13246-1-git-send-email-soares@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Synopsys DesignWare I3C master module

Signed-off-by: Vitor soares <soares@synopsys.com>
---
Changes in v2:
-Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
-Add controller version on compatible string

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
new file mode 100755
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


