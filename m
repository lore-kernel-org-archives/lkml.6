Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E32C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfAQXWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:22:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfAQXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:22:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0HNLwHe939742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 17 Jan 2019 15:21:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0HNLwPn939739;
        Thu, 17 Jan 2019 15:21:58 -0800
Date:   Thu, 17 Jan 2019 15:21:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jonathan Corbet <tipbot@zytor.com>
Message-ID: <tip-70921ae25f944423f0abf096f73455c586da0652@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, corbet@lwn.net,
        hpa@zytor.com, douliyangs@gmail.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, corbet@lwn.net,
          hpa@zytor.com, douliyangs@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190108170432.59bae8a6@lwn.net>
References: <20190108170432.59bae8a6@lwn.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Fix the kerneldoc comment for struct
 irq_affinity_desc
Git-Commit-ID: 70921ae25f944423f0abf096f73455c586da0652
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

Commit-ID:  70921ae25f944423f0abf096f73455c586da0652
Gitweb:     https://git.kernel.org/tip/70921ae25f944423f0abf096f73455c586da0652
Author:     Jonathan Corbet <corbet@lwn.net>
AuthorDate: Tue, 8 Jan 2019 17:04:32 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 18 Jan 2019 00:18:45 +0100

genirq: Fix the kerneldoc comment for struct irq_affinity_desc

A recent commit added a new field but did not update the kerneldoc comment,
leading to this build warning:

  ./include/linux/interrupt.h:268: warning: Function parameter or member 'is_managed' not described in 'irq_affinity_desc'

Add the missing information, making the docs build 0.001% quieter.

Fixes: c410abbbacb9 ("genirq/affinity: Add is_managed to struct irq_affinity_desc")
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <douliyangs@gmail.com>
Link: https://lkml.kernel.org/r/20190108170432.59bae8a6@lwn.net
---
 include/linux/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..4a728dba02e2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -260,6 +260,7 @@ struct irq_affinity {
 /**
  * struct irq_affinity_desc - Interrupt affinity descriptor
  * @mask:	cpumask to hold the affinity assignment
+ * @is_managed: 1 if the interrupt is managed internally
  */
 struct irq_affinity_desc {
 	struct cpumask	mask;
