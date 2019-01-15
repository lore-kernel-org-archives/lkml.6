Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0362085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfAOJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:46:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfAOJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:46:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0F9js2h2461534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 01:45:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0F9jsTD2461531;
        Tue, 15 Jan 2019 01:45:54 -0800
Date:   Tue, 15 Jan 2019 01:45:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-44133f7eaebec227d1381868d642e3c64023520f@git.kernel.org>
Cc:     hpa@zytor.com, malat@debian.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, malat@debian.org, hpa@zytor.com
In-Reply-To: <20190114203154.17125-1-malat@debian.org>
References: <20190114203154.17125-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Annotate implicit fall through
Git-Commit-ID: 44133f7eaebec227d1381868d642e3c64023520f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  44133f7eaebec227d1381868d642e3c64023520f
Gitweb:     https://git.kernel.org/tip/44133f7eaebec227d1381868d642e3c64023520f
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Mon, 14 Jan 2019 21:31:54 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 10:40:34 +0100

genirq: Annotate implicit fall through

There is a plan to build the kernel with -Wimplicit-fallthrough. The
fallthrough in __irq_set_trigger() lacks an annotation. Add it.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190114203154.17125-1-malat@debian.org

---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a4888ce4667a..1ca39dc4538d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -723,6 +723,7 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 	case IRQ_SET_MASK_OK_DONE:
 		irqd_clear(&desc->irq_data, IRQD_TRIGGER_MASK);
 		irqd_set(&desc->irq_data, flags);
+		/* fall through */
 
 	case IRQ_SET_MASK_OK_NOCOPY:
 		flags = irqd_get_trigger_type(&desc->irq_data);
