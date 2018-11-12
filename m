Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9507C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D3E214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D3E214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeKLMam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:30:42 -0500
Received: from shell.v3.sk ([90.176.6.54]:59365 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbeKLMal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:30:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E1ADBC6A17;
        Mon, 12 Nov 2018 03:39:37 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hduXOWho0b0U; Mon, 12 Nov 2018 03:39:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0525EC6A15;
        Mon, 12 Nov 2018 03:39:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nmt-09txEadt; Mon, 12 Nov 2018 03:39:33 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B24E0C6A0B;
        Mon, 12 Nov 2018 03:39:32 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 1/2] dt-bindings: himax,hx8837: add HiMax HX8837 bindings
Date:   Mon, 12 Nov 2018 03:39:28 +0100
Message-Id: <20181112023929.650002-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiMax HX8837 is a display controller used on OLPC platforms.
It controlls backlight and is able to capture and freeze a frame when
the LCD controller (and the rest of the plaform) is powered off.

What is missing here is the description of connections to the LCD
controller and the panel. Maybe it would be a good idea to plug in it
between the two in a manner described in
<Documentation/devicetree/bindings/graph.txt>.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- s/betweend/between/

Changes since v1:
- s/load-gpio/load-gpios/
- Use interrupt bindings instead of gpio for the IRQ

 .../devicetree/bindings/misc/himax,hx8837.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/himax,hx8837.t=
xt

diff --git a/Documentation/devicetree/bindings/misc/himax,hx8837.txt b/Do=
cumentation/devicetree/bindings/misc/himax,hx8837.txt
new file mode 100644
index 000000000000..d0822c679ae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/himax,hx8837.txt
@@ -0,0 +1,18 @@
+HX8837 Display Controller
+
+Required properties:
+- compatible: Should be "himax,hx8837".
+- reg: I2C address, must be 0x0d
+- stat-gpios: gpio specifier of DCON_STAT0 and DCON_STAT1 pins (active h=
igh)
+- load-gpios: gpio specifier of DCON_LOAD pin (active high)
+- interrupt: interrupt specifier of DCON_IRQ pin (edge falling)
+
+Example:
+	dcon@d {
+		compatible =3D "himax,hx8837";
+		reg =3D <0x0d>;
+		stat-gpios =3D <&gpio 100 GPIO_ACTIVE_HIGH
+			      &gpio 101 GPIO_ACTIVE_HIGH>;
+		load-gpios =3D <&gpio 142 GPIO_ACTIVE_HIGH>;
+		interrupts =3D <&gpio 124 IRQ_TYPE_EDGE_FALLING>;
+	};
--=20
2.19.1

