Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F3C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA88A214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfATR0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:12 -0500
Received: from shell.v3.sk ([90.176.6.54]:47320 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfATR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 852D5C9BA7;
        Sun, 20 Jan 2019 18:26:08 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Wm4ocy3XJqQA; Sun, 20 Jan 2019 18:25:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2702FC9AFC;
        Sun, 20 Jan 2019 18:25:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SVS649EIzloS; Sun, 20 Jan 2019 18:25:53 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CDB1DC9B22;
        Sun, 20 Jan 2019 18:25:52 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/6] dt-bindings: display: armada: Add mmp2 compatible strings
Date:   Sun, 20 Jan 2019 18:25:33 +0100
Message-Id: <20190120172534.24617-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120172534.24617-1-lkundrak@v3.sk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver will work on a MMP2 as well.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/display/armada/marvell-armada-drm.txt   | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/armada/marvell-arm=
ada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-ar=
mada-drm.txt
index 3dbfa8047f0b..53524077db25 100644
--- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm=
.txt
+++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm=
.txt
@@ -6,8 +6,9 @@ nodes that comprise the graphics subsystem.
=20
 Required properties:
=20
- - compatible: value should be "marvell,dove-display-subsystem",
-   "marvell,armada-display-subsystem"
+ - compatible: value should be one of:
+	- "marvell,dove-display-subsystem", "marvell,armada-display-subsystem"
+	- "marvell,mmp2-display-subsystem", "marvell,armada-display-subsystem"
  - ports: a list of phandles pointing to display interface ports of CRTC
    devices
  - memory-region: phandle to a node describing memory to be used for the
@@ -27,7 +28,7 @@ Marvell Armada LCD controller
=20
 Required properties:
=20
- - compatible: value should be "marvell,dove-lcd".
+ - compatible: value should be "marvell,dove-lcd" or "marvell,mmp2-lcd"
  - reg: base address and size of the LCD controller
  - interrupts: single interrupt number for the LCD controller
=20
@@ -72,8 +73,9 @@ Memory set aside for allocation of Marvell Armada frame=
buffer objects.
=20
 Required properties:
=20
- - compatible: value should be "marvell,dove-framebuffer",
-   "marvell,armada-framebuffer".
+ - compatible: value should be one of:
+	- "marvell,dove-framebuffer", "marvell,armada-framebuffer"
+	- "marvell,mmp2-framebuffer", "marvell,armada-framebuffer"
=20
 This binding is compatible with the binding, specified in
 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt..
--=20
2.20.1

