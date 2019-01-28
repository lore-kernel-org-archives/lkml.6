Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740C7C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8A620880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678980;
	bh=IR52/9i32l6RKNGiMdgsB7eWThYCpFVk+bEhWovfBaE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1npMf3L4yrN0j6OWmNhtQ6I+rsVrCo0E7IpXUJXKcqLioXaIO8fsL07lA/MY+h58j
	 MY+wWpxuYzfw2gxdZoCUSPvKiKRRGVwBGKHrGLmJ9lUVRFEOMB2EArs4zZ+vVWC9ht
	 lR5i1MKZwWo/YGB/RP0F0k1dveRlEmZht+YFPHzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfA1MgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:36:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfA1MgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ssq7PrBnwKvktPZbjkTclsAqRfHWNYmxUlpKAfHPHjE=; b=O3rM4aousyjW
        atyGti837Tacwol4KD/l6Nn6t+HRYBmDn0agJpa5bFJiXN+rOOvpSTiB21RdKI+LFU7MT3nJsgEk7
        xjCTGkmMsCN6t5w0eljbuG7DaqG/uOE9VLFjMYlnes4cQkrgLr2w/qblSrAvKMPrN6a2yAbzSbPwQ
        JiSGE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go695-0002U8-M4; Mon, 28 Jan 2019 12:36:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2F8641127D29; Mon, 28 Jan 2019 12:36:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "MAINTAINERS: add maintainers for the NXP FlexSPI driver" to the spi tree
In-Reply-To:  <1547553487-9936-6-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190128123606.2F8641127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:36:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: add maintainers for the NXP FlexSPI driver

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

From c71f9fd4503addcfa306f9bec95c3e7deade7ce1 Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Tue, 15 Jan 2019 12:00:37 +0000
Subject: [PATCH] MAINTAINERS: add maintainers for the NXP FlexSPI driver

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b6c0d454d7e..5e7ec7cda3bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10927,6 +10927,14 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
 
+NXP FSPI DRIVER
+R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
+M:	Ashish Kumar <ashish.kumar@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.20.1

