Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723EC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DBC2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4xoQS4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DBC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeIMImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:42:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40306 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeIMImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:42:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so2003286pfi.7;
        Wed, 12 Sep 2018 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rV1GWKSW7XACWiwwVzeCEC8YfhT7pdyQ6PSWC3G+8SY=;
        b=C4xoQS4J6ra2hf8NG/HOVLUw1z7+FYk3v9JcfFu3DPUF5iqtplfSTBznLJnCBGRKLc
         NXq53ab7ZZXHlyRI+42sPJXNcP1AY9S4zXAygo7R9wL+q8VFNZIMYfEyJan7pSPQLEeS
         WHPrPbYPbK7tuhja60+Zm40YoYgS6knzVPPDCaaH7GTEqXOPPQvD264mAgkmtTGT+aer
         rrF3lvqL/68WxDNHdOj7LRcK6fWP1PGznbJk0xQl7omVij29MmQtnQUel4VKMDY9HNMC
         VXHzS5dghB5J5CmgajjdUJhJcZuaDe9K4/u3KgzPI0SH6OSpzIR/OvI1sfw/dYPPnjU7
         Fu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rV1GWKSW7XACWiwwVzeCEC8YfhT7pdyQ6PSWC3G+8SY=;
        b=dlbmcshjS2L7O2TzZ1EsMSnhzFUkmc7LWIK80ZiiEQXnwUMwe/PIhuQ2bA6t/Ck5WU
         +2inWLY6kt9RuJt0+DR801HBlUSMtL92tkp51eHndmXj28NciW+d20Cy3Njqu7PHbBQT
         JzxtOTXCa4AUJJ3frs3lHWjcvQ2iEDy+VzaoXwwK/LtkDi8XQdKxO1Hb8Yodhy4ToSi3
         DK4GTnU4F9MdAczmpFaM+LcdXdOW90oxk04zch/zyfz1LopG+7wVDKOAeMu0ZCANv0vt
         InPIMxB6NxRbVoOKM3u4fhHgG2bB0qORq5AmkPCbXudY6d2bAOPHZoRQj9kAoUoybLKJ
         wLTQ==
X-Gm-Message-State: APzg51BqnRR11scXvFc4QCOTBYijBPCVl9ndh0U9Q/oZ0pr4HiwPy+BD
        YwrItsfmrtobipDYbFWTNtw=
X-Google-Smtp-Source: ANB0VdZ9wXp0SEDC8CfOPuTSbRndr0gRPRqSCEQROh/XYZbP2niM7/sorCAvInYohv+1Z/n+LkmdVg==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr5126125pgj.15.1536809689739;
        Wed, 12 Sep 2018 20:34:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:68d1:35da:fac1:c83b])
        by smtp.gmail.com with ESMTPSA id y4-v6sm4095266pfn.123.2018.09.12.20.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 20:34:49 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in __hid_request()
Date:   Thu, 13 Sep 2018 11:34:32 +0800
Message-Id: <20180913033432.16336-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid_alloc_report_buf() has to be called with GFP_ATOMIC in 
__hid_request(), because there are the following callchains 
leading to __hid_request() being an atomic context:

picolcd_send_and_wait (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

picolcd_reset (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

lg4ff_play (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

lg4ff_set_autocenter_ffex (acquire a spinlock)
  hid_hw_request
    __hid_request
      hid_alloc_report_buf(GFP_KERNEL)

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Make the description more human readable.
  Thanks Jiri for good advice.
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

