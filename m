Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA2C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A3C207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027080;
	bh=fV3+dRH5Ju9kj++KcRTXgB6OVsd4HkUCK5/+AfFd8NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHPiwe0aGnxPtseswFL5KnKJpijwcYfMDTCEkefoVhvSMzXgjSyQ7dI8jUaaQzVcS
	 RA3Imket5Pm+eYrUy1hyfnFZQNm4wltGqjRFFyTmo6IPIDieTgONcn77wi2Q0fu+Yf
	 sp3cGdiZMr3VhnjwXb+IAPSKMjdQSKDtLRJ6CqrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbfBMCeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387504AbfBMCdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AB1222C2;
        Wed, 13 Feb 2019 02:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025234;
        bh=fV3+dRH5Ju9kj++KcRTXgB6OVsd4HkUCK5/+AfFd8NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5bWBig6RbeLKrIHTw/hynSOHnGZZkM8EZqq8/SIeJ7JWJvE6HwuU12H3ZheDnuQl
         5Ys6kVJExMvcFhzDPp7KOAjvia9FI0D+WeQT/ivzU5YsrG7FAby4V09B88Y4C6uoRx
         wqjIk3zLin148qrDAmE96CAtOHQ2EiUknOg67K5M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oskari Lemmela <oskari@lemmela.net>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 017/105] mfd: axp20x: Add supported cells for AXP803
Date:   Tue, 12 Feb 2019 21:32:08 -0500
Message-Id: <20190213023336.19019-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oskari Lemmela <oskari@lemmela.net>

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
index 8037b4e01ed6..f8e0fa97bb31 100644
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

