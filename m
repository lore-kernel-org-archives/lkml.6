Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeB0CYv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:24:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60073 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751630AbeB0CYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:24:48 -0500
X-ME-Sender: <xms:cMGUWpBBgJmnQXyfnKcvbD799B1n6snwkf9-xugXU5MQijjxLhbkzw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] checkpatch: remove unused variable declarations
Date: Tue, 27 Feb 2018 13:24:21 +1100
Message-Id: <1519698263-17783-3-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698263-17783-1-git-send-email-me@tobin.cc>
References: <1519698263-17783-1-git-send-email-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables are declared and not used, we should remove them.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/checkpatch.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 235a02f4f4e1..d505fa4ec20c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6081,7 +6081,6 @@ sub process {
 			}
 			if ($r1 !~ /^sizeof\b/ && $r2 =~ /^sizeof\s*\S/ &&
 			    !($r1 =~ /^$Constant$/ || $r1 =~ /^[A-Z_][A-Z0-9_]*$/)) {
-				my $ctx = '';
 				my $herectx = $here . "\n";
 				my $cnt = statement_rawlines($stat);
 				for (my $n = 0; $n < $cnt; $n++) {
@@ -6169,7 +6168,6 @@ sub process {
 		if ($^V && $^V ge 5.10.0 &&
 		    defined $stat &&
 		    $stat =~ /^\+[$;\s]*(?:case[$;\s]+\w+[$;\s]*:[$;\s]*|)*[$;\s]*\bdefault[$;\s]*:[$;\s]*;/g) {
-			my $ctx = '';
 			my $herectx = $here . "\n";
 			my $cnt = statement_rawlines($stat);
 			for (my $n = 0; $n < $cnt; $n++) {
-- 
2.7.4
