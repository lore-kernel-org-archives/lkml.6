Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF12620833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MY+67Xgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF12620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeILVBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:01:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeILVBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:01:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so2604615wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ty0hsPtlDxkVSvhrAb3oFo5WMkAGEZViSsriu4+ocSg=;
        b=MY+67XgoBOeHRFvdBk9/9zmsIOq7kNvzQZSuszRrWqor4y3wAs26igs6QLQFDlI2iD
         CVQM2E9ijyuN4d0pkvDiDGAA/eCEQGjwjDcrSC4zIHxpXvcFZ1o4kPPray9ORYYzLK3A
         FUbZDRAQoQ5FbARr1QOR9wSg+1VLntldQsyNWJ3WKb5Qnr5kLz2cVfqtINM+28UBcTN1
         8WywZ/P8aLukanx/h8891AOnaq2WE00+I3Gonnh9mus1XLxOTpjQhtnpqis03ClYVP5k
         ks4LN1pXhGb71XoIXDgbOtGUnfevvnOfP4shnQ10mPDDsV1IbTChGW/tzAktnT0caQCt
         0JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ty0hsPtlDxkVSvhrAb3oFo5WMkAGEZViSsriu4+ocSg=;
        b=PLb3+Ra2LQNawxRoQyd+XgtdJ8pXCrdvHeLLpHCXF0J77L3fY24lFlcoxETELG3wHR
         Vh8NMFmekTuW0Q3X5t/Gu0RTAqrjbEiraGPm8RBFIdNPnWLON+qOs2WyYD3ElGleHDsk
         b8SMy0U4WAcf12d8CsyU+LUdr+aH9EktEpqGKfL3VM86gBTggkSrBSJkwkGC+BM4QI2m
         Ee9Iy1CbOYXDaEcHfiqF3c/FP0Y03DBNv+IVN7iYLXUvMDkPJqlOeodbfoFLV76NRNF8
         VJMIEsKIBddDPDKFVq07iZTC2mEdIiLT+JEHfPsN8eBy0Bski8xey1VC/wUR4VrLQMXN
         r1/g==
X-Gm-Message-State: APzg51AaJ/KQtMFVCMtphktuGP2hS0yHmvqObThlg+1FXHna7/+x2jdP
        PSsB4Shy7T9ydgE2iUPzi+/p/ocz0y/ngVrHQa+HNP9y
X-Google-Smtp-Source: ANB0VdafG4JUauk9x3zczBHJ/gENPJ6jjG2fNXstnekFqMM7wy5e4XGd6qnt5bi+qPon3W5s3/3KmmRYGYHEGZAZ2vE=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr1887415wrp.184.1536767782859;
 Wed, 12 Sep 2018 08:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 08:56:22
 -0700 (PDT)
In-Reply-To: <20180912125133.GE1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com> <CAJuCfpHaqNzgpbPCAUxsv+E4HL6vSDKem+sFh2njK1e9dX5ONA@mail.gmail.com>
 <20180912125133.GE1413@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Sep 2018 08:56:22 -0700
Message-ID: <CAJuCfpEVEohpfYCaca_NXkfe+5fhrzLE+mux2ffQD0SMG24mCQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 5:51 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 08-Sep 20:02, Suren Baghdasaryan wrote:
>> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> > +  cpu.util.min.effective
>> > +        A read-only single value file which exists on non-root cgroups and
>> > +        reports minimum utilization clamp value currently enforced on a task
>> > +        group.
>> > +
>> > +        The actual minimum utilization in the range [0, 1023].
>> > +
>> > +        This value can be lower then cpu.util.min in case a parent cgroup
>> > +        is enforcing a more restrictive clamping on minimum utilization.
>>
>> IMHO if cpu.util.min=0 means "no restrictions" on UCLAMP_MIN then
>> calling parent's lower cpu.util.min value "more restrictive clamping"
>> is confusing. I would suggest to rephrase this to smth like "...in
>> case a parent cgroup requires lower cpu.util.min clamping."
>
> Right, it's slightly confusing... still I would like to call out that
> a parent group can enforce something on its children. What about:
>
>    "... a parent cgroup allows only smaller minimum utilization values."
>
> Is that less confusing ?

SGTM.

>
> Otherwise I think your proposal could work too.
>
> [...]
>
>> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
>> > +/**
>> > + * cpu_util_update_hier: propagete effective clamp down the hierarchy
>>
>> typo: propagate
>
> +1
>
> [...]
>
>> > +                * Skip the whole subtrees if the current effective clamp is
>> > +                * alredy matching the TG's clamp value.
>>
>> typo: already
>
> +1
>
>
> Cheers,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
