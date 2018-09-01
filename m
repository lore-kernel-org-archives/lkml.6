Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69634C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBCD20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBCD20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIAMYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:45 -0400
Received: from mout.perfora.net ([74.208.4.197]:49739 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeIAMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:44 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LszG8-1fkYkT1bI2-012ZQY; Sat, 01 Sep 2018 10:13:23 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 12/34] ARM: tegra: colibri_t30: use proper irq-gpio for stmpe811
Date:   Sat,  1 Sep 2018 10:12:26 +0200
Message-Id: <20180901081248.22639-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:VmB9vAlspv6sAHb63RFJ8tzx0nFACI5+jNuy05jOUk5U3jAbhdT
 AVuVUDpPrVvv0qXzkkTw/o5lOyKy6nkGIeFjjMB3e21Q6LdRgkbd86yGS748iLnECG/MtWm
 gcns6NMK4wWU3HLaVj2LIQ8Vhdu6fRAgasMsqq0kprTnVHYwAsWeAoE5/C9MEmPp6B1TKoD
 vWJy28wFUMCVpKA4aeh1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8FufCYNjNuc=:e1npLjxfqRJaaSlRG0o6+N
 mdT+dcvYfgnenquweLr+DoQ5LuoOLnFkTGvkfqvxl3LowFAPt7QeR6gnASfx5l3zsoueBCFvh
 d5mAHioM7xeDag+3zAnO4cBSQxwx+QUzzHoxCKHHp7JU4R0o4HDmxik5qfFxTsIjuYhYRg3Z6
 fJ5IUppSjiYRsFgNq9tYM/QGTH+TJCURksN6uPOnt7+JzzyKr/S0CJLte7XVLO7O1ev9JRU7n
 Ki3xYjsyrZ9VuN1MvefPlvxnavppVTIvDPVRacGH+87hKpHDaymE0qX9X+q4D5aTTFY1HrrfL
 MP7v6QyOo6QL4pfebn8E02pw1TC1DWzJL2yYuhqs0aL8quqC84wnv4WSF8srPSrm4FE4oi5eR
 M9yHibP9uRDGSfQZR78HzBjvrzNEMdTIywM3joUBgjAj2tzLB4NbXDYV63lN/3O1rts2ehVXN
 9ayUhmsFdDG5i/rKi5fZrsiKXXWijVvc/RIw6Jbfv8dfvsizTFO9Yt7GCXeCVOfGgTDzunopb
 OUInNFwzIoU+i4uuZEoQYpwYnNRccFTC6l+l1oVxmnyo/6BwIXsLCPd2G6D8SfhrllFEzBv94
 yuJxL5OU5sbUvHnVemlzseVmS24zNWcamTjWTVRffAhJfWEPGNFsg5ZOddRJW9NdHrg1PS2Aw
 o+p5J3xhvAKJ/ZIwD5s1vb1HtRCCb7T2Esip9PghPuhKWEYLYAPxWKmXt2uz0iWMqV4s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use proper irq-gpio for stmpe811 touch controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 197605d99425..3a5151dc8483 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -844,8 +844,7 @@
 		stmpe811@41 {
 			compatible = "st,stmpe811";
 			reg = <0x41>;
-			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
-			interrupt-parent = <&gpio>;
+			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			id = <0>;
 			blocks = <0x5>;
-- 
2.14.4

