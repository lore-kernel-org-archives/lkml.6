Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2813C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6C2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BTIFEvRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbeGXRJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:09:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbeGXRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BXOkjd+lfkHiZWLJRqYbmvHFg7Bdfg3pkESRCBiOEUY=; b=BTIFEvRIVwu9
        7Q+V4EJlxxArs21+K/oVngNOhz+/5MLLry1Gp3jy7uGudumkXqnJFbw+pXL9z4uniYsc3Iu//+7Qg
        80ZcMwF8um0kq5xYzm9h5pFUdIKL1TUFlFj+pCSYJRKp53pfUCdVbJzSG2BYbB7mPy0mlZ6WwLBSr
        8Z5KY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhzls-0005ar-QL; Tue, 24 Jul 2018 16:02:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8E9F61123A86; Tue, 24 Jul 2018 17:02:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Add sw2_sw4 voltage table to cpcap regulator." to the regulator tree
In-Reply-To: 
Message-Id: <20180724160244.8E9F61123A86@debutante.sirena.org.uk>
Date:   Tue, 24 Jul 2018 17:02:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Add sw2_sw4 voltage table to cpcap regulator.

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

From ad66225dff3f30fece4f5133ea14058c95f4e29a Mon Sep 17 00:00:00 2001
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 24 Jul 2018 09:25:40 -0400
Subject: [PATCH] regulator: Add sw2_sw4 voltage table to cpcap regulator.

SW2 and SW4 use a shared table to provide voltage to the cpu core and
devices on Tegra hardware.
Added this table to the cpcap regulator driver as the first step to
supporting this device on Tegra.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/cpcap-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index bd910fe123d9..c0b1e04bd90f 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -271,6 +271,29 @@ static struct regulator_ops cpcap_regulator_ops = {
 };
 
 static const unsigned int unknown_val_tbl[] = { 0, };
+static const unsigned int sw2_sw4_val_tbl[] = { 612500, 625000, 637500,
+						650000, 662500, 675000,
+						687500, 700000, 712500,
+						725000, 737500, 750000,
+						762500, 775000, 787500,
+						800000, 812500, 825000,
+						837500, 850000, 862500,
+						875000, 887500, 900000,
+						912500, 925000, 937500,
+						950000, 962500, 975000,
+						987500, 1000000, 1012500,
+						1025000, 1037500, 1050000,
+						1062500, 1075000, 1087500,
+						1100000, 1112500, 1125000,
+						1137500, 1150000, 1162500,
+						1175000, 1187500, 1200000,
+						1212500, 1225000, 1237500,
+						1250000, 1262500, 1275000,
+						1287500, 1300000, 1312500,
+						1325000, 1337500, 1350000,
+						1362500, 1375000, 1387500,
+						1400000, 1412500, 1425000,
+						1437500, 1450000, 1462500, };
 static const unsigned int sw5_val_tbl[] = { 0, 5050000, };
 static const unsigned int vcam_val_tbl[] = { 2600000, 2700000, 2800000,
 					     2900000, };
-- 
2.18.0

