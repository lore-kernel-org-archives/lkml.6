Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60939C4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26669217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfBHREe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:04:34 -0500
Received: from foss.arm.com ([217.140.101.70]:54264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBHREc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:04:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4A261596;
        Fri,  8 Feb 2019 09:04:31 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049A03F719;
        Fri,  8 Feb 2019 09:04:30 -0800 (PST)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Julien Grall <julien.grall@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 1/3] nds32: Removed unused thread flag TIF_USEDFPU
Date:   Fri,  8 Feb 2019 17:04:23 +0000
Message-Id: <20190208170425.10891-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190208170425.10891-1-julien.grall@arm.com>
References: <20190208170425.10891-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit TIF_USEDFPU is not used in the nds32 code.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>

---
    Untested as I don't have a cross-compiler for it.
---
 arch/nds32/include/asm/thread_info.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index bff741ff337b..8c610abe673a 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -42,7 +42,6 @@ struct thread_info {
  *  TIF_SIGPENDING	- signal pending
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_NOTIFY_RESUME	- callback before returning to user
- *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
  */
 #define TIF_SIGPENDING		1
@@ -50,7 +49,6 @@ struct thread_info {
 #define TIF_SINGLESTEP		3
 #define TIF_NOTIFY_RESUME	4	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
-#define TIF_USEDFPU             16
 #define TIF_POLLING_NRFLAG	17
 #define TIF_MEMDIE		18
 #define TIF_FREEZE		19
-- 
2.11.0

