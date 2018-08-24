Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF64C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013A620A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVF3TZGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013A620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeHYAAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:00:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33114 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHYAAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:00:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id c7-v6so7620174lfe.0;
        Fri, 24 Aug 2018 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0+E+irQDZNa6kPpt/Qz4bPn4JZSjyYuZAb24O/WCUz0=;
        b=KVF3TZGGYB/NDUXIdm/USPorxWWzf3y+dJWweFp0ew6x7WqTsCa8w2fd5ZiQZ3f0B6
         Lcl3ubRzUlBUbY/q+7fh/puFoVk5cethSMqoG7HAaSZCVid2U1fb71DTTmUueSKKYemO
         XF52VFe9Es32uxoQrzqKyriXxY5KDYYfHuU4mvCr4GbdD/Lv1KqBeMSsEZ4docN5okTn
         ta4fx6YyU0WI3vaG1oNFrOdQww1iGFKTCyYaxZOTb29XtEQZmyZfPZFEqKJ50eGR7vPr
         vgS3C3Zfmag5qZtNW/4+4BMX+6GWwqry/JwVNkSVkSErAFzXSiomB4KB9GkboHUL5mjQ
         tq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0+E+irQDZNa6kPpt/Qz4bPn4JZSjyYuZAb24O/WCUz0=;
        b=aA8XN48+EQKrjc4pa87pGhXVVFxHArIi1f/BSVMsC36+/L0ipE1bCppLf+pTqgbC3r
         Toza+gtCsTEbqNPWjR56d3SVcsNWgcfkQBHsQa/4dVcZN9OkQ/eDZ25ShfZIF1tt8UZ2
         RpOtYHq0vV+ktZ16YlCp9NhI224i/1UO+Nj9/UqoTmQmQgvzd80qhJbbT0SWDxBhxcVz
         5+7LqGVxRT3DkCbnDXf9aEuQMYsGlaut9ouOuMWUHOhgmjxmwgKwKxXwBQpXB3bFErB4
         wYQuHeOD/PSaqskw8QOaXL3d5ZBikZpV3LJVkwwjZXUAgzG5VFsGhomYbou7UIbP9rKg
         P0PA==
X-Gm-Message-State: APzg51D2GRcjdZ+dwmurAG/KqU5uh9eao70E509+pwHuQNIIwqh8eI4M
        FbX8liEy3u7303w/YVA+lwg=
X-Google-Smtp-Source: ANB0VdZt5zb2cMlOLbzONlfZCR60jG/BxI1LxX2bmA871H4kj6lTEPKyLt834uKx1CME+qTRFNpAGQ==
X-Received: by 2002:a19:e51a:: with SMTP id c26-v6mr2197161lfh.78.1535142279175;
        Fri, 24 Aug 2018 13:24:39 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id d4-v6sm1459543lfc.57.2018.08.24.13.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:24:37 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: dac: ti-dac5571: provide of_match_table to driver
Date:   Fri, 24 Aug 2018 22:24:59 +0200
Message-Id: <20180824202459.21855-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the created list of of_device_id's as a match table.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/ti-dac5571.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index e39d1e901353..f6dcd8bce2b0 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -421,6 +421,7 @@ MODULE_DEVICE_TABLE(i2c, dac5571_id);
 static struct i2c_driver dac5571_driver = {
 	.driver = {
 		   .name = "ti-dac5571",
+		   .of_match_table = of_match_ptr(dac5571_of_id),
 	},
 	.probe	  = dac5571_probe,
 	.remove   = dac5571_remove,
-- 
2.18.0

