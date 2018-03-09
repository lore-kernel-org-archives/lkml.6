Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeCITKg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:10:36 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34372 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbeCITKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:10:34 -0500
X-Google-Smtp-Source: AG47ELs2phAuoOi227Tf5OB4L9e513bmLJAn0XqxeLhXnH+lYVYJb8VOWQUCP/nZp2s1/Rb+3WR75g==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 9 Mar 2018 14:10:30 -0500 (EST)
X-X-Sender: vince@macbook-air
To: Peter Zijlstra <peterz@infradead.org>
cc: Vince Weaver <vincent.weaver@maine.edu>, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, eranian@google.com, acme@redhat.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/core] perf/x86/intel: Disable userspace RDPMC usage
 for large PEBS
In-Reply-To: <20180309174218.GB4064@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1803091407080.4834@macbook-air>
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com> <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org> <alpine.DEB.2.21.1803090929380.4834@macbook-air> <20180309174218.GB4064@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Peter Zijlstra wrote:

> On Fri, Mar 09, 2018 at 09:31:11AM -0500, Vince Weaver wrote:
> > On Fri, 9 Mar 2018, tip-bot for Kan Liang wrote:
> > 
> > > Commit-ID:  1af22eba248efe2de25658041a80a3d40fb3e92e
> > > Gitweb:     https://git.kernel.org/tip/1af22eba248efe2de25658041a80a3d40fb3e92e
> > > Author:     Kan Liang <kan.liang@linux.intel.com>
> > > AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Fri, 9 Mar 2018 08:22:23 +0100
> > > 
> > > perf/x86/intel: Disable userspace RDPMC usage for large PEBS
> > > 
> > 
> > 
> > So this whole commit log is about disabling RDPMC usage for "large PEBS"
> > but the actual change disables RDPMC if "PERF_X86_EVENT_FREERUNNING"
> > 
> > Either the commit log is really misleading, or else a poor name was chosen 
> > for this feature.
> 
> Its the same thing, and yes that might want renaming I suppose.

I apologize for noticing these things so late in the game, but I haven't 
had time to keep up with a full lkml feed recently so I only see these 
things once I'm CC'd on them.

So to summarize this: rdpmc is only disabled on a per-event basis, and 
only if that event is doing multi-pebs sampling?

If that's true, then I don't think I have an issue with this.

We finally got rdpmc support in a released PAPI, and it is a massive
improvement when self-monitoring (even moreso if KPTI is enabled) so I was 
just trying to make sure this wouldn't suddenly disable rdpmc out from 
under us.

Vince
