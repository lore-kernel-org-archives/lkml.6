Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE49C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE3F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE3F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeKTUcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:32:18 -0500
Received: from shell.v3.sk ([90.176.6.54]:50076 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbeKTUcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:32:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 97470C6FBD;
        Tue, 20 Nov 2018 11:03:55 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2pmrLRmepOWw; Tue, 20 Nov 2018 11:03:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 93F7FC6FB3;
        Tue, 20 Nov 2018 11:03:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L6jYDEugBb8L; Tue, 20 Nov 2018 11:03:41 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5E227C6FB5;
        Tue, 20 Nov 2018 11:03:40 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Subject: [PATCH v3 05/14] media: dt-bindings: marvell,mmp2-ccic: Add Marvell MMP2 camera
Date:   Tue, 20 Nov 2018 11:03:10 +0100
Message-Id: <20181120100318.367987-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120100318.367987-1-lkundrak@v3.sk>
References: <20181120100318.367987-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Marvell MMP2 camera host interface.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- Added #clock-cells, clock-names, port

 .../bindings/media/marvell,mmp2-ccic.txt      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-=
ccic.txt

diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.tx=
t b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
new file mode 100644
index 000000000000..e5e8ca90e7f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
@@ -0,0 +1,37 @@
+Marvell MMP2 camera host interface
+
+Required properties:
+ - compatible: Should be "marvell,mmp2-ccic"
+ - reg: register base and size
+ - interrupts: the interrupt number
+ - #clock-cells: must be 0
+ - any required generic properties defined in video-interfaces.txt
+
+Optional properties:
+ - clocks: input clock (see clock-bindings.txt)
+ - clock-names: names of the clocks used, may include "axi", "func" and
+                "phy"
+ - clock-output-names: should contain the name of the clock driving the
+                       sensor master clock MCLK
+
+Required subnodes:
+ - port: the parallel bus interface port with a single endpoint linked t=
o
+         the sensor's endpoint as described in video-interfaces.txt
+
+Example:
+
+	camera0: camera@d420a000 {
+		compatible =3D "marvell,mmp2-ccic";
+		reg =3D <0xd420a000 0x800>;
+		interrupts =3D <42>;
+		clocks =3D <&soc_clocks MMP2_CLK_CCIC0>;
+		clock-names =3D "axi";
+		#clock-cells =3D <0>;
+		clock-output-names =3D "mclk";
+
+		port {
+			camera0_0: endpoint {
+				remote-endpoint =3D <&ov7670_0>;
+			};
+		};
+	};
--=20
2.19.1

