Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B451C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D45220836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550776408;
	bh=araHCdjeh5ghKN0Gy1uBH5LDh1jS7iDLoUDCls9y+iw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dQkjbKngyFwmpfdWVeT3xsNwzV5R06/j33GmjK3zMqfKTNhvtQjk73Dx91wuCvDri
	 a2Nh7ErPG/kkfdutYTAlUBnLA9b/8rwPRSbyegLzutZ9d/AWKOja+QF61R09ymA6Ua
	 DCSxFA0O3zELPl+aUnKb9vqf5IweGEz3GRoTCSd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBUTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:13:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfBUTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rPlblCWguVjvLPQ+uDzlqr1y1O5mMDU0UUhlfLdctYo=; b=ctWkXxJq269L
        U7fDx1pwQ7LpS9LQq+QMvyssM4MooDa+ZsHnX69AUGeYYMS+BXTSYb7vopg74FK8B0HGptU51THxA
        oJkxDKgVlog+kjwaDJhODlqaGYqeAPpIL9R3dCOunk/3zmAyDRQ6R5No2JFfNxoPEXQHnywjz+0HH
        +B/wY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwtmb-0005xP-ON; Thu, 21 Feb 2019 19:13:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4260A1122744; Thu, 21 Feb 2019 19:13:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s5m8767: Constify s5m8767_opmode_reg" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190221191316.4260A1122744@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 19:13:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s5m8767: Constify s5m8767_opmode_reg

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 21687b16248530bec6b950d73a58e4c2eca8e830 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 21 Feb 2019 21:17:21 +0800
Subject: [PATCH] regulator: s5m8767: Constify s5m8767_opmode_reg

The s5m8767_opmode_reg should never change, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s5m8767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index b581f01f3395..5b0e1fe6723f 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -115,7 +115,7 @@ static const struct sec_voltage_desc *reg_voltage_map[] = {
 	[S5M8767_BUCK9] = &buck_voltage_val3,
 };
 
-static unsigned int s5m8767_opmode_reg[][4] = {
+static const unsigned int s5m8767_opmode_reg[][4] = {
 	/* {OFF, ON, LOWPOWER, SUSPEND} */
 	/* LDO1 ... LDO28 */
 	{0x0, 0x3, 0x2, 0x1}, /* LDO1 */
-- 
2.20.1

