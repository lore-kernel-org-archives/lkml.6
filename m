Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E968AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EE1206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N2kfFlJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EE1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeIJMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:37:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36892 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIJMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:36:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so20231254wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yyY+qUV/SUUOUpL3Qh0YUKZvwUc1mE0aQHMeskrS120=;
        b=N2kfFlJ0hvluxiez25AvHVcoF86on/Dkn7dQmhvrDfUy2rkzFvlKwylnmj6VeHkAY1
         yJCcM8gMVFkdn2wc/zaLpRtVhwQNKHP10LOvcKrjqZeVcfoQCNZNqm8qbLNG2dFxhAaq
         AfG/qmCTz5GnGuGjaBAoQ5pKw6kQHoIODb8zd/3LmvpM2iWBi1V5MZTINoL1XCs3P2g8
         FiVzFdX+j/1R/jNgfBGFaFKI/XKtc+ezpJnmkd3ShLT8ql8MPvvQU7Fd6PyerJhD35di
         l3hlgIKjtGPW62rvWLIBGCtKP7WxHx8MCydQ0f2YXxm7LwA7qf3TvgcQrG9aq+VOhBMm
         fVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yyY+qUV/SUUOUpL3Qh0YUKZvwUc1mE0aQHMeskrS120=;
        b=cbMQjXA7b0dSoygDxZz7GwweeZoXz99+nvUbWHmBZmo9HkQ04/e//Y6LBe0oYlFKXX
         i7lreI9LQhn2C6s0iz97eMkSpsbtlvq0oB/rLWKaoL7xEyztB9obg5kZL+6TbILrpLQk
         zMRPWGJxty01y+GCF/M2W+2fTfFLTIkab8J5vEugYl++s0VAXLr2boe6YOqF/XLf/JVK
         lwjNtb748/CAJ5BUw5RtX9Tc3iC3UVY7+1tFmlBax2hgQO/P9NSJzBOrWhX9/gHy5yta
         Q3mhJRsJtQ1EKus+HHC/rzJdLOMfZC8UVfLAkseaEXYxwnNz7d14VfR6bLF3jzrNefpC
         o9WQ==
X-Gm-Message-State: APzg51CnBKngLs/B6oV2cmE4oK4KoGktfUxqWau8BmrjR5/H/0qLsTEh
        AgczNaebajPzenkF0qa+hphnag==
X-Google-Smtp-Source: ANB0Vda3TCV7k0cY18xDRHsZ1NQwfJlEvhCidY2gj+klFE+fBivMFU17gVhGNGxLFQkxLWRpZ0tJwA==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr11516026wme.111.1536565455697;
        Mon, 10 Sep 2018 00:44:15 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id j133-v6sm21589018wmd.12.2018.09.10.00.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:44:15 -0700 (PDT)
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
Subject: [PATCH 2/2] eeprom: at25: use devm_nvmem_register()
Date:   Mon, 10 Sep 2018 09:44:04 +0200
Message-Id: <20180910074404.8041-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910074404.8041-1-brgl@bgdev.pl>
References: <20180910074404.8041-1-brgl@bgdev.pl>
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

