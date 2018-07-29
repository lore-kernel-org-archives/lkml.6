Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E94C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7BD20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOfMlYjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7BD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeG2VJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:09:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41963 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeG2VIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so6024640pgu.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbeR4UeSqh4Lwp8spvsYG7QS8gcKKa52mTJVodO+cNQ=;
        b=mOfMlYjhVE21Dfz+m+PZZbygWi9hqQopMXdROiGGewZ79Ae4cUmLl0RXMO7DSVwWEd
         HDw8d8q90IC2gWHuq2ITYpxUOhIyDNaLSXb5ItgFQ1Bu7iekR6wctzb1B3OG3vOk69hG
         /uWxOf84bNywceB/PYxWezyAwVrldzwWY1RJGCfw11QeXSv133AJsQqhQqvQDsBa5Dle
         yUaq6coHSr3OQo0+Tk8xxs1JgH38/07hwZkt/F2nDfaNNgSxiqvB6X06nZCnoTLitLcw
         q5xnKp9XKACDJnMlFM8Cb/OhWe6Db01zmFSpA+NXQL48dUpN9kDGP4ENrUbWzSEtcN/Y
         ic4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbeR4UeSqh4Lwp8spvsYG7QS8gcKKa52mTJVodO+cNQ=;
        b=b/Mg2dCMjCGzH9hsNDMgYXYdNkVmF9A1uYj3UTEt6Cc//RBTNtx+c4Rf4UWaRbGf/b
         JqrNiGE8tlibvU2Gs7cvz70+WhCmSPxtO55juuC4uv2+S1UvZKEV4DOsVLQ83nhukC3t
         FVQpjyCGUIHBygvY9rF3N4lMzMs8yCMkZyMCaTG2eCOgkFNnWF2rkjzWX1dpwzWoWrcM
         +A48STCCEMHlSwnX9zcF4OANV4FmNAQAZYsJ9rabz9AX89Que49owFyG1zr4p95iWo3c
         /ZtwNmnPhk0KN01USi4x8YRcQlqArfLPULh9gYA8WAq0LYo73VkjTm+PNy6q+YxemCn4
         vttg==
X-Gm-Message-State: AOUpUlGtKz/kjvuN5Tt5zGKWrEMgYOXKuRwgBKaHb9FFFUGBaZUfBy8C
        WCzYPSaWsWzhkoJlsIrOV/A=
X-Google-Smtp-Source: AAOMgpfTygFc7RQursE26+BmAiVKSNxWzsj6iNwiU9Ra/Ro1qQh1AsMXD3Wz1aM32i9MAi9x5zhTWA==
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr13757142pgp.69.1532893020118;
        Sun, 29 Jul 2018 12:37:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:36:59 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/13] staging: gasket: sysfs: hold reference to device while in use
Date:   Sun, 29 Jul 2018 12:36:35 -0700
Message-Id: <20180729193646.201721-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Hold a reference to the struct device while a gasket sysfs mapping
exists for the device and a pointer to the struct is kept in the mapping
data structures.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index da972ce0e0db0..fde04658419bc 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -126,6 +126,7 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 		kfree(mapping->attributes);
 		mapping->attributes = NULL;
 		mapping->attribute_count = 0;
+		put_device(mapping->device);
 		mapping->device = NULL;
 		mapping->gasket_dev = NULL;
 	}
@@ -208,22 +209,20 @@ int gasket_sysfs_create_mapping(
 		device->kobj.name);
 
 	mapping = &dev_mappings[map_idx];
-	kref_init(&mapping->refcount);
-	mapping->device = device;
-	mapping->gasket_dev = gasket_dev;
 	mapping->attributes = kcalloc(GASKET_SYSFS_MAX_NODES,
 				      sizeof(*mapping->attributes),
 				      GFP_KERNEL);
-	mapping->attribute_count = 0;
 	if (!mapping->attributes) {
 		dev_dbg(device, "Unable to allocate sysfs attribute array\n");
-		mapping->device = NULL;
-		mapping->gasket_dev = NULL;
 		mutex_unlock(&mapping->mutex);
 		mutex_unlock(&function_mutex);
 		return -ENOMEM;
 	}
 
+	kref_init(&mapping->refcount);
+	mapping->device = get_device(device);
+	mapping->gasket_dev = gasket_dev;
+	mapping->attribute_count = 0;
 	mutex_unlock(&mapping->mutex);
 	mutex_unlock(&function_mutex);
 
-- 
2.18.0.345.g5c9ce644c3-goog

