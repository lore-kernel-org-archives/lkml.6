Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3A72150F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3A72150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJJVrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:47:51 -0400
Received: from shell.v3.sk ([90.176.6.54]:53467 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJJVru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:47:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 830A5BCEFC;
        Wed, 10 Oct 2018 16:25:22 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HRej-vn7v07l; Wed, 10 Oct 2018 16:25:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 613B8BCF6D;
        Wed, 10 Oct 2018 16:25:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l82Sbubspqtd; Wed, 10 Oct 2018 16:25:09 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5B22BBCF5F;
        Wed, 10 Oct 2018 16:25:09 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/8] dt-bindings: olpc,ap-sp: add GPIO lines
Date:   Wed, 10 Oct 2018 16:24:58 +0200
Message-Id: <20181010142504.233467-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010142504.233467-1-lkundrak@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties describing the GPIO lines used by the keyboard controller.
The olpc-apsp driver will do happily without them, but they are still par=
t
of the hardware description. The driver could still reserve the lines,
so that nothing else touches them.

This makes the device node almost compatible with "ps2-gpio". I'm not
adding a compatible property, because ps2-gpio would use a different
interrupt, so that we'd need to name it. And I haven't actually tried it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Doc=
umentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 36603419d6f8..2b1b1dbb54c1 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -7,6 +7,10 @@ Required properties:
 - clocks : phandle + clock-specifier for the clock that drives the WTM
 - clock-names:  should be "sp"
=20
+Optional properties:
+- data-gpios : GPIO line used for PS/2 interface data
+- clk-gpios : GPIO line used for PS/2 interface clock
+
 Example:
 	ap-sp@d4290000 {
 		compatible =3D "olpc,ap-sp";
@@ -14,4 +18,6 @@ Example:
 		interrupts =3D <40>;
 		clocks =3D <&soc_clocks MMP2_CLK_SP>;
 		clock-names =3D "sp";
+		data-gpios =3D <&gpio 72 GPIO_ACTIVE_HIGH>;
+		clk-gpios =3D <&gpio 71 GPIO_ACTIVE_HIGH>;
 	}
--=20
2.19.0

