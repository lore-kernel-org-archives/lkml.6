Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337AB2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337AB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeLJUmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbeLJUmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:42:35 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8B062084C;
        Mon, 10 Dec 2018 20:42:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gWSNt-0003ir-Hh; Mon, 10 Dec 2018 15:42:33 -0500
Message-Id: <20181210204126.603121253@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 15:41:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Fix a couple of memory leaks in the event trigger code
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom,

While testing other changes, kmemleak pointed out a few leaks in the
trigger code. Can you take a look at them and give me a Reviewed-by
or Ack.

Thanks!

-- Steve


Steven Rostedt (VMware) (2):
      tracing: Fix memory leak in create_filter()
      tracing: Fix memory leak in set_trigger_filter()

----
 kernel/trace/trace_events_filter.c  | 5 ++++-
 kernel/trace/trace_events_trigger.c | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)
