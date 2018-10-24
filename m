Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E4C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E312082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbpCg7eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E312082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJXLZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:25:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46991 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXLZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:25:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id a5-v6so712990pgt.13;
        Tue, 23 Oct 2018 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ejb7TUjIq2sUg/ciurEdUX72ayrKyRTFAOORT5hlWw8=;
        b=WbpCg7eHUxUsoCj9OAAOsxwFDHIpecSwdTg0vB053v5hSR+RIIHbptf0qFxTKeLj+4
         1BF2q26/31/hSDeTv3HHzmdzAa9F36ou/MXMb2GhXmR/oNO/iynR9YODhMb+EcejjQ21
         PVklSp6TRQ7U3dwI3B3GtGCeuun4uZ162YBwGbyyP15x32Uh/PTnlf12MvjWh/VAWjHV
         mEVleqPO3RO5zkVVEvEFY/HPk+qzexwLDdFWpPdGLNo/ABIOSFV+8bWi1LmCwBzCDo4T
         rTieXtwkzH+UgJw0m9OD5jlNCwgMd2AWkrklV76anOHT0I8Fpb3KyuUcWWjcjaNOf2kL
         2dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ejb7TUjIq2sUg/ciurEdUX72ayrKyRTFAOORT5hlWw8=;
        b=tGDncyAiVmClIIq369E9Q808zQWL7g96BwV/QdsT5rvV9sTN1LzutdteaN9XfGrxfs
         UslUF9qPIwTE5wjogd0QXnLvyf4xhv6l8W+7urFY64tCJLt/ZRSfKBkGnl8MANm2VIys
         bb75aECIEMPXqfU0lUTw9wguUS92KP68GP0Sei5x1LZhLIfjV6hLFM3UVYW9fu6agjPR
         x9ucZgL8seu2h9J55KWfxMI77uq2vJndGKsgfBJWW1nRaMduFc2Yo+KzwA1142aK5hk0
         TCSTHgYOrSPdrUR8YKOaKrDK3oraEEz+enYO/uAspv3BmomSdxaycJ8KQ+xy+ZMmFO7N
         HQ1Q==
X-Gm-Message-State: AGRZ1gKH72U8/SszOlLemj0P009Q15RhONd70zRt/kdJ/TqTZinPIwQx
        9zqbgJp1VvGun7o4MI3nOWc=
X-Google-Smtp-Source: AJdET5fK+mDCC5NgVl+hcrOHCOsng+xXJiS1S6tKhSm9bXjKtLkRj5aIAhB7ogM/1+lmXU7jUCzBxQ==
X-Received: by 2002:a63:64c:: with SMTP id 73mr762574pgg.373.1540348589988;
        Tue, 23 Oct 2018 19:36:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3606625pfj.84.2018.10.23.19.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 19:36:29 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] hwmon: (core) Inherit power properties to hdev
Date:   Tue, 23 Oct 2018 19:36:19 -0700
Message-Id: <20181024023623.4231-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024023623.4231-1-nicoleotsuka@gmail.com>
References: <20181024023623.4231-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hdev is a child device related to the original parent
hwmon driver and its device. However, it doesn't support the
power features, typically being defined in the parent driver.

So this patch inherits three necessary power properties from
the parent dev to hdev: power, pm_domain and driver pointers.

Note that the dev->driver pointer is the place that contains
a dev_pm_ops pointer defined in the parent device driver and
the pm runtime core also checks this pointer:
       if (!cb && dev->driver && dev->driver->pm)

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Added device pointer check

 drivers/hwmon/hwmon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..14cfab64649f 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -625,7 +625,12 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	hwdev->name = name;
 	hdev->class = &hwmon_class;
 	hdev->parent = dev;
-	hdev->of_node = dev ? dev->of_node : NULL;
+	if (dev) {
+		hdev->driver = dev->driver;
+		hdev->power = dev->power;
+		hdev->pm_domain = dev->pm_domain;
+		hdev->of_node = dev->of_node;
+	}
 	hwdev->chip = chip;
 	dev_set_drvdata(hdev, drvdata);
 	dev_set_name(hdev, HWMON_ID_FORMAT, id);
-- 
2.17.1

