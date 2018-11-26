Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C0EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA679208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz+bV9YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA679208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeK0IQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeK0IQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:16:57 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8275F20873;
        Mon, 26 Nov 2018 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543267290;
        bh=fRubPFu5gLk7G52iOH1qqfwbXbJj0zAx8sS2pcyEVqA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rz+bV9YHHN74FhGyiHT+RYwnVOBVl3ic46+zHTz9FtfH6dHwCSCQFU1AxQUj92Vr1
         fm+CqNIEmIfq+2LRmwoE/6ZDQLDhQphFNyQaeMv3z2ImJR/NzPHZVBTMlaOwQ5DuBx
         2ZgTQvjr1/hvma28yR+0uH9+kSejXCUKsI40/qPc=
Message-ID: <1543267288.2529.25.camel@kernel.org>
Subject: Re: [PATCH v7 00/16] tracing: Hist trigger snapshot and onchange
 additions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Mon, 26 Nov 2018 15:21:28 -0600
In-Reply-To: <20181126230928.17883eecfaefd6a29cbbd1c3@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <20181126230928.17883eecfaefd6a29cbbd1c3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, 2018-11-26 at 23:09 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 14 Nov 2018 14:17:57 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi,
> > 
> > This is v7 of the hist trigger snapshot and onchange additions
> > patchset.  It does a bit of refactoring to address the suggestions
> > made by Masami in v6.
> 
> Thank you for fixing it. 
> 
> > 
> > It also adds an additional patch to update the trigger/inter-event
> > testcases with SPDX license blurbs.
> > 
> > BTW, I noticed that with the recent kselftest changes, I now get
> > mangled output when running the selftests, though I can still see
> > well
> > enough that the tests passed as expected.  This happens with any of
> > the ftrace selftests and not just the trigger selftests.  In my
> > case,
> > this is using the stock Terminal in Ubuntu 17.10, in case that
> > helps.
> 
> Hmm, it should be fixed by
> 8096fbcf55c0 ("selftests/ftrace: Use colored output when available")
> 
> Could you check your kernel has this commit?
> 

Yes, it does have this commit.

> BTW, what terminal and environment (especially echo command)
> did you run your tests on? (It seems echo command didn't accept -e
> option)
> 

For that system, I'm using Gnome terminal 3.24.2 and GNU bash, version
4.4.12(1)-release (x86_64-pc-linux-gnu) (Ubuntu 17.10).

If I change 'echo' to '/bin/echo' in e.g. prlog() it works fine, so it
must be the inbuilt bash echo that's not doing the right thing.  I
thought it might be the xpg_echo option, but 'shopt -s xpg_echo'
doesn't have any effect.

I also tried on a Fedora 28 system (GNOME terminal 3.28.2, GNU bash,
version 4.4.23(1)-release (x86_64-redhat-linux-gnu), and it worked
fine.

Also, tried a Ubuntu 18.04.1 system (GNOME Terminal 3.28.1, GNU bash,
version 4.4.19(1)-release (x86_64-pc-linux-gnu) and in that case the
colors worked fine, but still got the '-e -n' and newlines in the
output:

-e -n [28] (instance)  event trigger - test histogram modifiers
-e 	[PASS]
-e -n [29] (instance)  event trigger - test histogram trigger
-e 	[PASS]

Again, substituting '/bin/echo' in prlog() fixed things in this case
too.   I guess the builtin bash 'echo' can't be relied on..

Tom


> Thank you,
> 
> > Example output:
> > 
> >   # ./ftracetest test.d/trigger/
> >   
> > -e === Ftrace unit tests ===
> > -e -n [1] event trigger - test inter-event histogram trigger
> > expected fail actions
> > -e 	[\e[31mXFAIL\e[0m]
> > -e -n [2] event trigger - test extended error support
> > -e 	[\e[32mPASS\e[0m]
> > -e -n [3] event trigger - test field variable support
> > -e 	[\e[32mPASS\e[0m]
> > -e -n [4] event trigger - test inter-event combined histogram
> > trigger
> > -e 	[\e[32mPASS\e[0m]
> > -e -n [5] event trigger - test multiple actions on hist trigger
> > -e 	[\e[32mPASS\e[0m]
> > .
> > .
> > .
> > -e 
> > -e # of passed:  31
> > -e # of failed:  0
> > -e # of unresolved:  0
> > -e # of untested:  0
> > -e # of unsupported:  0
> > -e # of xfailed:  1
> > -e # of undefined(test bug):  0
> > 
> > v6->v7 changes:
> > 
> >   - Removed unnecessary HANDLER_ONMAX checks from
> > onmax_print()/create()
> >   - Moved handler assignment to acion_parse()
> >   - Changed goto in ATION_TRACE case in action_create() to return
> >   - Changed EINVAL to EEXIST in action_create() ACTION_SAVE case
> >   - Made the return logic in create_actions() more consistent
> >   - Merged 'tracing: Move hist trigger key printing into a separate
> >     function' into 'tracing: Add hist trigger snapshot() action'
> >   - Updated the new snapshot, onchange, and trace test cases to
> > match
> >     4.20 kselftest changes.
> >   - Added new xfail test case that make sure certain unsupported
> >     handler/action combinations fail as expected.
> >   - While updating the test cases, realized that the other
> > testcases
> >     in the inter-event subdir needed SPDX license updates, so added
> >     them.
> > 
> > v5->v6 changes:
> > 
> >   - Added new Documentation patch explaining handler.action
> >   - Added new README patch explaining handler.action
> >   - Added separate snapshot() Documentation
> >   - Added new snapshot() test case
> >   - Updated README with snapshote()
> >   - Added separate onchange() Documentation
> >   - Added separate onchange() test case
> >   - Updated README with onchange()
> >   - Added separate trace() test case
> >   - Updated README with trace() and <synthetic_event>() syntax
> > 
> > v4->v5 changes:
> > 
> >   - added 'trace' keyword test case
> >   - added 'onchange' handler test case
> > 
> > v3->v4 changes:
> > 
> >   - added 'trace' keyword for generating synthetic events
> >   - fix elt_data leak
> >   - changed cond_update to cond_update_fn_t
> > 
> > v2->v3 changes:
> > 
> >   - fixed problem where trace actions were only being allowed for
> >     onmatch handlers - now trace actions can be used with any
> > handler.
> >   - fixed problem where no action was being assigned to onmatch
> >     handlers if save or snapshot actions were specified.
> > 
> > v1->v2 changes:
> > 
> >   - added missing tracing_cond_snapshot_data() definition for when
> >     CONFIG_TRACER_SNAPSHOT not defined
> >   - removed an unnecessary WARN_ON() in track_data_snapshot_print()
> > 
> > 
> > Original text:
> > 
> > This patchset adds some useful new functions to the hist
> > trigger code: a snapshot action and an onchange handler.
> > 
> > In order to make it easier to add these and in the process make the
> > code more generic, I separated the code into explicit 'handlers'
> > and
> > 'actions', handlers being things like 'onmax' and 'onchange', and
> > 'actions' being things like 'take a snapshot' or 'save some
> > fields'.
> > 
> > The first few patches do that basic refactoring, which make it
> > easier
> > to add the subsequent changes that arbitrarily combine actions and
> > handlers.
> > 
> > The fourth patch adds a 'conditional snapshot' capability that via
> > a
> > new tracing_snaphot_cond() function extends the existing snapshot
> > code.  It allows the caller to associate some user data with the
> > snapshot that can be checked and saved in an update() callback
> > whose
> > return value determines whether the snapshot should be taken or
> > not.
> > 
> > The remaining patches finally add the new snapshot action and
> > onchange
> > handler functionality - please see those patches for details and
> > some
> > examples.
> > 
> > Thanks,
> > 
> > Tom
> > 
> > 
> > The following changes since commit
> > ee474b81fe5aa5dc0faae920bf66240fbf55f891:
> > 
> >   tracing/kprobes: Fix strpbrk() argument order (2018-11-05
> > 09:47:14 -0500)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> > trace.git ftrace/hist-snapshot-onchange-v7
> > 
> > Tom Zanussi (16):
> >   tracing: Refactor hist trigger action code
> >   tracing: Make hist trigger Documentation better reflect
> >     actions/handlers
> >   tracing: Add hist trigger handler.action documentation to README
> >   tracing: Split up onmatch action data
> >   tracing: Generalize hist trigger onmax and save action
> >   tracing: Add conditional snapshot
> >   tracing: Add hist trigger snapshot() action
> >   tracing: Add hist trigger snapshot() action Documentation
> >   tracing: Add hist trigger snapshot() action test case
> >   tracing: Add hist trigger onchange() handler
> >   tracing: Add hist trigger onchange() handler Documentation
> >   tracing: Add hist trigger onchange() handler test case
> >   tracing: Add alternative synthetic event trace action syntax
> >   tracing: Add alternative synthetic event trace action test case
> >   tracing: Add hist trigger action 'expected fail' test case
> >   tracing: Add SPDX license GPL-2.0 license identifier to inter-
> > event
> >     testcases
> > 
> >  Documentation/trace/histogram.rst                  |  285 +++++-
> >  kernel/trace/trace.c                               |  177 +++-
> >  kernel/trace/trace.h                               |   56 +-
> >  kernel/trace/trace_events_hist.c                   | 1062
> > +++++++++++++++-----
> >  kernel/trace/trace_events_trigger.c                |    2 +-
> >  kernel/trace/trace_sched_wakeup.c                  |    2 +-
> >  .../inter-event/trigger-action-hist-xfail.tc       |   30 +
> >  .../inter-event/trigger-extended-error-support.tc  |    1 +
> >  .../inter-event/trigger-field-variable-support.tc  |    1 +
> >  .../trigger-inter-event-combined-hist.tc           |    1 +
> >  .../inter-event/trigger-multi-actions-accept.tc    |    1 +
> >  .../inter-event/trigger-onchange-action-hist.tc    |   28 +
> >  .../inter-event/trigger-onmatch-action-hist.tc     |    1 +
> >  .../trigger-onmatch-onmax-action-hist.tc           |    1 +
> >  .../inter-event/trigger-onmax-action-hist.tc       |    1 +
> >  .../inter-event/trigger-snapshot-action-hist.tc    |   43 +
> >  .../trigger-synthetic-event-createremove.tc        |    1 +
> >  .../inter-event/trigger-trace-action-hist.tc       |   42 +
> >  18 files changed, 1433 insertions(+), 302 deletions(-)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > action-hist-xfail.tc
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > onchange-action-hist.tc
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > snapshot-action-hist.tc
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > trace-action-hist.tc
> > 
> > -- 
> > 2.14.1
> > 
> 
> 
