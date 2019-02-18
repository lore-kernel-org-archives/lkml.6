Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92E2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499302;
	bh=Z6BBe5R3C9jcYuMTzSVdrzFm4EbiXzz4Uc986ip51eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bD9Su6dd0/d+aGXJaEMgmTKo0XdVa1/DF8I0BhPqwiq5F5fV8VYTG9KgIFpfp5yqN
	 gaRDjN1ooCZX0l7T4Yr5Gvbk6U8CvRvGWjbexcSrQUWxgmMN0nhrjMBC3O/N6A16e1
	 ChYfmOfO9uLEZ3pJH8hK/65EdlvkuC2ibUQO5auU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392081AbfBROMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392055AbfBROMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA76218AD;
        Mon, 18 Feb 2019 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499151;
        bh=Z6BBe5R3C9jcYuMTzSVdrzFm4EbiXzz4Uc986ip51eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLqX6tPnzjjleH++mMkXfZD5F90N4Qifpnl/OhUYBI9fYE30cAyfpCf03hXJkJ5eQ
         BjMNGoZ3znPj7hqp/JKP813EhRdUamotUSq9au/y8t5QLQiKRoP7L+a7yJVwS8W4oN
         j5IQGaRh8zSTa+WrEPwwyBX98rWcGm5CuLrJsQA8=
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
Subject: [PATCH 3.18 093/108] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
Date:   Mon, 18 Feb 2019 14:44:29 +0100
Message-Id: <20190218133523.935629895@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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



