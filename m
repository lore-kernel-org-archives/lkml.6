Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeDHUSl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeDHUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF1C2183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201833.674820217@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 03/23] ktest: Clarify config file usage
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-ktest-Clarify-config-file-usage.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

Simply telling a new user to edit "the config file" without giving any
hints on where that file should go, what it should be named, or where
a template can be found, is not particularly helpful.

Link: http://lkml.kernel.org/r/20170717001630.10518-1-swood@redhat.com

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 3 ++-
 tools/testing/ktest/sample.conf | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a959b6f79ce5..c85a9f9342f4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1143,7 +1143,8 @@ sub __read_config {
 sub get_test_case {
 	print "What test case would you like to run?\n";
 	print " (build, install or boot)\n";
-	print " Other tests are available but require editing the config file\n";
+	print " Other tests are available but require editing ktest.conf\n";
+	print " (see tools/testing/ktest/sample.conf)\n";
 	my $ans = <STDIN>;
 	chomp $ans;
 	$default{"TEST_TYPE"} = $ans;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 8df62c837dd1..e628e7c8d875 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -1,6 +1,9 @@
 #
 # Config file for ktest.pl
 #
+# Place your customized version of this, named ktest.conf, in the
+# working directory that ktest.pl is run from.
+#
 # Note, all paths must be absolute
 #
 
-- 
2.16.3
