Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F0C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E25620869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRtUdEHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E25620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeIHO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:29:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeIHO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:29:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so17148411wrc.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tp4C1yWWvB+8ko/eDTyTNS3saAJMERwxTlp8QikV5sE=;
        b=YRtUdEHkANcX8yk2rah+gf3JzAqVPcsEtNdhCIiuJV8GiVVCzIpj5OVZ3VcuviTPH6
         AqfAMZDFtfSNLCGj6GVkXQYPGzS1mbvJN4Hmn5qq42XTBng0H9o8iZxOkPEztAfo/TVU
         ehJYDj178eNY7XTXYzoaumy4Ws/Rplbsm0wJ0E3b3vcw58XkhhNSI6OX5ZYz0C0PNuRG
         ZqwmpekBSIiT4hCsLD2T60phNkVz4QG0rWnb9YMlK+1zcuzBlf5Pb5aIREeSveoSbRrA
         OhpfbLPjcFatfJaP63b//Z35wkxJ32lh9mTDWR4t2HpuIIfnbrSedxiRRsk+v67UO+Q5
         Szww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tp4C1yWWvB+8ko/eDTyTNS3saAJMERwxTlp8QikV5sE=;
        b=C+s+jITDqGkGBylEWEXtcxRcpy9VttQSWtqsIBlvu1qS6nvNmtNyne8HzqPg5/HMTo
         WoxBj48yut2PfjiHb4hhw8ln+gFPt4onu3j3J2esDGs3L+3rnUgApv+dWlDLCoIMsbqM
         ttkljUS4rUh3uiCAX7IhfZLl4rGNRzl86CZr2woB72W9a0iAtepmFuAIedTHKvrvH3cc
         +8C4j7KbGbQZ280vJgXvgMyZibKB4WeQzE9PUyMiRqWBg4fx5rRxFM20fP0BMEJLO0Qn
         IqY+Geb09YsDvL6T7y8HiG6Yzrue/AnF/ItnlsbYs0hfFjq+L/JUOEg9teh1EFSC/XB0
         YhsQ==
X-Gm-Message-State: APzg51Dfkmtz3wYuUNlKcZjQ57kZlCpsGjfn6va3smUuXofUQwAr+d/8
        dE8IFprHD8t0yMZyPjRMQKpRZl7F
X-Google-Smtp-Source: ANB0VdZfeaywSsFktf5rlFJpKCB/LGYbZkhsI358QSo2YiYWcKTegEfUjHB84fWBk2X/I5BDXk00jA==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr8919650wrm.213.1536399860464;
        Sat, 08 Sep 2018 02:44:20 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id t132-v6sm13975018wmf.24.2018.09.08.02.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 02:44:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 4/4] staging:rtl8192u: Remove typedef from enum opt_rst_type_e - Style
Date:   Sat,  8 Sep 2018 10:44:09 +0100
Message-Id: <20180908094409.4043-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908094409.4043-1-johnfwhitmore@gmail.com>
References: <20180908094409.4043-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef directive from enumerated type opt_rst_type_e,
this change clears the checkpatch issue with defining new types in
the code.

This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_firmware.c | 2 +-
 drivers/staging/rtl8192u/r819xU_firmware.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/rtl8192u/r819xU_firmware.c
index 15fd026638fe..c3ea906f3af3 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -208,7 +208,7 @@ bool init_firmware(struct net_device *dev)
 	u32			file_length = 0;
 	u8			*mapped_file = NULL;
 	u32			init_step = 0;
-	opt_rst_type_e	rst_opt = OPT_SYSTEM_RESET;
+	enum opt_rst_type_e	   rst_opt = OPT_SYSTEM_RESET;
 	enum firmware_init_step_e  starting_state = FW_INIT_STEP0_BOOT;
 
 	rt_firmware		*pfirmware = priv->pFirmware;
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.h b/drivers/staging/rtl8192u/r819xU_firmware.h
index 870301853480..b84344c1e62b 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.h
+++ b/drivers/staging/rtl8192u/r819xU_firmware.h
@@ -11,9 +11,9 @@ enum firmware_init_step_e {
 	FW_INIT_STEP2_DATA = 2,
 };
 
-typedef enum _opt_rst_type {
+enum opt_rst_type_e {
 	OPT_SYSTEM_RESET = 0,
 	OPT_FIRMWARE_RESET = 1,
-} opt_rst_type_e;
+};
 
 #endif
-- 
2.18.0

