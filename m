Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467301;
	bh=E4YYoZ48S8tXhZuIu4iemGbnTJPCgKEfCx9rxhNvTNo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aT9rqGkQKOae9PwJZtd4ptQ4kaq3+nMMncHkRoIuohQcNUSf2GwJqRgWSdn/oikrC
	 szO7fcrSgPY289amVo1lSvozduYeHVuoLG/cPsh/hiPtlT/F4BvECNv7wotpJ4SQIv
	 emYc5fz4rgUt/EMH1dH2JkFODs4YZBiD2oZSc0Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfANMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57240 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfANMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vPeKflxMsrR/+HcrZJ4MV02QlRVgNcpC3b0fI7eHxjM=; b=GEKp+bXbQR5z
        0eFXbcZ6VxYujjHe/I/ynB8SbAwoGoUW54DGpKhelWUnxvmB0DBqM+PSa+pOLLHzDffPWhHm06dGM
        SxXJIRaNz6E3DGgUPiq2o/bJSsm4gr5emk16Et5uXQCRLdwdAYABjCSdwW3HoKUKRqRtCC/UUPdSX
        HPkvE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vu-0004tu-3S; Mon, 14 Jan 2019 12:01:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B18171127AD1; Mon, 14 Jan 2019 12:01:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: hi655x: Removed unused ctrl_regs field from struct hi655x_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120133.B18171127AD1@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: hi655x: Removed unused ctrl_regs field from struct hi655x_regulator

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

From 08f0b14adc7c4fd5ef7ab2f4b7a62ed1b8216bbb Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 13 Jan 2019 22:17:46 +0800
Subject: [PATCH] regulator: hi655x: Removed unused ctrl_regs field from struct
 hi655x_regulator

The ctrl_regs field is not used at all, remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/hi655x-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 36ae54b53814..bba24a6fdb1e 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -28,7 +28,6 @@
 struct hi655x_regulator {
 	unsigned int disable_reg;
 	unsigned int status_reg;
-	unsigned int ctrl_regs;
 	unsigned int ctrl_mask;
 	struct regulator_desc rdesc;
 };
-- 
2.20.1

