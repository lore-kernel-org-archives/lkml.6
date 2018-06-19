Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C31C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E4B20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLPLykCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E4B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967048AbeFSQSb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:18:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40889 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966516AbeFSQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:18:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id w8-v6so90273pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JeyUsxnTyQTcW11AC0CkebNcePtYQ3ge9NTIWKrqw0M=;
        b=HLPLykCr2YptZP3woYDiZ6IpxkbbK6IMj4T7aVfYsdoPtrWm9mk7iu3cQBiy//tLyy
         J1qmY8lfjq+E+3NspbtFjnZ4F4drxdnPGvuHH+UR0HMViIPO4ZFDN32qIeWCAgdQPLS3
         y/64DeBikhWxO6z/5TezAX+wPncOJ8VJTU+G49LhgObSghqakaJf8pWsX0MURCf58Bgj
         UTXmXk3iQcj2kMriXN7LA/rLGgbI4t/k76bQrpyb1HWwA9IZZe5+xApDcJbcKhHxfgg7
         DDO0IwDPL67hmwBh8GDLfZ7ztL3HqaSaYuFSo2ubSiu84AAX2P/psNgi0jSY7zId4YNU
         o3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JeyUsxnTyQTcW11AC0CkebNcePtYQ3ge9NTIWKrqw0M=;
        b=cVNqAVIAVazZwxmRvQIgG8lrzm8UdklpzfSXNhTokodiGXuCBCUZjne+o40EKnIiPz
         dBSgV8a/kCcP7a+SO44NeY0t6L3KXNLYsyhZF3+1Nz0WOiGiNhQgEd4Fmpynb1JcDB3B
         8E9Kcc4q31sVGiQivnBcnVL0KinfshmgVk8x6gucYxbpkshEpE+yxFI72lhpjPMrhjlH
         Ig2AmVo4kxz3JWmt2eF/D1+vhf350soRPPTx4xjxev4y1GidVzxcXDvId/6Xq9BkHLcv
         Qwj4gRpRmglUi/F594uqjq7GfmR3Jeo2C/IJI/+kdNIScOy9RXIZqUQMyRmP+xJaRqn7
         s8JQ==
X-Gm-Message-State: APt69E0MoUBq60/OwdsDh6qzxMOA9OOV+x65DRvCEQEU4lek7BeKvODR
        N4Y43xwSTzOG7S9U6++XOIVvjwKS2FNespU97dnlGw==
X-Google-Smtp-Source: ADUXVKJCRMujNSZ090PbVlY7pzu8+BBXFsK2/1+4DpEowvzZsdFeSBgdLognsIAiNEG8hCWJooqQ13qVLpmQ5SZtGVk=
X-Received: by 2002:a63:70a:: with SMTP id 10-v6mr15878110pgh.216.1529425108266;
 Tue, 19 Jun 2018 09:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:18:07
 -0700 (PDT)
In-Reply-To: <20180618051522.GC28120@thunk.org>
References: <20180618051522.GC28120@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 18:18:07 +0200
Message-ID: <CACT4Y+aq6vXoQpFgg6-_rEttnM4i3j7ng5LkP9gbqX98im=afw@mail.gmail.com>
Subject: Re: An example of a much more impactful way of doing file
 system-specific fuzzing
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 7:15 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> I'd like to commend to you the style of bug reports which Wen Xu,
> researcher at Georgia Tech has been using.  (He's a Ph.D. student,
> with an interesting in fuzzing, and he's been very responsive to my
> suggestions about how to make his fuzzing much more impactful.)
>
> Please see some of his bugs:
>
> https://bugzilla.kernel.org/buglist.cgi?bug_status=RESOLVED&component=ext4&email1=wen.xu%40gatech.edu&emailreporter1=1&emailtype1=substring&query_format=advanced&resolution=CODE_FIX
>
> https://bugzilla.kernel.org/buglist.cgi?bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&component=ext4&email1=wen.xu%40gatech.edu&emailreporter1=1&emailtype1=substring&query_format=advanced
>
> As of this writing, I've found and fixed 13 bugs found by his fuzzing
> system, out of 26 bugs that he filed with the kernel Bugzilla (the
> others ended up being duplicates of the other reports).  Of special
> note that is the fact that he submits a separate image file from the C
> file used to provoke the failure.
>
> He has also been submitting cut-down reproducer C files, and more
> recently he has been creating cut-down fuzzed images.  This is
> currently been done by hand, but I've been suggesting that finding
> ways to do this automatically might be a great area for future
> research.
>
> In any case, his methods, which do require a bit more manual effort on
> his part at the moment, save *me* as the developer a huge amount of
> effort on my part.  And so I really appreciate his method of engaging
> with file system developers.
>
> Creating a smaller number of actionable, impactful reports, is in my
> opinion far more productive than spamming developers with reports that
> are either not actionable (due to the lack of a reproducer) or
> extremely difficult to act upon, given the extremely limited amount of
> resources developers have available to respond to these sorts of
> reports.
>
> (Most of my work responding to fuzzing reports has been done at night
> or on the weekends, and it's not something my employer pays me to work
> on.  So help from the bug reporters, which otherwise would vastly
> outnumber me, is greatly appreciated.  Spamming me with not
> actionable, or hard-to-act-upon bug reports, simply doesn't scale.)

+LKML

Hi Ted,

I appreciate your feedback but please take into account significant
difference in context and goals of what they are doing and what we are
doing:

1. 26 bugs vs 2600 bugs.
2. Specialized testing for a single subsystem vs coverage of a hundred
of kernel subsystems.
3. Personal interest in getting a dozen of trophies to publish
research and forget about it vs setting a continuous lasting process
for systematic bug reporting.

What we are trying to do can't work without active interest and
participation of all of kernel development community, without
thousands of kernel developers who know, write and maintain all these
subsystems. While we do have interest in all of these bugs getting
fixed, we don't have specific personal interest in any single bug or
any single subsystem. This needs to be completed by more specific
interest in each particular subsystem from maintainers of that
subsystem. In this context it's much more reasonable if fs maintainers
cut down fs images, USB maintainers cut down USB packets and we
continue improving tooling. Rather than we cut down images, you cut
down USB packets, Alan Stern cuts down network packets, and Eric
Dumazet improves tooling.

When we reported bugs manually we indeed did more manual work on our
side in some cases. But the problems were: (1) we couldn't keep up
reporting all bugs even making this our full time job, (2) bugs were
lost on kernel mailing lists in massive amounts (which is frustrating
when it's your manual work), (3) while some bugs got more "personal
touch", others got even less, sometimes we even mess or forgot
details, (4) this frequently lead to wasted work when you spent half
day getting everything perfect, but then you get "nah, known issue",
or "oh, I just looked into code for 10 secs and I see the problem",
or, well, no response at all, this is quite unpleasant experience. And
in the end this means no automation, no improvements to tooling and no
growth of kernel test coverage as all our time is already taken. In
short, it did not work.

One could say that then it's better to report few bugs but with full
manual assistance on the reporter side. I tend to disagree:

1. At the very least we need to fix bugs faster than we introduce
them. And with a single person as a bottleneck this is not happening.
There are thousands of people introducing new bugs.
2. Who will do all of the uninteresting, mechanical, assistive work?
Any volunteers? I don't think there will be any. And I don't even
think it's a healthy thing for a software project to try to push all
this work onto a dedicated group of people.
3. You say "not actionable reports without reproducers", but you can
find hundreds of fixed bugs without reproducers at [1] and [2]. Fix
ratio for bugs without reproducers is 66% which is not significantly
lower than 76% for bugs with reproducers. A person without expertise
in a particular subsystem (me) can't know if a bug is actionable by an
expert in the subsystem (you) without first reporting this bug.
4. Reporting any bug is not a negative thing. First of all, it may be
just very easy to fix (but we will never know until it's reported).
And if nobody has time to look into it deeper, or it's really
unactionable at this point, well, ok, being aware of state of the
things is still better than being blind. Over time additional
information may pop up, or several developers may contribute pieces of
insight which will then lead to a fix (we are seeing such cases too).

Looking at the data, reporting all bugs is clearly having overall
positive effect.
I mean a particular developer can receive a particular report that
they think is non-actionable, and they are frustrated by the "spam".
But let's not consider this in isolation. Realistically there is no
option of somehow retroactively report only bugs that will be well
accepted, right. Please look at this in larger context. Over time
quality of reports will improve and that's on us (though, syzkaller is
also an open-source project and contributions are welcome).

To conclude, we need active involvement of all of kernel community to
improve the situation. There are still plenty of unfixed bugs [3]. An
expert in a subsystem may be able to quickly identify that this single
thing in a reproducer is the culprit; or that there were recent
changes in that part of code so that's the likely culprit; or just
seeing the problem in code right away. Our team is really a negligible
part of the overall equation.

[1] https://syzkaller.appspot.com/?fixed=upstream
[2] https://github.com/google/syzkaller/blob/master/docs/linux/found_bugs.md
[3] https://syzkaller.appspot.com/
