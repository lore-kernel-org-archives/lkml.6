Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE68ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BEB214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TJzSY5yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BEB214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeJSU67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:58:59 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:47906 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJSU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:58:59 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7A0FA24E0D73;
        Fri, 19 Oct 2018 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539953579; bh=BUIQO7FeCEAKhg/RERsa+UOiQZcQ/AanY3sGPIkFcCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJzSY5yNqT2bElHjYSHngjEcH6vlDohXmG5VVnpz29MJaJ4A8Nep3qnmyNMlMSbPu
         m7J32X3DTNtfVFpVzoR9OnWHs/IAMd4DFVjsT61HD11M5nz0kxsb+2RLaHCMBlZ/V4
         z56zxQs0VX6RoIhXKVNJ/5Q4ADd7rtEkw/EEDTj9BhBqowQ/73IStwbZmwGxFu32Ck
         sl96UWgAlLoHv/EPPdjU/ZJ4OKZTZ/5Yj1Cc028+psKXkl758rPU7AN1QoM7FuRT6L
         /WKInBYVTi+eQbJoJJxITayzHPIUyj7Q2jUno5kpQBcwCod+kAt713B3JfCtc7EgzB
         gpHzWoUm5bXug==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2857051AA;
        Fri, 19 Oct 2018 05:52:58 -0700 (PDT)
Received: from de02dwemt290.internal.synopsys.com (de02dwemt290.internal.synopsys.com [10.225.18.64])
        by de02.synopsys.com (Postfix) with ESMTP id 57F847E58;
        Fri, 19 Oct 2018 14:52:57 +0200 (CEST)
Received: from de02dwemt290.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt290.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w9JCqug2035857;
        Fri, 19 Oct 2018 14:52:56 +0200
Received: (from lolivei@localhost)
        by de02dwemt290.internal.synopsys.com (8.14.4/8.14.4/Submit) id w9JCqrNf035856;
        Fri, 19 Oct 2018 14:52:53 +0200
From:   Luis Oliveira <luis.oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joao.pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: [V3, 1/4] Documentation: dt-bindings: phy: Document the Synopsys MIPI DPHY Rx bindings
Date:   Fri, 19 Oct 2018 14:52:23 +0200
Message-Id: <1539953556-35762-2-git-send-email-lolivei@synopsys.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
RX mode.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changelog
v2-V3
- removed gpios reference - it was for a separated driver
- changed address to show complete address

 .../devicetree/bindings/phy/snps,dphy-rx.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt

diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
new file mode 100644
index 0000000..03d17ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
@@ -0,0 +1,28 @@
+Synopsys DesignWare MIPI Rx D-PHY block details
+
+Description
+-----------
+
+The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
+Please refer to phy-bindings.txt for more information.
+
+Required properties:
+- compatible		: Shall be "snps,dphy-rx".
+- #phy-cells		: Must be 1.
+- snps,dphy-frequency	: Output frequency of the D-PHY.
+- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or 12bits->12).
+- reg			: Physical base address and size of the device memory mapped
+		 	  registers;
+
+Example:
+
+	mipi_dphy_rx1: dphy@d00003040 {
+		compatible = "snps,dphy-rx";
+		#phy-cells = <1>;
+		snps,dphy-frequency = <300000>;
+		snps,dphy-te-len = <12>;
+		reg = < 0xd0003040 0x20
+			0xd0008000 0x100
+			0xd0009000 0x100>;
+	};
+
--
2.7.4

