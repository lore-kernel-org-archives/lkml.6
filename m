Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE83C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D294C217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY/9MYni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBZI1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:27:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44351 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:27:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id q128so9928225ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GoghCpE3m09U1qCdk54uox+dcUb/swy+30E2QwXbWbc=;
        b=oY/9MYnizFFUwqJF04cYtlg3fOhYSdqpBP3nWcJtFpRwG37osUp2aChr+Ak+wALvNo
         YhRotsYWSQcoJwuUgP3MXl6SuF0jBytrmXuXyGJT0Xbg0g6u/d5DsGMe8EL2/4UeiHzT
         jDRu8+vRr9C7aBaWRzP5RQkUuEHxN/rHQ9PWmYxb+ThD/VPyafSQwA9uRSIAGkEPbaPB
         Qu5qTfAanhnXOOmnzJpuG4Cbk/kTPyU5n3rVeErB0QEuMQYf6Ux1KK90oE8cUlS7Tpcf
         xQzM8Qm/+G3mt89pNfgz8w9soi1NdRttjqGQVfcO2pma0GLZl9qgZtPAxoA0m2GuzWWO
         ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoghCpE3m09U1qCdk54uox+dcUb/swy+30E2QwXbWbc=;
        b=rft9cBYdYUrhq/qT525h/4SW6hmBtr0aW+308wKiBG9FHG3J6KBTU+ss+x4qEDkzH4
         fRRvtHtFRLsBBCpaR3BM7MQv/omxTqHYwMRuD58LtacMLcJG6odNFF+6Ke842kxTElWP
         yhGL3P/1KnDo/VjjqrP9gKYMdnfplDg0U4sB/2KswDcz9feSzWKroIB38CScKR3kIy8j
         4nmoYSnbr4ERuP4KvvRSIGVC1Q1/pMUcMzO9s2TDos/LrqeBHWuuRVLXqbZCSJZEUHqc
         Wg3XWkXGpxbeUpNBAiEzIWFb4suk3pIVzTX+Ioik6mXvLSXhuC5uqKjrRFiwi9w4SwpC
         5h8A==
X-Gm-Message-State: AHQUAuYZh6K5EEx1l5G+L7exzJaf0BhL6ZiiRIoEEmJ566yThMh0dw+5
        z8iS7nb8SDWV4uN6i2sJOvYSRBspjatssTxUmL0=
X-Google-Smtp-Source: AHgI3IaYLEh8VZidui1rqmnD4JEp5NMyZi9JhLP11xc1W/yMj4EYEwdd0dt4dBMniy0zZ2oyjFQvc/Mxzk+PLVsUaWQ=
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr11420233ljd.168.1551169624403;
 Tue, 26 Feb 2019 00:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190218204020.GV32494@hirez.programming.kicks-ass.net> <407b6589-1801-20b5-e3b7-d7458370cfc0@redhat.com>
 <20190222142030.GA32494@hirez.programming.kicks-ass.net> <786668c1-fb52-508c-e916-f86707a1d791@linux.intel.com>
In-Reply-To: <786668c1-fb52-508c-e916-f86707a1d791@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 26 Feb 2019 16:26:53 +0800
Message-ID: <CAERHkruwfKWzP6gySSEFGWKkG9-tZm5YybyUONatkRhULx_nBA@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 3:27 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On 2/22/19 6:20 AM, Peter Zijlstra wrote:
> > On Fri, Feb 22, 2019 at 01:17:01PM +0100, Paolo Bonzini wrote:
> >> On 18/02/19 21:40, Peter Zijlstra wrote:
> >>> On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
> >>>> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>>
> >>>>> However; whichever way around you turn this cookie; it is expensive and nasty.
> >>>>
> >>>> Do you (or anybody else) have numbers for real loads?
> >>>>
> >>>> Because performance is all that matters. If performance is bad, then
> >>>> it's pointless, since just turning off SMT is the answer.
> >>>
> >>> Not for these patches; they stopped crashing only yesterday and I
> >>> cleaned them up and send them out.
> >>>
> >>> The previous version; which was more horrible; but L1TF complete, was
> >>> between OK-ish and horrible depending on the number of VMEXITs a
> >>> workload had.
> >>>
> >>> If there were close to no VMEXITs, it beat smt=off, if there were lots
> >>> of VMEXITs it was far far worse. Supposedly hosting people try their
> >>> very bestest to have no VMEXITs so it mostly works for them (with the
> >>> obvious exception of single VCPU guests).
> >>
> >> If you are giving access to dedicated cores to guests, you also let them
> >> do PAUSE/HLT/MWAIT without vmexits and the host just thinks it's a CPU
> >> bound workload.
> >>
> >> In any case, IIUC what you are looking for is:
> >>
> >> 1) take a benchmark that *is* helped by SMT, this will be something CPU
> >> bound.
> >>
> >> 2) compare two runs, one without SMT and without core scheduler, and one
> >> with SMT+core scheduler.
> >>
> >> 3) find out whether performance is helped by SMT despite the increased
> >> overhead of the core scheduler
> >>
> >> Do you want some other load in the host, so that the scheduler actually
> >> does do something?  Or is the point just that you show that the
> >> performance isn't affected when the scheduler does not have anything to
> >> do (which should be obvious, but having numbers is always better)?
> >
> > Well, what _I_ want is for all this to just go away :-)
> >
> > Tim did much of testing last time around; and I don't think he did
> > core-pinning of VMs much (although I'm sure he did some of that). I'm
>
> Yes. The last time around I tested basic scenarios like:
> 1. single VM pinned on a core
> 2. 2 VMs pinned on a core
> 3. system oversubscription (no pinning)
>
> In general, CPU bound benchmarks and even things without too much I/O
> causing lots of VMexits perform better with HT than without for Peter's
> last patchset.
>
> > still a complete virt noob; I can barely boot a VM to save my life.
> >
> > (you should be glad to not have heard my cursing at qemu cmdline when
> > trying to reproduce some of Tim's results -- lets just say that I can
> > deal with gpg)
> >
> > I'm sure he tried some oversubscribed scenarios without pinning.
>
> We did try some oversubscribed scenarios like SPECVirt, that tried to
> squeeze tons of VMs on a single system in over subscription mode.
>
> There're two main problems in the last go around:
>
> 1. Workload with high rate of Vmexits (SpecVirt is one)
> were a major source of pain when we tried Peter's previous patchset.
> The switch from vcpus to qemu and back in previous version of Peter's patch
> requires some coordination between the hyperthread siblings via IPI.  And for
> workload that does this a lot, the overhead quickly added up.
>
> For Peter's new patch, this overhead hopefully would be reduced and give
> better performance.
>
> 2. Load balancing is quite tricky.  Peter's last patchset did not have
> load balancing for consolidating compatible running threads.
> I did some non-sophisticated load balancing
> to pair vcpus up.  But the constant vcpu migrations overhead probably ate up
> any improvements from better load pairing.  So I didn't get much
> improvement in the over-subscription case when turning on load balancing
> to consolidate the VCPUs of the same VM. We'll probably have to try
> out this incarnation of Peter's patch and see how well the load balancing
> works.
>
> I'll try to line up some benchmarking folks to do some tests.

I can help to do some basic tests.

Cgroup bias looks weird to me. If I have hundreds of cgroups, should I turn
core scheduling(cpu.tag) on one by one? Or Is there a global knob I missed?

Thanks,
-Aubrey
