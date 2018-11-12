Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A78BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1B4214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1B4214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeKLMVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:21:45 -0500
Received: from shell.v3.sk ([90.176.6.54]:59286 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbeKLMVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:21:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 24F59C6A19;
        Mon, 12 Nov 2018 03:30:44 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z8VYd48kR-Sj; Mon, 12 Nov 2018 03:30:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AD1EEC6A11;
        Mon, 12 Nov 2018 03:30:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MF7io-FFTiw1; Mon, 12 Nov 2018 03:30:34 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 90821C6A0B;
        Mon, 12 Nov 2018 03:30:34 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/6] dt-bindings: olpc,ap-sp: add clock
Date:   Mon, 12 Nov 2018 03:30:24 +0100
Message-Id: <20181112023029.648408-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
References: <20181112023029.648408-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock is necessary for the device operation, hence it's required.
Its name, "sp", stands for "Security Processor". It is one of several
names that are used for the processor that serves as the keyboard
controller on an OLPC and is consistent with the node name.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Doc=
umentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 0e72183f52bc..36603419d6f8 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -4,10 +4,14 @@ Required properties:
 - compatible : "olpc,ap-sp"
 - reg : base address and length of SoC's WTM registers
 - interrupts : SP-AP interrupt
+- clocks : phandle + clock-specifier for the clock that drives the WTM
+- clock-names:  should be "sp"
=20
 Example:
 	ap-sp@d4290000 {
 		compatible =3D "olpc,ap-sp";
 		reg =3D <0xd4290000 0x1000>;
 		interrupts =3D <40>;
+		clocks =3D <&soc_clocks MMP2_CLK_SP>;
+		clock-names =3D "sp";
 	}
--=20
2.19.1

