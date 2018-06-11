Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dko6ICWOHlsofQAAmS7hNA
	; Mon, 11 Jun 2018 14:58:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74D06607A4; Mon, 11 Jun 2018 14:58:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F30860351;
	Mon, 11 Jun 2018 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F30860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbeFKO6m (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:58:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33328 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeFKO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:58:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so6409062ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 07:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3WNyY+2Seh6M5aQ+SvVyMVdf6SBv3d5jFZOEpDJ+Sp0=;
        b=kiKhQwKM32XV/kodCkVuuUC7OaNQR0O+nFSDX6DJBEboYHJHTYZrJgySMntP3osDch
         5/ct/YMtTtbt2ZweCst+6hPFSjtq7ajZBs1b9hVZpkJk0qinO1xsdW7kuDpGwfiyBp6z
         N9IvRoYM0axgckxjoIIBrLwKk9uADTAkpqNj7+S5Bg7CMjMVMSPf23uk9HLMiPuQaHEV
         eVk/pGPrOk6SeceAbgQfGk7V+P/duvbS8eiqLpNZUImtUW1pcQWO8VA77dnQnrOdGB9x
         gOjBjglchJsfvVCfsHdY8xy37jHOz9sH6UPAH9JBUCtT+8TfkcwWPshZ68HbD3X7gApI
         wV6w==
X-Gm-Message-State: APt69E3TMkMI8zLuV3rA/AVtehRx4kqmUQ+9c5vtOaElNj7WXUsYFTSa
        xBkHD7llqJOrJwyPg1Khzg==
X-Google-Smtp-Source: ADUXVKLTfhazk5mAO3RPW2WnRZJrvY1f30LEsds+MUzrbNH5cPEB4p3tx+HH+0kT1svk4N3Xxv7YKg==
X-Received: by 2002:a81:3050:: with SMTP id w77-v6mr9820500yww.88.1528729120564;
        Mon, 11 Jun 2018 07:58:40 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id u11-v6sm14500297ywc.77.2018.06.11.07.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 07:58:39 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH] microblaze: heartbeat: fix missing prom.h include
Date: Mon, 11 Jun 2018 08:58:36 -0600
Message-Id: <20180611145836.21128-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 96f0e6fcc9ad ("microblaze: remove redundant early_printk
support") prom.h was removed and one instance in heartbeat.c remained.
Include of.h as it is the actual header needed.

Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/microblaze/kernel/heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/heartbeat.c b/arch/microblaze/kernel/heartbeat.c
index 2022130139d2..87aa942eee8c 100644
--- a/arch/microblaze/kernel/heartbeat.c
+++ b/arch/microblaze/kernel/heartbeat.c
@@ -11,10 +11,10 @@
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
-#include <asm/prom.h>
 
 static unsigned int base_addr;
 
-- 
2.17.1
