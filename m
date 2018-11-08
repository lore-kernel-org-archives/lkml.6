Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5013420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYWQ3pSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5013420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKIBlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:41:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43505 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKIBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:41:07 -0500
Received: by mail-io1-f66.google.com with SMTP id t81-v6so14977719iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2Vr2ZG0zmyLRrHVdW5RJrZXBbVNMkLlMfTVb6ZhAWw=;
        b=IYWQ3pSFlzh5J06f79t5H2cChUEZpF7UwJCAap7A7WvjnqQy4sh4vxvJ3BFXh8or76
         7rZ+COX0Izx7R80dMa3MWlSBzByNHlPqGo7zt0/ODkIbG3Yk3epo5F2cj0SBzG3v0K7j
         mXlUM3tmfrVw9Dd43cFb1QkaMCW2UEJQV9mZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2Vr2ZG0zmyLRrHVdW5RJrZXBbVNMkLlMfTVb6ZhAWw=;
        b=M/TO/OHlEN31JcfCVx3iAfgx7OzV9pc/9DunTFpdt7cXrmrtK+wRr1t9xxowH3UahO
         l6gKYm9nn34anRudok6UEaIFl1tP7peYM/kBP1FWBQ4J8SY5cT7QRtCRtKyxgQjtQaQw
         oZP+xOP8itiTKNFqKU2YpTrwwE53OGE3SGlBr5e80Fgq8q7jG6T3EYxiWj6vJhbxSdKk
         Su0Ybw3qDW5Ka4Tcdk0ME3ukyBDo8NkoWFVY0cd7lM0GaZtw+jL3fhXLry6b6wbolFiK
         h9XKDAsA26zAV5iJmdaZpJqJMErbkBFVjjFesPP2I8i4STBq9VgKyRbUIMN/Zp4ZimUT
         u/nw==
X-Gm-Message-State: AGRZ1gJrJ0NOXlaggwIraHq8HVIhe4dY7dHGY5jJOKGQ1yG4KoMUe4wX
        mnMAvD202OwZO8LmOHi+XD8+hlx9MEtNPTWeRNe9Nw==
X-Google-Smtp-Source: AJdET5ebzkjad4B1S7teT+ffjXO2w1t7oj6kypYNdnaJaVrbAvTtV6fWeld1NhYyL3CFpQYdBdqbUOUmVbyXfgKQP9E=
X-Received: by 2002:a6b:244:: with SMTP id 65-v6mr3979758ioc.183.1541693097005;
 Thu, 08 Nov 2018 08:04:57 -0800 (PST)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com> <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
 <28af1313-8153-624d-1ae9-1554bb2db474@arm.com> <20181108113532.vh7q3s3k7vpbevl3@queper01-lin>
In-Reply-To: <20181108113532.vh7q3s3k7vpbevl3@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 8 Nov 2018 17:04:45 +0100
Message-ID: <CAKfTPtCXPSUXE_zL9Paoazv0EmXStv7ZUtG6JJqZb5o0Zfg9vw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 at 12:35, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Wednesday 07 Nov 2018 at 11:47:09 (+0100), Dietmar Eggemann wrote:
> > The important bit for EAS is that it only uses utilization in the
> > non-overutilized case. Here, utilization signals should look the same
> > between the two approaches, not considering tasks with long periods like the
> > 39/80ms example above.
> > There are also some advantages for EAS with time scaling: (1) faster
> > overutilization detection when a big task runs on a little CPU, (2) higher
> > (initial) task utilization value when this task migrates from little to big
> > CPU.
>
> Agreed, these patches should help detecting the over-utilized scenarios
> faster and more reliably, which is probably a good thing. I'll try to
> have a look in more details soon.
>
> > We should run our EAS task placement tests with your time scaling patches.
>
> Right, I tried these patches with the synthetic tests we usually run
> against our upstream EAS dev branch (see [1]), and I couldn't see any
> regression, which is good sign :-)

Thanks for testing

>
>
> <slightly off topic>
> Since most people are probably not familiar with these tests, I'll try
> to elaborate a little bit more. They are unit tests aimed to stress
> particular behaviours of the scheduler on asymmetric platforms. More
> precisely, they check that capacity-awareness/misfit and EAS are
> actually able to up-migrate and down-migrate tasks between big and
> little CPUs when necessary.
>
> The tests are based on rt-app and ftrace. They basically run a whole lot
> of scenarios with rt-app (small tasks, big tasks, a mix of both, tasks
> changing behaviour, ramping up, ramping down, ...), pull a trace of the
> execution and check that:
>
>    1. the task(s) did not miss activations (which will basically be true
>       only if the scheduler managed to provide each task with enough CPU
>       capacity). We call that one 'test_slack';
>
>    2. the task placement is close enough to the optimal placement
>       energy-wise (which is computed off-line using the energy model
>       and the rt-app conf). We call that one 'test_task_placement'.
>
> For example, in order to pass the test, a periodic task that ramps up
> from 10% to 70% over (say) 5s should probably start its execution on
> little CPUs to not waste energy, and get up-migrated to big CPUs later
> on to not miss activations. Otherwise one of the two checks will fail.
>
> I'd like to emphasize that these test scenarios are *not* supposed to
> look like real workloads at all. They've be design with the sole purpose
> of stressing specific code paths of the scheduler to spot any obvious
> breakage. They've proven quite useful for us in the past.
>
> All the tests are publicly available in the LISA repo [2].
> </slightly off topic>
>
>
> So, to come back to Vincent's patches, I managed to get 10/10 pass rate
> to most of the tests referred to as 'generic' in [1] on my Juno r0. The
> kernel I tested had Morten's misfit patches, the EAS patches v8, and
> Vincent's patches on top.
>
> Although I still need to really get my head around all the implications
> of changing PELT like that, I cannot see any obvious red flags from the
> testing perspective here.
>
> Thanks,
> Quentin
>
> ---
> [1] https://developer.arm.com/open-source/energy-aware-scheduling/eas-mainline-development
> [2] https://github.com/ARM-software/lisa
