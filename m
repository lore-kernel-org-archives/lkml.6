Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C074240F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UOusofXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C074240F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeGER4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:56:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGERzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w5i05gaKMVlSO2cIhgBdZFBMsDIzICkQf5lKEv3ZUNg=; b=UOusofXSJoS5
        NoaLpeMUKeVc9L5H8d1rKu4vNKfAvwj5oaMfMFSE7901IpMvFmQgvMHvsuU3Z/1SdfxEIkVKUqy8v
        J+NIxhEKQmk9gF+iVLl9iFhavSCExbn+vyt4VO43JhxFJvcdKIHPC96yL7+Aqq8FUEEJZnRT4yhKV
        L//0I=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb8Tj-00012D-8f; Thu, 05 Jul 2018 17:55:39 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb8Ti-00026e-NU; Thu, 05 Jul 2018 18:55:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     pascal paillet <p.paillet@st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Link consumer with regulator driver" to the regulator tree
In-Reply-To:  <1530800748-7300-3-git-send-email-p.paillet@st.com>
Message-Id: <E1fb8Ti-00026e-NU@debutante>
Date:   Thu, 05 Jul 2018 18:55:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Link consumer with regulator driver

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

From ed1ae2dd9f242c7a36e8e39100f6a7f6bcdfdd89 Mon Sep 17 00:00:00 2001
From: pascal paillet <p.paillet@st.com>
Date: Thu, 5 Jul 2018 14:25:56 +0000
Subject: [PATCH] regulator: core: Link consumer with regulator driver

Add a device link between the consumer and the driver so that
the consumer is not suspended before the driver. The goal is to avoid
implementing suspend_late ops in regulator drivers.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index da9b0fed8330..bb1324f93143 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1740,6 +1740,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			rdev->use_count = 0;
 	}
 
+	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+
 	return regulator;
 }
 
@@ -1829,9 +1831,21 @@ static void _regulator_put(struct regulator *regulator)
 
 	debugfs_remove_recursive(regulator->debugfs);
 
-	/* remove any sysfs entries */
-	if (regulator->dev)
+	if (regulator->dev) {
+		int count = 0;
+		struct regulator *r;
+
+		list_for_each_entry(r, &rdev->consumer_list, list)
+			if (r->dev == regulator->dev)
+				count++;
+
+		if (count == 1)
+			device_link_remove(regulator->dev, &rdev->dev);
+
+		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
+	}
+
 	regulator_lock(rdev);
 	list_del(&regulator->list);
 
-- 
2.18.0.rc2

