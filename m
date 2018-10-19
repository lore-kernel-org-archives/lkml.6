Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2160ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DD420644
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bF02DjtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DD420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJSU7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:59:25 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:50616 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJSU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:59:25 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C6FE610C1320;
        Fri, 19 Oct 2018 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539953605; bh=ex4lGGpItYuoY0EDFugUQQL0dyxJ+bksDaJcx+H91LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bF02DjtMU7ewwq+bxtM2zIz9pQyqOLDmRT8iGvMibq7W70MINXFCdhBCpn40o5yXj
         TT/uxuimAjgc41bWdkL1mcdZ57uqmqRZ/ORcuW6RgJOi++o68FUlrmEIhgw39Zgpll
         UCxJYyV3JzWPw3O3qYRaAxFcjSqZGoigKlAHOyfbtxuc1r6ZLzSpctM+xvIyZgxPCc
         sTRTdeAxvszfv9VFswU9YZtCFX/c7M8HrMu8imRRRo4zFC9wrRgU/wDxtQP69Mhuc0
         L2aHDpGO5sDI3d9FIJvVFHjVRlxZijwPQv0kzxtuqKgCVAPdow9m4xcPv1Zjz5zdeX
         6azadr//4hPlA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 760AF3C9B;
        Fri, 19 Oct 2018 05:53:25 -0700 (PDT)
Received: from de02dwemt290.internal.synopsys.com (de02dwemt290.internal.synopsys.com [10.225.18.64])
        by de02.synopsys.com (Postfix) with ESMTP id A84E47E67;
        Fri, 19 Oct 2018 14:53:24 +0200 (CEST)
Received: from de02dwemt290.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt290.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w9JCrOPf035884;
        Fri, 19 Oct 2018 14:53:24 +0200
Received: (from lolivei@localhost)
        by de02dwemt290.internal.synopsys.com (8.14.4/8.14.4/Submit) id w9JCrIXA035882;
        Fri, 19 Oct 2018 14:53:18 +0200
From:   Luis Oliveira <luis.oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joao.pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [V3, 3/4] Documentation: dt-bindings: media: Document bindings for DW MIPI CSI-2 Host
Date:   Fri, 19 Oct 2018 14:52:25 +0200
Message-Id: <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Synopsys DesignWare MIPI CSI-2 host.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changelog
v2-V3
- removed IPI settings

 .../devicetree/bindings/media/snps,dw-csi-plat.txt | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt

diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
new file mode 100644
index 0000000..be3da05
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
@@ -0,0 +1,52 @@
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
+- snps,output-type	: Core output to be used (IPI-> 0 or IDI->1 or BOTH->2)
+			  These  values choose which of the Core outputs will be used,
+			  it can be Image Data Interface or Image Pixel Interface.
+- phys			: List of one PHY specifier (as defined in
+			  Documentation/devicetree/bindings/phy/phy-bindings.txt).
+			  This PHY is a MIPI DPHY working in RX mode.
+- resets		: Reference to a reset controller (optional)
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
--
2.7.4

