Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C458C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D053820830
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="R/BUeeHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfBEDLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:11:54 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:41976 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfBEDLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549336309; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1KQuKdC3HXzixy/88R1T0mNoaMsOo5uU9Ul/2C3K/hY=;
        b=R/BUeeHW5AmYiDvCEnDSI6n6EzpZ3edc576BaJyKj1aNi2+V896G9k12XLCoU6A5wX4g33
        Lx6A0bVZPwamR0kZCinmce+BuJOnlglnfZe3oGhbRIbV3O2X9BVndT3WrMTvLlWpYVMXaG
        yLJn8WvBE7YZb9W1T1vXus9fWlV4ryo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/6] ASoC: codecs: jz4740: Add support for devicetree
Date:   Tue,  5 Feb 2019 00:11:06 -0300
Message-Id: <20190205031108.26171-4-paul@crapouillou.net>
In-Reply-To: <20190205031108.26171-1-paul@crapouillou.net>
References: <20190205031108.26171-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the driver from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4740.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index af57a7d6ec12..b5a1323f0883 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -347,10 +347,19 @@ static int jz4740_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_codec_of_matches[] = {
+	{ .compatible = "ingenic,jz4740-codec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jz4740_codec_of_matches);
+#endif
+
 static struct platform_driver jz4740_codec_driver = {
 	.probe = jz4740_codec_probe,
 	.driver = {
 		.name = "jz4740-codec",
+		.of_match_table = of_match_ptr(jz4740_codec_of_matches),
 	},
 };
 
-- 
2.11.0

