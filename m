Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765562084A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9TxmLz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeL1JnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:43:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35689 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeL1JnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:43:24 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so26585794itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fb6k0LPeOHNMfCRnerIFkwQ2PZBNuSlETT11x6xzlDg=;
        b=I9TxmLz6icwv2Z+yHRvM7r0nJ8joZtE0Kvwu0hVwx0r73QMzLcbNODLFgKktIyneDO
         6OH/wNN42yTalU9/dicCeVmYEd5kWAr+jquDvhexNHbwu8SfV26algPRjTtlrBVYYyL6
         YxC8b5FgZpcOjRCbeZtaqvSw1d1WoVkbifn4PqPeBDfL5jIsje0hCsm9nWWY3uAuOXat
         tG35kcbxZGiK56OyIemFbUUIUwCT/ueb8Q5uj6ml/D4InvMYIdaTkyzMA0s0gjgL0AuG
         5bGPmLt5GzD88a2M0W//jwltjFVHReF2vd/D+tmL69iTXc0xcolMzC2F/ZyETTZ58dDn
         B6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fb6k0LPeOHNMfCRnerIFkwQ2PZBNuSlETT11x6xzlDg=;
        b=soMtpEhkbeyKsx1pgivkgHB04xWM43RWXpdmDW7QaNGJS2NzRtRZS59KV4Bj17EfSu
         J8IH/UtUMzDD2fmMqh4VEgPnZKpOFUrN9eaY5SyQr1iQ0QG3RGGeSVZ8vRdo4AzaUTT+
         UxPg9ZUd0grGWEDBxy2fikZiP0L6rVzrz820sbkfK540+a2J9vCOKIAjvaZM4VOlXhKM
         t9GoosEc4OHVEkdj/Sdv0jN4viFIgmRDnENfe/9+GhH7m94JmIjXMVMW1omGIlpiGH6t
         XcvVwof3DVGeC+A0EoUZKewpBB0uH2KFR4YNB8JEZ/JhfFqygxQet5BluppLARUHpvLF
         MKnQ==
X-Gm-Message-State: AJcUukc7OdFWQwP9j7FlqAqNH3X2iJjaxE/8McFezvauQZNyDi3FLaTV
        mimbC//EYVctfzrou2+pNUVMbmY8vmWebddp9Pq24A==
X-Google-Smtp-Source: AFSGD/Vqnnmhoh0C30IhPBavbybpLM+wg/nyTFdwE90FAgw3f9TFMtrkHPCjU6PYd2gZcmVHPrhidfgbqaB7xK+UFP0=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr15184364itl.144.1545990202607;
 Fri, 28 Dec 2018 01:43:22 -0800 (PST)
MIME-Version: 1.0
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
 <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com> <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
 <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
In-Reply-To: <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 28 Dec 2018 10:43:11 +0100
Message-ID: <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com>
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

On Thu, Dec 27, 2018 at 6:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Dec 27, 2018 at 6:28 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > Lots of kernel bug reports routinely get lost on mailing lists, which is bad.
>
> Nobody reads the kernel mailing list directly - there's just too much traffic.
>
> And honestly, even fewer people then read the syzbot reports, because
> they are so illegible and inhuman. They're better than they used to
> be, but they are still basically impossible to parse without a lot of
> effort.
>
> And no, syzbot didn't really report the bug with any specificity - it
> wasn't clear *which* commit it was that caused it, so reading that
> syzbot report, at no point was it then obvious that the original patch
> had issues.
>
> See the problem?
>
> So the issue seems to be that syzbot is simply not useful enough. It's
> output is too rough for people to take it seriously. You see how the
> report by Wei Wu then got traction, because Wei took a syzbot report
> and added some human background and distilled it down to not be
> "here's a big dump of random information".
>
> So I suspect syzbot should strive to make for a much stronger
> signal-to-noise ratio. For example, if syzbot had actually bisected
> the bug it reported, that would have been quite a strong signal.
>
> Compare these two emails:
>
>     https://lore.kernel.org/lkml/1542702858-4318-1-git-send-email-wanpengli@tencent.com/
>     https://lore.kernel.org/lkml/0000000000001c7a5c0573607583@google.com/
>
> and note the absolutely huge difference in actual *information* (as
> opposed to raw data).
>
> Any possibility that syzbot would actually do the bisection once it
> finds a problem, and write a report based on the commit that caused
> the problem rather than just a problem dump?

Hi Linus,

I agree there are things to improve in syzbot. Bisection is useful and
we will implement it. This is a popular user request, we keep track of
all them, so nothing is lost:
https://github.com/google/syzkaller/issues?q=label%3A"syzbot+user+request"

But let's not reduce the discussion to syzbot improvements and
distract it from the main point, which is:

> Nobody reads the kernel mailing list directly - there's just too much traffic.

As the result bug reports and patches got lots and this is bad and it
would be useful to stop it from happening and there are known ways for
this.

syzbot not doing bisection is not the root cause of this and most of
what you said does not have place.

1. I specifically added a case where it happens the other way around:
human report was ignored, then syzbot report fixed.

2. syzbot reports are not worse then average human reports, frequently better.
What linked to is not the human report, it's a reply from a developer
that includes a fix with explanation. If you look at the original
human reports, then can see that they miss kernel config, full console
output (sometimes there is some useful information before the crash):
https://www.spinics.net/lists/kvm/msg177705.html
https://www.spinics.net/lists/kvm/msg177704.html
syzbot reports are also better formatted, as one does not need to
parse custom prose to digest information:
https://groups.google.com/forum/#!msg/syzkaller/40Ts5kOqJlo/tEYv9j-3AQAJ

3. Bisection is useful, but not important in most cases.
First of all, both human reports did not contain bisection info. Which
clearly means that bisection is not the reason syzbot reports were not
acted on.
We see fix rate of 75% for reports without bisection. Lots of bugs
don't require even a reproducer (e.g. a wrong local if condition), fix
rate for such reports is 66% for an absolute number of hundreds. For
simple bugs nothing other then a crash message is required. For more
complex ones there is an infinite tail of custom information. E.g.
bisection may not help when a latent bug is unmasked, or when it's
bisection just to addition of WARN_ON. Say, for kvm bugs a critical
piece may be cpu stepping.

4. syzbot reports are useful and signal-to-noise ratio is high:
https://syzkaller.appspot.com/?fixed=upstream
You can also ask developers who fixed dozens of syzbot reports.

5. Developers who look at syzbot reports acknowledge that they are
lost because of the kernel development process.
This one that I linked:
https://groups.google.com/d/msg/syzkaller-bugs/o_-OeMyoTwg/UOZv1d2IAgAJ
Steven Rostedt says that it wasn't lost because it did not contain
bisection information, but because "Yeah, that time was quite busy for
me. I guess I failed to get time to look into it when it was first
reported [and then it was simply lost with no chances of recovering]".
Here the bug was acknowledged:
https://groups.google.com/d/msg/syzkaller/WA6MdAfCYS0/1rSe_qDeAgAJ
but then simply lost for half a year:
https://groups.google.com/forum/#!msg/syzkaller-bugs/wFUedfOK2Rw/waUrQYOxAQAJ

So while I see potential for syzbot improvements, I see the problem
that leads to lost reports/patches in the kernel development process.
