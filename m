Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E968C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991C2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPP1QGWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJZCoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:44:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJZCoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:44:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so2489109wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lp/ggYCV1jr9KpgGQVrAqczAG346LMz0SpCFm0bs1EQ=;
        b=PPP1QGWmRXijA4JApHN5W8asoiJONMCcY0VBUp/2YLgzcxAm3vieEfPnijvkHWGXaS
         UsDnJKF1BBDnaAi/0U9NIlyXrWBMb7bvlFv5kkN8jLBMbwfBC4oOP8caNvnVcGi/FfIm
         XIcJEOpv5NkRQQcubpExSnj995vupH/CWyo0fmeuqr+wCTdosG7wAsff8PiQSQuhoJA2
         OHIzPdWirzO6mXyCR5yYnwfBP/fccCnOKeT1kxa/YZ2SwvOWYL8TF6lXM97pu2v2sPDJ
         EU06sdw7AX0Ue0jXiIsEItvmVUtZ889AgJnAuqiDfTOeQO7YGTThv9oFIM6XXkVpX8hR
         PpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lp/ggYCV1jr9KpgGQVrAqczAG346LMz0SpCFm0bs1EQ=;
        b=bkzxee9U7hYJRobBimLdco++S+2VMZ4YmcvxaFVDuegLFMZuOSBoktX+svON/RpJt9
         J3EAK7de/zAOs2xtfDwjQDlRo4+CUDzse+DiMUXLHcbDNbvW6VBtuEU7q22JHhFgiHXw
         iHSgifYXFSwClfGm83Wt2/jiIrtSH72eepqtE9rJc5HRtaa8IYw00n8+aKjEk7U9fW96
         F12q8dBaI+MGLda5/UO/FQmSbpyzFsMOzkXjQeHGjV4JkEEuLwF/sGKHt70Q4Zy2afXF
         mfxeD++mKzrABA+dC55oBlaSEtKs2a3LOVLaT8lPMByX43b27+/EjH1JCHm0+srTwGU7
         KbVg==
X-Gm-Message-State: AGRZ1gLi25NTMy9Yc7M1L7B2PVRU9gMhb4lPhpRgaMyUkRf2n8t8d4MW
        sfbn3dFzH9UqjaklKAEY832ZkoRe
X-Google-Smtp-Source: AJdET5fopElO/mQ9FVw/sgjAp4nqvW4/VzD0ARro6u6ATV5GZfsZo6vR94amr6oX+gWnp8PgL2d2yw==
X-Received: by 2002:a1c:3c82:: with SMTP id j124-v6mr2131321wma.62.1540491024159;
        Thu, 25 Oct 2018 11:10:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id m136-v6sm2432291wmb.4.2018.10.25.11.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:10:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tony Lindgren <tony@atomide.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS disabled
Date:   Thu, 25 Oct 2018 11:09:55 -0700
Message-Id: <20181025180957.7900-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some software such as perf makes unconditional use of the special
[vectors] page which is only provided when CONFIG_KUSER_HELPERS is
enabled in the kernel.

Facilitate the debugging of such situations by printing a debug message
to the kernel log showing the task name and the faulting address.

Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/fault.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f4ea4c62c613..f17471fbc1c4 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		show_regs(regs);
 	}
 #endif
+#ifndef CONFIG_KUSER_HELPERS
+	if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
+		printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
+		       tsk->comm, addr);
+#endif
 
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
-- 
2.17.1

