Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A8ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6B52086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWVHpRv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6B52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbeIUT3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56014 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbeIUT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:32 -0400
Received: by mail-it1-f196.google.com with SMTP id d10-v6so2002242itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/0R3w/YyRjmUKnlnZ1pdly25jlIiIzlpEdSveGkcWc=;
        b=jWVHpRv6Yy73yvA733s8Xzwq+sF8OhMrKgQPS4Y9uu26Eugt5Z/smUNl9DxrwLGciw
         W2NzT2e7RIDNLS46KJNxi8hDdFSjJaW2pCGcGdWFAzaA44nd30Y9Bqhnjb8h1mnRh2zq
         JJrH+cjcZJwb5ltShAYnhO70fN7AKsSvAK1Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/0R3w/YyRjmUKnlnZ1pdly25jlIiIzlpEdSveGkcWc=;
        b=tsFlUsYH7I0nEjc9Jg4LgggdtJfh1LedHpFOatk44JYzKXaJ/R+63ONSFtLFTS8oZb
         YOWpEpiPJ5HclUKc0OUNx6sy2LddykNw4+o3NKvspviUX/Xv6j+n+6+o4Nptz2IvM9/g
         i7eJhmOV5qBPzPt45SviDxvuHe9Q4QQXhVtTIJ2v5mDbg28w6XOWlg0oKcpaL+CDt3Xq
         xz/LEbkPJ9KcMYtnL+QaJie3IgBSnz649Xibuc3rtVNHKaIFXMZWkFd91UfQNbxVsT9s
         8HhMfAan4DvppLM1+Nad9exlGWaYSSqsReM+j76y9qQrqgrTTLYNZ6ZZxrFaP+F7b3HB
         EdBQ==
X-Gm-Message-State: APzg51Abs/aBW61GINd5KOnj+4hKCN38kUlRIX0nNXxwVH4Zijmxq6Qd
        NeoPw7q64yAciiGALjHft01hww==
X-Google-Smtp-Source: ANB0VdarRE3T8eia+0B7ioAy/pb3yvIbAl+p6WLZPsM6hKDfoHaz1uO4DlXPB1RUuNb3GtpltkGy3w==
X-Received: by 2002:a02:9c5c:: with SMTP id h28-v6mr2842169jal.3.1537537237599;
        Fri, 21 Sep 2018 06:40:37 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:37 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/26] eeprom: at25: use devm_nvmem_register()
Date:   Fri, 21 Sep 2018 06:40:02 -0700
Message-Id: <20180921134026.4596-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.19.0

