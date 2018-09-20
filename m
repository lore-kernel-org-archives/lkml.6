Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71222ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293CD21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ep/qEHWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293CD21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeITRCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:02:33 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43030 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeITRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:02:33 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 792DA10C1038;
        Thu, 20 Sep 2018 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537442373; bh=ywMhwdvW2XHK4grxUgU6xMhv0eh+lzM2mbcd2MMWp+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep/qEHWEzwNn+L2ki+rRjk+vSmD8ThtQhkitgPFB9bzMZpBMOxEQR9xYT20NYdD+9
         R6wI5XYW+1vfwVkdGbeSc7jg+9n3WKfYT9ckXOH68xiapbaeoVNy5XIVeCJZuRvRWN
         bE49XDdx9TxOtkG28hlhTfH3ltJ+KDoPk18Jj8YPkGezaKx80VbABBZKBarvDtzHRn
         zT9txK392/V2DCFLMN/cq5DtWxS1V4aNysOAKPhP79+Pnq7WbQa6tmvT++PeOIZKxG
         h6c3A3vBGy8MSdHKXGN11Tz0Kiu27V+sX2zqVMjl494ka2opleJ95RW2UIGJag62FR
         RZm3YEzVOD8+g==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1DFDB58CB;
        Thu, 20 Sep 2018 04:19:31 -0700 (PDT)
Received: from de02dwemt291.internal.synopsys.com (de02dwemt291.internal.synopsys.com [10.225.18.65])
        by de02.synopsys.com (Postfix) with ESMTP id 25D7D3E4B1;
        Thu, 20 Sep 2018 13:19:31 +0200 (CEST)
Received: from de02dwemt291.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt291.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w8KBJU5A028464;
        Thu, 20 Sep 2018 13:19:30 +0200
Received: (from lolivei@localhost)
        by de02dwemt291.internal.synopsys.com (8.14.4/8.14.4/Submit) id w8KBJL8b028458;
        Thu, 20 Sep 2018 13:19:21 +0200
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: [V2, 2/5] Documentation: dt-bindings: Document the Synopsys MIPI DPHY Rx bindings
Date:   Thu, 20 Sep 2018 13:16:40 +0200
Message-Id: <20180920111648.27000-3-lolivei@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180920111648.27000-1-lolivei@synopsys.com>
References: <20180920111648.27000-1-lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
RX mode.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changelog
v2:
- no changes

 .../devicetree/bindings/phy/snps,dphy-rx.txt       | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt

diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
new file mode 100644
index 0000000..9079f4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
@@ -0,0 +1,36 @@
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
+Optional properties:
+- snps,compat-mode	: Compatibility mode control
+
+The per-board settings:
+- gpios 		: Synopsys testchip used as reference uses this to change setup
+		  	  configurations.
+
+Example:
+
+	mipi_dphy_rx1: dphy@3040 {
+		compatible = "snps,dphy-rx";
+		#phy-cells = <1>;
+		snps,dphy-frequency = <300000>;
+		snps,dphy-te-len = <12>;
+		snps,compat-mode = <1>;
+		reg = < 0x03040 0x20
+			0x08000 0x100
+			0x09000 0x100>;
+	};
+
-- 
2.9.3

