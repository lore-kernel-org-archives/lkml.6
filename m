Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6110FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353F120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfAQNah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:30:37 -0500
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:33486 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbfAQNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:30:37 -0500
Received: from faui49copter1 (faui49copter1.informatik.uni-erlangen.de [131.188.42.149])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id BC436548028;
        Thu, 17 Jan 2019 14:30:31 +0100 (CET)
Received: by faui49copter1 (sSMTP sendmail emulation); Thu, 17 Jan 2019 14:30:31 +0100
From:   Andreas Ziegler <andreas.ziegler@fau.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH] tracing: uprobes: fix typo in pr_fmt string
Date:   Thu, 17 Jan 2019 14:30:23 +0100
Message-Id: <20190117133023.19292-1-andreas.ziegler@fau.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subsystem-specific message prefix for uprobes was also
"trace_kprobe: " instead of "trace_uprobe: " as described in
the original commit message.

Fixes: 7257634135c24 ("tracing/probe: Show subsystem name in messages")
Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e335576b9411..19a1a8e19062 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -5,7 +5,7 @@
  * Copyright (C) IBM Corporation, 2010-2012
  * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
  */
-#define pr_fmt(fmt)	"trace_kprobe: " fmt
+#define pr_fmt(fmt)	"trace_uprobe: " fmt
 
 #include <linux/ctype.h>
 #include <linux/module.h>
-- 
2.17.1

