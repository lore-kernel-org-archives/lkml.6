Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36022089F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z2960B3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36022089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeGZHIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeGZHIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:08:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B5220673;
        Thu, 26 Jul 2018 05:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532584401;
        bh=EJW/TunykCaAAzTv7nwh4GpX3xy3W7bJRoqK+T8HpzQ=;
        h=From:To:Cc:Subject:Date:From;
        b=z2960B3wWzN39I9GlvgjvNqn/wj7KobjEjzWuvNqhor/MY8bZRhUHjWChoo3RYH67
         IAhDpniMZSwpNKa1L4dsaUesxjMh/WIyXER98WpH1PutKcLwvCc4cF9vElZx52eEtM
         V1CisN+Qw9ETc9RjdDKSUEWH5mGf2gJwcQKzq0oo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] tracing: kprobes: Prohibit probing on notrace functions 
Date:   Thu, 26 Jul 2018 14:52:57 +0900
Message-Id: <153258437722.11602.12405835083073480618.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is the 2nd version of the series to prohibit kprobe
on notrace functions which Francis sent before.

Here is v1 series:
 https://lkml.org/lkml/2018/7/12/678

In this version, I've add a kconfig option to remove notrace
protection just for debugging, and also fix ftracetest testcase
to not probe notrace function.

Thank you,

---

Francis Deslauriers (1):
      selftest/ftrace: Move kprobe selftest function to separate compile unit

Masami Hiramatsu (2):
      tracing: kprobes: Prohibit probing on notrace function
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function


 kernel/trace/Kconfig                               |   18 ++++++++++
 kernel/trace/Makefile                              |    5 +++
 kernel/trace/trace_kprobe.c                        |   35 ++++++++++++++------
 kernel/trace/trace_kprobe_selftest.c               |   10 ++++++
 kernel/trace/trace_kprobe_selftest.h               |    7 ++++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 +++++++----------
 6 files changed, 76 insertions(+), 29 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
