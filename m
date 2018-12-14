Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0388C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8624020892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791093;
	bh=/u56KJRZATnW8rbC7A0ETNdBNNclTy0vbFyouIxi4nM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YOnDM8aIghUwQdjcvgYjFXy0gXeDN76FEMmmrhHWycw4YiJ7pwa/KVg9y6+67FnmB
	 kNG7oihj7AXusXIsYNG+NEVvQqv5rTvDyYyzYwtpyrKRxiTLv+xmXjmer1wE2QbJU0
	 6hziMlZx0znnezDDaX/XY+AdLL+EK8Gr9FfQezV0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8624020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbeLNMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:38:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58916 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbeLNMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V7v8Uh6839enwi2ZlhBHQPYbjbyrC7Kzrhrq3CIbkAk=; b=IRfbPn8pDsSv
        X+YVyjYNkiZvoUJIEjlEsRgGMYS7qUgYbHrWOZeow2DQ/vrQdAPLoXr+4Xdkrjfb1aO/klq1SDvzY
        Wk3+KyFXULJYDgPOuvL+eXMlt0vNjyA72wIhRA8lrrQj6A6rc0pDf5Lgi3dR6j/dketEMUP+rWdPw
        o//00=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXmj8-0006kX-LV; Fri, 14 Dec 2018 12:37:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 576FF11258A1; Fri, 14 Dec 2018 12:37:58 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: sh-msiof: Add r8a774c0 support" to the spi tree
In-Reply-To:  <1544732397-6361-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20181214123758.576FF11258A1@debutante.sirena.org.uk>
Date:   Fri, 14 Dec 2018 12:37:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sh-msiof: Add r8a774c0 support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 079e7f8709bb41cd0dc13efaffb24a0f17841955 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Thu, 13 Dec 2018 20:19:57 +0000
Subject: [PATCH] spi: sh-msiof: Add r8a774c0 support

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 4b836ad17b19..37cf69586d10 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -5,6 +5,7 @@ Required properties:
 			 "renesas,msiof-r8a7744" (RZ/G1N)
 			 "renesas,msiof-r8a7745" (RZ/G1E)
 			 "renesas,msiof-r8a774a1" (RZ/G2M)
+			 "renesas,msiof-r8a774c0" (RZ/G2E)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
-- 
2.19.0.rc2

