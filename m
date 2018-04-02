Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeDBO3p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:29:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36584 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeDBO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:29:30 -0400
X-Google-Smtp-Source: AIpwx49LoQnmFOQy94dfGZqp0Ph+cVJTVjr/Gg7V1e2Zcj682zUFvInd9ocbM4kAO5W6+UoP1SYQlA==
From: Jia He <hejianet@gmail.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Jia He <hejianet@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH] checkpatch: relax check for revert commit
Date: Mon,  2 Apr 2018 07:28:59 -0700
Message-Id: <1522679339-19067-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
References: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For revert commit, it might has two double quotation marks in its
commit log.

Relax the check condition for revert commit to avoid checkpatch
errors.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 scripts/checkpatch.pl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d40403..96138d6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2643,20 +2643,20 @@ sub process {
 			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
 			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
 			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.*)"\)/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
+				 $rawlines[$linenr] =~ /^\s*\("(.*)"\)/) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
-				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+		       } elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".*$/i &&
+				defined $rawlines[$linenr] &&
+				$rawlines[$linenr] =~ /^\s*.*"\)/) {
+				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.*)$/i;
 				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
+				$rawlines[$linenr] =~ /^\s*(.*)"\)/;
 				$orig_desc .= " " . $1;
 				$hasparens = 1;
 			}
-- 
2.7.4
