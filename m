Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18134C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA6F20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfATR0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:48 -0500
Received: from shell.v3.sk ([90.176.6.54]:47328 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfATR0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8809CC9B3E;
        Sun, 20 Jan 2019 18:26:03 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lXG8EzHpWccR; Sun, 20 Jan 2019 18:25:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2CDB3C9AB8;
        Sun, 20 Jan 2019 18:25:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1RTMvAkGmjaN; Sun, 20 Jan 2019 18:25:52 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 41693C9AFC;
        Sun, 20 Jan 2019 18:25:52 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/6] dt-bindings: display: armada: Add framebuffer reserved-mem binding
Date:   Sun, 20 Jan 2019 18:25:31 +0100
Message-Id: <20190120172534.24617-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120172534.24617-1-lkundrak@v3.sk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the binding for memory that is set aside for allocation of Marvel=
l
Armada framebuffer objects.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../display/armada/marvell-armada-drm.txt     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/armada/marvell-arm=
ada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-ar=
mada-drm.txt
index 2606a8efc956..de4cca9432c8 100644
--- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm=
.txt
+++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm=
.txt
@@ -40,3 +40,28 @@ Example:
 			};
 		};
 	};
+
+Marvell Armada framebuffer reserved memory
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Memory set aside for allocation of Marvell Armada framebuffer objects.
+
+Required properties:
+
+ - compatible: value should be "marvell,dove-framebuffer",
+   "marvell,armada-framebuffer".
+
+This binding is compatible with the binding, specified in
+Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt..
+
+Example:
+
+	reserved-memory {
+		display_reserved: framebuffer {
+			compatible =3D "marvell,dove-framebuffer",
+			             "marvell,armada-framebuffer";
+			size =3D <0x02000000>;
+			alignment =3D <0x02000000>;
+			no-map;
+		};
+	};
--=20
2.20.1

