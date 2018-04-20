Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeDTOSI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:18:08 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:38060 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755168AbeDTOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:18:07 -0400
X-Google-Smtp-Source: AB8JxZoHpuZ2d7fK3xucVHznGWa67Q9xJ1bPSTFmQTuu0W3eFvjQwgTdkBp8kr7l5ioQajQuE9zDNA==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 20 Apr 2018 10:18:04 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Peter Zijlstra <peterz@infradead.org>
cc: Vince Weaver <vincent.weaver@maine.edu>, Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
In-Reply-To: <20180420083607.GG4064@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1804201015250.22578@macbook-air>
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com> <20180417062010.GA2052@krava> <alpine.DEB.2.21.1804181109100.1587@macbook-air> <20180420083607.GG4064@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Peter Zijlstra wrote:

> On Wed, Apr 18, 2018 at 11:10:20AM -0400, Vince Weaver wrote:
> > On Tue, 17 Apr 2018, Jiri Olsa wrote:
> > 
> > > On Mon, Apr 16, 2018 at 10:04:53PM +0000, Stephane Eranian wrote:
> > > > Hi,
> > > > 
> > > > I am trying to understand what the exclude_idle event attribute is supposed
> > > > to accomplish.
> > > > As per the definition in the header file:
> > > > 
> > > >     exclude_idle   :  1, /* don't count when idle */
> > > 
> > > AFAICS it's not implemented
> > 
> > so just to be completely clear hear, we're saying that the "exclude_idle" 
> > modifier has never done anything useful and still doesn't?
> 
> AFAICT it works on Power and possibly ARM.

at least some ARMs are a bit more honest about it than x86

ivybridge:
	Performance counter stats for '/bin/ls':
	1,368,162      instructions
	1,368,162      instructions:I

pi2/ARM cortex-A7
	Performance counter stats for '/bin/ls':
	1,910,083      instructions
	<not supported>      instructions:I

I'd fire up my Power8 machine to see but not sure it's worth the hassle 
and/or having to get out the ear protection.

Vince
