Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5638ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADED2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESo9eprl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADED2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeJUXWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbeJUXWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:22:52 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F8C2083E;
        Sun, 21 Oct 2018 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540134494;
        bh=UT7XkX9sBku/Oe0j/IyJ8xnb+5D0Gp0So+yYv3hC8Zg=;
        h=From:To:Cc:Subject:Date:From;
        b=ESo9eprltHpv6RL4/8UxaFy4PTSU/yzPiSW9+ZzQvt0oHo06Cgg2qXsyV3q3sJ3zf
         0TJJ4214sh/aBBtvRtZ3wfvT8jppV1kFQGZCBtK+CjqAVAzPhHlZUWGMgCCRp9lGoV
         Uiubp8P8NtYH58KLR+0IvpU72NAkFJnpfCq9KXqw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix synthetic event parser
Date:   Mon, 22 Oct 2018 00:07:50 +0900
Message-Id: <154013446976.25576.14780785912268176178.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found another bug in synthetic event. This is a small fix, but
confusingly, there is also a bug in a test case.

Steve, since the testcase bugfix ([2/2]) breaks the test result
unless corresponding fix ([1/2]), I would like to ask you to send
these fixes from your tree.
Shuah, could you give this your ack?

Thank you,

---

Masami Hiramatsu (2):
      tracing: Return -ENOENT if there is no target synthetic event
      selftests/ftrace: Fix synthetic event test to delete event correctly


 kernel/trace/trace_events_hist.c                   |    4 +++-
 .../trigger-synthetic-event-createremove.tc        |   12 ++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
