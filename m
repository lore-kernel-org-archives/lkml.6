Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D891C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4674920883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5V5RNf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4674920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbeG0DhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:37:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42328 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbeG0DhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:37:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so2285985pgp.9;
        Thu, 26 Jul 2018 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G8y7N9RH4AZkGuy8f62RMTy9APWhxwa4QK5qc88GqXI=;
        b=L5V5RNf5sSBsbQCk1PgyDjBJUfjGqGSIuvrwIOoI/1t+jw66a5B78CufrTekxOL9tW
         S0Uprpd6FZZdrU+p4mUPyvwbbZ98t8dRSQLfJ+Br0Dt8oxEMbETW/A4jx4QL/nR9YpNm
         1ofb45mEwqPxVzhmX+Vhj3C9aSjVhGOGB3zAVdtA6LX7xtuyphciiNQu2H8Z5p9n1A0S
         9qoLTLK53iYtnd4FzfGby7dL4mNGLB9KFhBPK/PY77glgo7yVc7bixZN21jX1SbfBWPH
         I8bq6ad9TkI7kgwJ39L5kWa+2qhlgNhpvfbPtc+nuF5jAh5yNMFit3xGTCURVnQp5/Lb
         +66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G8y7N9RH4AZkGuy8f62RMTy9APWhxwa4QK5qc88GqXI=;
        b=G5LlAUg6qoA3RU6MUiAPZSluq8VNPSJOb/EaOsoApufMSgar1NQuY0LkodUF8u9fhH
         c2s7lROSofgSH4G/nvvQ1g8eexwEBRu+7A1rj991TH9/0qo1V53eYGTTtq7QmHbr4b+A
         sdZWJTpzhILtSAGCa+qu145eP0Un2ItE80PDpp3zAEIb+cwqgr7Lh3zuI0Ppk7vRKeCR
         iKxh6OIMfVJpnEluCK+6nGazA8/3RhgCNSrDN/fbDZO63zioNhsV+NSjZjPTFn37JM2Q
         xpJCA7GC7lGmifCb1RKJVRvFhZqsSqZQXsL41HAiGHHEpnLr5bkJTYzegpevsH8v4MZc
         UMwA==
X-Gm-Message-State: AOUpUlFBNOzGcdsQI+KuhtVLF47KGXuZGSNVvkuz6iErdHUYZ05tpUXo
        76zJBeUhjBTJvbrVhv9kPWw=
X-Google-Smtp-Source: AAOMgpeluSlSXdfteri0oN9jHZUS6F8SLSvLntvPQ8mgEEF6n+XG49KSuVyqOChNqvNe9rffP6uL7Q==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr4224804pge.248.1532657852447;
        Thu, 26 Jul 2018 19:17:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id y3-v6sm3364502pge.29.2018.07.26.19.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:17:32 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dmitry.torokhov@gmail.com, arvind.yadav.cs@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: misc: powermate: Replace GFP_ATOMIC with GFP_KERNEL in powermate_alloc_buffers()
Date:   Fri, 27 Jul 2018 10:17:23 +0800
Message-Id: <20180727021723.709-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powermate_alloc_buffers() is never called in atomic context.
It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/misc/powermate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 5c8c79623c87..e8de3aaf9f63 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -277,7 +277,7 @@ static int powermate_input_event(struct input_dev *dev, unsigned int type, unsig
 static int powermate_alloc_buffers(struct usb_device *udev, struct powermate_device *pm)
 {
 	pm->data = usb_alloc_coherent(udev, POWERMATE_PAYLOAD_SIZE_MAX,
-				      GFP_ATOMIC, &pm->data_dma);
+				      GFP_KERNEL, &pm->data_dma);
 	if (!pm->data)
 		return -1;
 
-- 
2.17.0

