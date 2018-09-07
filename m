Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C5F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qGQ4CLbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C5F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIGUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:50:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52940 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeIGUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=y3HbkXzRN75xh2KVnMY7suswIZi0PLzxTjvUJnxo9yw=; b=qGQ4CLbkzDdX
        KfgP809Gnwt8jrqrO4ppplgKGHLI9KZboFY6VVBkZ+I3SadnOE8+d6nlvQeZ2GuMPgCLz9XZB0X1Z
        4EXIvdRfgoN/uVRsJQBoBSy8nbc+vlJ0B9p2s8LVfUpHoIuVXNquuRhDynhGz2SDfwQJXW6IQ4YGz
        aC5q8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fyJJX-0005Xy-Od; Fri, 07 Sep 2018 16:08:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 860551122A6D; Fri,  7 Sep 2018 17:08:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     David Frey <dpfrey@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: fix comment for regmap.use_single_write" to the regmap tree
In-Reply-To: 
Message-Id: <20180907160855.860551122A6D@debutante.sirena.org.uk>
Date:   Fri,  7 Sep 2018 17:08:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: fix comment for regmap.use_single_write

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From 9ad8eb0168ab76786f65d4b80ce082980f79a1d9 Mon Sep 17 00:00:00 2001
From: David Frey <dpfrey@gmail.com>
Date: Sat, 1 Sep 2018 09:50:40 -0700
Subject: [PATCH] regmap: fix comment for regmap.use_single_write

Signed-off-by: David Frey <dpfrey@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a6bf34d6394e..16414ccace96 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -149,7 +149,7 @@ struct regmap {
 
 	/* if set, converts bulk read to single read */
 	bool use_single_read;
-	/* if set, converts bulk read to single read */
+	/* if set, converts bulk write to single write */
 	bool use_single_write;
 	/* if set, the device supports multi write mode */
 	bool can_multi_write;
-- 
2.19.0.rc1

