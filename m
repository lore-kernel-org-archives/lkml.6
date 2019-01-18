Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E33C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAC62086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfARL1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:27:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55148 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfARL1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:27:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 375C3EBD;
        Fri, 18 Jan 2019 03:27:02 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31B33F557;
        Fri, 18 Jan 2019 03:26:59 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:26:58 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        qais.yousef@arm.com, Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched: Document Energy Aware Scheduling
Message-ID: <20190118112655.cd5q5x7n4ahv3r5f@queper01-lin>
References: <20190110110546.8101-1-quentin.perret@arm.com>
 <20190110110546.8101-3-quentin.perret@arm.com>
 <20190117155117.GG14385@localhost.localdomain>
 <20190118091652.xn6iw52tccwh6vap@queper01-lin>
 <CAJZ5v0jw0BgmkwrtjuiC7YKO6A+k2eFfFDGtGsSWymW8PSTscA@mail.gmail.com>
 <20190118103359.jqctbopx25h3zvqs@queper01-lin>
 <CAJZ5v0jHq8pgB=XPydTyiqpUpX4ZdA5DVbk=Lqh=aUDBr-QOQQ@mail.gmail.com>
 <CAJZ5v0h24RZf1vF7zV5_2yqrVif_y5W4sBrBWC0Hdf3q5rArNQ@mail.gmail.com>
 <20190118111114.dytdk7oq63illgkg@queper01-lin>
 <CAJZ5v0iJFs00knKqn+M-sO=tMbAxdu3wk6GTAWt+d0bhDFJhww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJFs00knKqn+M-sO=tMbAxdu3wk6GTAWt+d0bhDFJhww@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 Jan 2019 at 12:20:57 (+0100), Rafael J. Wysocki wrote:
> On Fri, Jan 18, 2019 at 12:11 PM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Friday 18 Jan 2019 at 12:01:35 (+0100), Rafael J. Wysocki wrote:
> > > On Fri, Jan 18, 2019 at 11:58 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 18, 2019 at 11:34 AM Quentin Perret <quentin.perret@arm.com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > On Friday 18 Jan 2019 at 10:57:08 (+0100), Rafael J. Wysocki wrote:
> > > > > > On Fri, Jan 18, 2019 at 10:16 AM Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > > >
> > > > > > > Hi Juri,
> > > > > > >
> > > > > > > On Thursday 17 Jan 2019 at 16:51:17 (+0100), Juri Lelli wrote:
> > > > > > > > On 10/01/19 11:05, Quentin Perret wrote:
> > > > > > > [...]
> > > > > > > > > +The idea behind introducing an EM is to allow the scheduler to evaluate the
> > > > > > > > > +implications of its decisions rather than blindly applying energy-saving
> > > > > > > > > +techniques that may have positive effects only on some platforms. At the same
> > > > > > > > > +time, the EM must be as simple as possible to minimize the scheduler latency
> > > > > > > > > +impact.
> > > > > > > > > +
> > > > > > > > > +In short, EAS changes the way CFS tasks are assigned to CPUs. When it is time
> > > > > > > >
> > > > > > > > Not sure if we want to remark the fact that EAS is looking at CFS tasks
> > > > > > > > only ATM.
> > > > > > >
> > > > > > > Oh, what's wrong about mentioning it ? I mean, it is a fact ATM ...
> > > > > >
> > > > > > But it won't hurt to mention that it may cover other scheduling
> > > > > > classes in the future.  IOW, the scope limit is not fundamental.
> > > > >
> > > > > Agreed, I can do that.
> > > > >
> > > > > > > > > +for the scheduler to decide where a task should run (during wake-up), the EM
> > > > > > > > > +is used to break the tie between several good CPU candidates and pick the one
> > > > > > > > > +that is predicted to yield the best energy consumption without harming the
> > > > > > > > > +system's throughput. The predictions made by EAS rely on specific elements of
> > > > > > > > > +knowledge about the platform's topology, which include the 'capacity' of CPUs,
> > > > > > > >
> > > > > > > > Add a reference to DT bindings docs defining 'capacity' (or define it
> > > > > > > > somewhere)?
> > > > > > >
> > > > > > > Right, I can mention this is defined in the next section. But are you
> > > > > > > sure about the reference to the DT bindings ? They're arm-specific right ?
> > > > > > > Maybe I can give that as an example or something ...
> > > > > >
> > > > > > Example sounds right.
> > > > > >
> > > > > > You also can point to the section below from here.
> > > > >
> > > > > Sounds good.
> > > > >
> > > > > > Side note: If the doc is in the .rst format (which Peter won't like
> > > > > > I'm sure :-)), you can actually use cross-references in it and you get
> > > > > > a translation to an HTML doc (hosted at kernel.org) for free and the
> > > > > > cross-references become clickable links in that.
> > > > >
> > > > > Right, I personally don't mind the .rst format, but the existing files
> > > > > in Documentation/power/ and Documentation/scheduler/ are good old txt
> > > > > files so I just wanted to keep things consistent.
> > > >
> > > > In fact, Documentation/power/ is under a slow on-going transition to
> > > > .rst (due to the benefits mentioned above).
> > > >
> > > > > I don't mind converting to rst if necessary :-)
> > > >
> > > > It is not necessary, but maybe worth considering.
> > >
> > > That said, as this is targeted at Documentation/scheduler/, being
> > > consistent with the other material in there is probably more
> > > important.
> >
> > Right. Patch 01/02 is targeted at Documentation/power/ though. So if
> > that makes your life easier I can turn that one into a .rst file, no
> > problem at all.
> 
> Yes, I'd prefer it that way.  And please put it into
> Documentation/driver-api/pm/.

Will do in v2.

Thanks,
Quentin
