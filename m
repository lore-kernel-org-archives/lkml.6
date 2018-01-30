Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeA3T4g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:56:36 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36694 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeA3T4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:56:35 -0500
X-Google-Smtp-Source: AH8x22435bjYiMmaCe6rA7x9GhW5+njHcIoy5cCb+Kce363TR+eskutwPXU2zMY3ekGIJZFXou8c47xySicy0XQ4KHU=
MIME-Version: 1.0
In-Reply-To: <20180130185212.GA16806@krava>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
 <20180130133917.GC29098@krava> <6d708c09-52a7-a906-b651-b133a7b4f189@linux.intel.com>
 <20180130150454.GE29098@krava> <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
 <CABPqkBRWtSsKEM7ycPs0HYSKLsYDmZhr4ztUmMMqsytYamPGsw@mail.gmail.com>
 <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com> <20180130185212.GA16806@krava>
From: Stephane Eranian <eranian@google.com>
Date: Tue, 30 Jan 2018 11:56:33 -0800
Message-ID: <CABPqkBRp9bDmGECStbAHA5Ja0SjJmDQ2SOceat=qXno707MuAA@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
To: Jiri Olsa <jolsa@redhat.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 30, 2018 at 11:48:18AM -0500, Liang, Kan wrote:
>
> SNIP
>
> > > >
> > > > The events in fixed mode could enable large PEBS. Events in freq mode should
> > > > not enable large PEBS.
> > > > I think that could be a problem if some events try to enable large PEBS,
> > > > while others not.
> > > >
> > > You only enable large PEBS if 100% of the events use fixed periods,
> > > either via -c period
> > > or because they all use individual period=p. The --no-period could
> > > also be used to remove
> > > the period for measurements where the period is not needed.
> >
> >
> > Oh, right, the kernel has already guaranteed that.
> >       if (cpuc->n_pebs == cpuc->n_large_pebs) {
> >               threshold = ds->pebs_absolute_maximum -
> >                       x86_pmu.max_pebs_events * x86_pmu.pebs_record_size;
> >       } else {
> >
> > Sorry for the noise.
> >
> > jirka's patch looks good to me.
>
> cool, I'll post it later this week
>
Still, the part I am missing here, is why asking for
PERF_SAMPLE_PERIOD voids large PEBS.
