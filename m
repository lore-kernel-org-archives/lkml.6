Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD29C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwGlSoOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD29C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeH3ST0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:19:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbeH3STZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:19:25 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F782073D;
        Thu, 30 Aug 2018 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638624;
        bh=RC664nWoPcHwOnUQh+4+LHBof19YDTLD5cz8JkSEDyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwGlSoOpjie7upC+q8rpS4iZk4p18NQKdPybLjRZmjed+9cJkkipq3b0soTst28NP
         6ir2tcRWJ3YFpSH6toShmVqwWFCcXAY9RymuNy2dti2Bxonz+qoV1PA3PtcS+eFd6c
         0KxoM1shl26izKnJusd4ddAwEWEwdvtHTyocaPmg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/28] selftests/ftrace: Fix checkbashisms errors
Date:   Thu, 30 Aug 2018 23:16:41 +0900
Message-Id: <153563860167.29700.13365388020478810834.stgit@devbox>
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

Fix a test case to make checkbashisms clean.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
 

