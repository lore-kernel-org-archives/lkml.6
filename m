Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAFD20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOJvpS3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAFD20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbeGWJ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:28:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39003 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeGWJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:28:03 -0400
Received: by mail-io0-f196.google.com with SMTP id o22-v6so13784223ioh.6;
        Mon, 23 Jul 2018 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B1vLM+8b8cA1zrmSIxmtAqNH2b+kVmXF94FZKEkF6OI=;
        b=YOJvpS3M1tShO3QyKcMvIJ+mncHiR5wKppnnD05PdXN8VC9BePGiFy3KvBCxD+PKqn
         KkjYkCHQwbzHzZANqBjZ43pOm9TD88WgjltienhiX5wqP15yHhkjdG639kZTJpqSs/8h
         417dCcKLT/dHfDHEICJU5x1yLHLElY1MEaVAbv0KEy7XzsdaOTsnJx3xYF/gpTKas4jM
         tU1TuuA3vkqCl0mJRe/zeaziITE7/ny6KjYranwoAZ4dNOXKe25l/fbhrJxrqOL/9lyp
         MJoeJDg4EpyWBh0FjeEirSKRuLfYOuOHpki/6sCwFRdO+oFzkHwFsWvXd/f2f/9SUtS7
         LmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1vLM+8b8cA1zrmSIxmtAqNH2b+kVmXF94FZKEkF6OI=;
        b=IoGbkU3HuLOjeGySLAYJlYMxLlH3Dh3LE0cr9LywDpRTkrP249WhHgaoyxzbRWR7JY
         p7vrPSJfpMCu/+cNiVAj7svsSLFrH3t8yE6CyUx84KdNjaBhs4YZKXV28J3GOaWwdH1y
         WjhephQlEL34IsE2OBnWg5JgKpW0u9+5GorK2GOkFP9dKx0lOeEyN3XrzE+wb95rrXuG
         KyQhdQrWnmu4h3Wc/dbg5/VFb9YnFMZlbvnfe/Q7cydtLavVrjNDViAPfYWYv2b1/EH+
         jPV56ErMHld+VpUn7+5X/qxjxzPQ7eKk4jW8FWqyMFwX54hxjq4E7rknL2d690/HfkLP
         sJwA==
X-Gm-Message-State: AOUpUlGfg0ln+ddZLhnZ8Hmv+OLwLCLaKN3Kzw0AtSI3GUM40ihnngPR
        7z15wg/wol/LHlg4LgCRHOI=
X-Google-Smtp-Source: AAOMgpd1I2MFIJ427h8+ojpyojXkpskQuJRhx7WlIfI78bWERwDTKqXlYCQ9A7q2AnjGhxR4n9MuyA==
X-Received: by 2002:a6b:580c:: with SMTP id m12-v6mr8703403iob.228.1532334480571;
        Mon, 23 Jul 2018 01:28:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id j6-v6sm2703969iog.39.2018.07.23.01.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:28:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] crypto: qat: adf_aer: Replace GFP_ATOMIC with GFP_KERNEL in adf_dev_aer_schedule_reset()
Date:   Mon, 23 Jul 2018 16:27:44 +0800
Message-Id: <20180723082744.25409-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adf_dev_aer_schedule_reset() is never called in atomic context, as it
calls wait_for_completion_timeout().

adf_dev_aer_schedule_reset() calls kzalloc() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/crypto/qat/qat_common/adf_aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index da8a2d3b5e9a..9225d060e18f 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -163,7 +163,7 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 		return 0;
 
 	set_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
-	reset_data = kzalloc(sizeof(*reset_data), GFP_ATOMIC);
+	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
 	if (!reset_data)
 		return -ENOMEM;
 	reset_data->accel_dev = accel_dev;
-- 
2.17.0

