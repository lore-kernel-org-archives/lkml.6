Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DBC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7306621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026189;
	bh=TrngeQ7lT6I8Fa6zu+H7VvOTWm/GhYHvMOIbAa1IBBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ky2zW8A9xWECw4LoQHkKSkT0mvs3WDy0G3FrmjjBSDpaByYM1bBKXe5gScnHq+MHV
	 /IKiJJEx3CPMawv8mMDQviZarwwuNowDab8cO5nBfWVRmrpj5bJ45GKcmEC3AHJLQe
	 LcFTDQoDeuF3XZS3z+elOPRi7YqvUbyGZvFlyQ78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbfBMCtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733143AbfBMCkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FE4222C2;
        Wed, 13 Feb 2019 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025601;
        bh=TrngeQ7lT6I8Fa6zu+H7VvOTWm/GhYHvMOIbAa1IBBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UbfVolODnRV2flHNrwiia0qdOOp3+gFbN5GL5Lqbjsc6Bc7pczHMqzW6nbaHocel
         mXkKFeJsdBcHWbaMLNb+pbsDH9LAQTr4ZIEwOqrFM6rktIywBeShpKCaHTtMlS8DO4
         5JA2QbJWI5dEXT71VoB3XwNtrHersCAyJ0CMQClw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dien Pham <dien.pham.ry@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/34] mfd: bd9571mwv: Add volatile register to make DVFS work
Date:   Tue, 12 Feb 2019 21:39:25 -0500
Message-Id: <20190213023952.21311-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dien Pham <dien.pham.ry@renesas.com>

[ Upstream commit b0aff01e7aa6ad2d6998ef1323843212d1db8b04 ]

Because BD9571MWV_DVFS_MONIVDAC is not defined in the volatile table,
the physical register value is not updated by regmap and DVFS doesn't
work as expected. Fix it!

Fixes: d3ea21272094 ("mfd: Add ROHM BD9571MWV-M MFD PMIC driver")
Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[wsa: rebase, add 'Fixes', reword commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/bd9571mwv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 64e088dfe7b0..98192d4863e4 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -57,6 +57,7 @@ static const struct regmap_access_table bd9571mwv_writable_table = {
 };
 
 static const struct regmap_range bd9571mwv_volatile_yes_ranges[] = {
+	regmap_reg_range(BD9571MWV_DVFS_MONIVDAC, BD9571MWV_DVFS_MONIVDAC),
 	regmap_reg_range(BD9571MWV_GPIO_IN, BD9571MWV_GPIO_IN),
 	regmap_reg_range(BD9571MWV_GPIO_INT, BD9571MWV_GPIO_INT),
 	regmap_reg_range(BD9571MWV_INT_INTREQ, BD9571MWV_INT_INTREQ),
-- 
2.19.1

