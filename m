Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89EDC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730FB2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="a2ft22AD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730FB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIKUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:19:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37088 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Bo1+SIHDcdY36t2RWtmMyz6pqc1zzhQE407aYgM41Kg=; b=a2ft22ADJB80
        aXfb4m8KCXPMEp2hlMLLaMR6dNiIoyHRnk+/krWlld6oiONbF28IL+Weg3udcWy++f7HFeBgvKt/w
        BIzrmJ0uiX+6aXwolGJgvp+BIXoI4/Fv3OKdUy1ygJauYB1cWvJcQe5HAuQHc/QapdUGfY8gzBnIE
        GDlv4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzkSB-0004yN-Go; Tue, 11 Sep 2018 15:19:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 43A391121B1F; Tue, 11 Sep 2018 16:19:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "kernel/reboot.c: export pm_power_off_prepare" to the regulator tree
In-Reply-To: 
Message-Id: <20180911151947.43A391121B1F@debutante.sirena.org.uk>
Date:   Tue, 11 Sep 2018 16:19:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   kernel/reboot.c: export pm_power_off_prepare

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

From 74f008f251bc1797109b7f027d3fdb1ad620385d Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 2 Aug 2018 12:34:22 +0200
Subject: [PATCH] kernel/reboot.c: export pm_power_off_prepare

Export pm_power_off_prepare. It is needed to implement power off on
Freescale/NXP iMX6 based boards with external power management
integrated circuit (PMIC).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 8fb44dec9ad7..e1b79b6a2735 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -49,6 +49,7 @@ int reboot_force;
  */
 
 void (*pm_power_off_prepare)(void);
+EXPORT_SYMBOL_GPL(pm_power_off_prepare);
 
 /**
  *	emergency_restart - reboot the system
-- 
2.19.0.rc2

