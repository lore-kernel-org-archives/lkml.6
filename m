Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB122C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E3B20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738229;
	bh=H2I9j7Z9RZpoUBHcjn2d9ThQxaoQidRr26MSQKPfPgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWc/1eZ3pWu2YUz/s2GTEbphPI6zAIBsD68IEO1lsh76MjlMlwalUgYxjSwTGsMmi
	 ytaJ62TbKYquHfjmpbdXNv/Ml72PGCri0nQ7qlIv0KSlVt4GlwgceTbL45KS+nNd4Q
	 8E0m/jtjczdi3JdlrMoGyDHdnuX+OaVajirM0WZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfBISuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfBISuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919062196E;
        Sat,  9 Feb 2019 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738217;
        bh=H2I9j7Z9RZpoUBHcjn2d9ThQxaoQidRr26MSQKPfPgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZTFq39onUzKWc67+AibdawmNdRDSVdHnuSpnxOJkvH5g8oSr0mbeM8VRN35Z1YJe
         Jwa7mv3ZdfM+F1I/LIJPHT0qxPtfjBTpmijnEbUsOUvxyo9iKNaC1i4enMOMR7n6uj
         0k3Kmtq+T0E+uurIGOQXFe2jVOEiLDPFbX+ndvIQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jamie Lentin <jm@lentin.co.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Julien D'Ascenzio <jdascenzio@posteo.net>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 2/4] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
Date:   Sat,  9 Feb 2019 13:50:12 -0500
Message-Id: <20190209185014.127264-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209185014.127264-1-sashal@kernel.org>
References: <20190209185014.127264-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit b5f034845e70916fd33e172fad5ad530a29c10ab ]

These two lines are active high, not active low. The bug was
found when we changed the kernel to respect the polarity defined
in the device tree.

Fixes: 1b90e06b1429 ("ARM: kirkwood: Use devicetree to define DNS-32[05] fan")
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Julien D'Ascenzio <jdascenzio@posteo.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Jamie Lentin <jm@lentin.co.uk>
Reported-by: Julien D'Ascenzio <jdascenzio@posteo.net>
Tested-by: Julien D'Ascenzio <jdascenzio@posteo.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 113dcf056dcf..1b2dacfa6132 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -35,8 +35,8 @@
 		compatible = "gpio-fan";
 		pinctrl-0 = <&pmx_fan_high_speed &pmx_fan_low_speed>;
 		pinctrl-names = "default";
-		gpios = <&gpio1 14 GPIO_ACTIVE_LOW
-			 &gpio1 13 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio1 14 GPIO_ACTIVE_HIGH
+			 &gpio1 13 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0    0
 				      3000 1
 				      6000 2>;
-- 
2.19.1

