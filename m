Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B913C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060ED206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="quFNtK/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060ED206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeILNId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:08:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36803 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeILNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:08:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so969261wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyY+qUV/SUUOUpL3Qh0YUKZvwUc1mE0aQHMeskrS120=;
        b=quFNtK/MhnW6NDZ0V+iKicPoyQ/TiiJd5QH0MwjvvuJUGXlaKEnW7wmFJc/FxhH/7k
         blYWIwLrjDdq+V/4b8NEcoRKEf7gPGn2a1SwKBCmwZC8rJHAASaTCgFzMwZPf8td1tyR
         A+T8MhVsymy9f9jF2/G/NwSW8oh26kORzxLYKhuaSR0B4fT6LIy+Ykf77s5iSh/K3l4F
         4TdHy4CqXupGjydBu6SbYi0tbJviz9ChfVzyi+x+AAUYP2v27vmb4WvyYSxmhgueCaPw
         Q/ebZyVgiICPXZ4Dgo6TlbK5Hjn9A3S3gFCFO9llRrct9qi8shkS/cRqtrEiZI2PhP85
         2ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyY+qUV/SUUOUpL3Qh0YUKZvwUc1mE0aQHMeskrS120=;
        b=VSImtwUE4jrilgvZBEe7ZOhHdPJGoTtReKuyvVrQzrTTp2vPLD1lJlfE4Be6810n5t
         Owm5v93cYOghHCNkWtHYYlouAzwaUPPKH39dkp7IJib6EdBX3bGX+MNdhd1RfmR3tcrK
         vSsdQZZRwaGhrB+/0C+jloV1pqRB6mnrUOTLanq+ASLKmFNaVaJo/84hlM/DH9XXCUEI
         x4NwXVhxwP2U2RmN6YrZzen6uvOQBaD7VJ0oGLYkghqM8sx3fvvixGtdbMj87sl0yYdw
         XfBZHiqT/uwxvYB7NIFixkbIvwFhmZZv3AQFELcM5wJjmTydEYNGeMfGD5JfRomIijgh
         rKIQ==
X-Gm-Message-State: APzg51BeVCjzjUeTgqi/C7xpqk/nwuMjdIf/qIOIN1iWpkqx31qt1qWj
        3pdE1ahybzqOWNyXr2Yke2pDwA==
X-Google-Smtp-Source: ANB0VdYrUOCOppJ0tVuk2M4GE6wPCkyFSmUjwubtqODKRqdRy7oq5mpqIJwBBkJUEgedKtOd+iJOgA==
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr567055wrn.123.1536739509499;
        Wed, 12 Sep 2018 01:05:09 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id 139-v6sm1225182wmp.4.2018.09.12.01.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:05:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/2] eeprom: at25: use devm_nvmem_register()
Date:   Wed, 12 Sep 2018 10:04:57 +0200
Message-Id: <20180912080457.12238-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912080457.12238-1-brgl@bgdev.pl>
References: <20180912080457.12238-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at25.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 840afb398f9e..d874df72853f 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -366,7 +366,7 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.word_size = 1;
 	at25->nvmem_config.size = chip.byte_len;
 
-	at25->nvmem = nvmem_register(&at25->nvmem_config);
+	at25->nvmem = devm_nvmem_register(&spi->dev, &at25->nvmem_config);
 	if (IS_ERR(at25->nvmem))
 		return PTR_ERR(at25->nvmem);
 
@@ -384,7 +384,6 @@ static int at25_remove(struct spi_device *spi)
 	struct at25_data	*at25;
 
 	at25 = spi_get_drvdata(spi);
-	nvmem_unregister(at25->nvmem);
 
 	return 0;
 }
-- 
2.18.0

