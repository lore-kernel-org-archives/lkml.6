Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B732146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWOpxPZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B732146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeGQKwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:52:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46147 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbeGQKwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:52:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so244767pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5fHudnLgNIpYde+yFGqLpc8kWsTXeNZDx2IvqSqOkGU=;
        b=WWOpxPZc9JQT/DJk/6pamBYaGnL1O4J0SDiLSrMSyE3FU8fXM3xbPV6C9BqbpJzDzq
         oQTD+YQ+74VaujYx1A9LYdRZT0BPjF+R5er14QOh+shB3jSliOVMdZWl01AQkD0X7i2X
         NVAUCVZu/hyejzX4VV+25Qh+xJgYhBLU0hDsaTdckFI+SghM8yDWsULzrsTMBu9YP52f
         4sF9W9SxG4B2OZQuJSAPdd0z8A+YQhu3m2eX9cVshnl2aQWs8g5+bWLukbx47IUQxKz8
         3geVsInwMHYFGheS0QM2l8wQEYZEPt4MvF2hyVQr9Zw/mGzykvjAWA/TlYkNR44iO1sc
         k98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5fHudnLgNIpYde+yFGqLpc8kWsTXeNZDx2IvqSqOkGU=;
        b=aioSxYs4H5HJ8s01tAKBqDTwADgGPS3VdGYJ4GVQpOs4bBubdr02+NZycEOvoehgcd
         m/FdRPLZrygmXxk19+3HcVCF1/EIq0tVkynDfqUq4J2nnDbbiaBIihKRU9nhlDMtsjyb
         Fylz86NtfWsZBQirQ1Yp/Cy5uyX1hkcgUrEvvLMUXZ5WLiWFA8AQFCVZ8onYH0xf3B8U
         83Knt02ekXxpW5d+7xJGomNSpVRe/KpWFElcFBhyrC0JRJ0PaZ1KfWcfP6iL4ajMyn00
         WouC3HfN6y/cG3MsURUp3VNgQjQR2lbR8T2Y48gK98B64N8SPo/pxl8nFFoiqhqoDjQo
         GRfA==
X-Gm-Message-State: AOUpUlHHGpCjD8KJ/LXnvNDLnfQf8lND2EeUKzk0cbBmoU8q35lIWgOD
        eWxEMyvzxMDRNLOOxkeMfDEug/MU
X-Google-Smtp-Source: AAOMgpeiYL8y/eqF6Ez7sSu69xTG3r+b7Jw/f/K424/NPrqJliO7kYdHDBncVb0xwUPjo32nYAe2GA==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr77780pfa.96.1531822818106;
        Tue, 17 Jul 2018 03:20:18 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id h24-v6sm2976073pfk.113.2018.07.17.03.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 03:20:17 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, tglx@linutronix.de
Subject: [PATCH] genirq:free_irq:remove redundant null ptr check
Date:   Tue, 17 Jul 2018 15:50:09 +0530
Message-Id: <20180717102009.7708-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.1807171100590.3238@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1807171100590.3238@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove the misleading null pointer check in __free_irq, its redundant because
the callee checks before calling __free_irq.

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 kernel/irq/manage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index facfecfc543c..7246f6c7f702 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1563,9 +1563,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
-	if (!desc)
-		return NULL;
-
 	mutex_lock(&desc->request_mutex);
 	chip_bus_lock(desc);
 	raw_spin_lock_irqsave(&desc->lock, flags);
-- 
2.17.1

