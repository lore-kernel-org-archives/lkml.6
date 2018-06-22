Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F2DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1F1243FB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzjzGqEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1F1243FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933715AbeFVOuM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:50:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54546 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFVOuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:09 -0400
Received: by mail-it0-f68.google.com with SMTP id 76-v6so3179764itx.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+NQcT7gcjtlgehD9loAIA0bpMq5p6KCsCKyDySf2OY=;
        b=kzjzGqEmjEYjpDJeYUsE7p1SaTsBe3nh5PLaM9tilaoH5zxVM9pSPt3pv/N+C8ap6U
         hMCxM7noZ4mLmXHEcseQEZodA6/w9UsN1PxiS+H7RYOsjKnsq/++vZbF6bmDLCq2z27O
         4vBqc5T42wUfdw1bUlDhI20x9HC6n0/eoeskw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+NQcT7gcjtlgehD9loAIA0bpMq5p6KCsCKyDySf2OY=;
        b=Urqi4ro2nzKOphi997C2o+4I4GiXS7RiWzdwQ8QSESDwGOu3d0rIOwFZqBo0NGW+31
         ZQIVofJ4+b6/Qp935ZAmzd/R0wxtIuN5mpiZUuQCjXENlhLxVc5AQsJEi68v4z4r72AI
         AbM8he2VVx2vYX3TNIV6itCAVVQ9sd46+5cpZ7oQybHJA458zrQKoST5yluXPhRoDwhO
         SfKPJixVOm6aRNzGNlc/5RoGx7lMPTABGyFL1td3AbJP5h2C8f7eucU9/X3SeKCxomwM
         eO1sOQRgz1cpT7taKd8W55aRLHuXbAR7aHE7fkgUkRtNT8+nUdce2uZvOSvLOF6amk8r
         g/3w==
X-Gm-Message-State: APt69E2YNVl5Jq74A7UxEQ2EGN4qSFeYuL1j1+0vAV+IYO1Vm9yCibI7
        n6tsXR7FrFomsPCF6S7Bx3I6i9R7fy5PA3RQxpSYXA==
X-Google-Smtp-Source: ADUXVKKkqNXikdByPnUkfYfy145zqww/e7HHvtHChgRbhw38dDCEhljwnjZLinaWecy4XxJHmRYSjqlsAYjUluVSfK4=
X-Received: by 2002:a24:9401:: with SMTP id j1-v6mr1696174ite.89.1529679008115;
 Fri, 22 Jun 2018 07:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net> <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net> <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
 <CAKfTPtC-4HyMZ82oDdVamN3FVtP4VgShPO6JSei3GZHWv8EqNQ@mail.gmail.com> <20180622144603.GR2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180622144603.GR2476@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 16:49:56 +0200
Message-ID: <CAKfTPtAhw+2UQ-k05tnOSUv9xTOZxdw6KdY0Lrik9XRrS-Y+Hg@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 16:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 22, 2018 at 03:57:24PM +0200, Vincent Guittot wrote:
> > On Fri, 22 Jun 2018 at 15:54, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > > On Fri, 22 Jun 2018 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > > And that is my objection to that straight sum thing; there the dl util
> > > > distorts the computed dl bandwidth thing even if there is no cfs
> > > > utilization.
> > >
> > > hmm,
> >
> > forgot to finish this sentence
> >
> > hmm, dl util_avg is only used to detect is there is idle time so if
> > cfs util is nul we will not distort the  dl bw (for a use case where
> > there is no rt task running)
>
> Hurm.. let me apply those patches and read the result, because I think I
> missed something.

ok.

the patchset is available here if it can help :
https://git.linaro.org/people/vincent.guittot/kernel.git   branch:
sched-rt-utilization

>
