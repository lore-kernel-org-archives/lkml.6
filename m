Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE1CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD02073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4dOyw8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAD02073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI2DUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:20:02 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38509 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeI2DUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:20:02 -0400
Received: by mail-ot1-f51.google.com with SMTP id h15-v6so7333546otj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFY6aqOxx6i+K5Q/DjbhTXWf4HP8ZHwThzBzWHhx/d0=;
        b=b4dOyw8jLewPsNG9T8BzlZwg6RN6VEHzrA8MLbj+p/pTVbyLCXcaRpRSCN4EyqJ5G9
         A+Vgj+ItK29D0xl/04AUR5IFVl7JgdbOznxJAxOnsqkKY72F2oPNjdumIt+XNov0mbAV
         CVTHHbHQ3lDJBpdhu/WvgxMwYCXqYT+lKFRTc5Ax6IxYC+xdl/DOVJrXtNpzKq+fE+3K
         r+tLLUguscdBOaoU/cmipv0jbEXL+El5uONnMzKSMSZwfLxIzfd+enm8GGoMSr5gOuwZ
         QWNZ6yPQY22rWCDOLHsxMPw9WSaAzoTBlF55pe2Z3xy80emVVadQ4xzZANw/ZXy0Q9IF
         7X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFY6aqOxx6i+K5Q/DjbhTXWf4HP8ZHwThzBzWHhx/d0=;
        b=qGjTEW3SkBk2FRfWhJPiqzHsRKmEG+DKqUQgiE/ekITjS4n3Y/ogZeGQFoe0ulrwod
         ADbHboOM9VgOnRhthQ00ErQyMnSGYedt8YDcG7RZWHJmaXtgoJVclbh/QAtSb3f8p0pA
         7Nyv3G5E2ccXEhIzw5qyQAX+OTiKKxXqcW19tij4tcycBcdIW3OsdJRgE8qKUe5k52ii
         2x8UGg44s6Iu+ytRdo2NZ+LV0NU1NyYQaLdi0CuhN0xd+8nTIuFuY+JjVKlzM6VOfETD
         0MTPcVvvwUqa3QNGyWDq+rQxQ6GBEhDFGFT8LI3GpeeEzlJMVG8EYgxS3nt4X2NUdHwS
         bjxA==
X-Gm-Message-State: ABuFfoj7+yv1c2PsDm4wcCyfkT9FbSlfjoSJG+7ancu7jNuMdVUUA009
        d7CYBeBRT4iNpDezCLLoUm0jCWPmG8LEq43uzfVZ9A==
X-Google-Smtp-Source: ACcGV625kNcnm/RXEbbg6UgBZzKSNyiTqgRMKnF4pFk1kNVHfkCuFKWqU72IpgjzdHIahz9sJ0CRvmGTHoJ6Kf4GXVs=
X-Received: by 2002:a9d:4716:: with SMTP id a22-v6mr245736otf.242.1538168072259;
 Fri, 28 Sep 2018 13:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com> <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com>
In-Reply-To: <20180928204930.GC32651@tassilo.jf.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 22:54:05 +0200
Message-ID: <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        alexey.budankov@linux.intel.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:49 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Fri, Sep 28, 2018 at 06:40:17PM +0100, Mark Rutland wrote:
> > On Fri, Sep 28, 2018 at 10:23:40AM -0700, Andi Kleen wrote:
> > > > There's also been prior discussion on these feature in other contexts
> > > > (e.g. android expoits resulting from out-of-tree drivers). It would be
> > > > nice to see those considered.
> > > >
> > > > IIRC The conclusion from prior discussions (e.g. [1]) was that we wanted
> > > > finer granularity of control such that we could limit PMU access to
> > > > specific users -- e.g. disallow arbitrary android apps from poking *any*
> > > > PMU, while allowing some more trusted apps/users to uses *some* specific
> > > > PMUs.
> > > >
> > > > e.g. we could add /sys/bus/event_source/devices/${PMU}/device, protect
> > > > this via the usual fs ACLs, and pass the fd to perf_event_open()
> > > > somehow. A valid fd would act as a capability, taking precedence over
> > > > perf_event_paranoid.
> > >
> > > That sounds like an orthogonal feature. I don't think the original
> > > patchkit would need to be hold up for this. It would be something
> > > in addition.
> >
> > I have to say that I disagree -- these controls will have to interact
> > somehow, and the fewer of them we have, the less complexity we'll have
> > to deal with longer-term.
>
> You're proposing to completely redesign perf_event_open.

And I think it would be a very good redesign. :) I love things that
use file descriptors to represent capabilities.

> This new file descriptor argument doesn't exist today so it would
> need to create a new system call with more arguments

Is that true? The first argument is a pointer to a struct that
contains its own size, so it can be expanded without an ABI break. I
don't see any reason why you couldn't cram more stuff in there.

> (and BTW it would be more than the normal 6 argument limit
> we have, so actually it couldn't even be a standard sycall)
>
> Obviously we would need to keep the old system call around
> for compability, so you would need to worry about this
> interaction in any case!
>
> So tying it together doesn't make any sense, because
> the problem has to be solved separately anyways.
>
> >
> > > BTW can't you already do that with the syscall filter? I assume
> > > the Android sandboxes already use that. Just forbid perf_event_open
> > > for the apps.
> >
> > Note that this was about providing access to *some* PMUs in some cases.
> >
> > IIUC, if that can be done today via a syscall filter, the same is true
> > of per-pmu paranoid settings.
>
> The difference is that the Android sandboxes likely already doing this
> and have all the infrastructure, and it's just another rule.
>
> Requiring syscall filters just to use the PMU on xn system
> that otherwise doesn't need them would be very odd.
>
> -Andi
