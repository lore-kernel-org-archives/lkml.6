Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D68C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2741020851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2741020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeLCLsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:48:32 -0500
Received: from shell.v3.sk ([90.176.6.54]:37890 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeLCLsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:48:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 657E3C805C;
        Mon,  3 Dec 2018 12:47:47 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gwh2D_Foacst; Mon,  3 Dec 2018 12:47:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8A10FC8125;
        Mon,  3 Dec 2018 12:47:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yHJl7o5JEKvZ; Mon,  3 Dec 2018 12:47:40 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C971CC8123;
        Mon,  3 Dec 2018 12:47:39 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: rtc: use a generic node name for ds1307
Date:   Mon,  3 Dec 2018 12:47:36 +0100
Message-Id: <20181203114736.637012-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example should follow the practice or using a generic node name
instead of the precise programming model, as recommended by the DTSpec.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/rtc/rtc-ds1307.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Docum=
entation/devicetree/bindings/rtc/rtc-ds1307.txt
index eebfbe04207a..eaee19b60960 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
@@ -35,7 +35,7 @@ Optional properties:
 	Should be given if internal trickle charger diode should be disabled
=20
 Example:
-	rtc1: ds1339@68 {
+	ds1339: rtc@68 {
 		compatible =3D "dallas,ds1339";
 		reg =3D <0x68>;
 		interrupt-parent =3D <&gpio4>;
--=20
2.19.1

