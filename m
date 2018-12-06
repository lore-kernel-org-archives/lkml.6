Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A74DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A2320989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itLsYDix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A2320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeLFHbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:31:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40408 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeLFHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:31:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so10245095pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eq5c2aoTlNEBR4vdJDWHcTDFFsOiMSh4dwP893bAFFA=;
        b=itLsYDixH1lxNOkZCJZU3ssPt76bbfN2Gf9zw/9e5hCowL668OI9eUmNB1IgFaM7hV
         YFdvv7WqujooxOrUiAT08WsSJl4kjJUm7ddwMpx7vK41IwXKaK70vwo/BQptTNXordMz
         oSvFfB/1pwRSnFUvLk6PWVrdUXJipOcJ8qILaYaIqZeFyD+0nFsC3P2/IfoJ3O430rkv
         0slHeOMlvndyYABf5X8pEbmG9HD7mb280OagMGGqYNsSjh/XfuQU9kpgZNG/Kl8WSjE8
         C5ukhJxE1t6ExkFS1LTTrc4n940XysL2t1DD1qMXLfyGGO7lLg9H/PXnVwZHPouAZzMj
         9qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eq5c2aoTlNEBR4vdJDWHcTDFFsOiMSh4dwP893bAFFA=;
        b=lsRbrVHh9Lau0+qEz+zCIHce9UzGKP3/WFwPBL5PsC3i9L1ss1GQ8/2RNrxDaC7rS/
         zZP3l8AeyCBnIukqfRr1JEoVI9Pz9LRdQWVTZHbDgpCQ/id1y+qB2Gc9Qm27ovoKt547
         NWPMWSxcUthM6ToteLt/4++i76uo++sKnOizeqvsBrS3Y6jhVey+P1o91o6AJi3j+S/O
         iCS9pYO1NZqynuafa3Y8lCTJ4PQjUKiI1PeofjJmjFC6/9Og5q6kT75llzOCifF5xVGo
         N8EZLXDh1aumcSIf6GH6PLtHwqeCkXMOiXcC+0l2n2gek/Ta9RzWxi1rQP92EvqTZBJ3
         O08g==
X-Gm-Message-State: AA+aEWY5COOjn9R2r4u728kadjzrqWvptIo9J9USNX3iJphFqhRgcnJ/
        OkmN4YbpdZFOew6rnyeFPs4=
X-Google-Smtp-Source: AFSGD/Vk71MzVErNZdxcJxTjtnNjqD0bf7umupJNTUU4aNmsA8EAsnQs0mAlf+qvLO7QVbF8ANsf2A==
X-Received: by 2002:a65:57cb:: with SMTP id q11mr23293739pgr.60.1544081504614;
        Wed, 05 Dec 2018 23:31:44 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:31:43 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] irqchip/irq-imx-gpcv2: Remove unused code
Date:   Wed,  5 Dec 2018 23:31:21 -0800
Message-Id: <20181206073125.7255-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Varaible 'reg' in imx_gpcv2_irq_set_wake() has no users. Remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4760307ab43f..cbed00319315 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -73,11 +73,9 @@ static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct gpcv2_irqchip_data *cd = d->chip_data;
 	unsigned int idx = d->hwirq / 32;
 	unsigned long flags;
-	void __iomem *reg;
 	u32 mask, val;
 
 	raw_spin_lock_irqsave(&cd->rlock, flags);
-	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
 	mask = 1 << d->hwirq % 32;
 	val = cd->wakeup_sources[idx];
 
-- 
2.19.1

