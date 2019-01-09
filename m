Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B9FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33213214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfAIFto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:49:44 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:28240 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfAIFtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:49:43 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 85BD6383F7A297B820D9;
        Wed,  9 Jan 2019 13:49:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x095nbHr025153;
        Wed, 9 Jan 2019 13:49:37 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019010913495850-21220444 ;
          Wed, 9 Jan 2019 13:49:58 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  rcu: Remove rcu_*_state declaration
Date:   Wed, 9 Jan 2019 22:13:28 +0800
Message-Id: <1547043208-11941-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-09 13:49:58,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-09 13:49:30,
        Serialize complete at 2019-01-09 13:49:30
X-MAIL: mse01.zte.com.cn x095nbHr025153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of just only one set of rcu_state, the declaration of
rcu_sched_state/rcu_bh_state/rcu_preempt_state is unnecessary.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/rcu/tree.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 703e19f..9ea704c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -401,13 +401,6 @@ struct rcu_state {
 /*
  * RCU implementation internal declarations:
  */
-extern struct rcu_state rcu_sched_state;
-
-extern struct rcu_state rcu_bh_state;
-
-#ifdef CONFIG_PREEMPT_RCU
-extern struct rcu_state rcu_preempt_state;
-#endif /* #ifdef CONFIG_PREEMPT_RCU */
 
 int rcu_dynticks_snap(struct rcu_data *rdp);
 
-- 
1.8.3.1

