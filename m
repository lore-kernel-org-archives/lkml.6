Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E64C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8131C20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfAOJqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:46:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33565 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfAOJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:46:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0F9kVNk2461595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 01:46:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0F9kUMW2461592;
        Tue, 15 Jan 2019 01:46:30 -0800
Date:   Tue, 15 Jan 2019 01:46:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-01cdfa912f1004c463586f52f1dfcbec1274b1f2@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, malat@debian.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, malat@debian.org,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190114203633.18557-1-malat@debian.org>
References: <20190114203633.18557-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Correctly annotate implicit fall through
Git-Commit-ID: 01cdfa912f1004c463586f52f1dfcbec1274b1f2
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

Commit-ID:  01cdfa912f1004c463586f52f1dfcbec1274b1f2
Gitweb:     https://git.kernel.org/tip/01cdfa912f1004c463586f52f1dfcbec1274b1f2
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Mon, 14 Jan 2019 21:36:33 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 10:40:53 +0100

genirq: Correctly annotate implicit fall through

There is a plan to build the kernel with -Wimplicit-fallthrough. The
fallthrough in __handle_irq_event_percpu() has a fallthrough annotation
which is followed by an additional comment and is not recognized by GCC.

Separate the 'fall through' and the rest of the comment with a dash so the
regular expression used by GCC matches.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190114203633.18557-1-malat@debian.org
---
 kernel/irq/handle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 38554bc35375..6df5ddfdb0f8 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -166,7 +166,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 
 			__irq_wake_thread(desc, action);
 
-			/* Fall through to add to randomness */
+			/* Fall through - to add to randomness */
 		case IRQ_HANDLED:
 			*flags |= action->flags;
 			break;
