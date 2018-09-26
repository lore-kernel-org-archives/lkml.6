Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C3A2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABba2hD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C3A2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeI0EFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:05:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38681 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id u197-v6so450916oif.5;
        Wed, 26 Sep 2018 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ed58DK0mq/CUN9d7m32fybQoY77oD7EopNvBZHOohQ4=;
        b=ABba2hD+zc/82Pi5dsdiP13p6acwCbl/L187+mbGVE0Ed3f8Wp+Ee/5Aa2YzL/xYnm
         42LHSQV7d7anAki2l/R+7sxVc31mTaNGeczxi9CVCVRrQU/lXMEEiBY/GunoYmO2Zvv0
         b103leJHXWh4qypJHEsO3v5DI3EljGe9M9YNYWBJFeECChhGu+z/SNPcHrjDnXO9msxC
         r5bt8nWPM9YGSB1Y5xEGlzaU3zDWa9EZSPnTGxH12dXIf/4vLJXho/+R2sNdlqFKofJI
         SE05ZhWinyynBvJRHkh1Xoz8oOdaR4PKfM3T3tKUE2EP9RXzxWysqjxHUFFJF0R4L6iz
         AUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ed58DK0mq/CUN9d7m32fybQoY77oD7EopNvBZHOohQ4=;
        b=HcdGnMoJ15mrXIbf5EZk3dKBmeInrGCHYbYqkIerBJ2Fdzjou9ikjatmgIGQnTFK2C
         +sit5IVkv49WYpVRoPCzfykhgGSkVWcB+4YcvPC2iT77TfXzaT2Wlckohj9vLz8JE3eR
         CPCasA7M6nea89DSQTa1F1mfKgiiEJbRCDTX3OIO6QVcZWPj4s3lRfL/bc4/Ya+JlGNh
         NPv5GXJgMaSMu2luIdJKPjyoRmRICJiupRhAMwZaQzJFNfeays2yLwTH2ufpGKrOJmao
         klelkw/eFvyjbhjAHuqDU0nIm4wo5ktaVm5lS9SQo1alvTl0wgXKJ30P7NB1aDsN4AU3
         DQmw==
X-Gm-Message-State: ABuFfogAVoeWGeJLKvRBnf1B078scYXkhdk2G+IfjxfDfDxLSF0QU/L5
        +mYDMwwd44oG/kDwuUiuepI=
X-Google-Smtp-Source: ACcGV62gOBpcnQUjm+vIyswAu33T4lndsVJpOKuSu1GpDEaNw2CwKkBJEAEnUHMGBokB35Lenk0q7Q==
X-Received: by 2002:aca:a5b:: with SMTP id 88-v6mr1869650oik.324.1537998637064;
        Wed, 26 Sep 2018 14:50:37 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b124-v6sm95121oii.14.2018.09.26.14.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:50:36 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Doug Warzecha <Douglas_Warzecha@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 1/5] firmware: dell_rbu: Make payload memory uncachable
Date:   Wed, 26 Sep 2018 16:50:17 -0500
Message-Id: <20180926215021.30471-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
References: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dell_rbu driver takes firmware update payloads and puts them in memory so
the system BIOS can find them after a reboot.  This sometimes fails (though
rarely), because the memory containing the payload is in the CPU cache but
never gets written back to main memory before the system is rebooted (CPU
cache contents are lost on reboot).

With this patch, the payload memory will be changed to uncachable to ensure
that the payload is actually in main memory before the system is rebooted.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
This patch has been discussed previously, see history at
https://patchwork.kernel.org/patch/10512079/

 drivers/firmware/dell_rbu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index fb8af5cb7c9b..ccefa84f7305 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
+#include <asm/set_memory.h>
 
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
@@ -181,6 +182,11 @@ static int create_packet(void *data, size_t length)
 			packet_data_temp_buf = NULL;
 		}
 	}
+	/*
+	 * set to uncachable or it may never get written back before reboot
+	 */
+	set_memory_uc((unsigned long)packet_data_temp_buf, 1 << ordernum);
+
 	spin_lock(&rbu_data.lock);
 
 	newpacket->data = packet_data_temp_buf;
@@ -349,6 +355,8 @@ static void packet_empty_list(void)
 		 * to make sure there are no stale RBU packets left in memory
 		 */
 		memset(newpacket->data, 0, rbu_data.packetsize);
+		set_memory_wb((unsigned long)newpacket->data,
+			1 << newpacket->ordernum);
 		free_pages((unsigned long) newpacket->data,
 			newpacket->ordernum);
 		kfree(newpacket);
-- 
2.19.0

