Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C0D2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="G2VO2v1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0D2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIRCup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:50:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIRCup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7CxnU57uh33Uf06scADVEb2VOVxMQLps0PtzVRpK6Q8=; b=G2VO2v1/vo7e
        6XhVLOssO1goXxfFGjc0F1VAcoMdwkol89Z2QzxL9r2gmyOoPoR66UEWNSHqOODetljdxixbkGVZT
        MDYZ07svtN4Ksw1ru8MaH/Nr6ZID486ISpxnhluaMlKjYkJNC4TLERnLZWqqu8TYPS5lvZ6TuAlGN
        ky0B0=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g20xc-0000kh-OF; Mon, 17 Sep 2018 21:21:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 019DB440078; Mon, 17 Sep 2018 22:21:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100-regulator: fix spelling mistake "standy" -> "standby"" to the regulator tree
In-Reply-To: 
Message-Id: <20180917212135.019DB440078@finisterre.ee.mobilebroadband>
Date:   Mon, 17 Sep 2018 22:21:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100-regulator: fix spelling mistake "standy" -> "standby"

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

From db6565af68db17f6dbc26307a2768cb36e9f824a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 14 Sep 2018 13:38:50 +0100
Subject: [PATCH] regulator: pfuze100-regulator: fix spelling mistake "standy"
 -> "standby"

Trivial fix to spelling mistake in dev_info message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 1e43a9de3bd5..dd41a9bb3f5c 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -576,7 +576,7 @@ static struct pfuze_chip *syspm_pfuze_chip;
 
 static void pfuze_power_off_prepare(void)
 {
-	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power off");
+	dev_info(syspm_pfuze_chip->dev, "Configure standby mode for power off");
 
 	/* Switch from default mode: APS/APS to APS/Off */
 	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_SW1ABMODE,
-- 
2.19.0

