Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5229DC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F58D20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfATR0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:40 -0500
Received: from shell.v3.sk ([90.176.6.54]:47320 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfATR0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A221DC9B0A;
        Sun, 20 Jan 2019 18:26:05 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ie6sPyaHkLlX; Sun, 20 Jan 2019 18:25:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B3A46C9AE7;
        Sun, 20 Jan 2019 18:25:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PcjNH-AaDf-p; Sun, 20 Jan 2019 18:25:52 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 895B5C9A93;
        Sun, 20 Jan 2019 18:25:52 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem binding
Date:   Sun, 20 Jan 2019 18:25:32 +0100
Message-Id: <20190120172534.24617-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120172534.24617-1-lkundrak@v3.sk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell Armada DRM master device is a virtual device needed to list a=
ll
nodes that comprise the graphics subsystem.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/armada/marvell-arm=
ada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-ar=
mada-drm.txt
index de4cca9432c8..3dbfa8047f0b 100644
--- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm=
.txt
+++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm=
.txt
@@ -1,3 +1,27 @@
+Marvell Armada DRM master device
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+The Marvell Armada DRM master device is a virtual device needed to list =
all
+nodes that comprise the graphics subsystem.
+
+Required properties:
+
+ - compatible: value should be "marvell,dove-display-subsystem",
+   "marvell,armada-display-subsystem"
+ - ports: a list of phandles pointing to display interface ports of CRTC
+   devices
+ - memory-region: phandle to a node describing memory to be used for the
+   framebuffer
+
+Example:
+
+	display-subsystem {
+		compatible =3D "marvell,dove-display-subsystem",
+		             "marvell,armada-display-subsystem";
+		memory-region =3D <&display_reserved>;
+		ports =3D <&lcd0_port>;
+	};
+
 Marvell Armada LCD controller
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
--=20
2.20.1

