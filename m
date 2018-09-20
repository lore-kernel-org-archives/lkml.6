Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C7ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D0A21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZlGh0OsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D0A21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeITRDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:03:03 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:35906 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeITRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:03:03 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3080624E0F95;
        Thu, 20 Sep 2018 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537442404; bh=fMYJbfE9hMA2GAwf+yfyRNTuvk/LnARre0T7AkK97kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlGh0OsDC4B2cSYnpacjqmS+t6wgfcBlxH6sXw/fGCyOD602uRtMWZKePOHRk0foe
         PgUY1YvXCbfwQQwL9DaCHxUTLZMCmYxFV/5uQ+aJTis+ShNe/PliD8Thr/Jz4GBwaf
         xpfYXJIQBAFA7RvzhybI7++GFtT5cRQClsrkklhh3FG6JaGQXvWZtEv3/fiPiJbXm+
         ooElFQJw642RZClUI+gHO+vnMCLA2E9bnTLPcqkWv70C9Lnu33rAy6zcBIq//4tJvY
         oLFbdOe/N/PP1tO64s6JeUU6EiUa1mxO+abdk5s2+eaOPCEKTXFh4c6VZBSxSeNril
         U9f22OnIKNHQQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id CBAEE5AB3;
        Thu, 20 Sep 2018 04:20:03 -0700 (PDT)
Received: from de02dwemt291.internal.synopsys.com (de02dwemt291.internal.synopsys.com [10.225.18.65])
        by de02.synopsys.com (Postfix) with ESMTP id 01C853E4DC;
        Thu, 20 Sep 2018 13:20:03 +0200 (CEST)
Received: from de02dwemt291.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt291.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w8KBK2Jd028603;
        Thu, 20 Sep 2018 13:20:02 +0200
Received: (from lolivei@localhost)
        by de02dwemt291.internal.synopsys.com (8.14.4/8.14.4/Submit) id w8KBJuXP028601;
        Thu, 20 Sep 2018 13:19:56 +0200
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [V2, 4/5] Documentation: dt-bindings: Document bindings for DW MIPI CSI-2 Host
Date:   Thu, 20 Sep 2018 13:16:42 +0200
Message-Id: <20180920111648.27000-5-lolivei@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180920111648.27000-1-lolivei@synopsys.com>
References: <20180920111648.27000-1-lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Synopsys DesignWare MIPI CSI-2 host.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changelog
v2:
- no changes

 .../devicetree/bindings/media/snps,dw-csi-plat.txt | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt

diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
new file mode 100644
index 0000000..028f5eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
@@ -0,0 +1,74 @@
+Synopsys DesignWare CSI-2 Host controller
+
+Description
+-----------
+
+This HW block is used to receive image coming from an MIPI CSI-2 compatible
+camera.
+
+Required properties:
+- compatible: shall be "snps,dw-csi-plat"
+- reg			: physical base address and size of the device memory mapped
+  registers;
+- interrupts		: CSI-2 Host interrupt
+- snps,output-type	: Core output to be used (IPI-> 0 or IDI->1 or BOTH->2) These
+			  values choose which of the Core outputs will be used, it
+			  can be Image Data Interface or Image Pixel Interface.
+- phys			: List of one PHY specifier (as defined in
+			  Documentation/devicetree/bindings/phy/phy-bindings.txt).
+			  This PHY is a MIPI DPHY working in RX mode.
+- resets		: Reference to a reset controller (optional)
+
+Optional properties(if in IPI mode):
+- snps,ipi-mode 	: Mode to be used when in IPI(Camera -> 0 or Controller -> 1)
+			  This property defines if the controller will use the video
+			  timings available
+			  in the video stream or if it will use pre-defined ones.
+- snps,ipi-color-mode	: Bus depth to be used in IPI (48 bits -> 0 or 16 bits -> 1)
+			  This property defines the width of the IPI bus.
+- snps,ipi-auto-flush	: Data auto-flush (1 -> Yes or 0 -> No). This property defines
+			  if the data is automatically flushed in each vsync or if
+			  this process is done manually
+- snps,virtual-channel	: Virtual channel where data is present when in IPI mode. This
+			  property chooses the virtual channel which IPI will use to
+			  retrieve the video stream.
+
+The per-board settings:
+ - port sub-node describing a single endpoint connected to the camera as
+   described in video-interfaces.txt[1].
+
+Example:
+
+	csi2_1: csi2@3000 {
+		compatible = "snps,dw-csi-plat";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = < 0x03000 0x7FF>;
+		interrupts = <2>;
+		output-type = <2>;
+		resets = <&dw_rst 1>;
+		phys = <&mipi_dphy_rx1 0>;
+		phy-names = "csi2-dphy";
+
+		/* IPI optional Configurations */
+		snps,ipi-mode = <0>;
+		snps,ipi-color-mode = <0>;
+		snps,ipi-auto-flush = <1>;
+		snps,virtual-channel = <0>;
+
+		/* CSI-2 per-board settings */
+		port@1 {
+			reg = <1>;
+			csi1_ep1: endpoint {
+				remote-endpoint = <&camera_1>;
+				data-lanes = <1 2>;
+			};
+		};
+		port@2 {
+			csi1_ep2: endpoint {
+				remote-endpoint = <&vif1_ep>;
+			};
+		};
+	};
+
+
-- 
2.9.3

