Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45829C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F24521906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pI2VddK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeLUHZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:25:48 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58110 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732346AbeLUHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:25:47 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 17314CFE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ia_8PA1ggPwg for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 01:25:45 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id E0F33CFD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:25:45 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id m12so2462875ioc.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jipBkokQTPzDdu0P3LVe5/zRG7nUwlvyAUInrUQ280A=;
        b=pI2VddK519c6ZpzEN0K99Ah9n/bbwQ6jPCB+KzAB+ouZOOctYxdlXwgSuOky5EKNll
         cxqRKiZj8HXUFC2Sp+QypYjBWD+Vko2CCr4BEtD+Qwe5RN6wiVfHjesQsb9QaJkM03SE
         jF9DC4eC2OrFJZauoe5AKBK86BWJrMIRNfbE3FfIDP9F4Y9hiqEsF88yJ9Zr7cDVW/oe
         t8+hxvusBmTNMoONALXj/4GhZYgby/R+uPajr1X69pBUd8rzc3eUnzNZa/bXeLNCUwtY
         tQ0P5Q2gO3eqzhHeLppUjW1iKeNePYjK9tWs/MDwwPL0N1Iy6oDdtSFoD04xO38LIW9W
         Qe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jipBkokQTPzDdu0P3LVe5/zRG7nUwlvyAUInrUQ280A=;
        b=YG2PCGMB25ByyQRv2ZDDM0WJIe2n346FWD6XFiTUfH/SP3dyWiJwUP2pCPmkp4/gFO
         rD2omt1rCpOp7eCFadX9lfB+h0YXvoykv+3MeOGqZzx7tw/jcWAvg+6eg/86uwXVY3ko
         LMDG1fnNHs0L2LwKvl8EBu074J6zPn7mrTrZ+FtzY7sK+XiZwTBVi7mTZuDlPRACiRzx
         9/roDV+UtFKBT8tPASPawuXxx59njrCR0aTqsqi816EMdrTEdHVUqfxn5RNIknoucZnL
         6bX+jVpq1xDA8CLxT3cLZi48e9BhXTAbdk6A1EiH3a6lOEy1X9dxKd2WSonk3OiPyGaT
         z2Ag==
X-Gm-Message-State: AJcUukegQwCYfCQgAtuLAMZVqHUxkq3/7yru8ljHxqTN6i3bHO2282tW
        tjTVc5jfklwFaGKVEkjSzU64wVUzVrz6vZjD1wygKKny4gEonNHK+i3OMuUd+MaKefWjMhE27ZW
        Fwm/UNfL2VtfZSW341QV9fL+0P9T1
X-Received: by 2002:a24:3752:: with SMTP id r79mr1038415itr.121.1545377145481;
        Thu, 20 Dec 2018 23:25:45 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WNsTKNAZNlVTmfqbpRcQAze1z4uk/P9rkG5+FOjNjK4p2njXOirCjeQRtmS8YKNo3+Uxa85Q==
X-Received: by 2002:a24:3752:: with SMTP id r79mr1038408itr.121.1545377145234;
        Thu, 20 Dec 2018 23:25:45 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id 81sm8537907itz.15.2018.12.20.23.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 23:25:44 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lm80: fix a missing check of return value
Date:   Fri, 21 Dec 2018 01:25:24 -0600
Message-Id: <20181221072524.60369-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When lm80_read_value() fails, the read data is an error number. So let's
check its status before using the read data.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hwmon/lm80.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index fca6363cd77f..7457ff8bc860 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -628,6 +628,7 @@ static int lm80_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct lm80_data *data;
+	int rv;
 
 	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
 	if (!data)
@@ -640,8 +641,14 @@ static int lm80_probe(struct i2c_client *client,
 	lm80_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
-	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+	if (rv < 0)
+		return rv;
+	data->fan[f_min][0] = rv;
+	rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
+	if (rv < 0)
+		return rv;
+	data->fan[f_min][1] = rv;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, lm80_groups);
-- 
2.17.2 (Apple Git-113)

