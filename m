Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE0AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226332087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUWDbSUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226332087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJRUMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJRUMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:12:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E012087A;
        Thu, 18 Oct 2018 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539864689;
        bh=NV8cfs3n7FymRtTxxFREa29hRdu3Gncfr3vi3J57B/o=;
        h=From:To:Cc:Subject:Date:From;
        b=TUWDbSUHc9umvdxRFjWaBnScHJC0JFBwiEuJ8hvntOxWJHs4btv2j2cW+BN6Ye3xM
         nE6aO/SFqfgeUt6q1409uzLFl2d7DcU3Ibr5GdzKmNdV65y18OO/bi9CGSbMW/f3og
         gkMQHedqYq7gFPrEaRJAbn4gfNdBcaeTiSw05By0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: Fix synthetic event parser
Date:   Thu, 18 Oct 2018 21:11:06 +0900
Message-Id: <153986466551.1671.11399119973192957474.stgit@devbox>
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

Here are 2 fixes for synthetic event parser and its testcase.
One bug is that the synthetic_events can not accept "unsigned"
modifier for the field type, and another one is not allowing
the last independent semicolon.

I found that there is no testcase for checking it too. So the
last patch in this series adding a testcase for synthetic
event parser.

Thank you,

---

Masami Hiramatsu (3):
      tracing: Fix synthetic event to accept unsigned modifier
      tracing: Fix synthetic event to allow semicolon at end
      selftests: ftrace: Add synthetic event syntax testcase


 kernel/trace/trace_events_hist.c                   |   32 ++++++--
 .../inter-event/trigger-synthetic-event-syntax.tc  |   80 ++++++++++++++++++++
 2 files changed, 105 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
