Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C201ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7FC2154E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFhc/zMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7FC2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeIUCdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36956 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so9666058ljk.4;
        Thu, 20 Sep 2018 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WuzDVPY+DoNH0O4J3mOJwZElcAPkKwuc0RDsRb9BLGw=;
        b=TFhc/zMCr8WG62hTVa0+O9yXAFt6zBPZbQ+34Q3n4idMOXuLTHh0ewq5+zIHO3RiZz
         J99wY0h/gYSotcia/YfDrO3a7bo0nivfjId3/nJAI0k6WunoXYyG2iEMxOSzK41kBO/4
         Nd6tHSHK9Pu1cxQkz2riphEP9sPbAUZ3O6vBCQhQvIYSVJC0hzLerZbaQoG2awtVBQDv
         n5qI/OhD9FKAQ1cyutfkDwA3wTsLoqkqmFbWwXOdaUJO0fTLsTVkaXWEDphOKeVhQZcT
         2Qo8wqCQzlb9cmm7OQz4DWEGm27MJv3tKAaJrOh3xrI0cudDeGb8yxuQm40seyFHrgOZ
         2ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WuzDVPY+DoNH0O4J3mOJwZElcAPkKwuc0RDsRb9BLGw=;
        b=s2dVClk9aW6LaFxnIlosRg7QZjQv7bJcZY9i8M06L7fapkyH17BS7BhpE1Fd0wuo9y
         Bbb4EhC9+IiTYaWrlBbHmSsUkmI17bds98A7TebuTCtUFAtSLgz+gwPnZJhZa7x1WAQ5
         kLV/UKP+Yjlof2iVUofJTf13Tigtbed1j5wKicyLLOL+87zQWxt/fhx0rAGysaSMGFAo
         /b+USyERdLgPYxIW4FkjZz1/TPbF0EUExnQOmyBJSIh3LXJEVjPhzD4ui4it/aeDPBK/
         wGAPC6ThV0827teg0lqTSPS+774YNv5AOC3fb+zcTCo4WHQy6K56P4EMUR1t928ki6nz
         trrA==
X-Gm-Message-State: APzg51B9sJn8Lg0cGvmcFSrXPnfXbTRLoSZQMLuwwRh9sOx82G0TtbRQ
        2eX48g83g6mHQUoos+mVvJbiz+Rejmc=
X-Google-Smtp-Source: ANB0VdYWTRPNEBnZBlwbPbpbAOv7Fba3l4GCR66B1d1UTISuFv2Dgsy7Fksy8pYGX7qCf+oaT64Mfw==
X-Received: by 2002:a2e:982:: with SMTP id 124-v6mr26209673ljj.24.1537476474169;
        Thu, 20 Sep 2018 13:47:54 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1821609lfj.49.2018.09.20.13.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:47:53 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 1/7] [media] ad5820: Define entity function
Date:   Thu, 20 Sep 2018 22:47:45 +0200
Message-Id: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, media_device_register_entity throws a warning:

dev_warn(mdev->dev,
	 "Entity type for entity %s was not initialized!\n",
	 entity->name);

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ad5820.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 907323f0ca3b..22759aaa2dba 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -317,6 +317,7 @@ static int ad5820_probe(struct i2c_client *client,
 	v4l2_i2c_subdev_init(&coil->subdev, client, &ad5820_ops);
 	coil->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	coil->subdev.internal_ops = &ad5820_internal_ops;
+	coil->subdev.entity.function = MEDIA_ENT_F_LENS;
 	strscpy(coil->subdev.name, "ad5820 focus", sizeof(coil->subdev.name));
 
 	ret = media_entity_pads_init(&coil->subdev.entity, 0, NULL);
-- 
2.18.0

