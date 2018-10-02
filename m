Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7393C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9422089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9422089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJBN6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:58:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42174 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeJBN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:58:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so774508lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ux2mNotThpEP/wu/sanjsUbX4toj5uZkjTpJuZRPgfo=;
        b=gOl+CMkGKwH0IJsSqaW8xfXYZ8h1m+OSgG8SaMI+a/aVjPZJ3Hp6MRasbwRJ72gXUP
         wZ+XWCspoTioAQWj+WDtYJ3ICJlEtYIZFB7JSn0BMfp9joDbeaAouu3bqI18Z8+Fosnf
         BW1Od57vZlYun8XFJeL+pTAfBmfsKGlDsKKjluwtnDgg96i31Cb03vkXWgSoow2DlD6A
         nxL5P3GSG7g9D6AOFLCcw2rMvwl9leRbjXQ5F29bG4EyIJ58nqVyaQRtVDg1CeUQZE5s
         +RcGV2QFNNxChGq89fDbT2KzWDLKdCH34o0BvsDow492+ecQB+Kc4ZhjRy90+neNx6yw
         B6NA==
X-Gm-Message-State: ABuFfohC+dVvWMS5QfRGANiQRk0j9dRLI51nxAkQy4StybX/dHx1YXh6
        8/pif0EqVDALTJerd1gcEql2qwvR
X-Google-Smtp-Source: ACcGV62eM2Yt7fYmcJV8VSvyMzAm3NszxZoJpscuTz3o2gY40tPh4Q3kRoFKi5KvShLji4dH8rdZGg==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr840270lja.172.1538464617341;
        Tue, 02 Oct 2018 00:16:57 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z15-v6sm3186793ljh.16.2018.10.02.00.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 00:16:56 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:16:50 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718xx: fix build warning on x86_64
Message-ID: <20181002071650.GA7107@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casting address to unsigned int causes a warning on some 64 bit
architectures. Fix the cast.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Patch created against Mark's origin/topic/bd718xx. Fixes build warning
reported by Stephen from linux-next. See:
https://lore.kernel.org/lkml/20181002064317.GD9389@localhost.localdomain/T/#m3070ae63288d11eefda5c5f99ff31bd968afb67e

 drivers/mfd/rohm-bd718x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 161c8aac6d86..a29d529a96f4 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -98,7 +98,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	bd718xx->chip_irq = i2c->irq;
-	bd718xx->chip_type = (unsigned int)
+	bd718xx->chip_type = (unsigned int)(uintptr_t)
 				of_device_get_match_data(&i2c->dev);
 	bd718xx->dev = &i2c->dev;
 	dev_set_drvdata(&i2c->dev, bd718xx);
-- 
2.14.3

