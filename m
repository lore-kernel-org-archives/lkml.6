Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43519C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA3420880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678994;
	bh=iujMqwWlG7Zj3NZgs1PQxZy9Jr7CR0v1NjtW4hiFmBU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WYNq6T0c/GMrkJwKT9FhcaI7qcpzrgAYgF4uGISYzofpCG+eCqbnNnZgMq7X5HFyX
	 MxIQFI5czHCYrvg4d6P3CutsSsh/G9k17vV+yp+uCUt0YqIMowQXXoj5dJvCepS5+X
	 A3MvVdxU3MbbNamM79pe3EBYRs67oObOrrfSIfKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfA1Mfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42420 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfA1Mfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cQxN0636JXfzISjcLv536fnojzSwohWaKL8eVF6Vnzc=; b=bdao5L+ef6z4
        YUHNa9s/dIFpyfMQeqnk4Ks5RypKma5SrdU26oOPnHaQifylmr3557xy+BiZpi7w73GCzlC6AfQgn
        wOijrh+ksFO4ReyS8JxwNN/N0RVIrT/PS9R0mGcLq4e3PWsDex4pVq+o5RD4eQVUhgQYhd4PUbc5i
        0+eM0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68g-0002TM-Do; Mon, 28 Jan 2019 12:35:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0C1B31127D29; Mon, 28 Jan 2019 12:35:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp8788-buck: Constify lp8788_buck_desc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123546.0C1B31127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8788-buck: Constify lp8788_buck_desc

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

From b133305c51e977f5c64c9effd1b6533ae04095a0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 11:39:06 +0800
Subject: [PATCH] regulator: lp8788-buck: Constify lp8788_buck_desc

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8788-buck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index ec46290b647e..30de784d8e30 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -370,7 +370,7 @@ static const struct regulator_ops lp8788_buck34_ops = {
 	.get_mode = lp8788_buck_get_mode,
 };
 
-static struct regulator_desc lp8788_buck_desc[] = {
+static const struct regulator_desc lp8788_buck_desc[] = {
 	{
 		.name = "buck1",
 		.id = BUCK1,
-- 
2.20.1

