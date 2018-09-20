Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D23C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99921531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeQgnzmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbeIUAQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:16:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41446 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:16:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so9306346ljy.8;
        Thu, 20 Sep 2018 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M1KM9ge37DjiekXeHM0ecmdPDTzHX6M2Us9BCK0LUEE=;
        b=EeQgnzmkVG2Y3ZFQkfZ464yzlipGJjiLsKGfN+HM0uqkepXknnSf/rtIogS3VRSOT3
         IXHBUcvwvPs5XotYJmog3e8s0sKugG2MXtIjuWb9RWpLnsYMkdfkDYYdgzWJNS+QdEu2
         RVR8QC7RB7a4yAoK9RWuwCdzTsRIwxg8AL74a0LrGOlpGGDE7PlQ7U9mb8Ga2CHAVi4d
         1PWghPK4yhT3UkiJ26bdtYiYllQJTMt5lGLF6sTb9PIwRYj2cZungsNNB1kHMw/N7lQE
         znwlV9T8YHhOe8InP0VUijJVedRRi8jBlwlD0r0chK+qJCAmZ3H+RtUt+pwWxBM8HJ19
         kIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M1KM9ge37DjiekXeHM0ecmdPDTzHX6M2Us9BCK0LUEE=;
        b=iV1h4qFconeCSlcn7xTQs48IlUmRaHU76UFbAN+LRxA5p8+JgZXECkq6Z/VbVGhI3h
         vFei2QdfvnIXApgNa7Fj/djlzmdFf74S07KdQjaYAXYHmoIgJezs2v5pGEB0ErLW7M/5
         evm4+jasGGYV6oEkULk8C2SKWK1SJkphKtoi9ph/7ZzieS/K1rgnAgPQQ4yb2wtofLb/
         HOGlJHvT3UAdAtUZqhxg9Ce9LtnBVn9hSltgGzMG7Jh0NoJWQaNJW0OxOnaRj5hSisUz
         Q4muH0ZgPT74WXPvgKHYu8fb9ojImaESJcuJFJnKUtuljgBs+Ur+sOx6kUh05t9KSJ85
         N6lA==
X-Gm-Message-State: APzg51Dnp7WnOBjul0XFYu9JpZjarSPNO4bXrfRI8/SeH48DV4VKp4WS
        DA7tyyI5hoOpAq4yr0uSx9I=
X-Google-Smtp-Source: ANB0VdZEiTBXW8Kb1epw3i3g42B5tjlHzZOcfqEkvfSCVK2xBAjecF247j+XpHaDZW4kkqwGDA1dCQ==
X-Received: by 2002:a2e:1b4a:: with SMTP id b71-v6mr26592937ljb.104.1537468316513;
        Thu, 20 Sep 2018 11:31:56 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q21-v6sm1030434lfj.80.2018.09.20.11.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:31:54 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 4/4] [media] ad5820: Add support for of-autoload
Date:   Thu, 20 Sep 2018 20:31:51 +0200
Message-Id: <20180920183151.2933-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920161912.17063-4-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-4-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 4.16, i2c devices with DT compatible tag are modprobed
using their DT modalias.
Without this patch, if this driver is build as module it would never
be autoprobed.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/ad5820.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 20931217e3b1..75b9b8aa5533 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -375,12 +375,19 @@ static const struct i2c_device_id ad5820_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
+static const struct of_device_id ad5820_of_table[] = {
+	{ .compatible = "adi,"AD5820_NAME },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5820_of_table);
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
+		.of_match_table = ad5820_of_table,
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.18.0

