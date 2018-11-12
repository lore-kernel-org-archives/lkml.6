Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCCBC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D3B20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D3B20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeKLNMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:12:08 -0500
Received: from shell.v3.sk ([90.176.6.54]:59579 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbeKLNMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:12:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4AA95C6A2D;
        Mon, 12 Nov 2018 04:20:53 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RAKxe3cAYSOA; Mon, 12 Nov 2018 04:20:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 61C7EC6A2A;
        Mon, 12 Nov 2018 04:20:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id evc0Z8J5dUEe; Mon, 12 Nov 2018 04:20:36 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A7754C6A21;
        Mon, 12 Nov 2018 04:20:35 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 01/18] dt-bindings: mrvl,mmp-timer: add clock
Date:   Mon, 12 Nov 2018 04:20:10 +0100
Message-Id: <20181112032027.653931-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer needs the timer clock to be enabled, otherwise it stops
ticking.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Made the clock optional, to keep compatibility with DTs without it

 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b=
/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
index 9a6e251462e7..b8f02c663521 100644
--- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
@@ -5,9 +5,13 @@ Required properties:
 - reg : Address and length of the register set of timer controller.
 - interrupts : Should be the interrupt number.
=20
+Optional properties:
+- clocks : Should contain a single entry describing the clock input.
+
 Example:
 	timer0: timer@d4014000 {
 		compatible =3D "mrvl,mmp-timer";
 		reg =3D <0xd4014000 0x100>;
 		interrupts =3D <13>;
+		clocks =3D <&coreclk 2>;
 	};
--=20
2.19.1

