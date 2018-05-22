Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeEVTgd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:36:33 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:51757 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752016AbeEVTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:36:31 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3653:3871:3872:3876:5007:7875:10004:10400:10848:11026:11473:11658:11914:12043:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: blow58_72e2c258fbe37
X-Filterd-Recvd-Size: 1672
Message-ID: <5dd900e9197febc1995604bb33c23c136d8b33ce.camel@perches.com>
Subject: [PATCH] checkpatch: Fix macro argument precedence test
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>, lustre-devel@lists.lustre.org
Date: Tue, 22 May 2018 12:36:28 -0700
In-Reply-To: <20180522133439.12338-1-brnkv.i1@gmail.com>
References: <20180522133439.12338-1-brnkv.i1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch's macro argument precedence test is broken so fix it.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index baddac9379f0..68879aa65cfd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5041,7 +5041,7 @@ sub process {
 				$tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
 				$tmp_stmt =~ s/\#+\s*$arg\b//g;
 				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
-				my $use_cnt = $tmp_stmt =~ s/\b$arg\b//g;
+				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;
 				if ($use_cnt > 1) {
 					CHK("MACRO_ARG_REUSE",
 					    "Macro argument reuse '$arg' - possible side-effects?\n" . "$herectx");
