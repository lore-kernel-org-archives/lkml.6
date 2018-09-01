Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E40C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DBA20846
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA2bXdQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DBA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeIAQ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:28:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIAQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:28:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so6688673pfi.10;
        Sat, 01 Sep 2018 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AJBeg9WRcLJYFY2Ld2vmbpJxEP9YdFQye7oGciWd3nU=;
        b=dA2bXdQkCF+QknqavyZ5iAZRXtNAqJhZaWmE2/WdyhHP5+0QoDJgRDobkYVLJux+YK
         /O7+ur5ViE/Du5IKB4QnkF7zcjMIXMwkduNu765NCGuX+x3ObLl7PWiWRodslFHo8nSX
         o/vBEQpQEAeAgP3z9W193Yd/r8dfhvbE01XWEoLXIoKF/14vPQ97IvNJAao6aSNTuWPO
         tCHR5Ood7n/7t6TzHB0wx4ybqBYY9TjDnuXqHvfbI3CbuNTcE7oh/mjSLcNkyLahKPsb
         laiVR0SUm241WQy3BKmfiSfJ70awTmgH2iuTL9y06Y3Zt9G/OrGsW6lX0AwGG7GbVZ0K
         2XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AJBeg9WRcLJYFY2Ld2vmbpJxEP9YdFQye7oGciWd3nU=;
        b=Fr18YUTHpPPsFMcRnBo7cpVEVx0cjoXdePQxENX4OjHAPAbb5CqU53mxBcDzEXTWWl
         hLZW1uj0ImpWi057MfdOF8uTQPRvZJqwHB7yTAV3uyIizYNJQIjXpcYO0/y6OaVxwQ3p
         /ero25LJ0u2ETylzSKNyAcvJ5WuK59nEL0c00D7XAJzlbg6Q83/MKTWiZGI0tMQFKMh8
         m/AemSoDcza37Z5zhRXlX9eWvy2SmthmAPd2FQU9visSiOxZlAw8hPeDiaj5a3f3w4Pm
         3gCJ0/gqdmimwNHL2PzhKEZtfpWb3EVirrILznIaURaOEbFmtds39EGXMFVe26SsVQCw
         fR1g==
X-Gm-Message-State: APzg51AiC8AFZ0qAmeq0oFuSMz98Zbc5Vyga6TwW0zaypsGOJQbwYAA/
        jfweZsu6D1y5cSuPz1FxvS0=
X-Google-Smtp-Source: ANB0VdY9CptP5Y94eVEraGvo98B6/opiF3ExcbFRMmVgzvwy9hx73k62ac2ayvxdqRgisiUeik22Cw==
X-Received: by 2002:a63:e443:: with SMTP id i3-v6mr18798287pgk.381.1535804226870;
        Sat, 01 Sep 2018 05:17:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id 77-v6sm18758369pga.40.2018.09.01.05.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:17:06 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] hid: hid-core: Fix a sleep-in-atomic-context bug in __hid_request()
Date:   Sat,  1 Sep 2018 20:16:59 +0800
Message-Id: <20180901121659.1257-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-picolcd_core.c, 111: 
	hid_hw_request in picolcd_send_and_wait
drivers/hid/hid-picolcd_core.c, 100: 
	_raw_spin_lock_irqsave in picolcd_send_and_wait

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-picolcd_core.c, 245: 
	hid_hw_request in picolcd_reset
drivers/hid/hid-picolcd_core.c, 235: 
	_raw_spin_lock_irqsave in picolcd_reset

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-picolcd_fb.c, 215: 
	hid_hw_request in picolcd_fb_reset
drivers/hid/hid-picolcd_fb.c, 206: 
	_raw_spin_lock_irqsave in picolcd_fb_reset

[FUNC] hid_alloc_report_buf(GFP_KERNEL)
drivers/hid/hid-core.c, 1435: 
	hid_alloc_report_buf in __hid_request
./include/linux/hid.h, 1023: 
	__hid_request in hid_hw_request
drivers/hid/hid-lg4ff.c, 465: 
	hid_hw_request in lg4ff_play
drivers/hid/hid-lg4ff.c, 441: 
	_raw_spin_lock_irqsave in lg4ff_play

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3942ee61bd1c..c886af00c8c9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1442,7 +1442,7 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
 	int ret;
 	u32 len;
 
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	buf = hid_alloc_report_buf(report, GFP_ATOMIC);
 	if (!buf)
 		return;
 
-- 
2.17.0

