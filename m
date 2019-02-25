Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086CFC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15EE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131116;
	bh=kkozOgPquFFGV2phCEHPuqbBb1e5fm6fu6LbSrwJx6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vUMZ7JGWjmPszhgqjLMoRppXl5WWVvFs4iUXGDUc7uOAWbhcDU9GTZjj/XjWkjBKT
	 1uj8X9Uk2E5bg/78n1qe5AAMFR1GhYhKYfsd2peJ6lN2Jh0rlgHPIgk9OEN6yqv6Wl
	 8ay50Ts2HnkjyjgF9zTTAtM7LMOe6AXAx/wJ1vcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfBYV32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbfBYV3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85D2D21734;
        Mon, 25 Feb 2019 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130164;
        bh=kkozOgPquFFGV2phCEHPuqbBb1e5fm6fu6LbSrwJx6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyGbJjJjv7uHFvmM173djUvrg1jsEaMPnRMgwXJQ9xQdtOmqCUCbluAkGI6MOXolU
         6O8TnxCygvSlGC8uDeNLpNXq26dPdzq+nXICO4D2SVORxgvDAq3bYf06x6LJeMNqQC
         NiA0nAe0Ui/tKyVWd9nqsISeQjtqU6FBVWaJ2Pns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oskari Lemmela <oskari@lemmela.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 035/183] mfd: axp20x: Add supported cells for AXP803
Date:   Mon, 25 Feb 2019 22:10:08 +0100
Message-Id: <20190225195100.589699445@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

[ Upstream commit ea90e7b47f0a8bd2fe14e9a88f523de7c67db90a ]

Parts of the AXP803 are compatible with their counterparts on the AXP813.
These include the GPIO, ADC, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8037b4e01ed67..f8e0fa97bb31e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -726,6 +726,20 @@ static const struct mfd_cell axp803_cells[] = {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
 		.resources	= axp803_pek_resources,
+	}, {
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp813-gpio",
+	}, {
+		.name		= "axp813-adc",
+		.of_compatible	= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 	{	.name		= "axp20x-regulator" },
 };
-- 
2.19.1



