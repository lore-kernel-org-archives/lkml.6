Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BBCC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE26120989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmedYPKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE26120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeLFHbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:31:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41339 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbeLFHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:31:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so11360240plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCmWZWkjSO04W3R6eoda+PMgnu8YZorR38g+0MPbFl8=;
        b=RmedYPKuJlzfD3dyoXNGvWBtT6Y4A8ljx+RuFnHVx2mbo8gp9JKeHVq7bOvMhhCTVS
         YBq1QAqWfZhsoDTmJJiteOB2kAgRku+AsinQTt++0ffT692exyA7wTuGyBDaPOFVW/J8
         qUbym03yFY8fQwIOXmug+Ek4WRfW3uh99lOJ0dP3To0RTiFn97l3IA4uL4NGr6hLCdQo
         p9YO6CnZe9M4XHlNoAsY//YexPMXjrYhz2fi+nLmxfn+1bRbzIbZk7riPbDRUmzuMSwY
         yYfS+hYV82VJr+nL00w6RTcIe214GRL1SsD33sZpxEzMNHdwNw8FOFc2P4vXoQ1fsEP5
         Zd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCmWZWkjSO04W3R6eoda+PMgnu8YZorR38g+0MPbFl8=;
        b=uB3WbEy4qeRBXVt7/mBqd3petkm7pGiaPO5etAXVToJIa59i97ueoM0mSBkrWcorDE
         pbUNXC2173SEhcBgbEWLPJm4mXc2nwpV25k/uUQ5HgHuJ5AOaHnQ3xWcEbpwnJ31/wv9
         x1kj5+ugi9qdw3tKcvtfdcn25V7HDAvVoxX4T7h5av75vmyjH41OT1p8jlfRQ9b/aw+5
         80NvzZmynB5HlsGGZoU2TAYfh/9ZAcwJ6wj69Py/pgswfcA0JFJ5zSCPqG3z0KpgeKCI
         RZ6HdB/ZGj6wbQi+69McB6QFnrn12xKiu9tApcPpMaadcRIDDJ/PhaD/HOVO1tGHfZQJ
         YI6A==
X-Gm-Message-State: AA+aEWbE2hUA9QXsaS++K7se/MmetxDqhOyNr8AnaPL+d3B8W3XJYkpE
        EwKm2z7L7mnCQ4cl88h8z1w=
X-Google-Smtp-Source: AFSGD/WPZiPGuSbiRx1Z/A9FzknRnytfLbknJnMhpsV5bjT90fCq/696T1qgUgdPDqlCKRPkx1CRhA==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr27379293plb.115.1544081508277;
        Wed, 05 Dec 2018 23:31:48 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:31:47 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] irqchip/irq-imx-gpcv2: Make use of BIT() macro
Date:   Wed,  5 Dec 2018 23:31:23 -0800
Message-Id: <20181206073125.7255-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all instances of 1 << x to BIT(x) for consistency with other
kernel code.

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
 drivers/irqchip/irq-imx-gpcv2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b262ba8b2652..077d56b3183a 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -78,7 +78,7 @@ static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 	u32 mask, val;
 
 	raw_spin_lock_irqsave(&cd->rlock, flags);
-	mask = 1 << d->hwirq % 32;
+	mask = BIT(d->hwirq % 32);
 	val = cd->wakeup_sources[idx];
 
 	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
@@ -101,7 +101,7 @@ static void imx_gpcv2_irq_unmask(struct irq_data *d)
 	raw_spin_lock(&cd->rlock);
 	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
-	val &= ~(1 << d->hwirq % 32);
+	val &= ~BIT(d->hwirq % 32);
 	writel_relaxed(val, reg);
 	raw_spin_unlock(&cd->rlock);
 
@@ -117,7 +117,7 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)
 	raw_spin_lock(&cd->rlock);
 	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
-	val |= 1 << (d->hwirq % 32);
+	val |= BIT(d->hwirq % 32);
 	writel_relaxed(val, reg);
 	raw_spin_unlock(&cd->rlock);
 
-- 
2.19.1

