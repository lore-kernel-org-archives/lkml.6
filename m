Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161702AbeBNSKS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:10:18 -0500
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:52177 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161606AbeBNSKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:10:17 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3653:3865:3870:4321:5007:10004:10400:10848:11658:11914:12043:12296:12438:12555:12760:13069:13072:13311:13357:13439:14181:14659:14721:14777:21080:21221:21433:21451:21627,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: cloth55_75618597de92c
X-Filterd-Recvd-Size: 1495
Message-ID: <1518631805.3678.12.camel@perches.com>
Subject: checkpatch: Improve parse_email signature checking
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 10:10:05 -0800
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bare email addresses with non alphanumeric characters require
escape quoting before being substituted in the parse_email routine.

e.g. Reported-by: syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com

Do so.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..2b8397da39d3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1075,7 +1075,7 @@ sub parse_email {
 	} elsif ($formatted_email =~ /(\S+\@\S+)(.*)$/) {
 		$address = $1;
 		$comment = $2 if defined $2;
-		$formatted_email =~ s/$address.*$//;
+		$formatted_email =~ s/\Q$address\E.*$//;
 		$name = $formatted_email;
 		$name = trim($name);
 		$name =~ s/^\"|\"$//g;
