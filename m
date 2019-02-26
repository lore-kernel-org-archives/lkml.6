Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CEAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0721855
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182810;
	bh=F2Bl25Z4mlAF15nn/5fLjqLMOwMbT8f7GeBFM6AFfqU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mYuGIoX3Q/BthiPN46F257TLWIGGu6+/VMettuD1Bp7q/Stt/S9tr3pL2J9dFLA8+
	 eyaht1JfrJclwDyteewtOZCRpiV+eQvn7HFYCVXO0o6P7nkL51VmTbnoi1YEMLjCYy
	 69+vz3BJeaaufXvQKY3msU3pimVYvr7/xaVizXOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBZMGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfBZMGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vS/4YVilujIetfHNUTqq9yJYvLYLG/qRz+EzR8bZMU0=; b=I+6z4axL3mcX
        3Q+kENJprUT7ROJDOfXFeYSLEsAIDYPk2sRNWu22Y8/QDWS8BQU0XI6HqFkHqUQKiSthXUMgEpCH9
        uwfQ8qz40MWuozZh+FxIoJk+AsbGFBWks0ndGqZu/uYNKL4sJCkUGxam0cA4T+2llckKp7nJurw2/
        xq1vo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVS-0007iV-Af; Tue, 26 Feb 2019 12:06:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E74EA11284E3; Tue, 26 Feb 2019 12:06:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: tps65218: rectify units of LS3" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120641.E74EA11284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: tps65218: rectify units of LS3

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

From 5ee3d33d107feee21bd52697eeab8c7c726062f4 Mon Sep 17 00:00:00 2001
From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Date: Mon, 25 Feb 2019 08:15:03 +0100
Subject: [PATCH] dt-bindings: regulator: tps65218: rectify units of LS3

LS3 has a selectable current limit.
Change units to microamp in the example.

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index b28e9bd140c1..54aded3b78e2 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -77,7 +77,7 @@ tps65218: tps65218@24 {
 	};
 
 	ls3: regulator-ls3 {
-		regulator-min-microvolt = <100000>;
-		regulator-max-microvolt = <1000000>;
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
 	};
 };
-- 
2.20.1

