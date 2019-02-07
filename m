Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F012146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CFq90kkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBGNcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:32:13 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:56082 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549546329; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0TYmKriPQWetiVQTiupkGvMhIDeyKodtmIfFaz7WP5E=;
        b=CFq90kkhemNltECsgk3lLvGD3Ze8TVyazXO1GYcmE8vsf0Sal1ptprmGzBrG7GP5+JZ7QF
        0jar96VjDSvMY+MjiE4SxD3IP1P8KRDlWjYd/HzNELRHIAmcMGRWeHeErImEd0+XmokkIV
        azMHSTGGHAp1Htp4qayH8BXuk+tTIUw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/6] ASoC: codecs: jz4740: Add support for devicetree
Date:   Thu,  7 Feb 2019 10:31:41 -0300
Message-Id: <20190207133143.5232-4-paul@crapouillou.net>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the driver from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 sound/soc/codecs/jz4740.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9b3e1227a971..974e17fa1911 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -346,10 +346,19 @@ static int jz4740_codec_probe(struct platform_device *pdev)
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

