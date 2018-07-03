Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B944AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6822024D7D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Jf6z/G8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pH3w/M0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6822024D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeGCHE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54393 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754599AbeGCHEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E1EB721EAE;
        Tue,  3 Jul 2018 03:04:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Jul 2018 03:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=awTW+1TRddREQsN/z
        vjhbxkfdzoqaMwofnHS5CZgsrk=; b=Jf6z/G8YsMG7EfMrhdmQKxOhtWOP1DzfN
        sbVaz7gbyNh6/JtN/sNZrJUTCdTjysHKR0Q3MfUZAsBio5qrk0sLvaOHZtlCtVfI
        NnBohO52Ch944/8lKRrq+VH2VzKTe632Z2x1cp7zzPv3maEX1NSkTHUUKmAmSiTP
        HJ5I+qzbWBv/8If5QQ/tnkS51f+m0KEvhKrZNxG7g08iYIc+eHmHgxtMR0k0TOTU
        7+xU7FCBnxI8+OcyyEfjiBmQU5FNyu1lRGrwj7KBv6b613W9rwcT49naC8+WQCrA
        rv+vEfihGhKKYEyO0qBzzaMmW7ZmANIwIKrgBesrIRTCoHDcgKAXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=awTW+1TRddREQsN/zvjhbxkfdzoqaMwofnHS5CZgsrk=; b=pH3w/M0x
        9czQkmBBwHoWCTyd/wWQyL/pgp+3PCRiD1Roie4YGYfiLmFEK5oFj3LmQ7+zXBWt
        nktcn17WSALj26j0pE/RFYHVrF7/dTKtgAbpELMramQUt7Zw6kjQlHyumk/IlfkR
        eq/aMLZfwMeQtSDp84ImzD8yccuUTlZGj+tmtd67yD6VCYDo/zQZoPjFHQYzhWwV
        WhPsQYW0JcT9ccLDonu0mC3lN5+33iaBlZwa9qN//5HSSfCbSz67wHS8aO55BXs5
        9N1gu6jqh8ax3Kf41jwW2leRMzrONP1I70InDURWXmLR0U3lKf0VLAAcgFqBj9cR
        gA8ycZiSi9k68Q==
X-ME-Proxy: <xmx:FiA7W5-cv7wVeHdhibvhTmPVJ9n6FWILpHgaqSommY7t5YMmzjR6yw>
    <xmx:FiA7WzHn8mMpuCgG52ivvQlOLCkqu8sslIB3LDKRmGdkjoRRAmjilg>
    <xmx:FiA7Wzd4cjziZnqqwDTdIXUfQCPOncJ_eKKDy9OK0lPQXoaW5Q3qQQ>
    <xmx:FiA7Wykrsz00-_cfch8T-7kxPJQGpYlDkrAecsAbdY7Gb80SO3l3yQ>
    <xmx:FiA7W1q1_qS1SRMCRjkhyzNCn7ismtJhPfbFO7n41ZREYYIJGNyyVw>
    <xmx:FiA7Wzwray9cYlG-6uOu5FdeYsHs5KRcZHkCrlVBmjvuFTh-f6S15w>
X-ME-Sender: <xms:FiA7W0R1evbXvcQMnbqpHXz1W_vpvt5tY5lFSMA0fEnEk5iYQ8xhmw>
Received: from dave.bha-au.ibmmobiledemo.com (unknown [202.81.18.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A5251026E;
        Tue,  3 Jul 2018 03:04:49 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 4/4] dts: aspeed-g5: Add bmc-misc-ctrl nodes to devicetree
Date:   Tue,  3 Jul 2018 17:04:13 +1000
Message-Id: <20180703070413.28756-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703070413.28756-1-andrew@aj.id.au>
References: <20180703070413.28756-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 192 +++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17f2714d18a7..57d477e17c0c 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -187,6 +187,77 @@
 					aspeed,external-nodes = <&gfx &lhc>;
 
 				};
+
+				field@2c.16 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x2c>;
+					mask = <0x00030000>;
+					label = "dac-mux";
+				};
+
+				field@50.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x50>;
+					mask = <0xffffffff>;
+					label = "vga0";
+					read-only;
+				};
+
+				field@54.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x54>;
+					mask = <0xffffffff>;
+					label = "vga1";
+					read-only;
+				};
+
+				field@58.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x58>;
+					mask = <0xffffffff>;
+					label = "vga2";
+					read-only;
+				};
+
+				field@5c.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x5c>;
+					mask = <0xffffffff>;
+					label = "vga3";
+					read-only;
+				};
+
+				field@60.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x60>;
+					mask = <0xffffffff>;
+					label = "vga4";
+					read-only;
+				};
+
+				field@64.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x64>;
+					mask = <0xffffffff>;
+					label = "vga5";
+					read-only;
+				};
+
+				field@68.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x68>;
+					mask = <0xffffffff>;
+					label = "vga6";
+					read-only;
+				};
+
+				field@6c.0 {
+					compatible = "bmc-misc-ctrl";
+					offset = <0x6c>;
+					mask = <0xffffffff>;
+					label = "vga7";
+					read-only;
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
@@ -343,6 +414,127 @@
 						#reset-cells = <1>;
 					};
 
+					field@f0.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0 24 8>;
+						mask = <0xff000000>;
+						label = "sio-2b";
+					};
+
+					field@f0.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x00ff0000>;
+						label = "sio-2a";
+					};
+
+					field@f0.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x0000ff00>;
+						bit-shift = <8>;
+						label = "sio-29";
+					};
+
+					field@f0.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x000000ff>;
+						label = "sio-28";
+					};
+
+					field@f4.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0xff000000>;
+						label = "sio-2f";
+					};
+
+					field@f4.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x00ff0000>;
+						label = "sio-2e";
+					};
+
+					field@f4.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x0000ff00>;
+						label = "sio-2d";
+					};
+
+					field@f4.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x000000ff>;
+						label = "sio-2c";
+					};
+
+					field@f8.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0xff000000>;
+						read-only;
+						label = "sio-23";
+					};
+
+					field@f8.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x00ff0000>;
+						read-only;
+						label = "sio-22";
+					};
+
+					field@f8.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x0000ff00>;
+						read-only;
+						label = "sio-21";
+					};
+
+					field@f8.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x000000ff>;
+						read-only;
+						label = "sio-20";
+					};
+
+					field@fc.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0xff000000>;
+						read-only;
+						label = "sio-27";
+					};
+
+					field@fc.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x00ff0000>;
+						read-only;
+						label = "sio-26";
+					};
+
+					field@fc.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x0000ff00>;
+						read-only;
+						label = "sio-25";
+					};
+
+					field@fc.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x000000ff>;
+						read-only;
+						label = "sio-24";
+					};
+
 					ibt: ibt@c0 {
 						compatible = "aspeed,ast2500-ibt-bmc";
 						reg = <0xc0 0x18>;
-- 
2.17.1

