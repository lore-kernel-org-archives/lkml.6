Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D79C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A8120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547809115;
	bh=lYGaFjnPnH4xjFjy79/y68qSgQXCTDur8x5h5rhxydw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zv7TWXAjTDI2fs587yxtskNh+nRSb+a+7sqdXfHquiLk4HdIXe4QKCqgQ7MGiFQ4w
	 Gm0jMe3HDRT1+PaeHLL4Ue6AUrFlgnvvZtZSEQAsBv5vbG2XxlxRKkTkSEYsC9OMlc
	 IA3RAPTT0KwwFp04QXDgSXWSRnX6B2zWik9VcFqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfARK6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:58:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40830 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfARK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:58:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id t204so8641398oie.7;
        Fri, 18 Jan 2019 02:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JziQ1Qh8jFaTTCMoH48wl0YfwzuzRkq9NWufSf0sYoo=;
        b=hUBvV81jlytIxF4WxyZICjBaGwHCByGY/009BILWU5fi36ywgdaQrp2srniyYCZPrN
         0ycwdExyVNWlfLtxDKh5uI4dVCt+mDiPcxC++ByJHYEPDGUsT7TsfaOcEQ/aaFZxQhir
         jPBPjgQxCjQr1nr7en1daxV6yHa95ykCmX0K3/ZOrk/6OG47srsy1s5lg337sZ0aK1ls
         3q4hTHgissrnWne7MYx0kDQejjzWxf2RrqNTm2IvYTMqRMIpNrkS7i08VfrPJ5M5uyxV
         r3Ysg+UsVdX18Hith0bMaCr/3Dl2/M0Xy6gn3Dtrq2XYqYabzGINOzCnaZqhHl2xH0KU
         pCkg==
X-Gm-Message-State: AJcUukdsZywcIeOop0GiqjS0Aw7TFuFOEHCx0AGUG3DY9tyRnGLHjtKK
        5JWmnq+cOI0I3mdEHON2MBppAqCNjMCqvrsKTrA=
X-Google-Smtp-Source: ALg8bN5XOrCoTr6yZjBjyfj+J8krW9QYY3G0JRHorfNO+0D1yiDArCeS+BfG4NDIfcYr4QP+fw7tiyrQ3Ee5GZWSEo4=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr367075oix.246.1547809111788;
 Fri, 18 Jan 2019 02:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20190110110546.8101-1-quentin.perret@arm.com> <20190110110546.8101-3-quentin.perret@arm.com>
 <20190117155117.GG14385@localhost.localdomain> <20190118091652.xn6iw52tccwh6vap@queper01-lin>
 <CAJZ5v0jw0BgmkwrtjuiC7YKO6A+k2eFfFDGtGsSWymW8PSTscA@mail.gmail.com> <20190118103359.jqctbopx25h3zvqs@queper01-lin>
In-Reply-To: <20190118103359.jqctbopx25h3zvqs@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 11:58:20 +0100
Message-ID: <CAJZ5v0jHq8pgB=XPydTyiqpUpX4ZdA5DVbk=Lqh=aUDBr-QOQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: Document Energy Aware Scheduling
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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

On Fri, Jan 18, 2019 at 11:34 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
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
>
> > > > > +for the scheduler to decide where a task should run (during wake-up), the EM
> > > > > +is used to break the tie between several good CPU candidates and pick the one
> > > > > +that is predicted to yield the best energy consumption without harming the
> > > > > +system's throughput. The predictions made by EAS rely on specific elements of
> > > > > +knowledge about the platform's topology, which include the 'capacity' of CPUs,
> > > >
> > > > Add a reference to DT bindings docs defining 'capacity' (or define it
> > > > somewhere)?
> > >
> > > Right, I can mention this is defined in the next section. But are you
> > > sure about the reference to the DT bindings ? They're arm-specific right ?
> > > Maybe I can give that as an example or something ...
> >
> > Example sounds right.
> >
> > You also can point to the section below from here.
>
> Sounds good.
>
> > Side note: If the doc is in the .rst format (which Peter won't like
> > I'm sure :-)), you can actually use cross-references in it and you get
> > a translation to an HTML doc (hosted at kernel.org) for free and the
> > cross-references become clickable links in that.
>
> Right, I personally don't mind the .rst format, but the existing files
> in Documentation/power/ and Documentation/scheduler/ are good old txt
> files so I just wanted to keep things consistent.

In fact, Documentation/power/ is under a slow on-going transition to
.rst (due to the benefits mentioned above).

> I don't mind converting to rst if necessary :-)

It is not necessary, but maybe worth considering.
