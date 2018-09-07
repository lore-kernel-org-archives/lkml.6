Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC86C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5C02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EWZcTVhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5C02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeIGOto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:49:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37215 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeIGOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so14024282wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=EWZcTVhMhsDVDaTyLtMOAhQI2Mel8wWobR2y7nQ1kVN7wRHx4cAlWPLu80Yy532IG5
         Xp7pS3EH1WyMLwF0QDCy6h5dnfvaOmJ07pQy0yPBJqAvo8062+sLO2/mDOjMzmrgSxtF
         +p+3Xuvjq7ynmtNzy1RTf/IlQWvP7aiTXTR5VUp5oUCdPTDidjOE75dtLYBGuDmwRDRo
         VZzVfyzzWFfSFCwwI2KaW6t9WE6LgOb8LoZI3KzMUjqc3PgYTtmrWazIZDjmCO0elnow
         CnBM66A5OckVul4MCg1f8rbapv5hlMFQB5/q7/Ku6C/aAFkPx7LuBYuqLpfjE7y2jCPg
         Pggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enYwgS0Z/OX0ykxo6KT1YIz+qVBOPAuLng+TvhpgC2Q=;
        b=ieeY3UvyyycfxahNToNwUHXUox8W9wqsty/S5V5Xw0NaOzT6OWHheRMSUrKbkpzl7L
         LUEDSpqB+sVQqNNX01WVJ3gtK+/Oh1uymrfgz+FqPF/uPzQljXPFNEOzanBfK3yZg91d
         OON0Mb+k+lhNJ/x8Yipo9k0IMUxCgfGIJULbmfBHJ54w76+rNfGn0lRQh9+707isLxfS
         65DnckrM0uU8BmYfMwyfgpgvaLaPZ/JK2Mi1ORiOayghMpzETyMS7fsh2FfuPwEDU7jF
         xWECJ+CUjDEnb3o2RTBhsdB9KSYqua/x/0vKXk+jOPuRg5vSDT0KM4S5zdarfzlYOKvl
         T0MA==
X-Gm-Message-State: APzg51Bq+scJxztkng1SUDpfjEel/QxFXDjrpsiha+wtsYTvAB4AsodU
        6ZhrHr0OXCsGY8hhsNWLeAZ9JA==
X-Google-Smtp-Source: ANB0VdbYcfsCltzcsIaefcMp5kEoWkpJ+Cp5Y8fpSIMkBNxg+EiRcURTXVQcMphNwB6F7rsX4qgOig==
X-Received: by 2002:a1c:780c:: with SMTP id t12-v6mr4639093wmc.133.1536314906317;
        Fri, 07 Sep 2018 03:08:26 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:25 -0700 (PDT)
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
Subject: [PATCH v2 06/16] nvmem: mxs-ocotp: use devm_nvmem_register()
Date:   Fri,  7 Sep 2018 12:07:40 +0200
Message-Id: <20180907100750.14564-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register();

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/mxs-ocotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 7018e2ef5714..53122f59c4b2 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -177,7 +177,7 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
-	otp->nvmem = nvmem_register(&ocotp_config);
+	otp->nvmem = devm_nvmem_register(dev, &ocotp_config);
 	if (IS_ERR(otp->nvmem)) {
 		ret = PTR_ERR(otp->nvmem);
 		goto err_clk;
@@ -199,7 +199,7 @@ static int mxs_ocotp_remove(struct platform_device *pdev)
 
 	clk_unprepare(otp->clk);
 
-	return nvmem_unregister(otp->nvmem);
+	return 0;
 }
 
 static struct platform_driver mxs_ocotp_driver = {
-- 
2.18.0

