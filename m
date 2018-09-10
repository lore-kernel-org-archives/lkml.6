Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A929FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FDE20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LXec5bqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FDE20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIJMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:36:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41946 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:36:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so20765153wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QiqWwqI1f5VL/FBL9gH/H2QbmelqpF7WnXptLhlnNI4=;
        b=LXec5bqKmEMGXINbO0+rviy+xU5KXQ41wcb1Mx1t4W8DvEjZiRrdOf2XMJht9oBjrE
         FNM3Xbp/5wGeBtB4dt5hOqMtEqXxb7IUvxaEWoNXEazwU6HGBid4Sy7S6KYT0r/XMLo6
         Rm3Xl6fmKxJb34tLiazZPHjEF0uFsKbYwFGWSrzeVdup9pKCVcPKOGkidxOhIMBypGPF
         GhXhydYTnNhdPjdKi/eoJZyEqd1CjjWskR66mOOaugwJrlKSOv3nKzdI+IBpwNIZfSTT
         D5ulQQ3MCCgwoQh0utUfHUMc65EQ4moiG6JYKn5QPdGz/f3FxhrqY9bprD0cXSpaCz+z
         QKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QiqWwqI1f5VL/FBL9gH/H2QbmelqpF7WnXptLhlnNI4=;
        b=OoybbjqBlh9VIAn+gVAV9R+Fb4+dBT5nw4QGHHxbm6Ld59HlOmCV3MXjIjNKIEmQyd
         SqyOn066QtfMLl3C63nom6A6Jd6cmJLaBX12kys036qCWz4x1dJaoNFMlwSlPL9SYUYj
         1A/v6rrTJm7ccq2J+mJXYTgIXj2XO7Rre9oV+47AU4/YDRGPFrAC6W1tUuLI+G6X81Zo
         Fi9vrO6AxW+SFcQRvoNjfaF9nDZ4P2k0khYA/2yG3hGhOYfePBfIHM6rg4EXiE8UdB4d
         GTyHzCzoCWCaQmVW/B0KHSiKVytuNsaVneE2kneWuYTM5C36zmveyKj/OCuK3CGeXFkY
         xqIg==
X-Gm-Message-State: APzg51DTj1/KJYsK/BCfW3eUNO1fi1c9Xlg59h+RZXpRZZIv2BuxAfFx
        jhMGmV+EZx1sZjttiM2gq30ylsI1xqo=
X-Google-Smtp-Source: ANB0VdY8pi+SpeohPOpvho6MvNN4RtxqYyCs71+28hpC/zMktWiQzEVTdGMq960B547g/ymG9j3PZA==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr2826906wrm.136.1536565454725;
        Mon, 10 Sep 2018 00:44:14 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id j133-v6sm21589018wmd.12.2018.09.10.00.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:44:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] eeprom: eeprom_93xx46: use resource management
Date:   Mon, 10 Sep 2018 09:44:03 +0200
Message-Id: <20180910074404.8041-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910074404.8041-1-brgl@bgdev.pl>
References: <20180910074404.8041-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use resource managed variants of nvmem_register() and kzalloc().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 38766968bfa2..a06853543204 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -439,7 +439,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	edev = devm_kzalloc(&spi->dev, sizeof(*edev), GFP_KERNEL);
 	if (!edev)
 		return -ENOMEM;
 
@@ -473,7 +473,7 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	edev->nvmem_config.word_size = 1;
 	edev->nvmem_config.size = edev->size;
 
-	edev->nvmem = nvmem_register(&edev->nvmem_config);
+	edev->nvmem = devm_nvmem_register(&spi->dev, &edev->nvmem_config);
 	if (IS_ERR(edev->nvmem)) {
 		err = PTR_ERR(edev->nvmem);
 		goto fail;
@@ -499,12 +499,9 @@ static int eeprom_93xx46_remove(struct spi_device *spi)
 {
 	struct eeprom_93xx46_dev *edev = spi_get_drvdata(spi);
 
-	nvmem_unregister(edev->nvmem);
-
 	if (!(edev->pdata->flags & EE_READONLY))
 		device_remove_file(&spi->dev, &dev_attr_erase);
 
-	kfree(edev);
 	return 0;
 }
 
-- 
2.18.0

