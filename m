Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F636C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6310D21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="rJKFQUQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6310D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeKLQ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:59:07 -0500
Received: from host.euro-space.net ([87.117.239.2]:53354 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeKLQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=whYD6MxC+aJt0lLAkurxqD0uuCnoZcibs2tNJ2nqJwU=; b=rJKFQUQ3MaSQzzdLLQyRnHZzKv
        W1pKOsWUqdE1uFJCd3+9Hsrv3fzre2LWKYKl8doeJDccWURrbn/1v8x5yp8/AZiAoblE9KXxXC2Wc
        aKbLUApLJyezd2429P9U80IqCJa8U5VEIX16Mhu/EW9C2E7UZjDooNZuXjMxAjUi9n5IDa9h07N1a
        vkadABoDvimTtGSsG/bvWdeWRY/SeoKZwzpeBhA+RUCO9a53eYbJNQ5aO2xtwxILtS8GNWhJMC8NB
        7+Ja8Z1Vlcw+IAg6xgGsrZxEoDT1J57PYeK+cTEL0q4MgHlzjsgSbOKpPBHWD3t6kR+KGBKcn5MUs
        j4maKaNQ==;
Received: from x4e33ae63.dyn.telefonica.de ([78.51.174.99]:51016 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gM6JR-0002vg-MN; Mon, 12 Nov 2018 07:07:09 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH v2 2/3] ASoC: pcm3060: Add DT property for single-ended output
Date:   Mon, 12 Nov 2018 08:08:33 +0100
Message-Id: <20181112070834.16979-2-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181112070834.16979-1-kmarinushkin@birdec.tech>
References: <20181105112036.GC5365@sirena.org.uk>
 <20181112070834.16979-1-kmarinushkin@birdec.tech>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAC output may be differential (default) or single-ended.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++++++
 sound/soc/codecs/pcm3060.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 494d9d662be8..5f479aa61097 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -274,9 +274,23 @@ EXPORT_SYMBOL(pcm3060_regmap);
 
 /* device */
 
+static void pcm3060_parse_dt(const struct device_node *np,
+			     struct pcm3060_priv *priv)
+{
+	priv->out_se = of_property_read_bool(np, "ti,out-single-ended");
+}
+
 int pcm3060_probe(struct device *dev)
 {
 	int rc;
+	struct pcm3060_priv *priv = dev_get_drvdata(dev);
+
+	if (dev->of_node)
+		pcm3060_parse_dt(dev->of_node, priv);
+
+	if (priv->out_se)
+		regmap_update_bits(priv->regmap, PCM3060_REG64,
+				   PCM3060_REG_SE, PCM3060_REG_SE);
 
 	rc = devm_snd_soc_register_component(dev, &pcm3060_soc_comp_driver,
 					     pcm3060_dai,
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index fd89a68aa8a7..c895cf40ee10 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -25,6 +25,7 @@ struct pcm3060_priv_dai {
 struct pcm3060_priv {
 	struct regmap *regmap;
 	struct pcm3060_priv_dai dai[PCM3060_DAI_IDS_NUM];
+	u8 out_se: 1;
 };
 
 int pcm3060_probe(struct device *dev);
-- 
2.13.6

