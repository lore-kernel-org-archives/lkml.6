Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D984ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF25520825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8Sy9EQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF25520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKIBsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:48:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44047 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeKIBsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:48:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so9729575plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6NvzHZ7aTTzZqQ8Y2qRhwsNPKM8vK4b5mjsiG+4Wp4A=;
        b=R8Sy9EQ3Y++HqxhXPqGEsKCCPqjo4b5fS6lt1Lf44QO2MYrj+uUkkxGR1AtzrvTKi5
         Im4GioXLQcSOZZhmt2BJTxP/mZ8LqGnAEDpB4WDjDOCiMF9Akcb0hbIR7NHfT+hXvhOn
         +NzOH5PiC9ja86C1DcvOjR6YEaekSiX10RTXaXcQxHyWPc6DBPUbQRO59ktFDPpljnni
         pLSm/WNfIaA9EZ6Euh90x1L2YBkrD/tSoM1CSc0NiK0yKDo9owpXjj2F3PsEbXAtf850
         /znIFvX1XqQxp/S34XIWFpWLB7WjgKjsrlElYfUAqrqTr7hvmhJZmh9ejiRA7dI3w+xm
         8miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6NvzHZ7aTTzZqQ8Y2qRhwsNPKM8vK4b5mjsiG+4Wp4A=;
        b=fRGmqh9zrqzXaiuZvFhYqquRHXlY9u7wVhWpCa+6cwuxE1kcTg0l/tibdMRiM9B8iR
         Ip4WgiQ7Zaf7LUdV4i/hpfJRm3sxxDA7J62lOZBqMW7+iP2oSwVOmjWa1vzBHRZYn51/
         UUVigYspHUjVPzU1Rw6iPRoncUCyN5rdbFOptTHbhDQk2cTGGY7szrrW8XvDUT5oEWfx
         aaYR+f1K2I1HOuwx3QPIDmR0o+qYstLUAQrT0jr9A01CSl93fXdg8DsM5PK77EYc0jr1
         L+MRnvkjNJna737+LelGUK3z17NZpSvuz1rnlTsCSKBJ0ZHE3dYwekk3ZR8EwifS/Xe0
         bUnA==
X-Gm-Message-State: AGRZ1gI83UxcO2xYn5AwP4kU4zNzNV+7P7DOYD4IGxEwV6JIvxqcmkc0
        boyE1R/pVKCvUeiFpKrsRMs=
X-Google-Smtp-Source: AJdET5ea3Fo7/b4Kn26CdLcugPWdTX9hZN64ZoSsu2j5lXKqD8ZUTF23xILcm1FY4LxFNbk+3HcUdg==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6-v6mr5158677plq.31.1541693516900;
        Thu, 08 Nov 2018 08:11:56 -0800 (PST)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id p82-v6sm5112387pfa.47.2018.11.08.08.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:11:56 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Make capacity_margin static
Date:   Fri,  9 Nov 2018 00:11:40 +0800
Message-Id: <20181108161140.51036-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable capacity_margin local to the source and do not
need to be in global scope, so make it static.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 340a2d8d49cb..f622fc858d7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -116,7 +116,7 @@ unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
  *
  * (default: ~20%)
  */
-unsigned int capacity_margin				= 1280;
+static unsigned int capacity_margin			= 1280;
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
-- 
2.17.1

