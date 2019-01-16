Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF38C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A723120866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfAPDbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730639AbfAPDbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:31:31 -0500
Received: from vmware.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD63204FD;
        Wed, 16 Jan 2019 03:31:28 +0000 (UTC)
Date:   Tue, 15 Jan 2019 22:31:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/6] tracing: trace event error_log and inter-event
 bugfixes
Message-ID: <20190115223126.366d854c@vmware.local.home>
In-Reply-To: <cover.1523545519.git.tom.zanussi@linux.intel.com>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tom,

This thread sorta died and appears to be forgotten. Is there follow up
patches on this?

Thanks!

-- Steve


On Thu, 12 Apr 2018 10:13:15 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> Here are a few patches that should be applied on top of the
> 'Inter-event (e.g. latency) support v9' patchset.
> 
> The first fixes another problem I noticed when printing flags.
> 
> The rest implement the tracing/events/error_log suggested by Masami,
> and update the inter-event code to use it (and remove the old hist
> file error mechanism).
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit 404bb11b24fb9a592023c077b878d30ad6da4322:
> 
>   tracing: Enforce passing in filter=NULL to create_filter() (2018-04-11 11:18:42 -0400)
> 
> are available in the git repository at:
> 
>   https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-update2
>   https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-update2
> 
> Tom Zanussi (6):
>   tracing: Restore proper field flag printing when displaying triggers
>   tracing: Add trace event error log
>   tracing: Save the last hist command's associated event name
>   tracing: Use trace event error_log with hist triggers
>   tracing: Add field parsing trace event errors for hist triggers
>   selftests: ftrace: Fix extended error support testcase
> 
>  kernel/trace/trace.h                               |   3 +
>  kernel/trace/trace_events.c                        | 172 +++++++++++++++++++
>  kernel/trace/trace_events_hist.c                   | 188 +++++++++++----------
>  .../inter-event/trigger-extended-error-support.tc  |   2 +-
>  4 files changed, 274 insertions(+), 91 deletions(-)
> 

