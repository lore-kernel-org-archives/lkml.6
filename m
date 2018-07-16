Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22E22077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7BbuKC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22E22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeGQIEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:04:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38700 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeGQIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:04:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so76400pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0kL1xP30trixesrTAaYcNNUv4h7qQGTEztjDeNhY+NQ=;
        b=D7BbuKC1ZJmF6sDJsOWbLcGVcGgo3SW9uBXsyA5LccpcXKtuGiO3nv/g8xe/pC34+5
         lihYgxQK711uBMWc6i8w//vH3VtZ2/YvqxIammZkWtOVvkw+pzJOX0zLEkSjzyWBVauI
         mZrl3W/mre5oN8sCilFh3d2UJKorD3SzfkjfKTSF2amHX7hzRd82uyAp05CBu4vUCCbR
         au1QgtgMjmyjopqgP4+ALXFY7ZyT1JzCSvXJikWP+/f5xRC0MlUO06AvrbeVsxnTGGEK
         rZJZZuCWe5FmToXuVx5dtJ+90yS9Y0RcCIpFo/UB7yCSHi2p8uEiUOxKQWdEGfWv8KXi
         +DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0kL1xP30trixesrTAaYcNNUv4h7qQGTEztjDeNhY+NQ=;
        b=Ut10mCJByg32uuDL71v1L2n/+fQsFDXWQNSvKpQUcXLEQDUnSpRx4N9EKbkLBZBtCW
         iRfAbT9wBDiNWKxwSB2X24jDFXBkCrpPZfIDT45BJBP+NNwovoxGAH19vLotPyhRncqG
         b0CTURLPMkFXQgRa1yNjd3sWpCHFY+4fZwZJc6ywLNnDu44kZOf6C5Hj03Xeg5Nwa/4+
         j7BhHsdswGj1K3DQNKxoL4W6/GwgFl076zXyGvY/tJRSlEIquMyh9yhavTprodIAg3kE
         PQYvqp3YfWl8slN+d9hji9gFcnjxRda/JRaJrd0YYRWnycb41gv3IU85ASw+edQmHVQJ
         MBPA==
X-Gm-Message-State: AOUpUlH1NFGWa2lflovSNTlSwu1A08fgbN9/Lmuk6cZ2o5WUmbbSkgm9
        lDDTiyaYLFFAozbTLc+QMCA=
X-Google-Smtp-Source: AAOMgpfdSoT8dKmD4kl2iHUMua1KO1QanLL0EMC9I0sPM/4i9TYUdmEZ1LgrlLcOrHWvgiJCrRutiA==
X-Received: by 2002:a17:902:8207:: with SMTP id x7-v6mr516137pln.57.1531812810806;
        Tue, 17 Jul 2018 00:33:30 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.11])
        by smtp.gmail.com with ESMTPSA id y13-v6sm847136pfi.131.2018.07.17.00.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 00:33:30 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, tglx@linutronix.de
Subject: [PATCH] genirq:Dereference desc after null pointer check
Date:   Tue, 17 Jul 2018 04:33:09 +0530
Message-Id: <20180716230309.23937-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716222725.14896-1-raghuhack78@gmail.com>
References: <20180716222725.14896-1-raghuhack78@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove unchecked dereferencing of *desc & assigning it local irq
	variable
* Move the assignement after proper check of *desc for NULL pointer.

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 kernel/irq/manage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index facfecfc543c..33c77eb4fdb6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1557,15 +1557,16 @@ EXPORT_SYMBOL_GPL(setup_irq);
  */
 static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 {
-	unsigned irq = desc->irq_data.irq;
+	unsigned int irq;
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
-	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
 	if (!desc)
 		return NULL;
 
+	irq = desc->irq_data.irq;
+	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 	mutex_lock(&desc->request_mutex);
 	chip_bus_lock(desc);
 	raw_spin_lock_irqsave(&desc->lock, flags);
-- 
2.17.1

