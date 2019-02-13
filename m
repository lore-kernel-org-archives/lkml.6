Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA76C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791A207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027085;
	bh=vXh6xW+Be3BKZey5chac2k9E4/rrpVqWM1Q9YC9p7LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1EqnP1mcr9uO/2KXMC5xwe7NLGoG6r606zZV3oHtkb727G7LU5aM7OBDalrKtYmdh
	 rasXvxJU+MQGtS2eDdccDqUIhjIUq1IzL8k3ROvR57YtD9ADpbNUXeTvrVgJ0c7d1j
	 Krifn35PbsIfH3FQNhBzGXgQQaljiVfrG4WiaaTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfBMCeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387497AbfBMCdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB49222BA;
        Wed, 13 Feb 2019 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025232;
        bh=vXh6xW+Be3BKZey5chac2k9E4/rrpVqWM1Q9YC9p7LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxESBVotCaxdyF+YFJijZONxmWVm1lBOT6RNgYW+BN5namW78KzwUBHM5x4I7Ao30
         mx3Rjx+Jx/T1xQ+qUtQFHws2ZizHO+PPkPgS0t3ZqWqho522gyx346x5KQx2fyxDX9
         zJ5xnILyOizfF5+4dEMh5xoEa8c0YcmcaQDeTAiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 015/105] mfd: axp20x: Add AC power supply cell for AXP813
Date:   Tue, 12 Feb 2019 21:32:06 -0500
Message-Id: <20190213023336.19019-15-sashal@kernel.org>
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

[ Upstream commit 4a19f9a65375ca9781b3ca9e810ece92edfc3e78 ]

As axp20x-ac-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..dfc3cff1d08b 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -778,6 +778,11 @@ static const struct mfd_cell axp813_cells[] = {
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 };
 
-- 
2.19.1

