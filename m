Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fJRqGqe2GVtHdwAAmS7hNA
	; Thu, 07 Jun 2018 22:58:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8EDC96074D; Thu,  7 Jun 2018 22:58:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNOXji2R"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B97C601C3;
	Thu,  7 Jun 2018 22:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B97C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeFGW6v (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:58:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51824 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeFGW6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:58:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so127861wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 15:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v+KyweH6c0/5uR+9bkbPp68i2b0syMYrgorFm5gYS1E=;
        b=DNOXji2RCcCk8AWz91FvXOI+RVuNH++7f9DMiyxpP+hl8YJsyEVRUzm6KSuTg/826i
         0RV5sdCbOMUZAafqdW7C3D0G2JjbHFwxPVN/M4phbAolpCKSoqCU5fvHWOR+NFyn3TJf
         MIVA5PekcAaEqXTt6zE8p995DvfM6LrhNnO/a8hoQNCxWOb2t1e6Txq/zvixdSjGcqHf
         RUziheESv5LFVfwn4MoIhyTdNih3aAeKbB5P6fMf0LkiK2OScHoTW7rXO0mg9KW+r+5f
         fJAGksr7vIjud32aDO6EA1VplZoMOBT20qv5V/cXc5GkI4QwEpfKVOmjyqLoJZHS1gBw
         LWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v+KyweH6c0/5uR+9bkbPp68i2b0syMYrgorFm5gYS1E=;
        b=GjNUxJMkM/zGi7Y8ezk7DOlztqIUgi+qSFUZEXq37jdbnR9nbU1amOave0teG59KgZ
         cFeKXUyy5E1JY1VVPu8pC0Hu27T+Uqe3+Hs4i3XA7PeVCppDMK2DMYv4zCBZqKz2gJrb
         2Akl7HLv1mLg972+0Q1OJQfyUYD2J04xnyEq+tI5cDBT13HJzQLpuj8LyzNFv4hOWiDe
         Bnd9i2Isve5AFSpAT2o17dfCfYRO3/UzJZWZ89SzDKyTkxyrYQMYROLgUCXu+wFcnFn+
         Rttx7mabAUAW536T7WR+meRCMEgwou/8WgEEXR85LcxbmwRVvYGWpj5ZNEd2uQl2bY8L
         QBmw==
X-Gm-Message-State: APt69E0Iix28pXUGmVazr8t9/SRbuPB5PgQeLy1Bo5RqYTFefAv/OoSP
        IQsgcIbcuxvuIJFXoA9lu7H6caH1
X-Google-Smtp-Source: ADUXVKJwohLx7IwSwx+PCKGRCzCU8fdTjJGb8AePoehAJ4X/Je1ykgfvvDEpFdOgFYr+Rjdj9fK7HQ==
X-Received: by 2002:a50:a5ec:: with SMTP id b41-v6mr4314330edc.147.1528412329421;
        Thu, 07 Jun 2018 15:58:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g30-v6sm4195716edb.5.2018.06.07.15.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 15:58:48 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marc.zyngier@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Luca Scalabrino <luca.scalabrino@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: spectre-v2: Try to set IBE bit for Cortex-A15 and Brahma-B15
Date: Thu,  7 Jun 2018 15:58:02 -0700
Message-Id: <20180607225804.28771-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the ARM reference manual for the Cortex-A15, The ACTLR:

 Is a read/write register.

 Common to the Secure and Non-secure states.

 Is only accessible from PL1 or higher, with access rights that depend
 on the mode:

    * Read/write in Secure PL1 modes.

    * Read-only and write-ignored in Non-secure PL1 and PL2 modes
      if NSACR.NS_SMP is 0.

    * Read/write in Non-secure PL1 and PL2 modes if NSACR.NS_SMP
      is 1. In this case, all bits are write-ignored except for the SMP bit.

We can attempt to set this bit from within the kernel, which helps
avoiding firmware side modifications to set the IBE bit when that is
impractical. We do this within __v7_ca15mp_setup and __v7_b15mp_setup
because by then we already took those labels because the processors we
run on do match.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/proc-v7.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6fe52819e014..a21cf3729efa 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -284,10 +284,16 @@ __v7_cr8mp_setup:
 	b	1f
 __v7_ca7mp_setup:
 __v7_ca12mp_setup:
+	b	2f
 __v7_ca15mp_setup:
 __v7_b15mp_setup:
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	mrc	p15, 0, r0, c1, c0, 1
+	orr	r0, r0, #1			@ Enable IBE bit
+	mcr	p15, 0, r0, c1, c0, 1
+#endif
 __v7_ca17mp_setup:
-	mov	r10, #0
+2:	mov	r10, #0
 1:	adr	r0, __v7_setup_stack_ptr
 	ldr	r12, [r0]
 	add	r12, r12, r0			@ the local stack
-- 
2.14.1
