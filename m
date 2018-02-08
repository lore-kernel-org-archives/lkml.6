Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeBHEe1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 23:34:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:54362 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbeBHEe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 23:34:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,476,1511856000";
   d="scan'208";a="25643656"
Message-ID: <1518064452.29966.4.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH v9 35/37] tracing: Increase trace_recursive_lock() limit
 for synthetic events
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de, joel.opensrc@gmail.com,
        joelaf@google.com, mathieu.desnoyers@efficios.com,
        baohong.liu@intel.com, rajvi.jingar@intel.com, julia@ni.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date: Wed, 07 Feb 2018 22:34:12 -0600
In-Reply-To: <20180207205501.2b19c8d6@gandalf.local.home>
References: <cover.1516069914.git.tom.zanussi@linux.intel.com>
         <827fcc7a6840db06d196fc18905033d519681eff.1516069914.git.tom.zanussi@linux.intel.com>
         <20180207205501.2b19c8d6@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2018-02-07 at 20:55 -0500, Steven Rostedt wrote:
> On Mon, 15 Jan 2018 20:52:09 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> >  static __always_inline int
> >  trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
> >  {
> > -	if (cpu_buffer->current_context >= 4)
> > +	if (cpu_buffer->current_context >= 6)
> 
> I can't apply this patch because the new context counting broke tracing
> suspend and resume because it depended on the context recursive locking.
> 
> Link: http://lkml.kernel.org/r/20180116020051.776011914@goodmis.org
> 
> I added the attached two patches which appear to do the job.
> 
> Let me know what you think.
> 

Yeah, these look good and seem to do the trick - I did some quick
testing and didn't see any problems.

Thanks,

Tom
