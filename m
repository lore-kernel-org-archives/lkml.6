Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9882CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D3275BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486D3275BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967123AbeF1PUj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:20:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53343 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967066AbeF1PUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 031E420DD9; Thu, 28 Jun 2018 17:20:06 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id CBF00203EC;
        Thu, 28 Jun 2018 17:20:05 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: [PATCH 14/14] arm64: dts: marvell: armada-37xx: update the crypto engine compatible
Date:   Thu, 28 Jun 2018 17:15:44 +0200
Message-Id: <20180628151544.22134-15-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628151544.22134-1-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatibles are now supported by the Inside Secure SafeXcel driver.
As they are more specific than the old ones, they should be used
whenever possible. This patch updates the Marvell Armada 37xx device
tree accordingly.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 3353252d78a0..2d68614aa66c 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -287,7 +287,7 @@
 			};
 
 			crypto: crypto@90000 {
-				compatible = "inside-secure,safexcel-eip97";
+				compatible = "inside-secure,safexcel-eip97ies";
 				reg = <0x90000 0x20000>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

