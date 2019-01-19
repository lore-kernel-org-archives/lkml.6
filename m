Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03843C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D8D205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHURv9bR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfASQE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:04:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46540 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfASQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:04:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so7705217ply.13;
        Sat, 19 Jan 2019 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bk6YHkrN79KBpYNbpyXdgU6SAl9H9FvkZ8RPpWBaXoc=;
        b=cHURv9bRxV5tw6yiYEZVDPyXgY8/D1JnFN5o2x1izlHLVatjhcHNRDzovkBMeAWn3C
         RTN5voEfFW2cSYGAKNu5l2ZU7ZmxR5E/Bl63+4gFmBfp7gzF5AyD9WFh1RiavD452KXm
         bEDch521E5/DKkPD4MLq38nbuySbNiyqHeJ4JxWuLBpHb4J5hvaLpfmo7Z9Rs+VSBwOq
         1St3jArvHLaeUpZTSPNFELEMa4x/4xxHQ9baGwlXP+RsAEC8bBmPMV0nJUMx8A+W0qkA
         lz7aWYlGpDCahoYj2qao6tR2FwTYNcsbQrclrRTXz9yeQo4th9qtTbj5Kp8FEFP4OnPX
         4g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bk6YHkrN79KBpYNbpyXdgU6SAl9H9FvkZ8RPpWBaXoc=;
        b=qS+MFbBL07hs4fChOQNOugMs2GILtsMLKWyiFpAbWd2Ro7hTLayOYlXp2kziWpaOC6
         uVrvXGgjfVW33IxzBIFpWYNp2uDW0YLbkGcmZnF6ASn3mhxnCJ2kHqkT1W41kaaI8Vdq
         FfOoppquVR5QbQch0GavZqPHLUnJ5E/dwlRhUGJ9xY6W8I73ipeU7dqoetYYgMh/ECCN
         KyUA7AX8nIFxALfSS0srXLqjSw/RlTHnGEvjctCI3v0ZsPSKKyonyp+1zwUIruagz7gI
         GbfqfG8TwjvRzVzisbuF5Hf6L8rSyzQ750xIc1bJFTzN0xqNk5tOP1MAPRzEWZPwrS/f
         iFYA==
X-Gm-Message-State: AJcUukdeanCNfTunDyg42dydlvLn/GzWKxK4k95KXZGH8/RrAx+LhEBo
        YnjOuFf9oisyYbV+lR3ULBPvP3W++Mg=
X-Google-Smtp-Source: ALg8bN5/v1jCf1u0G83SGMUAYE/quYBbHY6Kz53/VsPjL7IM41c4La1qm0zOqWO4HAzfzwYI+/+vOA==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr23585839pls.5.1547913898261;
        Sat, 19 Jan 2019 08:04:58 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q1sm10908798pfb.96.2019.01.19.08.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 08:04:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/3] PM / devfreq: fix indentation in devfreq_add_device()
Date:   Sat, 19 Jan 2019 11:04:52 -0500
Message-Id: <20190119160454.23151-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To beautify the code format.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..076b1c2f40a4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -683,16 +683,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =
-		devm_kzalloc(&devfreq->dev,
-			     array3_size(sizeof(unsigned int),
-					 devfreq->profile->max_state,
-					 devfreq->profile->max_state),
-			     GFP_KERNEL);
+	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+					    array3_size(sizeof(unsigned int),
+					    devfreq->profile->max_state,
+					    devfreq->profile->max_state),
+					    GFP_KERNEL);
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-						devfreq->profile->max_state,
-						sizeof(unsigned long),
-						GFP_KERNEL);
+					      devfreq->profile->max_state,
+					      sizeof(unsigned long),
+					      GFP_KERNEL);
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
-- 
2.17.0

