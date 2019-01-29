Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1014C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9236920881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 02:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfA2CPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:15:19 -0500
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:36443 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbfA2CPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 21:15:18 -0500
X-Greylist: delayed 1159 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 21:15:18 EST
Received: from [4.30.142.84] (helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1goId2-000O3p-0C; Mon, 28 Jan 2019 20:55:56 -0500
Subject: [PATCH] tracing: Fix documentation about disabling options using
 trace_options
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     srivatsa@csail.mit.edu, linux-kernel@vger.kernel.org
Date:   Mon, 28 Jan 2019 17:55:53 -0800
Message-ID: <154872690031.47356.5739053380942044586.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

To disable a tracing option using the trace_options file, the option
name needs to be prefixed with 'no', and not suffixed, as the README
states. Fix it.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
---

 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b73..d632458 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4541,7 +4541,7 @@ static const char readme_msg[] =
 	"  instances\t\t- Make sub-buffers with: mkdir instances/foo\n"
 	"\t\t\t  Remove sub-buffer with rmdir\n"
 	"  trace_options\t\t- Set format or modify how tracing happens\n"
-	"\t\t\t  Disable an option by adding a suffix 'no' to the\n"
+	"\t\t\t  Disable an option by prefixing 'no' to the\n"
 	"\t\t\t  option name\n"
 	"  saved_cmdlines_size\t- echo command number in here to store comm-pid list\n"
 #ifdef CONFIG_DYNAMIC_FTRACE

