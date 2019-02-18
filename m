Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69075C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD002070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501146;
	bh=5y30JKxGx+uKKUURFdfc9dXjPyAEA70XEMgJ0imC+zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YikQ67zSP0YtQf+UPsWRR9OW44nDElCMurO/k9iCW1Q9GyqAbLj6iDonAdyTiPVgs
	 uKccSZpv5XLm5AhcTTEDTRBBhkMIA3qCtG4Q7CIsO160P+AoDwoHx8BauiCEGFmFk4
	 VAx0hpXTlwDDkRlcjmEinjpZnTE29L/0IkOKOX7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfBRNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbfBRNrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4384821900;
        Mon, 18 Feb 2019 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497626;
        bh=5y30JKxGx+uKKUURFdfc9dXjPyAEA70XEMgJ0imC+zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXs/4ryxc5ZdOeDGoRUAbMo0W4CM5v7P4BPM98mhP60BocsYfadHDYOeIV6nggGZs
         VH0C5caELeABZ4UEhMgFPhhhpi4p0ndYsyIzfnf/yIs3AIyraUbM7HpnbnuB4gkZOb
         MvkXOdfFQwRRRtROqeDU48qhfJ3wufxG4HlwihOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Julien DAscenzio <jdascenzio@posteo.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 36/92] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
Date:   Mon, 18 Feb 2019 14:42:39 +0100
Message-Id: <20190218133458.100487318@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index cbaf06f2f78e..eb917462b219 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -36,8 +36,8 @@
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



