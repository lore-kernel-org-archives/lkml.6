Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FCC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110AA208D6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110AA208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbeHGLCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:02:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbeHGLCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:02:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DA46CF6426C8;
        Tue,  7 Aug 2018 16:48:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Tue, 7 Aug 2018 16:48:33 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Mao Wenan <maowenan@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH] rtmutex: Drop pointless static qualifier in rt_mutex_adjust_prio_chain()
Date:   Tue, 7 Aug 2018 08:56:03 +0000
Message-ID: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'T *v' variable static
since new value always be assigned before use it.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2823d41..ba70db8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -472,7 +472,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * We limit the lock chain length for each invocation.
 	 */
 	if (++depth > max_lock_depth) {
-		static int prev_max;
+		int prev_max;
 
 		/*
 		 * Print this only once. If the admin changes the limit,



