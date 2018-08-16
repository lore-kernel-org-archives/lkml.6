Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B4FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D491C2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPjaxlJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D491C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404377AbeHPTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbeHPTdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:33:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B11F2148E;
        Thu, 16 Aug 2018 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437258;
        bh=+7Yf4U3n5hZ9r9YhJBHohcYXzPj7kzMaPtKJIo4BXFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPjaxlJxjiG0ziFmGr24KPRDhmO2/hyyz9eHZv7h377jYNVL7BgxzrKYu5siWQWoR
         9Dz5cUzJgFCF1c96LyTb6TwdwhuWsvmddiyb1kNuFTx94ZJFU6Uk7fpRYMD+Suz7Gr
         tMacXaETefoF3VqXOAeKSHyAQBYnBEU8aiFH87mE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/32] selftests/ftrace: Fix checkbashisms errors
Date:   Fri, 17 Aug 2018 01:33:55 +0900
Message-Id: <153443723502.23257.14228272091408974348.stgit@devbox>
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

Fix a test case to make checkbashisms clean.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../trigger/trigger-trace-marker-snapshot.tc       |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
index 79ce7d51350b..df246e505af7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -39,10 +39,10 @@ test_trace() {
 	fi
 	echo "testing $line for >$x<"
 	match=`echo $line | sed -e "s/>$x<//"`
-	if [ "$line" == "$match" ]; then
+	if [ "$line" = "$match" ]; then
 	    fail "$line does not have >$x< in it"
 	fi
-	let x=$x+2
+	x=$((x+2))
     done
 }
 

