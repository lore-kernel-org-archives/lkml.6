Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B724EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8B4206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LkBD1Mmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8B4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKICYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:24:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43620 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:24:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id y3-v6so21681819wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wi3RtwoU7gFjKqwR0o2e4Ytwq9fzaxAaDuVQ7ukHVnA=;
        b=LkBD1MmrAnQ18ZGE33LMrYtO9FAKIcBFgeFfsKePaGfnlFWOkP12lsoOraoRrwCH+8
         tAt/zibmuRv+MYGrTZPKMRDIDx3g9tsqNMFXyAGcIlSLzynNbRicdybcfruMaeTMTagh
         9vDLlEpZkoN0MmlodsQ4pPmtulZ3FuiMCGuPNDDDgAIhVgbWb6D7H2di64WcucNsSHTR
         LU2iEwzdwdlVb0Ox8L4J7mMUinX7aZ4QJP1Lxt9qTCghd4k5EG3EOR2R0likn/cgiPbo
         j9heTuDFAm9sQL77zPt8QJ60Ed4cAL9WqdL5irtqy/cSuWIvNQtkN63QEYAKiivQklHY
         aaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wi3RtwoU7gFjKqwR0o2e4Ytwq9fzaxAaDuVQ7ukHVnA=;
        b=PgpwGKi+OXcIdBlj/Bk1h9mXi1JQnbib4tRxw9eF0bBHSaCTCswbX4CD5rLvhixFp8
         vzpjLh7KoF/XFiRUveKlb5uMQJL+2W+Y7ROmY/gZ1N+7EoAq9vR6+0s8KcCdwx81x1GQ
         9/JDhSD2okrSjwP1j7EPjKd8eBE3+AZDmnVZLj9+JxODMRb1Fw8pFgEr0ufxJORNyVnd
         5gQpjLdbn060bSc0587uWPhnFkAMTTYSae4x1HhnvFrDVbZ/LZr6ILQJH+ONAtYzUPKL
         AQFeDYo0aD7z6y/tfvHFVNi2+bGT83v7eHQqNNseir0CGSvdOwv4kwwsc+FHi7J5BT/7
         qUUA==
X-Gm-Message-State: AGRZ1gLCJCqbxf8ElojwrxQ1rG+8t0gBc0Zy3ljATiG55AT9xX3qniR3
        Zsl0N2YvNXtwfbzOT+/tQPjBKvNV/LY=
X-Google-Smtp-Source: AJdET5cT0aS20yaRcn68Fu4pRE7/SRhCWL1nI4bJYbfVpf4Qccfd4XY0C3kMscgWaBgRp7pIrRrbng==
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr4918103wrq.294.1541695671774;
        Thu, 08 Nov 2018 08:47:51 -0800 (PST)
Received: from debian-brgl.lan ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i7-v6sm2810606wrb.3.2018.11.08.08.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:47:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] irq/irq_sim: add locking
Date:   Thu,  8 Nov 2018 17:47:48 +0100
Message-Id: <20181108164748.31222-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two threads can try to fire the irq_sim with different offsets and will
end up fighting for the irq_work asignment. To fix it: add a mutex and
lock it before firing.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 include/linux/irq_sim.h | 1 +
 kernel/irq/irq_sim.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 630a57e55db6..676bfa0c12b9 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -29,6 +29,7 @@ struct irq_sim {
 	int			irq_base;
 	unsigned int		irq_count;
 	struct irq_sim_irq_ctx	*irqs;
+	struct mutex		lock;
 };
 
 int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd20d0d528d4..2f06c24b51a0 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -74,6 +74,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	}
 
 	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
+	mutex_init(&sim->lock);
 	sim->irq_count = num_irqs;
 
 	return sim->irq_base;
@@ -142,10 +143,14 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
  */
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
 {
+	mutex_lock(&sim->lock);
+
 	if (sim->irqs[offset].enabled) {
 		sim->work_ctx.irq = irq_sim_irqnum(sim, offset);
 		irq_work_queue(&sim->work_ctx.work);
 	}
+
+	mutex_unlock(&sim->lock);
 }
 EXPORT_SYMBOL_GPL(irq_sim_fire);
 
-- 
2.19.1

