Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46046ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F125320856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F125320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeGTIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:46:48 -0400
Received: from mout.perfora.net ([74.208.4.194]:57211 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeGTIqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:46:47 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2018 04:46:47 EDT
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LpuQT-1gCRCQ2Ecx-00ff9M; Fri, 20 Jul 2018 09:54:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH] ARM: dts: spear: fix stmpe811 interrupt properties
Date:   Fri, 20 Jul 2018 09:53:56 +0200
Message-Id: <20180720075356.26156-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:be4meY3uKt6s/6h4fMN2rZkaSbdQN4M74trY7o9mNahAd5SNipr
 KiaterLdsWC4FNHl1CLAwcU4iuQEyCWamJO/3DbNDIQ3BYUVvdEo6tWllFrhvW+UTXplsS6
 m7LlCAcXU8ypp28vxpvCEirZkkkkrZuyJ7nWPHAzZQ5a9QO/vNkE5h12DmmBsy2fbm+W/oK
 vDBdFwiMHy8xCaHqEEkXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9pMNkUMpowk=:YkRhVEwzVr4zyeeZXC0KOe
 IIEnykIpMHPAAPmMoyqnAO/zhc6MoeAr07QbnosWk4PcOOlasTV/vDzaxt2vUIAxIfACgD2+u
 3hcgSxho+vCUERvBrXMEWEDiiaoLmSTbu9Dlxin6edA6ZGVcLSLqNn9wiJ9VnyyXlGCbkAsyc
 Lpu/tUq6Pkk6QC+7rTl5NGUIViI56ZeYyhVmCqtnr0eyGGiC0UgpAtrvlcfSseFZqm6h2SZbD
 kZPcz6BH9rwXA7XhFF0C94nqtTgANnyoBF4p+DoHoA8aJPzDqosW/kQTwhj4gzaKRKGKNAltf
 HQc9fRlg56DqVkWL3azU/K0cEun3fU8V0NxnJf50/GYbQTG9yWThyScJ/kgRKuzNHI1WQfpyi
 KF/hbj/7+UOehywkTtgJLxd1dswRgYLvpMnOmCkcpD9YL7Vgsd7mNUp7D3ykhTa6HSu4we+Dm
 xjvO7IrWvftHGRI2BihZb0hw2Nfk99DIsHWMvNrypIuviB17kErm2sBDfxlFZd08zoE4ZKheC
 XLMgcRaWJHn6d9f91V5sLrpFnyt5RCFUujJNyjNGT/itVp2Jy4qze5oFodFGfGg/pF0FtXJQQ
 hiqtVtOr8DsBbm4TmuoGAyBUE/adOp2SW62Nl6W7Vjrw685kWILiWBaKWubfj5cqWKq8bAhsX
 oEcsY9mXln4quFQbTJoclZFyzc8VLJ5vHSlg6jjOQiTsOEMXCOv5RAikZLSQc2VbK/8Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The property "irq-over-gpio" simply does not exist (this is nowadays
actually auto detected) and the property "irq-gpios" is actually called
"irq-gpios".

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/spear320-hmi.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 0d0da1f65f0e..d2d1fe944407 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -241,8 +241,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0x41>;
-					irq-over-gpio;
-					irq-gpios = <&gpiopinctrl 29 0x4>;
+					irq-gpio = <&gpiopinctrl 29 0x4>;
 					id = <0>;
 					blocks = <0x5>;
 					irq-trigger = <0x1>;
-- 
2.14.4

