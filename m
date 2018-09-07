Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF76C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1C12083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PZVbaP8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1C12083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeIGFiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:38:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:57575 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeIGFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:37:52 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F38068365F;
        Fri,  7 Sep 2018 12:59:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1536281979;
        bh=vXJ15sCbem1RejvdnmPQ3r4YvyNOwZT8GrobMGj6+lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PZVbaP8UxA7AqqZO5eIQhLv8GrqKs+whApm8KqioBZEIlBelfmSPKQsTPO3IePhXf
         7ChvsEbeqKAMSh4pK6sn+nlKEeMKwBKepKaovjsrcr2XklHiLMjoLoMuUEPzb8eFm5
         rFXL41R47TPHfohYnZCMwULo5rX1r+fDV6LHFdZc=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b91cd7a0002>; Fri, 07 Sep 2018 12:59:38 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id CE61613EE9C;
        Fri,  7 Sep 2018 12:59:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 97F301E1DDB; Fri,  7 Sep 2018 12:59:38 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, gregory.clement@bootlin.com
Cc:     jason@lakedaemon.net, davem@davemloft.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] ARM: dts: mvebu: add "marvell,prestera" to PP nodes
Date:   Fri,  7 Sep 2018 12:59:26 +1200
Message-Id: <20180907005926.27134-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
References: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible string "marvell,prestera" allows drivers to have code
common to any prestera variant.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 8d708cc22495..2185ea58abfe 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -243,7 +243,7 @@
 			ranges = <0 MBUS_ID(0x03, 0x00) 0 0x100000>;
 
 			pp0: packet-processor@0 {
-				compatible = "marvell,prestera-98dx3236";
+				compatible = "marvell,prestera-98dx3236", "marvell,prestera";
 				reg = <0 0x4000000>;
 				interrupts = <33>, <34>, <35>;
 				dfx = <&dfx>;
diff --git a/arch/arm/boot/dts/armada-xp-98dx3336.dtsi b/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
index 2f5fc67dd6dc..1d9d8a8ea60c 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3336.dtsi
@@ -35,5 +35,5 @@
 };
 
 &pp0 {
-	compatible = "marvell,prestera-98dx3336";
+	compatible = "marvell,prestera-98dx3336", "marvell,prestera";
 };
diff --git a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
index 7a9e8839880b..48ffdc72bfc7 100644
--- a/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx4251.dtsi
@@ -49,6 +49,6 @@
 };
 
 &pp0 {
-	compatible = "marvell,prestera-98dx4251";
+	compatible = "marvell,prestera-98dx4251", "marvell,prestera";
 	interrupts = <33>, <34>, <35>, <36>;
 };
-- 
2.18.0

