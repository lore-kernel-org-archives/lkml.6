Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50028C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2920855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547805444;
	bh=8eNTWXxioR9E5olBMR3uYVeqbKxgrLsRKpb2AsjLfTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f5wX8CSs92Ybm8SndRxp8yZYTsUnTaxGV46Anc0IArEEJ0TwxpfjbhU8RH5ozTcMe
	 kCkwXDrZmPNjskV81xn/79tUAEzZ+DtKa8JrSvcsdvg/Uvb+1iRbv96JD95wttM7VU
	 iUsu3hToJI/iHQyuEnDOPLxCA4c8Om8llhrojAF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfARJ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:57:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47052 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:57:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so8499674oif.13;
        Fri, 18 Jan 2019 01:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T36xT3KklDJSi9mofVJl4fRazTqUIiFyCa6uIdD9cYA=;
        b=NjdhpzgLe2G64qHk670MboSndeXBRQlc8yQVDR2/F7FrEkCIZiRF1maZ23AAqIS6vV
         pS/SOOcggyMowgxpDaYLp+wdwT/v0Ei9umBMxAlI3lw05exEGQG/EtJM4PMIQsV8NWs3
         rt3sMqPYUY+ATPwyeiYR6hOLOtJXYDacatrja4qKbbQ+pVPZAOgRsfPBq196/T5tdKVc
         rdyRh1ymrm75QpYIuNH0h1a0I9tFve1fgwzWAPsR50a/FUf+daZD/2qe6NsUhXm4LqlH
         sXSmyWX4Ucg0mU3uYKp3Hp9cyc7wARVF1Dqw2JJbxfEFh6o5HlZqmc+kLacVSgcXnOYj
         h1hA==
X-Gm-Message-State: AJcUukc3LmKyHWiilFxmPfZNARd/Ik2659BnJE1kaQm8aXB+DsWpxcNr
        PwUMnqA/iTYOh9ZsvdkNT1AC3rQK1cT5okzi14w=
X-Google-Smtp-Source: ALg8bN47s3GtC9ViwmZDTJ89ds4kjFxhzRT+dI8Db8ZH6UNkQJYIp9ENx9JnGIVzMrRqYabOxbqy0bzH9JjSbvpdO3o=
X-Received: by 2002:aca:b642:: with SMTP id g63mr273918oif.195.1547805440560;
 Fri, 18 Jan 2019 01:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20190110110546.8101-1-quentin.perret@arm.com> <20190110110546.8101-3-quentin.perret@arm.com>
 <20190117155117.GG14385@localhost.localdomain> <20190118091652.xn6iw52tccwh6vap@queper01-lin>
In-Reply-To: <20190118091652.xn6iw52tccwh6vap@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 10:57:08 +0100
Message-ID: <CAJZ5v0jw0BgmkwrtjuiC7YKO6A+k2eFfFDGtGsSWymW8PSTscA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Document Energy Aware Scheduling
To:     Quentin Perret <quentin.perret@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:16 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Juri,
>
> On Thursday 17 Jan 2019 at 16:51:17 (+0100), Juri Lelli wrote:
> > On 10/01/19 11:05, Quentin Perret wrote:
> [...]
> > > +The idea behind introducing an EM is to allow the scheduler to evaluate the
> > > +implications of its decisions rather than blindly applying energy-saving
> > > +techniques that may have positive effects only on some platforms. At the same
> > > +time, the EM must be as simple as possible to minimize the scheduler latency
> > > +impact.
> > > +
> > > +In short, EAS changes the way CFS tasks are assigned to CPUs. When it is time
> >
> > Not sure if we want to remark the fact that EAS is looking at CFS tasks
> > only ATM.
>
> Oh, what's wrong about mentioning it ? I mean, it is a fact ATM ...

But it won't hurt to mention that it may cover other scheduling
classes in the future.  IOW, the scope limit is not fundamental.

> > > +for the scheduler to decide where a task should run (during wake-up), the EM
> > > +is used to break the tie between several good CPU candidates and pick the one
> > > +that is predicted to yield the best energy consumption without harming the
> > > +system's throughput. The predictions made by EAS rely on specific elements of
> > > +knowledge about the platform's topology, which include the 'capacity' of CPUs,
> >
> > Add a reference to DT bindings docs defining 'capacity' (or define it
> > somewhere)?
>
> Right, I can mention this is defined in the next section. But are you
> sure about the reference to the DT bindings ? They're arm-specific right ?
> Maybe I can give that as an example or something ...

Example sounds right.

You also can point to the section below from here.

Side note: If the doc is in the .rst format (which Peter won't like
I'm sure :-)), you can actually use cross-references in it and you get
a translation to an HTML doc (hosted at kernel.org) for free and the
cross-references become clickable links in that.
