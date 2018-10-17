Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA035ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861792087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhhbXRs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861792087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJRGUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:20:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40079 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRGUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:20:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so22433683oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWone3F0vFg4fZjjbgWS6qX8iCPfGqtCKrJsR9egiDY=;
        b=DhhbXRs91GnjJSWXXXpRrf7QDzpEEoTLxvzRqXqNF0OVLRTGRPZ9+MqcaSkBz6ZxsS
         z4GzdfqTwGG3OBf8IZfJtWc9JiUdREfQvO+ki4KaQeJtlqnHeITQP7g08Dzzhr1tQepj
         zlXq/xWvC+9t/TR199A/YZEtP87+1EXNLHhejrSNBA0JUmihISRfoBxBSr+LhYYB2M97
         acMfdlpgSOKdGyYdWD2DO3C9CDTWYybbYCU0igqYLKcgVg1xN+G3Yl12E6ps+rM1S8yx
         l9aUd8mYXlkCiDNuNBNWKfN26wmvU4oJ1An/wgFZeVMBD8FJdxwLf6dTP0J0I9MtTnvw
         LMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWone3F0vFg4fZjjbgWS6qX8iCPfGqtCKrJsR9egiDY=;
        b=atsxPePopHKVizby6IJiQ87MWByuK+iVAL5Q9hHyPCtyp85v82NrVl9AfUIPZ3iNvV
         diIHJE0dHA58TP6o40qdsiGV/xDwvpkSwbKtIlLZuo59jfGI+EK9Owx2IFN90NyfDu9Q
         zH1wdAa9zzHv30+Cu0S5K+fehwkRUIoZKFs48710WYjSvoQSFkk/q2JfnDnvFboaZRbZ
         iTXmv62y0RaX5JRmgFu+0hQqp+IsnRdBao0SyD9yixSRHEb6KB/JZly67L8gg2YddCUx
         C5kqE+7vuO0U8/Le7Hn+6kOPK1wrbdGEFSAYk/AdESkBfBPhnsC0kA1wvClB9eejy0Ex
         9uVQ==
X-Gm-Message-State: ABuFfoiJ6/adzqF8svoWvq7poVtNq+bEEDYL7sbiOSNbCUbYb7JM4a82
        ExQDBXIZyT1voklAhTbiyYNiHCD6YTf/HjTe8J2NsQ==
X-Google-Smtp-Source: ACcGV610jFlhPenPzZA69EmQWgS0PTsFvwWtwobMzHZ6pwg7XIoF1nCetFL6mUxN+PfxDa9IRUI0Shzss8i4o8RH1yM=
X-Received: by 2002:aca:fd89:: with SMTP id b131-v6mr14528148oii.30.1539814982054;
 Wed, 17 Oct 2018 15:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com> <ECADFF3FD767C149AD96A924E7EA6EAF805242EE@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF805242EE@USCULXMSG01.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 15:22:50 -0700
Message-ID: <CAFd5g46kWMFY_JXei=VqNS74wwm3TtzESK7ZsYeOFu26z4D8hw@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
To:     Tim.Bird@sony.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From: Brendan Higgins
> >
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
>
> I'm interested in this, and think the kernel might benefit from this,
> but I have lots of questions.
>
Awesome!

> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > and does not require tests to be written in userspace running on a host
> > kernel.
>
>
> This is stated here and a few places in the documentation.  Just to clarify,
> KUnit works by compiling the unit under test, along with the test code
> itself, and then runs it on the machine where the compilation took
> place?  Is this right?  How does cross-compiling enter into the equation?
> If not what I described, then what exactly is happening?
>
Yep, that's exactly right!

The test and the code under test are linked together in the same
binary and are compiled under Kbuild. Right now I am linking
everything into a UML kernel, but I would ultimately like to make
tests compile into completely independent test binaries. So each test
file would get compiled into its own test binary and would link
against only the code needed to run the test, but we are a bit of a
ways off from that.

For now, tests compile as part of a UML kernel and a test script boots
the UML kernel, tests run as part of the boot process, and the script
extracts test results and reports them.

I intentionally made it so the KUnit test libraries could be
relatively easily ported to other architectures, but in the long term,
tests that depend on being built into a real kernel that boots on real
hardware would be a lot more difficult to maintain and we would never
be able to provide the kind of resources and infrastructure as we
could for tests that run as normal user space binaries.

Does that answer your question?

> Sorry - I haven't had time to look through the patches in detail.
>
> Another issue is, what requirements does this place on the tested
> code?  Is extra instrumentation required?  I didn't see any, but I
> didn't look exhaustively at the code.
>
Nope, no special instrumentation. As long as the code under tests can
be compiled under COMPILE_TEST for the host architecture, you should
be able to use KUnit.

> Are all unit tests stored separately from the unit-under-test, or are
> they expected to be in the same directory?  Who is expected to
> maintain the unit tests?  How often are they expected to change?
> (Would it be every time the unit-under-test changed?)
>
Tests are in the same directory as the code under test. For example,
if I have a driver drivers/i2c/busses/i2c-aspeed.c, I would write a
test drivers/i2c/busses/i2c-aspeed-test.c (that's my opinion anyway).

Unit tests should be the responsibility of the person who is
responsible for the code. So one way to do this would be that unit
tests should be the responsibility of the maintainer who would in turn
require that new tests are written for any new code added, and that
all tests should pass for every patch sent for review.

A well written unit test tests public interfaces (by public I just
mean functions exported outside of a .c file, so non-static functions
and functions which are shared as a member of a struct) so a unit test
should change at a slower rate than the code under test, but you would
likely have to change the test anytime the public interface changes
(intended behavior changes, function signature changes, new public
feature added, etc). More succinctly, if the contract that your code
provide changes your test should probably change, if the contract
doesn't change, your test probably shouldn't change. Does that make
sense?

> Does the test code require the same level of expertise to write
> and maintain as the unit-under-test code?  That is, could this be
> a new opportunity for additional developers (especially relative
> newcomers) to add value to the kernel by writing and maintaining
> test code, or does this add to the already large burden of code
> maintenance for our existing maintainers.

So a couple things, in order to write a unit test, the person who
writes the test must understand what the code they are testing is
supposed to do. To some extent that will probably require someone with
some expertise to ensure that the test makes sense, and indeed a
change that breaks a test should be accompanied by a update to the
test.

On the other hand, I think understanding what pre-existing code does
and is supposed to do is much easier than writing new code from
scratch, and probably doesn't require too much expertise. I actually
did a bit of an experiment internally on this: I had some people with
no prior knowledge of the kernel write some tests for existing kernel
code and they were able to do it with only minimal guidance. I was so
happy with the result that I was already thinking that it might have
some potential for onboarding newcomers.

Now, how much burden does this add to maintainers? As someone who
pretty regularly reviews code that come in with unit tests and code
that comes in without unit tests. I find it much easier to review code
that comes in with unit tests. I would actually say that from the
standpoint of being an owner of a code base, unit tests actually
reduce the amount of work I have to do overall. Code with unit tests
is usually cleaner, the tests tell me exactly what the code is
supposed to do, and I can run the tests (or ideally have an automated
service run the tests) that tell me that the code actually does what
the tests say it should. Even when it comes to writing code I find
that writing code with unit tests ends up saving me time overall.
