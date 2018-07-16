Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA2DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0E820C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuzIXXuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0E820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeGQH3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:29:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32941 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeGQH3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:29:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so32554pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z/yQXtVErqGNfHWNXKkyKBEpyU8wnR1elDva+eToLcU=;
        b=NuzIXXuJitaWxY0HXdSdpGGDBMsMY8nW9XjpoPywZaIpeQzn8SNBTf751j3V4aHbfp
         xieQzgktMrBwsrnjYTSajnZfkFIN3bDD/0elphvwHxQsE23vukW/PNBtj+0379T/J59I
         jI/w/Y8HgnSIop0pIn6Gf4xkXBM/5k3+aix2QWVpwNWvWWo3nM0/Sl3t9kql9rEkBahU
         v5zkrEQ9ql+o58DtqSwTkortmO6PQk9TsHDSpwJ73NY2wsTE7YPk9CT80JIiXnctYTlc
         jeetbQOc+XNyzGLN4YSNQASZ83ruB+u//6TGG45n0HFqCMoFiFJJiLz8bGN7tzNtkDy7
         dSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z/yQXtVErqGNfHWNXKkyKBEpyU8wnR1elDva+eToLcU=;
        b=Wn67hjq2kZhqu2L1Jju26KB6KL2ZBtXbjm056AIx6utb8gX3VwOf6Fv0/urtjJpElB
         8CfyF+zs+xgD6oqKQqrcGo020+gPjm2IHA1/hm29C93VBWgjd6hTz81VppyA8y1y164e
         2QMkrj7uJK3tVbbPNToLwZ2fSOorPbQnLei98nizgtt3I/gjkQxu2wfqrkFNfkwbsTxi
         AROPVYP1UbNmhpuD9jiDu8OlbV2GNORxNSXqLaWlfkZIFxY6nRi1vcvGdh4QFiBb929A
         k0V0kiIV835kOK3riUaaLrk1SYWmp3TcdYt0UXPLuYTLx76koTXpOGCA7mxDrAah0u10
         prDg==
X-Gm-Message-State: AOUpUlF0EDrsPrxyf7raxe7EJ8gL4eqvDdwz9zatmdELFOI6ptwn8Kph
        4jF3icH6zM6eYW3h8P9LsGHdvib+
X-Google-Smtp-Source: AAOMgpc/bV6PopetSKP5Md3iL36yszoK8S0sV+mcITUZZb41XvidB8VZe+nukuBMlDdd94ZBPRXT1g==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr413228pfj.175.1531810681185;
        Mon, 16 Jul 2018 23:58:01 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.11])
        by smtp.gmail.com with ESMTPSA id l4-v6sm445976pgn.46.2018.07.16.23.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 23:58:00 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, tglx@linutronix.de
Subject: [PATCH] genirq:Dereference desc after null pointer check
Date:   Tue, 17 Jul 2018 03:57:25 +0530
Message-Id: <20180716222725.14896-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove unchecked dereferencing of *desc & assigning it local irq
variable

* Move the assignement after proper check of *desc for NULL pointer.

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 kernel/irq/manage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index facfecfc543c..064d98e5ae32 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1557,7 +1557,7 @@ EXPORT_SYMBOL_GPL(setup_irq);
  */
 static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 {
-	unsigned irq = desc->irq_data.irq;
+	unsigned int irq;
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
@@ -1566,6 +1566,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	if (!desc)
 		return NULL;
 
+	irq = desc->irq_data.irq;
 	mutex_lock(&desc->request_mutex);
 	chip_bus_lock(desc);
 	raw_spin_lock_irqsave(&desc->lock, flags);
-- 
2.17.1

