Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966466AbeEJPqc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:46:32 -0400
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:38817 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966094AbeEJPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:30 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1381:1437:1534:1540:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3350:3867:3868:4321:4419:4605:5007:6261:10004:10848:11026:11658:11914:12296:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21433:21451:21627:30054:30062,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stick95_1b7a717399e2f
X-Filterd-Recvd-Size: 1628
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] proc: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:37 -0700
Message-Id: <2bd051ff8bd3d92d2f1d81da8ea15d0833ccaac2.1525964385.git.joe@perches.com>
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
 fs/proc/root.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 61b7340b357a..78399fa8cf38 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -63,14 +63,14 @@ int proc_parse_options(char *options, struct pid_namespace *pid)
 				return 0;
 			if (option < HIDEPID_OFF ||
 			    option > HIDEPID_INVISIBLE) {
-				pr_err("proc: hidepid value must be between 0 and 2.\n");
+				pr_err("hidepid value must be between 0 and 2\n");
 				return 0;
 			}
 			pid->hide_pid = option;
 			break;
 		default:
-			pr_err("proc: unrecognized mount option \"%s\" "
-			       "or missing value\n", p);
+			pr_err("unrecognized mount option \"%s\" or missing value\n",
+			       p);
 			return 0;
 		}
 	}
-- 
2.15.0
