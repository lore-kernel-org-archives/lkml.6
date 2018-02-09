Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeBITLD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:11:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750835AbeBITLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:11:01 -0500
Date: Fri, 9 Feb 2018 20:10:57 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf report: Add support to display group output for non
 group events
Message-ID: <20180209191057.GA10129@krava>
References: <20180202204004.GB8297@kernel.org>
 <CABPqkBQniVqi_7OuEmWQohWSsnp17BkDMRYgOE1RQYE00GpuVw@mail.gmail.com>
 <20180205151720.GA29340@krava>
 <CABPqkBRDVfoTEfR-4XLkYKKbPenpFfQ0QkibSBO1iTTAYQbzLA@mail.gmail.com>
 <20180205211340.GD25353@kernel.org>
 <CABPqkBQ272K=f7eYzk1MkgG04sy_szkMuyyTmyNEVSyBdYo-Og@mail.gmail.com>
 <20180206093553.GA8065@krava>
 <CABPqkBTXhL1U0HBbc2J0mdpGDiC2LG=Cm8MN+Pp_K=a_euDuUg@mail.gmail.com>
 <20180209092734.GB20449@krava>
 <20180209183711.GN3451@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209183711.GN3451@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 03:37:11PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 09, 2018 at 10:27:34AM +0100, Jiri Olsa escreveu:
> > On Wed, Feb 07, 2018 at 10:52:35AM -0800, Stephane Eranian wrote:
> > 
> > SNIP
> > 
> > > >> Similar to what I get if I do instead:
> > > >> $ perf record -e '{branches,branches,branches,branches}' my_test
> > > >> $ perf report --group
> > > >>
> > > >> But here, I would have to ensure all events fits in a group to allow
> > > >> the reporting
> > > >> I want. So that would limit me to 4 events.
> > > >>
> > > >> I think perf report --group should work regardless of how the events
> > > >> were grouped.
> > > >> Is there already a way to work around this?
> > > >
> > > > no workaround.. please try attached patch, it seems
> > > > to work for what you described
> > > >
> > > Works for me. That's great!
> > > Thanks.
> > > 
> > > Tested-By: Stephane Eranian <eranian@google.com>
> > 
> > thanks, full patch attached
> > 
> > jirka
> 
> Humm, its a nice hack, but it would be even better if it didn't showed
> it as if it was really a group:
> 
>   Samples: 20  of event 'anon group { cycles, instructions }', Event count (approx.): 4712980
> 
> It would be better to instead add another condition to the evlist that
> would trigger the view with all the examples...
> 
> I'm applying it anyway, as it is useful, but would be nice to have the
> same output except for that header, that should read instead:
> 
>   Samples: 20  of non grouped events: cycles, instructions, Event count (approx.): 4712980

right, I'll try to post something like that

thanks,
jirka
