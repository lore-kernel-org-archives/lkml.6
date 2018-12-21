Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F928C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146092195D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405706;
	bh=SQubZ9rDs9lg8qOzAj2FyjE5d/iJCcG1kmADqZzzLFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ehn+0SIEF9vpnLXYoeQRQilggR/hL1NPeYFE357UnlT1cPSjJqyElCaGMfS/KZbkY
	 T9bvkzSWGZ3o6enu3ytUfgcGrxTfYA7N/6ioiWm6T/SI3F8hz+OVjhR8XmdvRs7KWA
	 uOH9qiP+893kkVck8yz863wm7RrSVuI7/WMuQpaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404203AbeLUPVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbeLUPVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:41 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB58921917;
        Fri, 21 Dec 2018 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405700;
        bh=SQubZ9rDs9lg8qOzAj2FyjE5d/iJCcG1kmADqZzzLFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hn/sswHrwxj8Ivsl7G2R8mPBsMVI/wzggHA4qU4y6WYGX3zSo/PHGejyGUDK081yg
         T+gak0ECrjsIqQspwqLOTMzKnbe9J0wvVQJf3wxQj3qXTz56UgIBEFV4JehbRFBKBu
         4tSJEyeoypKPTQp/pVTS1B3/KpH0X3x4aLONyyfE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 5/9] work-simple: drop a shit statement in SWORK_EVENT_PENDING
Date:   Fri, 21 Dec 2018 09:21:17 -0600
Message-Id: <eee0dde6de03de4a7adfe1119c9a2575d8109df5.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 22f41ebe5579cc847a7bb6c71916be92c8926216 ]

Dan Carpenter reported
| smatch warnings:
|kernel/sched/swork.c:63 swork_kthread() warn: test_bit() takes a bit number

This is not a bug because we shift by zero (and use the same value in
both places).
Nevertheless I'm dropping that shift by zero to keep smatch quiet.

Cc: Daniel Wagner <daniel.wagner@siemens.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ tom.zanussi: applied to work-simple.c instead of swork.c ]
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/sched/work-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
index c996f755dba6..4284dd37aebe 100644
--- a/kernel/sched/work-simple.c
+++ b/kernel/sched/work-simple.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#define SWORK_EVENT_PENDING     (1 << 0)
+#define SWORK_EVENT_PENDING     1
 
 static DEFINE_MUTEX(worker_mutex);
 static struct sworker *glob_worker;
-- 
2.14.1

