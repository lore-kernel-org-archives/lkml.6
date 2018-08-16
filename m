Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0432C208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e68UEfOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0432C208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbeHPMse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeHPMsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:48:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20986208A5;
        Thu, 16 Aug 2018 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534413070;
        bh=I9YH7P2MWzZ9PmRaT+k1qt1cVxdwhStczAnG2jrJy14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e68UEfOAs5fRXcqK2PZZ0JIOyt78hsI4fHxoi716VagDAU4uHK8ZGAGjAfKOB5dES
         si2HOpKL01jQ9oeSOlemg1lhkDvt3wZRrC9mUw4h7QFkZCkdYk2Vx7JyP/sd9Ieq7E
         w9sdicC82fxgq0bkNQdA1T9b/fDO/5JjnS/ZBk/I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/2] docs: tracing: Add stacktrace filter command
Date:   Thu, 16 Aug 2018 18:50:47 +0900
Message-Id: <153441304709.6024.553337906391633027.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153441301698.6024.1680500212551396320.stgit@devbox>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description of stacktrace filter command.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/trace/ftrace.rst |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index a20d34955333..81378a8b631e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2987,6 +2987,9 @@ The following commands are supported:
   command, it only prints out the contents of the ring buffer for the
   CPU that executed the function that triggered the dump.
 
+- stacktrace:
+  When the function is hit, a stack trace is recorded.
+
 trace_pipe
 ----------
 

