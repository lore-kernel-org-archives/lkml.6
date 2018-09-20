Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9B4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344E92087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOLsMziA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344E92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeITWDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:03:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41622 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeITWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:03:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so8344078edd.8;
        Thu, 20 Sep 2018 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P/7Od3Bj2AH1Mmk63PhuUtdaCKTzQLyh+cixL8GilLY=;
        b=cOLsMziA9BAeUv5/iJXyQ4Lm7JUpn4XDuXm9uTAWsT2LJxuLCfBT2VxkLMYvEo6rkx
         WL54RTTlX6oDxfiv0r3EkpIgq/vSLQibnxDfIxyq6uQrSSVaszki+DOv8it7quL+ERZk
         olFC7QhrAhfmikdCm9knbZwcMM0Q4vG1KpZUjIY/jZa1tIHQm1XF/6PA1Q7781F5ZISy
         U9fOy8cBrSyYTQfxYMTprCZqjZm3CITAkIOyQVzsyvzzN7zMlS+8fz7Dzmz4gPaUVDq7
         gisP0cDpZy6uZIhPoGhfMTwk0feoJzQhEOiE8k1PrTKjPoB3vichr0SCXgKFCU/KxW6t
         RBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/7Od3Bj2AH1Mmk63PhuUtdaCKTzQLyh+cixL8GilLY=;
        b=iewBvevtwXOfr44+47EBVlvynd9hfXAGwaG/O1NbjSqCRDtL/tx4bN5MyHhNkitCiM
         Nx6fvT/bNz0U3J4Tx0CcG36G/Y/yMvlWI19ZaSNX6T9S0zlYe9CWUB/QwK/w8PWK5qH7
         Zvvigcd2gmOWopu5pYeXUxRmcM3vl3A0FnAb9WY4CebZ2OhYGQVF25/FQXNGOM3UjX7K
         uYkJ5ywKm+u3kl/duXhATOnE55TCK55nxF7HJq4yJr8QDwTKj27jKmjKUBxxHa/CRHcE
         90TlrWNfeA3F6lTYsYgivkiQ4HCyLNYZO5f4GQJR34q34bDuGEe4nzhY0xZN8G2Gxpvl
         HDWA==
X-Gm-Message-State: APzg51DFyee+BitjTDehm0gK+vOlpwHAS19UxIA9AZT+3TUzzjVco6VY
        nQE/qq/RZN8YlQXRTw8/XIE=
X-Google-Smtp-Source: ANB0VdbpPUXDbfFyoJw/6h/fGM+SP/mJCJ2KvJG1Aup2l0A664zmJJZCdCn7FvGpMKMtOJ8orjwbNA==
X-Received: by 2002:a50:fc03:: with SMTP id i3-v6mr1752545edr.85.1537460355676;
        Thu, 20 Sep 2018 09:19:15 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h40-v6sm958144edh.88.2018.09.20.09.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:19:14 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/4] [media] ad5820: Define entity function
Date:   Thu, 20 Sep 2018 18:19:09 +0200
Message-Id: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
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

