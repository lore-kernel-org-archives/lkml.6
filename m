Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B97CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BADA2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BADA2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJJWRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:17:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbeJJWRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:17:07 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 601BAD95DA183;
        Wed, 10 Oct 2018 22:54:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 10 Oct 2018 22:54:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] docs/completion.txt: Fix a couple of punctuation nits
Date:   Wed, 10 Oct 2018 22:56:32 +0800
Message-ID: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of punctuation nits which can make the document
more correct and readable.

Also missing "()" are added to some function references for consistency.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/Documentation/scheduler/completion.txt b/Documentation/scheduler/completion.txt
index 656cf80..108bd0f 100644
--- a/Documentation/scheduler/completion.txt
+++ b/Documentation/scheduler/completion.txt
@@ -116,7 +116,7 @@ A typical usage scenario is:
 This is not implying any temporal order on wait_for_completion() and the
 call to complete() - if the call to complete() happened before the call
 to wait_for_completion() then the waiting side simply will continue
-immediately as all dependencies are satisfied if not it will block until
+immediately as all dependencies are satisfied; if not, it will block until
 completion is signaled by complete().
 
 Note that wait_for_completion() is calling spin_lock_irq()/spin_unlock_irq(),
@@ -131,7 +131,7 @@ wait_for_completion():
 The default behavior is to wait without a timeout and to mark the task as
 uninterruptible. wait_for_completion() and its variants are only safe
 in process context (as they can sleep) but not in atomic context,
-interrupt context, with disabled irqs. or preemption is disabled - see also
+interrupt context, with disabled irqs, or preemption is disabled - see also
 try_wait_for_completion() below for handling completion in atomic/interrupt
 context.
 
@@ -224,7 +224,7 @@ queue spinlock. Any such concurrent calls to complete() or complete_all()
 probably are a design bug.
 
 Signaling completion from hard-irq context is fine as it will appropriately
-lock with spin_lock_irqsave/spin_unlock_irqrestore and it will never sleep.
+lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never sleep.
 
 
 try_wait_for_completion()/completion_done():
-- 
1.9.1

