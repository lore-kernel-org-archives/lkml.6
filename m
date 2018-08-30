Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11977C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8942073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKKGeD9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8942073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeH3SQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeH3SQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:16:34 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1772073D;
        Thu, 30 Aug 2018 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638454;
        bh=NY1erADssufJk68+bRn50XQcjpsqfXYCZqi8YeBAhB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKKGeD9PKwT9HaM+QozagIbuq04nfVXuob6RoOuw2Qx35UfjqzK88kfT2+0+mVNZt
         aSsSfcENz8BCHsJ7LM18OWKh84MToYp9xLG/HJ1jqMtDMkwt1gABufgq89e8HULTtp
         tOaQOYEaxiZyW7k4hc75Pwtn7BjCNXAY3eyqS6SY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/28] selftests/ftrace: Add case number prefix to logfile
Date:   Thu, 30 Aug 2018 23:13:51 +0900
Message-Id: <153563843138.29700.4836714204453571737.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153563834333.29700.11242968505215651399.stgit@devbox>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a case number prefix to each logfile. This makes
it easier to find which logfile is corresponding
to which failure.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/ftracetest |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 8debd37038e4..3ca596255eff 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -284,13 +284,13 @@ __run_test() { # testfile
 # Run one test case
 run_test() { # testfile
   local testname=`basename $1`
+  testcase $1
   if [ ! -z "$LOG_FILE" ] ; then
-    local testlog=`mktemp $LOG_DIR/${testname}-log.XXXXXX`
+    local testlog=`mktemp $LOG_DIR/${CASENO}-${testname}-log.XXXXXX`
   else
     local testlog=/proc/self/fd/1
   fi
   export TMPDIR=`mktemp -d /tmp/ftracetest-dir.XXXXXX`
-  testcase $1
   echo "execute$INSTANCE: "$1 > $testlog
   SIG_RESULT=0
   if [ $VERBOSE -eq -1 ]; then

