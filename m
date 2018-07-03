Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AA9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F1B22BC6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1av8b3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F1B22BC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeGCTfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:35:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36542 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeGCTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:35:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so2523580lfh.3;
        Tue, 03 Jul 2018 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VsZUnLnrDpdKh23C51SDfXPd0zNSeflc1G5OpPvX4Kc=;
        b=d1av8b3ZCLQRFIv4WuEH7W9s07xHNR5npRUf/OZZQYE5+fvp7ODNhYg3/Y9X+KIXm8
         eYRtY79AWcBwhJiXnzvQJ35OOdxI/wUmWDO/0tdcwh8A4F/EMq90zUZcGfWhzCT15agg
         bI8Q/Bk1PHGqc2zrf5T/bnB5ZqePeIzIYI9pUwOXZKFACo0asPN/9UakdFubzO8t9OFj
         Mq3IamTSGdt5MBookkyDKyji4c0Y+b9Cs7yCm03AKsKTdaAYN2p9eCMJe92mMmzGy6M3
         FxatrGStMBKDn47BJwSxQy3/vvz5JKprkm7PGJmPbGb56pV3hJw4Noc7XQHOgKbq21tX
         xrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VsZUnLnrDpdKh23C51SDfXPd0zNSeflc1G5OpPvX4Kc=;
        b=cbx2mVvrffsfdHN1QWyy/AC3inZsevCsrFNOdzMA0SCdeovo61qSZqSC6P9va5vLUr
         hYhBQ4NCiAq6C0Ysmssosm55X1UWJMsPeob8XwUadujg07toIxDpGieW1ZjXTWe4sNgD
         BDl3DbKQgcixx3pqP4bKtdCaPgcmayVxWbpPynr2YwiQyNd3WO+xwKVSYibCwROWehCv
         iFwnrRrfdqXfKgsr10C1QIxbVtg8f5LGFTRVVMdmKBt5+EZDIeGKnNonBKFNEP0VSF43
         gwsHrWmMymtI9VxbESMUK8W0KaiX9kjPyFcw9vkAUD/NjjSod6V3JyC2e87kFBhr18+y
         zyug==
X-Gm-Message-State: APt69E0xURhGv2gt78aaz7ko1gevh1TNWn5tMP/RORocjDDU8U72by+y
        HfHppen/glpLsMGFcS3g6g==
X-Google-Smtp-Source: AAOMgpfiPDHYloISxgSlRyV1BCX8ideeTV1+9R0/mGgOXdEjoHsFhvYO+DeLG1rFgzuEc4UYu1tcEg==
X-Received: by 2002:a19:7b0c:: with SMTP id w12-v6mr19972399lfc.22.1530646549382;
        Tue, 03 Jul 2018 12:35:49 -0700 (PDT)
Received: from natsu.teplo.pdc (mail2.teploobmennik.ru. [95.79.26.27])
        by smtp.gmail.com with ESMTPSA id y68-v6sm392663lfd.66.2018.07.03.12.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 12:35:48 -0700 (PDT)
From:   Aleksei Mamlin <mamlinav@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH] hwmon: w83795: Convert to hwmon_device_register_with_info()
Date:   Tue,  3 Jul 2018 22:35:15 +0300
Message-Id: <20180703193515.4379-1-mamlinav@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces deprecated call to hwmon_device_register() with the new
hwmon_device_register_with_info().

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/hwmon/w83795.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 49276bbdac3d..25bcf988ef1c 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -2234,7 +2234,8 @@ static int w83795_probe(struct i2c_client *client,
 	if (data->chip_type == w83795g)
 		w83795_check_dynamic_in_limits(client);
 
-	data->hwmon_dev = hwmon_device_register(dev);
+	data->hwmon_dev = hwmon_device_register_with_info(dev, client->name,
+							  data, NULL, NULL);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
-- 
2.16.4

