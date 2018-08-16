Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A489C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30A12148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1hPIUC/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30A12148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392311AbeHPTbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeHPTa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:30:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D072148E;
        Thu, 16 Aug 2018 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437088;
        bh=EqBePB607TSmcgfLZpxbZ+EvTA2WPpeo+sWrY/hp0rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hPIUC/UMfK5+mEoLVeJ7kS35+XeptiOneYcLTq5tHrkr6Lzir8v2CM2XD9hUGc99
         228nwD8Y6Fo28XxSJQKDnfpivJrgIu0BtdxnkJi9CLHXXpwT9KgWBmO0wh392u6oqg
         p5czzHoz9PaYeojC8sCyVNWOQGufbdDhrlf4xUg8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/32] selftests/ftrace: Add case number prefix to logfile
Date:   Fri, 17 Aug 2018 01:31:05 +0900
Message-Id: <153443706488.23257.9219288456614329354.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
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

