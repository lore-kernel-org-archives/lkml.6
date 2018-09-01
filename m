Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F01C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10722083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10722083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeIAQ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:58:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54644 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeIAQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:58:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so7496685wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2oakBCkzWEFkuf43kKatTH3r57oXPxeamnLhoBKTqiw=;
        b=f9BoTP/KaCxoHIF6KDvi1K5HhsURdILhvRBQmAKsGRZU6hHGTsX7bd7NSaGuueoum6
         GGsuQGo7VkTDAFpbhY7BcVQ4URkFkJ6MHiVEJG5OYpfEQ50ocYdEs0RoaNI74DXsmISv
         cp3aBDFzM445jKnMF2CVgSw8GEVj5T0vrgef0eKznxsKhxeYZVYPDBaSiK6GpTTI0Vmq
         4/BSn7OZ1UNoqoDMic8URUK3UFp+lZhEKLTdyxFpM99KFjCIIv99A82PkqGATIfZiKTx
         MWqVAjHaHb0iAqz+xEUTPvjW7hfMxuH7Ykm9ZpqAC89/+IcZpPyjFBNd3tGHmm/AGEWb
         fnlA==
X-Gm-Message-State: APzg51DS/dPYM6kOZ+iadtaEVnt3bDgAQirJAwlMDzKVnFdtK+T2+7VK
        JBFUmjgWtGzlm0p09flJdsSWg5NZxmU=
X-Google-Smtp-Source: ANB0VdbS9zmvMqClaGVr7Pkg1BzGzWmk8UWtedRxsTR7FUh05dY6AmxmrdXPONstSGng/GJs/uxf0g==
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr685512wmh.116.1535805997655;
        Sat, 01 Sep 2018 05:46:37 -0700 (PDT)
Received: from minerva.home ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id q3-v6sm8515547wma.45.2018.09.01.05.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 05:46:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v2 2/2] media: ov2680: rename ov2680_v4l2_init() to ov2680_v4l2_register()
Date:   Sat,  1 Sep 2018 14:46:30 +0200
Message-Id: <20180901124630.14139-2-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901124630.14139-1-javierm@redhat.com>
References: <20180901124630.14139-1-javierm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function not only does initialization but also registers the subdevice
so change its name to make this more clear.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

Changes in v2: None

 drivers/media/i2c/ov2680.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 3ccd584568fb..0e34e15b67b3 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -926,7 +926,7 @@ static int ov2680_mode_init(struct ov2680_dev *sensor)
 	return 0;
 }
 
-static int ov2680_v4l2_init(struct ov2680_dev *sensor)
+static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 {
 	const struct v4l2_ctrl_ops *ops = &ov2680_ctrl_ops;
 	struct ov2680_ctrls *ctrls = &sensor->ctrls;
@@ -1092,7 +1092,7 @@ static int ov2680_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto lock_destroy;
 
-	ret = ov2680_v4l2_init(sensor);
+	ret = ov2680_v4l2_register(sensor);
 	if (ret < 0)
 		goto lock_destroy;
 
-- 
2.17.1

