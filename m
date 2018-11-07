Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0887C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15442086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15442086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeKHIEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:30 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35404 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeKHIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so15306687oif.2;
        Wed, 07 Nov 2018 14:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zk0fMcNWEybl0Qy11hZmnnvnababl/kcVrGBWS2p8z4=;
        b=K7Ge2aQIKW44y3tmtI00wPa504UzI0xd5ygNVsEUA5l3sJl9AWqFrML+bDK6Rl+1VA
         8DfHpt9RiLVpowtBaLT1rbN3abYKogNcsuCc8lWjuCcC9QOxtK44OQsibPEKQL7y8vUa
         qd1kfpiuadlsQHdOd2jqSsQGOcm3Qoh0jDtk5YPOu0bBTMGtHVd77xp7OA0HMi6LiajM
         oTF7j7R4JO7RwFGxs23b62MJc/S1RMkdTUy3q15esQ0lS32yGBWtOo1YGh3CQlkTQK0L
         1GAQTZLFNerspHhY3MCJQ5TABRcvJWjNsfQlsuNY/FCm9Ac2OFmbAQH/DdGoh21GxleI
         g8GA==
X-Gm-Message-State: AGRZ1gJZyiKa73UWpzSpVfeU3J+UBOV1kDmNaqyGbbvOEda4gVKmKDdP
        wONeehSi7ZpzoM3dzyVrWVnLrYU=
X-Google-Smtp-Source: AJdET5d1VbWsoyQim1rJLlrFYZNAXkLVLatLqVG8lTSAKMm5RQRLRuT2kWOS2avXz62xeKLDRzH+Eg==
X-Received: by 2002:aca:5842:: with SMTP id m63-v6mr1319644oib.162.1541629921419;
        Wed, 07 Nov 2018 14:32:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f9sm750959oth.17.2018.11.07.14.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:32:00 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 7/8] sparc: Remove unused leon_trans_init
Date:   Wed,  7 Nov 2018 16:31:50 -0600
Message-Id: <20181107223151.14991-8-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function leon_trans_init is unused. Remove it and save us from
figuring out what to do with a '<NULL>' node name.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/include/asm/leon.h   |  1 -
 arch/sparc/kernel/leon_kernel.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c68bb5b76e3d..8c01f0f6b1ed 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -225,7 +225,6 @@ void leon_update_virq_handling(unsigned int virq,
 			       irq_flow_handler_t flow_handler,
 			       const char *name, int do_ack);
 void leon_init_timers(void);
-void leon_trans_init(struct device_node *dp);
 void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 void init_leon(void);
 void poke_leonsparc(void);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 84b233752f28..39229940d725 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -484,20 +484,6 @@ static void leon_load_profile_irq(int cpu, unsigned int limit)
 {
 }
 
-void __init leon_trans_init(struct device_node *dp)
-{
-	if (strcmp(dp->type, "cpu") == 0 && strcmp(dp->name, "<NULL>") == 0) {
-		struct property *p;
-		p = of_find_property(dp, "mid", (void *)0);
-		if (p) {
-			int mid;
-			dp->name = prom_early_alloc(5 + 1);
-			memcpy(&mid, p->value, p->length);
-			sprintf((char *)dp->name, "cpu%.2d", mid);
-		}
-	}
-}
-
 #ifdef CONFIG_SMP
 void leon_clear_profile_irq(int cpu)
 {
-- 
2.19.1

