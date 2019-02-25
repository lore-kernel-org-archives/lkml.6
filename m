Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7012083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131837;
	bh=gx31atz78pfUv5fV3LcBXmCMHSUdvgIQwaBSPkToge0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r0ZejDE3zWD1jgjSieE3cnwLrAVDuSSPclZE9aGr9HHpU5xsktc3YzKg+lkbmZLjr
	 a4x0rEGC60G68g11zHxhnewstHUHZYX8XPYzKuspq7IqdPtxDIkefKXuHhwk1c1J8V
	 7NZ09QRGRNVvbxTDfCtWAtDeGLUJ/Ru+EoBz9s04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfBYV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfBYVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306B72183F;
        Mon, 25 Feb 2019 21:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129671;
        bh=gx31atz78pfUv5fV3LcBXmCMHSUdvgIQwaBSPkToge0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWYgOR4d5o+f7Ptn7etk+4nxmC1jHtq9cCEhqeoA0SuqK4slbUSI/OmBi/h+kdDnR
         KAq3D7Y4rM97qiwc6BMblX7v6cnwqXPXlUB+4EP5T4NFL0VQ/jLcZNs5ZziWs73RRb
         hLiBFY+GYZt6YLtIfzRYfijByZz/t9u7g2lmHOYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oskari Lemmela <oskari@lemmela.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/152] mfd: axp20x: Add supported cells for AXP803
Date:   Mon, 25 Feb 2019 22:10:23 +0100
Message-Id: <20190225195045.824549233@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



