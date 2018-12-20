Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D441C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28FE20645
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545321628;
	bh=ylaV7RwQTXHLUS9UZJwjxA8C6zPQtCfjX6tzphgkEdw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=E/zi/EJi9ol1iVOmazX/EWq8Aa1O+xpY2xg03xigvNjpRvNP8eAN1JAsOIdneMrD1
	 Kqmq/zhgekC9dUTpOaGI+Yq5Yx+15CArMEfmqPsoXxuH8w5a/2iI/3GhlHRBF8Nm+A
	 8iDVQ4PX3z2f8K5BS6l6K7Jdsk1ISbXO7oAVAEFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbeLTQA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:00:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46328 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbeLTQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HlnwUa7MukyBFYYwg/vHNyv7RW9rtMWT0JEzpi8LlAo=; b=euhF2ovDsGO7
        pzLqJYaq4g5I07FwCLPNqaHRQvjia6L+NgHgWh1ZyDHtAQ+VCtsq/nLt3RVH2jtt/vSopWVAwcOHq
        Zk4wQV92UNKX+ASTV5Iy1Pse5pD5j0+7doCABDvaHylM+mA4U9vqoJ2slQNCr7yZE8dtd2zmIK+5/
        1714k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ga0kF-0003rJ-T5; Thu, 20 Dec 2018 16:00:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8C6191121B87; Thu, 20 Dec 2018 16:00:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mcp16502: Fix missing n_voltages setting" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181220160019.8C6191121B87@debutante.sirena.org.uk>
Date:   Thu, 20 Dec 2018 16:00:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Fix missing n_voltages setting

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

From f4c8f980283b4832dad4d9ff4d5ecb3d7763efae Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 19 Dec 2018 16:58:04 +0800
Subject: [PATCH] regulator: mcp16502: Fix missing n_voltages setting

The n_voltages setting is not set, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index cb11fb206899..3479ae009b0b 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -90,6 +90,7 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 		.ops			= &(_ops),			\
 		.type			= REGULATOR_VOLTAGE,		\
 		.owner			= THIS_MODULE,			\
+		.n_voltages		= MCP16502_VSEL + 1,		\
 		.linear_ranges		= _ranges,			\
 		.n_linear_ranges	= ARRAY_SIZE(_ranges),		\
 		.of_match		= of_match_ptr(_name),		\
-- 
2.20.1

