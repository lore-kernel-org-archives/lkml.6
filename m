Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69195C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0EC2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691457;
	bh=148sDG9duXACtyjsI7o/I4sR9rvIi2U0xb0huy7DZns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CAwpVHdrjXKmqcGHUAcgIlH75xDMtmQmbiqffgGnuVy/1ygh2z3muKu8xg2rCi7A0
	 ESzoBlnv0YSyYSc0wa7ZRT6/U/losOhHDTBUo1cM1N4Sb5gl91T4Ui98vX7fdxKVeQ
	 KQD8Ln0kCGZbWiSxmL5GEdqkIM+lwULWPX3U6ryA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfA1QEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbfA1QEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF652147A;
        Mon, 28 Jan 2019 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691449;
        bh=148sDG9duXACtyjsI7o/I4sR9rvIi2U0xb0huy7DZns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3sBFTRMpPXpLYntY/u2kB4FanOKi4NfbqUFVP/gDxQOTwb5+puI5XVJsjMWUcO5V
         26tB2q55R+C6uyMQmssxNhJx07aCmiDYrGDnWYJPZZII1UFRIfKhbxD6UAkLYFy/xN
         rX8Vp2tKLX1Zd9U9Sjdc/wgcbZ1eAOTVwCKa37YM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 096/258] ARM: dts: aspeed: add missing memory unit-address
Date:   Mon, 28 Jan 2019 10:56:42 -0500
Message-Id: <20190128155924.51521-96-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 8ef86955fe59f7912a40d57ae4c6d511f0187b4d ]

The base aspeed-g5.dtsi already defines a '/memory@80000000' node, so
'/memory' in the board files create a duplicate node. We're probably
getting lucky that the bootloader fixes up the memory node that the
kernel ends up using. Add the unit-address so it's merged with the base
node.

Found with DT json-schema checks.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts       | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts         | 3 +--
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts    | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
index df1227613d48..c2ece0b91885 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
@@ -13,7 +13,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
index 7a291de02543..22dade6393d0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
@@ -13,7 +13,7 @@
 		bootargs = "earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index d598b6391362..024e52a6cd0f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -14,7 +14,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
@@ -322,4 +322,3 @@
 &adc {
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
index 43ed13963d35..33d704541de6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
@@ -17,7 +17,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
-- 
2.19.1

