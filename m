Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49C220673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eulvPAYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49C220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeG0EW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:22:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37668 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeG0EW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:22:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so1230710pfo.4;
        Thu, 26 Jul 2018 20:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Nr0HwSpQc+d2T41s0uxFH46hkeQiIdKoqj90TjbRaVQ=;
        b=eulvPAYX0SK9FLk6lD4bHt/G/ctkGlIudAKaiGy4Yrjqsul4lHy1fDJaa2YBBRi8pj
         XzOC98UXFgAkf5M/MFE2Y3ZkYZ3g+jBZ2X1/SDlnUZXIlJdRSjM38qx3ibYX3kMar3EL
         1khlHQyyJME3iGQOFdJ7vDqX135f7uiUozBIfPz5BYJYQX3hdIjF2CP01hZR4Lbfm7oG
         lrz70c9J+isX+NBBt6fmS2h7EjaA6r3wd3Q7nTmtdIDQRDyq0OuWO3Q6KhQp5POCcjqN
         ra03vPlusY9rVGU2Q053aLEQbZhdd+K2AJfuBKwf3zPYl/UleWnEtDkZ2Tkg7kWdMv44
         BVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nr0HwSpQc+d2T41s0uxFH46hkeQiIdKoqj90TjbRaVQ=;
        b=b0Ft2GVzemsTTxfmZZf1SFqhoCC+54XHEj+SKul21GTqjMkryhhhafBTQ1T1BwfGw+
         zRI49TLtjCBkU/bz26A2QgKCLMhn8DN3Gfe8ctco7R3BFq+YytTVCf+3rcxTlDZ0d1/a
         9RJBIqedQd/gb03g/oWpjqLdAeCHNgNO10aJ5o/F826QpX7dgRSEcO1U05hyAMzuPmh+
         +0GTtj2HU2cCyV49qRYI5js4S0YnrcbkJEEHq7deUO5+Said94MpUkr0x0MzUfpq+bts
         gaXJHq37Yx2bjb1BJZrPKbf4F5/ZnMZaimdCIwszaGqtpFscNkH+Tr7qudx46w5aB9m8
         Su5g==
X-Gm-Message-State: AOUpUlEppk37Y855UeBbFpXqlXrfvjF6Uh2QaP5KUROe3QUlJJZpV7Em
        geffHfbND7ERU2z8IQmM0uI=
X-Google-Smtp-Source: AAOMgpexnBGtjaw2GCW175W1zaxTjOIHjF/VXYvSt83wjZ9VGHV7dBv5n97u+nWWT4SfXqw5KQkb/g==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr4792164pfi.66.1532660567999;
        Thu, 26 Jul 2018 20:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id m20-v6sm4541320pfg.61.2018.07.26.20.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:02:47 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: i2c: vs6624: Replace mdelay() with msleep() and usleep_range() in vs6624_probe()
Date:   Fri, 27 Jul 2018 11:02:40 +0800
Message-Id: <20180727030240.2558-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vs6624_probe() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/i2c/vs6624.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/vs6624.c b/drivers/media/i2c/vs6624.c
index 1658816a9844..bc9825f4a73d 100644
--- a/drivers/media/i2c/vs6624.c
+++ b/drivers/media/i2c/vs6624.c
@@ -770,7 +770,7 @@ static int vs6624_probe(struct i2c_client *client,
 		return ret;
 	}
 	/* wait 100ms before any further i2c writes are performed */
-	mdelay(100);
+	msleep(100);
 
 	sensor = devm_kzalloc(&client->dev, sizeof(*sensor), GFP_KERNEL);
 	if (sensor == NULL)
@@ -782,7 +782,7 @@ static int vs6624_probe(struct i2c_client *client,
 	vs6624_writeregs(sd, vs6624_p1);
 	vs6624_write(sd, VS6624_MICRO_EN, 0x2);
 	vs6624_write(sd, VS6624_DIO_EN, 0x1);
-	mdelay(10);
+	usleep_range(10000, 11000);
 	vs6624_writeregs(sd, vs6624_p2);
 
 	vs6624_writeregs(sd, vs6624_default);
-- 
2.17.0

