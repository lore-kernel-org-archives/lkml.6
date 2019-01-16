Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0165020657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394190AbfAPPmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:42:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:5270 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbfAPPmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:42:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 07:42:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,486,1539673200"; 
   d="scan'208";a="267594829"
Received: from gregmoor-mobl.amr.corp.intel.com ([10.254.11.196])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2019 07:42:36 -0800
Message-ID: <e885d1fd02e76f121d6cc2bb28e58b523e2434a7.camel@linux.intel.com>
Subject: Re: [PATCH 0/6] tracing: trace event error_log and inter-event
 bugfixes
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Wed, 16 Jan 2019 09:42:35 -0600
In-Reply-To: <20190115223126.366d854c@vmware.local.home>
References: <cover.1523545519.git.tom.zanussi@linux.intel.com>
         <20190115223126.366d854c@vmware.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2019-01-15 at 22:31 -0500, Steven Rostedt wrote:
> Hi Tom,
> 
> This thread sorta died and appears to be forgotten. Is there follow
> up
> patches on this?
> 

No, there wasn't a followup v2 for this - the last suggestion was that
we'd discuss this face-to-face at Plumbers, but I didn't get to go to
Plumbers...

Anyway, there were some good suggestions in the thread - let me spin up
a v2 that incorporates them, and we can go from there.

Tom

> Thanks!
> 
> -- Steve
> 
> 
> On Thu, 12 Apr 2018 10:13:15 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Hi Steve,
> > 
> > Here are a few patches that should be applied on top of the
> > 'Inter-event (e.g. latency) support v9' patchset.
> > 
> > The first fixes another problem I noticed when printing flags.
> > 
> > The rest implement the tracing/events/error_log suggested by
> > Masami,
> > and update the inter-event code to use it (and remove the old hist
> > file error mechanism).
> > 
> > Thanks,
> > 
> > Tom
> > 
> > The following changes since commit
> > 404bb11b24fb9a592023c077b878d30ad6da4322:
> > 
> >   tracing: Enforce passing in filter=NULL to create_filter() (2018-
> > 04-11 11:18:42 -0400)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/tzanussi/linux-trace-inter-event.git
> > tzanussi/inter-event-update2
> >   
> > https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-update2
> > 
> > Tom Zanussi (6):
> >   tracing: Restore proper field flag printing when displaying
> > triggers
> >   tracing: Add trace event error log
> >   tracing: Save the last hist command's associated event name
> >   tracing: Use trace event error_log with hist triggers
> >   tracing: Add field parsing trace event errors for hist triggers
> >   selftests: ftrace: Fix extended error support testcase
> > 
> >  kernel/trace/trace.h                               |   3 +
> >  kernel/trace/trace_events.c                        | 172
> > +++++++++++++++++++
> >  kernel/trace/trace_events_hist.c                   | 188
> > +++++++++++----------
> >  .../inter-event/trigger-extended-error-support.tc  |   2 +-
> >  4 files changed, 274 insertions(+), 91 deletions(-)
> > 
> 
> 

