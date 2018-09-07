Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18FCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFBE20879
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pStjsn6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFBE20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeIGOsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32802 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeIGOsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so14422252wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=pStjsn6kmYK+/TObJHiv70QDQbm1gSNXEr7yllZ1+4tL4q7jO8zy8f8+x41lSJnsZL
         dtePAJtd1L1Um5CXMGKhQ7qt/ATjQPr+KHSz7dsoMo7cs89bklGfi7lrBi3uNTLlmQRk
         WukSi6u2bqvZMhSy3t+MQ/sO8rgjZJIHjBKEvFuJn+KeI6k8B8GfKb9DKy0CtYujFju6
         ifbuZEgUyGjLC7TSAiKI/JMGEekuPzMJLM+TQgBQqbZvOWJkDwybZNsKQ3pQI+xEO3bI
         Q9IyCgpLblryTuygIqlgJJVeVv3LfVlAjxp3nMY34BFXefS5ijfafeuf0M6INj9D1Pte
         MzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=g9OQ/mYVx8O7jcEyV81wvv1LXIAdOlc7xOE3PZ656MWMfsaXdE1kNYJ77rTWdhQQzU
         1/Hx6DfURS6uqPQg9dNyEthsVV2qthQ0Cb2x2KajwjsbggxngmmCX6VsZC61a9nOjTQc
         O2Ii5AlG8rI2Qr7T8AX89dhCmvht+WNt20Lb42WqqApA3+25WCsJEuXTYuVFD13U9rS1
         Ov37GHxofvXlEJhzajgeRoVZdDPFBZOBaEjGgdlEGvGmXvFqajnbWgXX+yb5jSTMwgOB
         g7L8gFTgDlGukYDn21lUjqjOox/4KwII70B+VvKNexaS/Q/2hz7/r9s7pOt/pzX16EKp
         qUtQ==
X-Gm-Message-State: APzg51B45SG6D32OzNaETTglnz8K9U4LsxywowdaPghWDxmP94RFMiv5
        /eptUJ7Lh5jv6rSHaL+A4gEmoQ==
X-Google-Smtp-Source: ANB0VdZirVJ1u2qyK6wuLab9le89WJXC9zyf3+G3pIOciQldk+8VJ9d2GdCkjBv5ltzgbCQDCNmvLg==
X-Received: by 2002:adf:aa9c:: with SMTP id h28-v6mr5700208wrc.149.1536314903810;
        Fri, 07 Sep 2018 03:08:23 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:23 -0700 (PDT)
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
Subject: [PATCH v2 04/16] nvmem: lpc18xx_eeprom: use devm_nvmem_register()
Date:   Fri,  7 Sep 2018 12:07:38 +0200
Message-Id: <20180907100750.14564-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
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

