Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3C1C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB15220873
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uH2+9M1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB15220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIEO1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35864 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeIEO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so7098256wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=uH2+9M1vAtnwku1Qa7KM2VgdAGrG0XLyYybPUYTA4fKQnCzh8i4nEBS3myuoDA12pY
         lTCDRzkJIJvR0J9tNluzzXpp6xZtYIDeO+U1j8lacab7QYrOpiJrbvFRP7gVZf0eUOQs
         v9nxKCAel0Nfn3nWryYtHcAICshAw0QLosvjAFMfdqKGaXdQS3SomqRoAR9ncyRkq/4I
         kRjfapP/qsKxvX9izTIgyzQxZMZjTDdykvnLDW6wwTwBM/ZhM3tq41sUQYNRFgVUG7ID
         oGUKD+WEl7ilca410ajmA78D+FkDQQOHmGtBsrC3iWoRqMaKK7sxE7FVWFPDG11nWFIu
         YWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=JPdAeGsOJRhsVDIxJpDe/B3cDRsXjkfphHorX08vfa/qQdxsI5GU9b3YbuaNWxKg11
         XV2o775e3ZLWTJXGfYJwNcxb0x0JI7HKDBKm6zEc+4hO19nQsDe0A7AQOtBHvlQszGXE
         aPAl7Nd7N1ElQG1jqWthtwn/+4JMWfFcOc9WWu0EhgN6qQCGowTpwpx5nCp6QO0AiNGU
         T5q1OLXqRD/greBV6Pu0yY0tAaL6Gl4cKikk3clh08kBbSvkcD9X39f2+OLCh5+zSGGB
         Uw4l9pjQguVtu1dbNNQZ228cxFWefKrTzDRIf7xAl7XjxWcFgrkBJYidlJWVzlNSkNlh
         yQ2Q==
X-Gm-Message-State: APzg51AiAAE2n9tcPlFMlPaEWqGe2fbloJH2yPvrgLOGrdS/ySz74EMs
        xMDU2fCNCZac3wb7XaQg99sxig==
X-Google-Smtp-Source: ANB0Vdbjycgs8VTG9HTFl1NgudxNUJQopymPyAJg8rzJUbjsM6UngJ4KzkdaBwotgzJ4H2Gn40hPvg==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr4925548wmb.88.1536141489278;
        Wed, 05 Sep 2018 02:58:09 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/13] nvmem: lpc18xx_eeprom: use devm_nvmem_register()
Date:   Wed,  5 Sep 2018 11:57:29 +0200
Message-Id: <20180905095738.26406-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed version of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/lpc18xx_eeprom.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index a9534a6e8636..b42dbaddb419 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -236,7 +236,7 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	lpc18xx_nvmem_config.dev = dev;
 	lpc18xx_nvmem_config.priv = eeprom;
 
-	eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
+	eeprom->nvmem = devm_nvmem_register(dev, &lpc18xx_nvmem_config);
 	if (IS_ERR(eeprom->nvmem)) {
 		ret = PTR_ERR(eeprom->nvmem);
 		goto err_clk;
@@ -257,10 +257,6 @@ static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = nvmem_unregister(eeprom->nvmem);
-	if (ret < 0)
-		return ret;
-
 	clk_disable_unprepare(eeprom->clk);
 
 	return 0;
-- 
2.18.0

