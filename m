Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097DEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22632081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldyq8k4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22632081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeKAXoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47013 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbeKAXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id o2-v6so14344078lfl.13;
        Thu, 01 Nov 2018 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CYC7TvGqETSeFhRceruurl+Tb4FvS5Rq+MfygM9JIE=;
        b=ldyq8k4UGUALcCMImtgsxylY25oIybGcspBl7nRnW+x1BYyd+9KUuy9UrjRBRImv9l
         ch5ryhkP7ogRGHUXT6AeG9P3WIj9pms47fJJfyeLG01ExZvTP12arQpHSrgK1DZIErSX
         EEE9NobQBuSFuGXsMJtQHJ+FFMjMF5Zn/BAG89N3R+II6NCllF68oUOftI28C517plq5
         iK59jDCHmWfOmso82BLDfbMciUJjiVpEmCzyYFzJmMonrXhNgZEGyrGbX7pPRWQ7AAMp
         kkuGyMTrq4CXir1I0IbDGFudO0btDQ1ZLYQ/A9jGYWjxeuQshWtpigY6n9ga5RzFJ9Wt
         d96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CYC7TvGqETSeFhRceruurl+Tb4FvS5Rq+MfygM9JIE=;
        b=V0rQF4afjMVXysOhGp34fm6aN2fUZfXquAtxiYj4+FQU5+pTT32hdYOI1I0K4nG3Wt
         M2uX2YDmD+MS9AVzMKCggjNEPSWK92msjRIqZptSFXIp0hAbe+WsBcrPU6jtn3qZsWq5
         GkovegoipOrR3wNGZdgC+7d+GLtCdrzd5kY4BRNbD43B5iJBCGt3cM1NNL7VadhKVZ9j
         NlekI08RxdtOR86AA3W44mx2WPpY4HlUpWSnFBgBhdnra9p/O6mpgMqivAfdhnLPhW8x
         Z7O3ThjW8KZ0Vpuh+OxZ4KxQYrLDdHCy0V2odwsdIMN34eYsE/ZkKDBb9TOHwTI8LAVq
         49qg==
X-Gm-Message-State: AGRZ1gIwy3jsf9dp5gkS3a61kONRj9jriElw/7FTOzw4CIFewMb81+mJ
        5B/zJdOyxpDLqReMAgG2ZoCpOUc62ZE=
X-Google-Smtp-Source: AJdET5d2brU6ngoxn/SJdoTVamVE+k0NE8Fen/E0tFmNKLgjL51cZFZEclNcM+vT+fRrxI+/vthGpg==
X-Received: by 2002:a19:7111:: with SMTP id m17mr4506320lfc.64.1541083257059;
        Thu, 01 Nov 2018 07:40:57 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a9sm404870lfa.19.2018.11.01.07.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:40:54 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 5/5] clk: gpio: Use devm_of_clk_add_provider
Date:   Thu,  1 Nov 2018 15:40:44 +0100
Message-Id: <20181101144044.11495-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_add_provider. It will take care of clk un-registering.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/clk/clk-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 40af4fbab4d2..6eedb4bd779c 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -252,7 +252,7 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return devm_of_clk_add_provider(&pdev->dev, of_clk_src_simple_get, clk);
 }
 
 static const struct of_device_id gpio_clk_match_table[] = {
-- 
2.19.1

