Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3369BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14472178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZUOqcDwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14472178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeHCWk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:40:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38450 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeHCWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:40:56 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so10204213itb.3;
        Fri, 03 Aug 2018 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NL4fku+xboNURUcDAdSfUChZ/+fYzGn8CWnuW2juxZY=;
        b=ZUOqcDwCA6kTWxRYli2SgxXmbe1JvQ4KHBPtj5FJ3O8CzotkM5EtsyE+wwt0+J0hgf
         VY2LR1HwS8jjiI5nsry+mamKgz75iPOVBOBDl33qptgimOvVpiSYrAqhe/jVu5jOV1MD
         btisbTjpZ1iV+rLrH+N6bEfMkFlzpf7CDTT3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NL4fku+xboNURUcDAdSfUChZ/+fYzGn8CWnuW2juxZY=;
        b=HrkkB4mJqY68IvOwNPT8e1lv29sWKmFxZ/N5dVIISGR6LyqnoS8b1rJEbruSoSSZ8j
         Tw1V2VDeEtI95v4d0a3oZdDTAHk35YsD6qCdDfwd48CJRxGG4tUgHH08xXxdpYsvuyXN
         7SvNJlikL1flvmOyjrC6ow7kpwPYzYNbJZa4qmW95iYWGppCp1K0nQfkdjhs73VXGGDc
         wlI4zZxCa2cKcvUknO5lxE+4Az8uymO7IS9xZ3a1XSScUneXCHYxCyr5c4X4h1IxZ4jV
         vK2kyvxrH+YOhJePgCjP53/M8aZzcz7e53avKZ9EKzT9aIrY9gpk4DJAKIr8YN2686Ap
         Fncg==
X-Gm-Message-State: AOUpUlEcFzz/G+m3Be3UfwLBa7UbgkUQKb7ShM5ZFWD41lxJvpGcuPha
        hjqu2EbMZzO5Q5iWEeqQyo0ZjPINV1cYK0wX8TA=
X-Google-Smtp-Source: AAOMgpeMb3wORLTLrKxdXnriOhxCd9TnD1ldpWVMEie2t9yan+APzt7Se+0VQhwUwG4/r2S/pcFXWcFgiwH+S68SRAw=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr4801610jas.72.1533328983107;
 Fri, 03 Aug 2018 13:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com> <20180803152034.GD32066@thunk.org>
 <20180803195636.GA31444@agk-dp.fab.redhat.com> <20180803200817.GB31444@agk-dp.fab.redhat.com>
In-Reply-To: <20180803200817.GB31444@agk-dp.fab.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 13:42:52 -0700
Message-ID: <CA+55aFyFXxN3Qkt+=Ke5Mqctbc3+iX5_HzeH0gHFZK8tDpa=Uw@mail.gmail.com>
Subject: Re: [dm-devel] LVM snapshot broke between 4.14 and 4.16
To:     "Theodore Ts'o" <tytso@mit.edu>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 1:08 PM Alasdair G Kergon <agk@redhat.com> wrote:
>
> If taking this approach, it might be better to use the current version
> i.e.  where we add the kernel-side fix.  IOW anything compiling against
> a uapi header taken from a kernel up to now will see the old behaviour,
> but anything newer (after we next increment the kernel dm version) will
> be required to change its userspace code if it has this problem in it.

No, please don't do things like that.

It's a nightmare. It just means that different people randomly have
different behavior depending on what development environment they had,
which is horrible for any situation where you do cross-builds, but
it's also horrible from a testing standpoint.

And it's a *huge* nightmare for stable releases and backporting fixes.
Absolutely *no* user space shjould ever care about kernel versions. If
you want to use a new system call or something, just *use* if, and
then if it fails, fall back to the old one. Never ever check "what's
the kernel version" or anything like that.

Instead, what I suggest we do is:

Case 1: if a user program notice that a new kernel breaks something, then

 (a) report it to kernel people with a test-case

 (b) if you notice that the *reason* a new kernel broke something is
because you had a bug and you can just fix that bug and it will always
work on all kernels, by all means just fix the bug. Obviously you
don't want to just keep buggy code around just because it was found by
a kernel change

 (c) but even if (b) happens, do that report. In fact, you now have a
perfect test-case for the kernel people you report it to: you can tell
them *exactly* what changed, and what the two situations were.

 (d) and if whoever you reported the kernel breakage to doesn't seem
to take it seriously, just escalate it to me.

Note that for the (d) case, there are situations where even _I_ won't
necessarily take it seriously. If you're the only user of some
program, I may just go "Oh, you already fixed your own problem, I
don't need to worry". Or if it turns out that the breakage wasn't
"user flow", but some test-suite regression, I will tend to ignore
those. Test suites are by definition for finding _behavior_, but
behavior can change - it's actual _breakage_ I worry about.

But also notice how none of that "case 1" has any versioning related
to it.  Yes, you'll have old versions of the user program before the
bug was fixed, but they will *not* look at kernel versions, and the
new versions certainly shouldn't either.

Case 2: the kernel side.  We get that breakage reported, but it turns
out that different versions of the workflow act differently, and maybe
some versions depend on the new behavior, and some depend on the old
behavior.

And yes, this happens.

We have been in the situation where we get a bug-report for something
we changed three years ago, and by now, all modern user space depends
on the new "fixed" behavior, but some embedded user who hadn't
upgraded a kernel in years is unhappy.

It's happened several times, and if it really is "it's been years",
even I will go "tough luck, I guess you're stuck on your old kernel".
Because we can't fix it.

But in a situation like this, where we really want to encourage new
behavior but we have somebody who reported the breakage in a timely
manner (ie it's fairly recent), _and_ it's a system tool like lvm2
that actually gives us a version number, at that point the *kernel*
might decide "this is an old binary, I will now use some versioning to
fall back on old behavior".

Because for the kernel, the compatibility really is a #1 concern, and
if we have to check version numbers or infer compatibility issues some
other way, we'll do it.

But that "different behavior for different application versions" is
something we generally avoid at all costs. We do have a couple of
cases where we deduce what people want based on behavior. But it is
very very rare, and we generally want to avoid it if there is _any_
other model for it.

So even in case 2, we do try to avoid versioning. More often we add a
new flag, and say "hey, if you want the new behavior, use the new flag
to say so". Not versioning, but explicit "I want the new behavior"

Not all system calls take flags, of course.

             Linus
