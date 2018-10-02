Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCBF20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO1Y8vQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCBF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJBOOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46467 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeJBOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so801703ljj.13;
        Tue, 02 Oct 2018 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xt3dmmL2vF+yL6QeZS4w6KrzNFaw1J26hKwwcqzdAE=;
        b=bO1Y8vQ0jkvvKkL6+18x87QcPCcEFJSE7UcfS0XeZFHFmR9NJOA7GHNhrMe07SRXDf
         wHF+ACcDLEbVnS/bWrer8LRNCVjmxh5scSCK6/ATtb/5gPF84lHlrLBOvXbnevSimMuD
         YKp0JU1PPFdGFNLfjdNpYz2NCmicj61TwgP0kGSbJ6rrVZiXwuQGIrhAfKpt5dVEN5wY
         ty8psr0LaFcjCO1rxgBBL/OHB3m/kqG0yjAMD8cCNZNaUp435m+loU87IBbNQbaRNMLO
         gRox7nxdjoXIfoGqagoRcdun6jm5VzWu9fuSRx96xo2OeUrhUpRZG+K56aD6fhfTFSTn
         OJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xt3dmmL2vF+yL6QeZS4w6KrzNFaw1J26hKwwcqzdAE=;
        b=TGJvT39FKemMKXoUc3l53hpE/EmF5poPlFEJmKDojDaei/BrW9PHGLLwyVmy0rhh1y
         YbGrbT/Yq852zzUIusRixUa4D/2cwAZyXoDGODI1GO7w+kHdLriLS7LX6ZltpQpajOw+
         xte3ngBQ1Sf83LgfCCtpgQMuPq/WQSXR9T/hkBm9n+gyTAiqh7q3abBCTwwdCktnp+vl
         BunY+PD+PS/T5Cxhz0JCE73Bd4jLZpo6YRP4Mwpu6OM2VOD+QzirzMf7/u5OBMhMFhDG
         ZH/0O/jyR7RXPDiGPRZE31xVvItdwwZnxm4GpndzThzZtVIZllKYQN8JkuO7+d6TgdHY
         No7w==
X-Gm-Message-State: ABuFfog9rrTauI4E/p4T8pkuBSxB4h4VMg6CdH7zoBHl5wRxzpKqOml0
        ixKVjbDAgMX605y7+b1fU48=
X-Google-Smtp-Source: ACcGV612V8MilinU2/QxQnLMBupIEvG4x9ytesgYW4TR4jb5IHE1zHojgFddBhj76Ow0Z7a1ay6LSw==
X-Received: by 2002:a2e:44d0:: with SMTP id b77-v6mr8413384ljf.47.1538465545093;
        Tue, 02 Oct 2018 00:32:25 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1242246lfj.9.2018.10.02.00.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:32:24 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v5 1/6] [media] ad5820: Define entity function
Date:   Tue,  2 Oct 2018 09:32:17 +0200
Message-Id: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.0

