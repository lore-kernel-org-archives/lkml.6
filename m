Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5BFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFFF2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BodiFLFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFFF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbeKFGKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:10:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeKFGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:10:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so4990798pfn.8;
        Mon, 05 Nov 2018 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ADAr5AQOBKf5xqeLGhSnQ4E/XqcDmKpYJgabGVmIJo=;
        b=BodiFLFauFXWxpl33rPnpQhlyR3FOO2W8zwfoU+ztyLUlvxIYEGtqfDwQlUyyMDLvP
         pEdlyAuU4SqKMg45oL5RON/H6f2pBUaKMqmeg4NOoo9LhQNiP6/n+vwaSeUCTjPGk5rW
         VfKIGM8vHAlfi25U3QIPFaML1PntcJ7muVtAMt9qv5nx18trKGG7xpKfSV9FoG/m7zGy
         7qsj3bYpJr29rKuq80M8Uwpir9GVSD66K734Fw4x4YbD85i57vZnf9jVFnn91IPZ2zH2
         s5JUJApNkS/i/Tmt59zEXQJM0PqKigspPZ0hD/KeVm30icFYL2fsMMoFeqxqsnM0PSI6
         +W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ADAr5AQOBKf5xqeLGhSnQ4E/XqcDmKpYJgabGVmIJo=;
        b=pVOGDs4Jy9HxFUbmhUuQFy1oG5oN6BqaVmgT2DDir0ayPkeBlYSdvNPVLwj1bC/zKo
         NzOkcS12UfQybjDuokRKiPJv3bPr6feV6xmMT9vmaWceRE7looSpYaciv5R6RTDyOx40
         sl6rKW00AORrYIUMbWPw6YZROtC8+1cnB/10/457uoCV8ZAUtV8EylJBmNSQjvvBrOZU
         wAvbxeOMQZB996tf7lrpwt26g6vdPWp6xEKagWWV3eU40jd0VOiIDkfxNpmXxgeBbPiV
         /QCpE0FKFkGAki/zO1++V9TNS7XCAQha0G7B6X6WRbDoSdc3jnoU/9BV5WuCXBJzFw8V
         Q57g==
X-Gm-Message-State: AGRZ1gJFz08U1Izn6lztqUnFWb+2s+1xgmo7umhArIvVet8PECaK7f2J
        jwfQWCfEmDdAkwTr/if/eXq9LUQD
X-Google-Smtp-Source: AJdET5cOIVpiz0npjVa1cOGfyWdzUk19+BrqQyamZJ3aU/+Fe3THCARym4BTr/5I2NMZjDBJsdOpGQ==
X-Received: by 2002:a63:1342:: with SMTP id 2-v6mr21175929pgt.19.1541450931063;
        Mon, 05 Nov 2018 12:48:51 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm25569257pgs.14.2018.11.05.12.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:48:50 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] hwmon: (ina3221) Check channel status for alarms attribute read
Date:   Mon,  5 Nov 2018 12:48:40 -0800
Message-Id: <20181105204843.4081-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105204843.4081-1-nicoleotsuka@gmail.com>
References: <20181105204843.4081-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing critically wrong to read these two attributes
without having a is_enabled() check at this point. But reading
the MASK_ENABLE register would clear the CVRF bit according to
the datasheet. So it'd be safer to fence for disabled channels
in order to add pm runtime feature.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v2->v5:
 * N/A
v1->v2:
 * Returned 0 for alert flags instead of -ENODATA

 drivers/hwmon/ina3221.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index d61688f04594..26cdf3342d80 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -200,6 +200,12 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		return 0;
 	case hwmon_curr_crit_alarm:
 	case hwmon_curr_max_alarm:
+		/* No actual register read if channel is disabled */
+		if (!ina3221_is_enabled(ina, channel)) {
+			/* Return 0 for alert flags */
+			*val = 0;
+			return 0;
+		}
 		ret = regmap_field_read(ina->fields[reg], &regval);
 		if (ret)
 			return ret;
-- 
2.17.1

