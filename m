Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658AFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9832176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd+ufpem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9832176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeHCVZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:25:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33687 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeHCVZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:25:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so5754486wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9OA5LgHSgaLYXTbwaDFhQKZeZeOzaWcET78LLCmeXsc=;
        b=fd+ufpemeQBTkIrfBBKlGH0sH6+xUlZWxyZRTG+sTvAvmTomJdj7HflsnpX+WjSX3G
         EpIlIZqHv5UbGt/+P+lnhV4i79+SfRn4Sh44jBD0fcIIaAN4+eNTYv0BzuJLIBZ2T0aE
         cf1VOP2NGT/b7Z1/AupVPDuP6SEoyDSqPWMq7B/7RZh3TBIce8fN57Kdl24VOkm3SoNV
         pcip15Ew7SdD5E68hpAeqEAnh+uVt82pUcBOsIs9CcgMMUTMQ7AZLOGapcklXl7DrluC
         dJXuJFRNUDYRmy9cJeXKflL9WAuj1TT+FA/TMWAE0/dLqkQiDYddY10dLK3ZuObtZrl6
         VDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9OA5LgHSgaLYXTbwaDFhQKZeZeOzaWcET78LLCmeXsc=;
        b=PopVeY6jfjsWOr73YqXP9O1yx9oVeOBYphfdfYFccCuU9mqu0PGo3AflrWRC5QmkUx
         ry/KYXPjQzegj4An8Y9Y8Q/10ODExlQv9yNl15hDJswv6CbYhUhRFJFyRRx6Hwd1zZEX
         hHpse70FEbArG6mHhvRegyAbPOkvvdcp1+XaBTXkoX1cV154B1z4W4Um4y3PvC9zu7Y/
         BqN1fwCB990/Hs6esnSDP6zMVU2gF2iSd4IXIyOCPggqRyZP62zAKePN9SMAx28AvVP/
         8hYFoNVHPS8PM4YxcBhqN7zNKNIkmaU3GrE4asyJwXlz+UPIgG822awLCobg1FPJKY9+
         TVSA==
X-Gm-Message-State: AOUpUlGCf12C7rb5kgr2JlI5JnJ4FtWByI0umeFqnoPzCC+Rn1PMIwQE
        rKGKXJamjhrSw65VrfBMlzGPf6/s
X-Google-Smtp-Source: AAOMgpcJu2z4rqso39dCrDQO4b5FmQ6PYHbLcCltjbTx7+UQIZtz6629oCShpVIHrfIejw2u5WAuLg==
X-Received: by 2002:a1c:5f56:: with SMTP id t83-v6mr6116119wmb.27.1533324445957;
        Fri, 03 Aug 2018 12:27:25 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id x7-v6sm7057437wrr.95.2018.08.03.12.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 12:27:25 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] genirq: Consider domain hierarchy when checking for
 IRQCHIP_ONESHOT_SAFE
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a0407813-dbc3-4d4a-4feb-2c4865dfd4f5@gmail.com>
Date:   Fri, 3 Aug 2018 21:27:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a domain hierarchy we may miss the IRQCHIP_ONESHOT_SAFE
flag because we look at top of the stack only. See also discussion
here: https://marc.info/?l=linux-kernel&m=153301773524685&w=2

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
Uups, PATCH tag was missing.
---
 kernel/irq/manage.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a66c58f9..1a28f068 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1156,6 +1156,16 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	return 0;
 }
 
+static bool irq_data_oneshot_safe(struct irq_data *data)
+{
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+	/* check topmost irq_chip only */
+	while (data->parent_data)
+		data = data->parent_data;
+#endif
+	return !!(data->chip->flags & IRQCHIP_ONESHOT_SAFE);
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1243,7 +1253,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * chip flags, so we can avoid the unmask dance at the end of
 	 * the threaded handler for those.
 	 */
-	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
+	if (irq_data_oneshot_safe(&desc->irq_data))
 		new->flags &= ~IRQF_ONESHOT;
 
 	/*
-- 
2.18.0

