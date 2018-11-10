Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64FCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B3C2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABuhpvD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B3C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeKJKZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:25:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42473 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeKJKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:25:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6-v6so1651211plo.9;
        Fri, 09 Nov 2018 16:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yusnVUysSlqFmxFAYpbEWiLkz85WRojrbbOQah5PD6I=;
        b=ABuhpvD/c8idwK/Uq0b2AINeR/fCpM5rwFG9KEocndFhpUkVo7VOGWKiz/RISsjaU/
         ttZZ6Rg5ogK547NUlKsv3/bJboZRgdKSmo7/Gyc65q/hr46WSJEkoRGFy/QdNwxGucGM
         iKdawRkGjw9z5t4NirODrEzqeSai3d1YLA0Hb5VF+EBPw9m4VNv+KHYi2pszbxCTbjEk
         ApKHb1meKSQjthTGZh8kSyAbM1bdPEctNNbqW/PGsoWUG2aukKfZuU2vQljOps7rzyWw
         gmsX6uqwpWOCyymXdgZW60RKGrHxIQqK3soaeIQZ3Yq4E+T1UDo5A8twr8T+x0QuZoxM
         kEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yusnVUysSlqFmxFAYpbEWiLkz85WRojrbbOQah5PD6I=;
        b=XjJ6G3n0COdYgMbYaOqjioplcQ8MSEOr16K6ykHumadMCyGrTmrmRJGz3x/n4YJ82E
         SaZo/Nzo07n7eMGUjb98/JtDRB7KHzkBZ4rtw6VM54vAA0SV1kfXJEV706D8Mr5JzDZn
         bYbdObUl9oTH0+hcdsg5FJxMnQYAqsazsgWehKIfGbZBoNrJW5DH9aLTj0BL0Muj+tm/
         MG4fg+TEObThSMn7zt/7ryWggFj8X0YW7xbkmjQ5UkzglEdc3ibTmQ64G1HK2naxbe9/
         wYFe0rDYx+BSBi3Vbqhkmlwyx0XFrxc67pEhWQPmzEltiqcU25NqlfGevMSs2Kson67G
         xHKQ==
X-Gm-Message-State: AGRZ1gKfeGy34rf8W/Hu1iTfp+1Z8T/3U/pxknZK8EYGj6DcHkSIP/T6
        r9ztBf0AMN2O1/GVHArXaoo=
X-Google-Smtp-Source: AJdET5cfm5+0gj3xZgx7X3ou4TIpk4LanIDKHx8CksrCwZ4l/k6fwzdBHJJJVxU9whuTx+G5H8iN4w==
X-Received: by 2002:a17:902:147:: with SMTP id 65-v6mr11053942plb.140.1541810549425;
        Fri, 09 Nov 2018 16:42:29 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 196-v6sm24078586pfc.71.2018.11.09.16.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 16:42:28 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon (ina2xx) Fix NULL id pointer in probe()
Date:   Fri,  9 Nov 2018 16:42:14 -0800
Message-Id: <20181110004214.13858-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DT configurations, the id pointer might turn out to
be NULL. Then the driver encounters NULL pointer access:

  Unable to handle kernel read from unreadable memory at vaddr 00000018
  [...]
  PC is at ina2xx_probe+0x114/0x200
  LR is at ina2xx_probe+0x10c/0x200
  [...]
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

The reason is that i2c core returns the id pointer by matching
id_table with client->name, while the client->name is actually
using the name from the first string in the DT compatible list,
not the best one. So i2c core would fail to match the id_table
if the best matched compatible string isn't the first one, and
then would return a NULL id pointer.

This probably should be fixed in i2c core. But it doesn't hurt
to make the driver robust. So this patch fixes it by using the
"chip" that's added to unify both DT and non-DT configurations.

Additionally, since id pointer could be null, so as id->name:
  ina2xx 10-0047: power monitor (null) (Rshunt = 1000 uOhm)
  ina2xx 10-0048: power monitor (null) (Rshunt = 10000 uOhm)

So this patch also fixes NULL name pointer, using client->name
to play safe and to align with hwmon->name.

Fixes: bd0ddd4d0883 ("hwmon: (ina2xx) Add OF device ID table")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina2xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 71d3445ba869..c2252cf452f5 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -491,7 +491,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	}
 
 	data->groups[group++] = &ina2xx_group;
-	if (id->driver_data == ina226)
+	if (chip == ina226)
 		data->groups[group++] = &ina226_group;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
@@ -500,7 +500,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return PTR_ERR(hwmon_dev);
 
 	dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
-		 id->name, data->rshunt);
+		 client->name, data->rshunt);
 
 	return 0;
 }
-- 
2.17.1

