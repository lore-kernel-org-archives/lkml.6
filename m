Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F938C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26E254B4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F26E254B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeFYG1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:27:06 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:49682 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752142AbeFYG1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:27:05 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 25 Jun 2018 15:27:02 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 25 Jun 2018 15:27:02 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH] rcu: Make it stop complaining about docbook function-header comment
Date:   Mon, 25 Jun 2018 15:26:55 +0900
Message-Id: <1529908015-7256-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make htmldocs" complains about the docbook function-header
comment. It wants the "irq" parameter described which wasn't done by
a commit 5e5ea52645b197 (rcu: Refactor rcu_{nmi,irq}_{enter,exit}()).
So add its description of the parameter to the comment.

Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4ed74f1..6c5a7f0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -774,6 +774,7 @@ void rcu_user_enter(void)
 
 /**
  * rcu_nmi_exit_common - inform RCU of exit from NMI context
+ * @irq: Is this call from rcu_irq_exit?
  *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
@@ -933,6 +934,7 @@ void rcu_user_exit(void)
 
 /**
  * rcu_nmi_enter_common - inform RCU of entry to NMI context
+ * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
  * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
-- 
1.9.1

