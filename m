Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CC720821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I196i83h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfAII2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:28:39 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44448 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbfAII2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:28:38 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so5351086iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 00:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwZwEOQ7fEMI2ww0uv7KdLHhEOm9BiRPB6x1IPlIo80=;
        b=I196i83hGJFzc+fFu9tFlj6sh0ijCNQFKLIpVlvfHH/iRTsZrrJ9L058udaMhlqpwW
         dYNRP8W7G1r2Ftx+h6P58VsS9+n8o50bysJAS+TyrqdQYSGgEvdFtSi1UfIj3ZB111TG
         MOpBSakaV1QAH7ueSLwDbb5/+vTpK2ld5dC7APblzr+IRS/qHME2+uOsbwHzZNMHKjdg
         q0eIiqvS7Y/MmXAG7UI+Yp1xgQYbdt0ApVvhQyE704hLvfTUx6sJeJckf5Az/U03Ban0
         Tt+VfwPeruIIF4Kt5mJAFXoe2qW/cqu4JeJrPUT1lQ/n/DUoV+E1tIR833KR1/O2koLn
         g14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwZwEOQ7fEMI2ww0uv7KdLHhEOm9BiRPB6x1IPlIo80=;
        b=YWSWp5Bp1x8AR7jgz+LZPSFVxvW3/IFkA0KJotzAfuSYGShfmaN3jd/+xfcpHnvZWN
         jWRCUGdONtFI2DunBtvcZJpE/Oe0Wak7EmGmEorjFxBEJuDMJ+tgCZ4ZHJdPOAPomY9Q
         rNc6cbyN8vQlOHP/oyheiPzhnpqswEY3NZXypyM5veYuB+dEZWXB0Fi38SAA6rWcH0bw
         SQEmd/4Fyf3uJBPQvcszpqsb8ZJzPK/cmv9Vlnn8pN+2D3eiNIsHC7f3loSTyDLgo2t9
         CkYl+NYj2EglY5aMs03ABqL08yYpwItESa3v5XRy933M/PENCvM1W76CvwkDXxBKo/Qx
         uTQg==
X-Gm-Message-State: AJcUukerwmmr0sWav7tYhTGH5U8fRBXK4VqPGhHhNDPNoPpoOOtTOJom
        WJX7P4JETLqy0Ivl1arKIQH0CMEZ0hU2ptHOnGnf8A==
X-Google-Smtp-Source: ALg8bN5LzZIId3QQIMF+8v2J++UFGfKJ+6DRYaRNGGixXYp2/AKh7PA+zqOMh1S6R2CFyjwAWRwzC6uD3hPaK3EIJAA=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr2711236ior.282.1547022516668;
 Wed, 09 Jan 2019 00:28:36 -0800 (PST)
MIME-Version: 1.0
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
 <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com> <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
 <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
 <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com>
 <CAHk-=wjS8MG+xcHgjx-BTcAdyh7fugbHQkdJFcwBk=6QEGVKnw@mail.gmail.com> <CACT4Y+Y8pMfxyWgsM2roX8DpDUFMigiR90aY7SMTAQCTcz7SHw@mail.gmail.com>
In-Reply-To: <CACT4Y+Y8pMfxyWgsM2roX8DpDUFMigiR90aY7SMTAQCTcz7SHw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Jan 2019 09:28:25 +0100
Message-ID: <CACT4Y+biZXfPiU4SPRj=WZAr+J=tazJ7GxxWFce0kO1OPT8hmw@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dledford@redhat.com, KVM list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>, Kostya Serebryany <kcc@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chris Mason <clm@fb.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Olof Johansson <olofj@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Tso <tytso@google.com>, Tim.Bird@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 3:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Dec 28, 2018 at 10:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Dec 28, 2018 at 1:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > Nobody reads the kernel mailing list directly - there's just too much traffic.
> > >
> > > As the result bug reports and patches got lots and this is bad and it
> > > would be useful to stop it from happening and there are known ways for
> > > this.
> >
> > Well, let me be a  bit more specific: you will find that people read
> > the very _targeted_ mailing lists, because they not only tend to be
> > more specific to some particular interest, but also aren't the flood
> > of hundreds of emails a day.
> >
> > And don't get me wrong: I'm not saying that lkml is useless. Not at
> > all. It's just that it's really more of an archival model than a
> > "people read it" - so you send your emails to a group of people, and
> > then you cc lkml so that when that group gets expanded people can be
> > pointed at the whole thread. Or, obviously, so that commit messages
> > etc can point to discussion.
> >
> > But that does mean that any lkml cc shouldn't be expected to cause a
> > reaction in itself. It's about other things.
> >
> > > syzbot not doing bisection is not the root cause of this
> >
> > Root case? No. But if you do bisection, it means that you can now
> > target things much better. So then it's not lkml and "random
> > collection of maintainers", but a much more targeted group.
> >
> > And that targeted group also ends up being a lot more receptive to it.
> >
> > Again, look at the raw syzbot email and the email by Wanpeng Li. Yes,
> > the syzbot email did bring in a reasonable set of people just based on
> > the oops (I think it did "get_mainainter" on kvm_ioapic_scan_entry()).
> > But Wangpeng ended up sending it to the *particular* people who were
> > directly responsible.
> >
> > > 2. syzbot reports are not worse then average human reports, frequently better.
> >
> > No, they really aren't.
> >
> > They are better in a *technical* sense, but they are also very much
> > obviously automated, which makes the target people take them much less
> > seriously.
> >
> > When you see lots of syzbot emails, and there are lots of more or less
> > random recipients that may or may not be correct, what's the natural
> > reaction to that?
> >
> > Look up "bystander effect".
> >
> > > 3. Bisection is useful, but not important in most cases.
> >
> > No.
> >
> > Exactly because of the problem syzbot has. It's too scatter-shot.
> > People clearly ignore it, because people feel it's not _their_ issue.
> >
> > The advantage of bisection is that it makes the problem much more
> > specific. Right now, you'll find that many developers ignore syzbot
> > simply because it's not worth their time to chase down whether it's
> > even their problem.
> >
> > See what I'm saying?
> >
> > It's the whole "data vs information" issue. Particularly when cc'ing
> > maintainers, who get hundreds of emails a day, you need to convince
> > them that this email is _relevant_.
>
> I see what you are saying and I agree that bisection results will make
> reports better in some cases. But I mean a more general problem.
>
> Say you reported a bug, and it happened so that you missed that single
> right person in CC because something, whatever, can happen, right?
> With the current process it will be a coin flip if your report will be
> routed to the right person or lost. And it's not that you personally
> care a lot about this particular bug, it just happened that you
> noticed it and wanted to be a good samaritan. So you will not keep
> track of it on a post-note on your monitor and won't ping later. But
> the bug can be bad and either cause security problems later, or reach
> release and break things in the field and then require 1000x more work
> to port the fix to all downstream forks.
>
> Or, we heavily rely on end users for testing. End users are not kernel
> developers and can't be generally expected to do pre-triage and proper
> routing. Losing these valuable reports is bad because only small
> fraction of users report anything to projects and this can also affect
> user trust, if you see that your reports are not acted on, you don't
> report next time.
>
> Even if we take syzbot, it won't be able to bisect all the time for
> multiple reasons:
>  - some bugs don't have reproducers (but still very real and sometimes
> manageable to fix)
>  - kernel is build/boot broken sometimes for prolonged periods
>  - some old bugs are bisected to introduction of the debugging tool
> that detects the bug
>  - some crashes can be too flaky for reliable bisection
>  - some reproducers won't work on older kernels, yet the bug is there
>  - ...
> So it's will be nice to have bisection results when they are
> available, but it does not feel like it should be the only guarantee
> of a bug report not being lost.
>
> Moreover, you can see in the examples I referenced above that they
> were delivered to the right people, but then still lost because there
> is nothing in the kernel development process that would prevent loses.
>
> Moreover, replying on a small set of private emails generally creates
> problems wrt bus-factor and vacations. It would be useful if anybody
> could see what are the open bugs for rdma_cm subsystem at any point in
> time.

This is quite indicative:

Serious issues affecting all filesystems:

Kernel quality control, or the lack thereof
https://lwn.net/Articles/774114/

Comment on ycombinator:
https://news.ycombinator.com/item?id=18844612

I've filed bugs for some of the mentioned copy_file_range() issues
more than two years ago:
- https://bugzilla.kernel.org/show_bug.cgi?id=135461
- https://bugzilla.kernel.org/show_bug.cgi?id=135451
No response...
