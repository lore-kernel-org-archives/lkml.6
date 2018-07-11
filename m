Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5337C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831E6208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="QEoXolVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCfSmbw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831E6208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeGKFfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:35:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43569 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbeGKFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:35:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EEEA920D92;
        Wed, 11 Jul 2018 01:32:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 11 Jul 2018 01:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Dj6mBVhsBrF8XIKB1
        bidTmvR6Il8SyosUL7k//Sd068=; b=QEoXolVQpWfCsj8eBUPuYORmlybWZhLkj
        Kx77M+HrvqGtqtUb2suua3Fb+R28D32yLLXflWxLKrnyigduASM0mrCWOmBZoXag
        aqEufUXVltNXT7bAxGH+tkCfj0d+8Q4zUUgRptKZJeqEySWdXHLpytbTNtEzQPXH
        n/T30hkjkRBCmQAcoxZpZi1UQvVFCUbLYEUEHv2mzO5nymAWAEXTSEb3MJZI8Fuz
        KuDeIzoNOb3UmPUsE4AXbM3DZxD/EuRp2btLBAai5MIc3lNBBY34xhqNSn+RZySK
        ulohk9yYOB+ld0AK0UeZ8XxQj0sD5W8p5wHo/TAVvgkkjdh7I8f4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Dj6mBVhsBrF8XIKB1bidTmvR6Il8SyosUL7k//Sd068=; b=kCfSmbw7
        eblAAubM2qyMMq5tNInjJUo+GqxeYF2QYIHQaHdU7TdVyPx7v147YYeuiqGOlIP3
        YxllaYg03NACDZ6TOvNwXpOClOzPhcyzu5cevwVPFBmN5e1pRVYNzudhRZtAZ0a3
        6gkqtVMAk6YJWXw0wTmVGRchPVd6PB++9oVyupTY3Sy86DFZJgzQa2G2kzDjPSO3
        FyEUSAusLDTKisTau5zbUzFqQ4nGP5ROB4dJhLKed4LSoQAr8F5PgExzejM3auXt
        O42PYNIx0KZkGrKOpeBrE1FfXdZy/yrH+M4o089SoJmYrjNP6lGx7raZTCQiOtDW
        rLnrRX7HdygoVA==
X-ME-Proxy: <xmx:bpZFW9y7RWKs3vXHMWCuJGxgWGL7Ek25F3UJzRlGrcCqMifcLY7rbQ>
    <xmx:bpZFW3TCMep11DG_ZOUOMLn_GmR2oFjEYmmxSMTghUC-HatAXUBjjA>
    <xmx:bpZFW9-REm-Gqk-kLOA7vjUouvHRyzsrXJSZQG887oZc4GItWTWtJw>
    <xmx:bpZFW9tzQrYa4xaNcSh5st_xBihbKYr_PQX3Q_70RqyLend3Wq2v5A>
    <xmx:bpZFW9NmCYkUyVMsYluhUKB5KIwgxZEfU9tceIwDuERsWIliv-M1pg>
    <xmx:bpZFW6beA56BmbosJ9sbkqokdNVh0yyYYx8J8iLPsAlpWVbI8hq16A>
X-ME-Sender: <xms:bpZFW6FuWD71B1fprdF9A1gYlkXehxdOTrtxzMCVlAVGWlALa987fQ>
Received: from localhost.localdomain (ppp118-210-173-37.bras2.adl6.internode.on.net [118.210.173.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72C7CE473B;
        Wed, 11 Jul 2018 01:32:26 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 4/4] dts: aspeed-g5: Describe VGA, SIO scratch and DAC mux fields
Date:   Wed, 11 Jul 2018 15:01:22 +0930
Message-Id: <20180711053122.30773-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711053122.30773-1-andrew@aj.id.au>
References: <20180711053122.30773-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AST2500 has VGA scratch registers that are read-only, SuperIO
scratch registers that are a mix of read-only and read-write, and a
graphics DAC mux that must be read or configured in the process of
booting e.g. an OpenPOWER system.

These capabilities do not really have a place in other drivers, so
expose them as fields via bmc-misc-ctrl.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since RFC v1:

* Rework labels to what is documented in the bindings
* Fix an incorrect offset property

 arch/arm/boot/dts/aspeed-g5.dtsi | 192 +++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17f2714d18a7..c484ac637328 100644
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
+						offset = <0xf0>;
+						mask = <0xff000000>;
+						label = "sio2b";
+					};
+
+					field@f0.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x00ff0000>;
+						label = "sio2a";
+					};
+
+					field@f0.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x0000ff00>;
+						bit-shift = <8>;
+						label = "sio29";
+					};
+
+					field@f0.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf0>;
+						mask = <0x000000ff>;
+						label = "sio28";
+					};
+
+					field@f4.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0xff000000>;
+						label = "sio2f";
+					};
+
+					field@f4.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x00ff0000>;
+						label = "sio2e";
+					};
+
+					field@f4.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x0000ff00>;
+						label = "sio2d";
+					};
+
+					field@f4.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf4>;
+						mask = <0x000000ff>;
+						label = "sio2c";
+					};
+
+					field@f8.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0xff000000>;
+						read-only;
+						label = "sio23";
+					};
+
+					field@f8.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x00ff0000>;
+						read-only;
+						label = "sio22";
+					};
+
+					field@f8.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x0000ff00>;
+						read-only;
+						label = "sio21";
+					};
+
+					field@f8.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xf8>;
+						mask = <0x000000ff>;
+						read-only;
+						label = "sio20";
+					};
+
+					field@fc.24 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0xff000000>;
+						read-only;
+						label = "sio27";
+					};
+
+					field@fc.16 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x00ff0000>;
+						read-only;
+						label = "sio26";
+					};
+
+					field@fc.8 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x0000ff00>;
+						read-only;
+						label = "sio25";
+					};
+
+					field@fc.0 {
+						compatible = "bmc-misc-ctrl";
+						offset = <0xfc>;
+						mask = <0x000000ff>;
+						read-only;
+						label = "sio24";
+					};
+
 					ibt: ibt@c0 {
 						compatible = "aspeed,ast2500-ibt-bmc";
 						reg = <0xc0 0x18>;
-- 
2.17.1

