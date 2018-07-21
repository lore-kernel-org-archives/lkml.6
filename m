Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C693ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9020854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0XelieA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A9020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGUUEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34618 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so14137956wrt.1;
        Sat, 21 Jul 2018 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cs0oJnLo2LfTemgdMwNzfJPIk8MN9r2ly9dw0G7v5ts=;
        b=Z0XelieA39SlDImtmOwEoL3K30qD6KgKX4I6m+UfwymTBb7pZra8V6jZvzzgBjXFoK
         XV9mcJcDdLg0OefChXGvvtMHkpVXOwlyvQaKXeItg2WkiwVsCWOY+Qwnt6UsJYXmENqT
         PVYKTLVBBVmGXvjL3JCTvT/POl48J7BW6O79NsBUmLVyF3YP7fsEHP1lJPQ9zIEr1U/c
         hp8sEygpNLy03L1s3juW/BYsRauMF2cH/QlrF0fl8ppYF1GkFxu+BFAt1ewVtrDCCRq7
         dnX3BiBMk1GvF7CmgpNtznO7Zk//93k2x7lVV8S4FYmKPhI4l7qHiNJ7FDDR+1QloD1V
         Xa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cs0oJnLo2LfTemgdMwNzfJPIk8MN9r2ly9dw0G7v5ts=;
        b=b9fPKKSTX4TIWv/tleh25BN8KB6hAl+ZoVNsTjRyskCZnsXVmJWkVih/s2YoUHp+ZD
         Y5gsxlo9sRODrYxl8kG7+wPjYjVgdPd/uz6CKqLZY28X3WiyrDdefsj5yF35OCmkEXCE
         TmY0Op8dXaHO0nNHRhtT8jg7Zo3bb0O3jk5TwA9ynL7ab9OlGic/OxFQojS1455+a8oX
         8LgjFeu5+6py0U0H/Ptcd8/9GYxsj8P+VNvuXBKdivbqHUwC+XPDWiICk2KIzr6LzI5+
         FKGyEsQhtoS4FO1r0EM23ekvODcRxe83ZyaG4kIQuYcIs3bFmVTbFgfj9Wl/vSCglhjR
         w8wg==
X-Gm-Message-State: AOUpUlGBaszEEkHuUnEKKaSgSjF2Ac/yBrV9HXBpkS4IpqLRs1NpD2Xz
        yGmBansmQtaN2ryz3jy2iQM=
X-Google-Smtp-Source: AAOMgpfGXgEpDzd9R1NzI+A00aoxc1Y07iOV9RnHmHUkv/UfZRW/4SkRPs+SIKVT32A5njvcjU38Jw==
X-Received: by 2002:adf:99ea:: with SMTP id y97-v6mr4391317wrb.215.1532200234328;
        Sat, 21 Jul 2018 12:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:33 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] touchscreen: ad7846: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:43 +0530
Message-Id: <20180721191029.25658-2-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a2f45aefce08..7c07de0802de 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -431,7 +431,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 		return v; \
 	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
-static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+static DEVICE_ATTR(name, 0444, name ## _show, NULL);
 
 
 /* Sysfs conventions report temperatures in millidegrees Celsius.
@@ -561,7 +561,7 @@ static ssize_t ads7846_pen_down_show(struct device *dev,
 	return sprintf(buf, "%u\n", ts->pendown);
 }
 
-static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
+static DEVICE_ATTR(pen_down, 0444, ads7846_pen_down_show, NULL);
 
 static ssize_t ads7846_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
-- 
2.17.1

