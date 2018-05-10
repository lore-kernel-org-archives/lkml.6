Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966523AbeEJPsN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:48:13 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:44165 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966170AbeEJPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:31 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1534:1540:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3350:3867:4321:4419:5007:6261:6642:10004:10848:11026:11658:11914:12048:12296:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21433:21611:21627:21740:30054:30056,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: tax92_1ba0a97171932
X-Filterd-Recvd-Size: 1666
From: Joe Perches <joe@perches.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] uprobes: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:38 -0700
Message-Id: <46f6ea01b4313f0f1ade4eab199c8caa43b3f0d5.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/events/uprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1725b902983f..a7448ddaa302 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1469,8 +1469,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
 {
-	pr_warn("uprobe: %s:%d failed to %s\n",
-			current->comm, current->pid, msg);
+	pr_warn("%s:%d failed to %s\n", current->comm, current->pid, msg);
 }
 
 static void dup_xol_work(struct callback_head *work)
-- 
2.15.0
