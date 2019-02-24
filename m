Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ABC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 07:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81C82063F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 07:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPutkt5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfBXHLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:11:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37519 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfBXHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 02:11:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so3024253pll.4;
        Sat, 23 Feb 2019 23:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PmIjXNwqDiVD9Di9IY3LxUQOpYelhQ/Ozybq8tQF2HY=;
        b=DPutkt5x+UcE0WyopFqOVr9FuwDM3EFQe9oWnaTG0MLF5MxmDR9l3R5VjyG+L5phy6
         8nUvpsrPHaKUkDQBmUOVtOLEWyAXGJOohBg/nbh3p4cumT6C7jzIWWaROxFHi4mDIaGd
         RxIe7nMEhzw8/4jL2ouRd8L6nfdz+wf3tOKKX3XqRuYKFHddFYhVj+gPJsEpvJ55eWmp
         VifgV/7AVgZp3MYECew+wj51cMg7MXJAcdex2tZWF5t5ZUs6iN5KDA6UdV2hu2fQa8r1
         FxCddT4aPz+fT7QW01mszORM7ZX7nJo5zQqV0Iiklh/8prQ9khbxkE6EIgv6AcUu7uU5
         QGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PmIjXNwqDiVD9Di9IY3LxUQOpYelhQ/Ozybq8tQF2HY=;
        b=sLIsRUVhiLNL2mDQt1gAi6Xl+PvBj9LT8IWc/rPllOHujMSmc4QnAb1IYTA5a/i6u7
         XCI9naBrjrB7J8+lZtoEeku3+hIKonFi5MKr8e+BCNBqFaXJzUGkWzEwpW6Bz4oDsnO9
         ZlMVmfG3xIUF66kHJUqXB1otHWO5+MytoojLCthKAj+ItqNow6qfd/VNO8OKiR8HY4jD
         JMNU4XOSem4VdCNH4ZfRhqF3S+sFt5w7XElpskKDCCBatDPHGb/NI5W6f3JYX2V8/hxf
         95/SQpXvoIcVJpwOlwUF4KTclXKnhf7DR11SY2vSrCu3OJoJPJmIO0+f9m0UhPr2XTDg
         6o6A==
X-Gm-Message-State: AHQUAuZ6/Gx+LNUiUKnN909d+9neXIjCxTnngupSc2mWR+HKug/nS60k
        0BSiJmby8GztZ3Bi71BPEWlEuLtCeLg=
X-Google-Smtp-Source: AHgI3IbdJOPu9jq6Uk+EJvxOBuoW/LGySfpsMbL5m6Bu4bhccuISZ/tKyolSU5ub9535SeTojCX7UA==
X-Received: by 2002:a17:902:44c:: with SMTP id 70mr12807872ple.318.1550992264360;
        Sat, 23 Feb 2019 23:11:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m9sm10600480pfi.31.2019.02.23.23.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 23:11:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] of: thermal: Improve print information
Date:   Sun, 24 Feb 2019 02:10:58 -0500
Message-Id: <20190224071058.18329-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pr_fmt macro to add a prefix to the message,
this can make the thermal log better recognized.

Before:

[    0.602672] nfc: nfc_init: NFC Core ver 0.1
[    0.602828] NET: Registered protocol family 39
[    0.603435] clocksource: Switched to clocksource mct-frc
[    0.746216] failed to build thermal zone cpu-thermal: -22
[    0.746451] NET: Registered protocol family 2

After:

[    0.602804] NET: Registered protocol family 39
[    0.603463] clocksource: Switched to clocksource mct-frc
[    0.746309] thermal_sys: failed to build thermal zone cpu-thermal: -22
[    0.746545] NET: Registered protocol family 2

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/of-thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..02b5e78f027b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -5,6 +5,9 @@
  *  Copyright (C) 2013 Texas Instruments
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/thermal.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-- 
2.17.0

