Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E780AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C8205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V905Qqp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2C8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbeGXM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:59:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38316 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388254AbeGXM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8PknnEZcOuVha9BLIitUFnJH60Tw+0ALE7dX0aQ/r/s=; b=V905Qqp+1oxK
        Wkjt81toUA8RaPxSkKtJK37ZzIDvo/F0c1GpigdB/1RfDK05MN8kp4W6q4P+6kSz+FBS8RGsH6qLS
        I5CeqFOD63t09obeYC8Bgg3KwHCLZChVFFpvwn7u3yGV2KyZ6P3zmio8jfcjCvvBVThta2Bf2dTHf
        45EnU=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhvsD-0005NW-6V; Tue, 24 Jul 2018 11:53:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C04EC440078; Tue, 24 Jul 2018 12:53:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd9571mwv: Make symbol 'dev_attr_backup_mode' static" to the regulator tree
In-Reply-To: 
Message-Id: <20180724115300.C04EC440078@finisterre.ee.mobilebroadband>
Date:   Tue, 24 Jul 2018 12:53:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd9571mwv: Make symbol 'dev_attr_backup_mode' static

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

From a70a4694ed38fb68407c142db0f53722553bedea Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 24 Jul 2018 06:32:59 +0000
Subject: [PATCH] regulator: bd9571mwv: Make symbol 'dev_attr_backup_mode'
 static

Fixes the following sparse warning:

drivers/regulator/bd9571mwv-regulator.c:220:1: warning:
 symbol 'dev_attr_backup_mode' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd9571mwv-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index c44613b9423b..274c5ed7cd73 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -217,7 +217,7 @@ static ssize_t backup_mode_store(struct device *dev,
 	return count;
 }
 
-DEVICE_ATTR_RW(backup_mode);
+static DEVICE_ATTR_RW(backup_mode);
 
 static int bd9571mwv_suspend(struct device *dev)
 {
-- 
2.18.0

