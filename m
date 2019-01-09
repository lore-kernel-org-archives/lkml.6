Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81019214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="av/9Mcnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfAITCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:02:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:24662 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAITCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547060528;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=EER1ZLK/+IraXTJb7+h4KsPe9R0jqrCuUBlJHFJyfzs=;
        b=av/9McnuOKe8bEBk3+4BH2gLXDJesvMnZCQago0m5J2sTTzz4NfehkKPmOPO1Az4BI
        6s4JgbGnFO64yp7BV43270u7TzbDbvo08zqhPy467JU52Wt9o1str/QizkLAc3WOIwlG
        teqTtvyJzT7OifTLBCfwiEWI+jF9RULToYMSfU0niMz2UaNp/bI6EdLLCKOvKLL5Egmt
        l4XBPX8pIrwiwF5TxbbUN8vUl+b/RCAYyfIYf2+k86b9jcwSHmuBYNJ8VyU2dlXzXnMy
        9h9XT/kGGgD1YmRpbPym6bGT3OBZzeBmzEdCTF+NGKxB4mnVRuiJN81SvE0Or7WkVaMX
        ShwA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH4GpcRmBzW"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 608499v09J1uSS1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 20:01:56 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        letux-kernel@openphoenux.org
Subject: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
Date:   Wed,  9 Jan 2019 20:01:56 +0100
Message-Id: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

We're currently getting a warning with make dtbs:

arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
/ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
address error, expected "0"

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e53d32691308..93b420934e8e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -714,11 +714,7 @@
 
 	vdda-supply = <&vdac>;
 
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port {
-		reg = <0>;
 		venc_out: endpoint {
 			remote-endpoint = <&opa_in>;
 			ti,channels = <1>;
-- 
2.19.1

