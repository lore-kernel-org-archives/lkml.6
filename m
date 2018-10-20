Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23629ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC109214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC109214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeJTJj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJTJj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:39:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B035F214C3;
        Sat, 20 Oct 2018 01:30:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gDg6M-0006Dq-MM; Fri, 19 Oct 2018 21:30:50 -0400
Message-Id: <20181020012958.223064271@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Oct 2018 21:29:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] [GIT PULL] tracing: A few small fixes to synthetic events
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus (aka Greg),

Masami found some issues with the creation of synthetic events.
The first two patches fix handling of unsigned type, and handling
of a space before an ending semi-colon.

The third patch adds a selftest to test the processing of synthetic events.

Please pull the latest trace-v4.19-rc8-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-rc8-2

Tag SHA1: e97b692b87a195b6f33386989bb7fc7341e27288
Head SHA1: ba0e41ca81b935b958006c7120466e2217357827


Masami Hiramatsu (3):
      tracing: Fix synthetic event to accept unsigned modifier
      tracing: Fix synthetic event to allow semicolon at end
      selftests: ftrace: Add synthetic event syntax testcase

----
 kernel/trace/trace_events_hist.c                   | 32 +++++++--
 .../inter-event/trigger-synthetic-event-syntax.tc  | 80 ++++++++++++++++++++++
 2 files changed, 105 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
