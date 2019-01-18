Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29FE20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfARMeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:34:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39551 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfARMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:34:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so14863049wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 04:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HeZNwP9EcZ9AAVB8WD/3SS0wP0RYFQh5uPHojKsFw98=;
        b=LKOLixiXzOi31IRUk6ncsDW+IlzMBRtEGrT0kVf3DlmpnDeO6DRcbAjKMMyf1BKyqw
         IDT+ZbdM367tSzeomJ+TcjuJRnn3eT0Ir4zZTuE2+t2VCLPEryruxo9CitCtHOxBPm0a
         iIOQoxMcyH/ykBsBkvzWV1DRpaQmTnIOsbGNpLUwZBzwEgChshAXuiy4ZuZOD7Fr2XxW
         aLWyUbmD0QKiGLu6kXBQEkaDSt0TGp4wM9+wXrYjYFP1uv8tCfqSLFzQV6wSBUMrojzk
         vIKThGM7EZmGF7ExA3Saubz1DjkNyZzLZchK5enPx3ed5EjrJbxSZEuqyg3t3tCw5uXs
         EU6A==
X-Gm-Message-State: AJcUukc2ONHogzinq3bfnztpdxvyVecbiyNEBmxdVEemCMN0PCzQnd56
        fKlnl6L20XWWMbQKL7ZN5I3QzDsfGDw=
X-Google-Smtp-Source: ALg8bN486whx+wp2qH2IHDAWlpvY7s8udW2vHDvSbGwqXExR7dRQFCUPskcHLJoxHGNTHfUEH733jQ==
X-Received: by 2002:adf:f691:: with SMTP id v17mr15766940wrp.114.1547814852799;
        Fri, 18 Jan 2019 04:34:12 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id q14sm69149697wrw.39.2019.01.18.04.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 04:34:12 -0800 (PST)
Date:   Fri, 18 Jan 2019 13:34:09 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20190118123409.GI14385@localhost.localdomain>
References: <20190110110546.8101-1-quentin.perret@arm.com>
 <20190110110546.8101-3-quentin.perret@arm.com>
 <20190117155117.GG14385@localhost.localdomain>
 <20190118091652.xn6iw52tccwh6vap@queper01-lin>
 <CAJZ5v0jw0BgmkwrtjuiC7YKO6A+k2eFfFDGtGsSWymW8PSTscA@mail.gmail.com>
 <20190118103359.jqctbopx25h3zvqs@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118103359.jqctbopx25h3zvqs@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/01/19 10:34, Quentin Perret wrote:
> Hi Rafael,
> 
> On Friday 18 Jan 2019 at 10:57:08 (+0100), Rafael J. Wysocki wrote:
> > On Fri, Jan 18, 2019 at 10:16 AM Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > Hi Juri,
> > >
> > > On Thursday 17 Jan 2019 at 16:51:17 (+0100), Juri Lelli wrote:
> > > > On 10/01/19 11:05, Quentin Perret wrote:
> > > [...]
> > > > > +The idea behind introducing an EM is to allow the scheduler to evaluate the
> > > > > +implications of its decisions rather than blindly applying energy-saving
> > > > > +techniques that may have positive effects only on some platforms. At the same
> > > > > +time, the EM must be as simple as possible to minimize the scheduler latency
> > > > > +impact.
> > > > > +
> > > > > +In short, EAS changes the way CFS tasks are assigned to CPUs. When it is time
> > > >
> > > > Not sure if we want to remark the fact that EAS is looking at CFS tasks
> > > > only ATM.
> > >
> > > Oh, what's wrong about mentioning it ? I mean, it is a fact ATM ...
> > 
> > But it won't hurt to mention that it may cover other scheduling
> > classes in the future.  IOW, the scope limit is not fundamental.
> 
> Agreed, I can do that.

Oh, sorry, bad phrasing from my side. I meant that we should probably
state clearly somewhere that EAS deals with CFS only ATM, but extending
it to other classes (DEADLINE in particular) makes certainly sense and
people are welcome to experiment with that.

So, yeah, I agree with both of you. :-)
