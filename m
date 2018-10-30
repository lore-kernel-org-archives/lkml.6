Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96232081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96232081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJ3WI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:08:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163712081B;
        Tue, 30 Oct 2018 13:15:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gHTrK-0002fJ-07; Tue, 30 Oct 2018 09:15:02 -0400
Message-Id: <20181030131332.141023797@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 30 Oct 2018 09:13:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Fixes to synthetic events
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This is not my 4.20 pull request (that will be coming shortly). This
is just some last minute fixes that Masami sent me that I finally got
around to test.

Masami had a couple more fixes to the synthetic events. One was a proper
error return value, and the other is for the self tests.

Please pull the latest trace-v4.19-rc8-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-rc8-3

Tag SHA1: 11638fdbcb30c761886e38a7efb561d6ca11272a
Head SHA1: 0d0352d8b3d6d7ca9a710b40e194cbbaeb841c88


Masami Hiramatsu (2):
      tracing: Return -ENOENT if there is no target synthetic event
      selftests/ftrace: Fix synthetic event test to delete event correctly

----
 kernel/trace/trace_events_hist.c                             |  4 +++-
 .../inter-event/trigger-synthetic-event-createremove.tc      | 12 ++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)
