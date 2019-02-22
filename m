Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56FC2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550798870;
	bh=RB7jNEYHIyfWPaSAh3WqkGGYKLM1w67mawtfHLwHWDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sFwSQoO4ojhh7NpvhNwLYtEzdz6R50ZL/PBsp6flkSTD3zJLr194mP/sVYuWSBxBf
	 PpkHFNFJEZErSWmzfRVg/8IGSGmPWVxfls4LIbyORjpsWVj6sJLijFrRW8o29W2Mzv
	 /Pfas1h4rNFhIVx6YHuhxoKYhyy8Othjat2iMPNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfBVB1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBVB1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:27:49 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EDA207E0;
        Fri, 22 Feb 2019 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550798868;
        bh=RB7jNEYHIyfWPaSAh3WqkGGYKLM1w67mawtfHLwHWDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeJDuIlK77dkowopOAUdkMhsHYjo15yIAaC/fWwvZoD/oH4W0tnsQ+0GrWftmrpLk
         PnE0mwsF7vlYoeyVcElHtuDZgFzc2+/C61C/ot+uUBRKQnRlADtXiZuLsKx1/P4SuA
         NSmuwhzJcgfvjVS6pzL/9F3R6ybX8jyZrC400E7w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH selftests 2/2] selftests/ftrace: Add checkbashisms meta-testcase
Date:   Fri, 22 Feb 2019 10:27:25 +0900
Message-Id: <155079884527.5157.14848621451304431136.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155079878723.5157.12433171255092403676.stgit@devbox>
References: <155079878723.5157.12433171255092403676.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a meta-testcase which tests ftracetest itself with
checkbasisms. This helps us to keep our test script
bashisms clean.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest          |    1 +
 .../selftests/ftrace/test.d/selftest/bashisms.tc   |   21 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 75244db70331..72b6df37cdb9 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -313,6 +313,7 @@ run_test() { # testfile
     local testlog=/proc/self/fd/1
   fi
   export TMPDIR=`mktemp -d /tmp/ftracetest-dir.XXXXXX`
+  export FTRACETEST_ROOT=$TOP_DIR
   echo "execute$INSTANCE: "$1 > $testlog
   SIG_RESULT=0
   if [ $VERBOSE -eq -1 ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
new file mode 100644
index 000000000000..1b081e910e14
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Meta-selftest: Checkbashisms
+
+if [ ! -f $FTRACETEST_ROOT/ftracetest ]; then
+  echo "Hmm, we can not find ftracetest"
+  exit_unresolved
+fi
+
+if ! which checkbashisms > /dev/null 2>&1 ; then
+  echo "No checkbashisms found. skipped."
+  exit_unresolved
+fi
+
+checkbashisms $FTRACETEST_ROOT/ftracetest
+checkbashisms $FTRACETEST_ROOT/test.d/functions
+for t in $(find $FTRACETEST_ROOT/test.d -name \*.tc); do
+  checkbashisms $t
+done
+
+exit 0

