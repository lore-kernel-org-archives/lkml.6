Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438A8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDDE2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZV8OEDNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDDE2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeINT5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:57:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeINTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so10893033wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9taBHuR1Z2o6Tp/6FUEDxrf8r9YUt6RGonYwMvTT5A=;
        b=ZV8OEDNLDzAqKYFT/h1fmNr0LGgc6hSRMKH8jwYkb7++Fs28jhjP94E6Z/qM2Zy+xf
         ZY+PbDG+gl4pECeSwdZ4u0IqwX6ZPTCn8RveRw5f5LyNV/wIk5EzJj3GODsSGFvESZrd
         T6YmQ1F2Yerk5/mPuhTtILw9vZSUSDLt+qBJh6zKFzxKjWcF4BHgoPiSgi1PpixweveU
         QayhwBH3VH6Elvm8sQkWhsB26OCqbTwO0HquS2DBwnWre6NJn3VPbbtEm3FqJKF12I3s
         KnhRtKqIr62H8VU/H/a2jPmMywAMRuTkF5JC0g2fcLdcGOQnam6td3eVHnm3YHFmd0my
         hQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M9taBHuR1Z2o6Tp/6FUEDxrf8r9YUt6RGonYwMvTT5A=;
        b=AyYoxSaKK+uTIerkSRyFAVeRtypzk9DOxK+ILXNrtDIyaOeD66NAj0urOjz80brdaL
         8Ou/8ELfcK11JPuvvoH0sGCHElt9uVrkLrkUjQiqn2gbuM+54ijzyap7iEVsIb4psyft
         a26RGaMvMj/jl1L044VjCMsZMiy8o37GFECpR1wb2eXpSVeMFdSftMSxsdcTxaXN5Hrj
         jho0CHOdDZMoDY0faHsgWBVkhzPI1VKC5vt42kEXH4D3yf2zVI1HHmEfLxsOuCN/gC2V
         WAFqbgoypppT0dSIER2RKnR0EFdu+T4b0v/qK8RtTXF4H3GEwINI0fOSGdUYceSYLzqm
         iS+w==
X-Gm-Message-State: APzg51ClgiEQiQUhjEn0/FMsJD5Y9QGsP175s8JwyLNnsB3FF6CeCpZ8
        K8MOscsN1nCcXc2UsOLxXoo1DQ==
X-Google-Smtp-Source: ANB0VdYInIfM4MafDSF34HNDSpOlPYMYbsOmD+6s3esuwAMxaa9I90iHesl+qaV43/rVItBKNcBDMQ==
X-Received: by 2002:a5d:4648:: with SMTP id j8-v6mr9722923wrs.52.1536936034233;
        Fri, 14 Sep 2018 07:40:34 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 08/22] nvmem: sunxi_sid: use devm_nvmem_register()
Date:   Fri, 14 Sep 2018 16:39:57 +0200
Message-Id: <20180914144011.27614-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/sunxi_sid.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 4d0b7e72aa2e..1310f8af37f8 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -181,15 +181,13 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	else
 		econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
-	nvmem = nvmem_register(&econfig);
+	nvmem = devm_nvmem_register(dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
 	randomness = kzalloc(size, GFP_KERNEL);
-	if (!randomness) {
-		ret = -ENOMEM;
-		goto err_unreg_nvmem;
-	}
+	if (!randomness)
+		return -ENOMEM;
 
 	for (i = 0; i < size; i++)
 		econfig.reg_read(sid, i, &randomness[i], 1);
@@ -200,17 +198,6 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nvmem);
 
 	return 0;
-
-err_unreg_nvmem:
-	nvmem_unregister(nvmem);
-	return ret;
-}
-
-static int sunxi_sid_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
 }
 
 static const struct sunxi_sid_cfg sun4i_a10_cfg = {
@@ -243,7 +230,6 @@ MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
 
 static struct platform_driver sunxi_sid_driver = {
 	.probe = sunxi_sid_probe,
-	.remove = sunxi_sid_remove,
 	.driver = {
 		.name = "eeprom-sunxi-sid",
 		.of_match_table = sunxi_sid_of_match,
-- 
2.18.0

