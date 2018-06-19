Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4519C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D1E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937522AbeFSIVu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:21:50 -0400
Received: from foss.arm.com ([217.140.101.70]:44684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937448AbeFSIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:21:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A21E81435;
        Tue, 19 Jun 2018 01:21:40 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D1E1C3F25D;
        Tue, 19 Jun 2018 01:21:39 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] coredump: Remove unsued trace event includes
Date:   Tue, 19 Jun 2018 09:21:26 +0100
Message-Id: <20180619082126.2443-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coredump does not use any task or task scheduler trace events.

Commit 10c28d937e2c ("coredump: move core dump functionality into its
own file") moved coredump from fs/exec.c in which task and task
scheduler trace events are used.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 fs/coredump.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1e2c87acac9b..5859666150f1 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -46,11 +46,8 @@
 #include <asm/tlb.h>
 #include <asm/exec.h>
 
-#include <trace/events/task.h>
 #include "internal.h"
 
-#include <trace/events/sched.h>
-
 int core_uses_pid;
 unsigned int core_pipe_limit;
 char core_pattern[CORENAME_MAX_SIZE] = "core";
-- 
2.11.0

