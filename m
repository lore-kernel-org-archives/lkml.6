Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FE52151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VKqIPHSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FE52151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeHUUDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:03:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52776 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeHUUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:03:36 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/8] pinctrl: ingenic: Probe driver at subsys_initcall
Date:   Tue, 21 Aug 2018 18:42:30 +0200
Message-Id: <20180821164236.21101-3-paul@crapouillou.net>
In-Reply-To: <20180821164236.21101-1-paul@crapouillou.net>
References: <20180821164236.21101-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534869763; bh=UfkuqVKJe2vkkG0xoS4B+qlAvZb5p3fqqB2NF/DTTes=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VKqIPHSVdNMGPY1+VXI9CXO7S9Cr7n4czvXmf8pQoVKytoY/FeQUJqH9SusWUpzL/zxOevuLV/LaOvSti5O7HolafG86QlpquDEmNLRl49zKg2lMzzSlV+rZ9AHocM/8e6RijWYk9IMQQUgEPol0uhu/PyhpnK+QgTHWTKekYd8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using postcore_initcall() makes the driver try to initialize way too
early.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 drivers/pinctrl/pinctrl-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 6a1b6058b991..4bceae88d056 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -847,4 +847,4 @@ static int __init ingenic_pinctrl_drv_register(void)
 {
 	return platform_driver_register(&ingenic_pinctrl_driver);
 }
-postcore_initcall(ingenic_pinctrl_drv_register);
+subsys_initcall(ingenic_pinctrl_drv_register);
-- 
2.11.0

