Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3247C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DACD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/yvZ/od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DACD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeK0Mhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:37:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39288 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeK0Mhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:37:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so18645429oth.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5RnrTMKKxcHKxat3En3dRHQKj3rXNQfdF6ztUbQ3rI=;
        b=h/yvZ/odo+70dB7p2OPAIq6ORBwji0oRNm3DabapKWkGWAQHNVlYlMcvBZr9hOoXn2
         7ZtNzcyByoxsciqMDy/5BBSYp0dYBnix90+HhDvUsVTNFUSmjK9dtCYX3tkhzU1z/kuP
         hmz9Gsp0VpFdmbTyRolI1CWPieDsctbbTNeYfMm37D/QGbK9EE2HHbnm3yeXOUUG37kT
         UTinrtTR0W5QfhujxejwGyh8d74xgaMmlk1TaB/vNg5nLkhh8QIeoqPJ5ld78JH4YUB6
         Hcy9aRjXhQmOxY8S2yCjLGZ1q70HTpTEqJhK1+Oh0SZjcKWHfUp3DfCz0TJCbfNHgnNP
         YI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5RnrTMKKxcHKxat3En3dRHQKj3rXNQfdF6ztUbQ3rI=;
        b=WLO1vg+jGK+9W0V3HwZfRHu48Q+MU+m/7X6DvKFSTLxp7DAGCkpNS9BA/2kt+kGLwl
         ptf3jPxkf889+a5R/LD+Dq9OQjf7t7384UxtjtbFmzf6jMjmr4TbY4QXHmeWXHasWqpL
         HD6X66oE6kdRk8llr7iccq7HQ8w+4Tb2a8Hm8YrLznTKDXmIpSjNOnxRl4GShmxRlV1B
         vJnjdukl7qx2F3cAbI3ptzZNw5CArUQQxCqSdJ3/mbTIX2D/sCVH+zSYuy9pKgs3TJwp
         xVUA1iqtIkssUzkMXOq02VsLg1q2O4SdU55CtR64iYxkVlDuEzC5o12RUHxpOsHbCCty
         ZrqQ==
X-Gm-Message-State: AA+aEWb/HQ4oiyGQmA01m2ll0pGPC3Y19TRjqAjTyyoP77Jowq0urFU0
        /894W6b9oBVHAdW/JDEehtT6rLixRkIs5z9fKY+E7g==
X-Google-Smtp-Source: AFSGD/VI114OAvjTxXpV72u+CNG5XLRtY7PaIBQBQmMwXtUb8jVPzdWoResMHdR460ML8ZkPPwBW1HmuoflURVhOTqY=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr17227030oth.338.1543282890976;
 Mon, 26 Nov 2018 17:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com> <1543036529.4680.655.camel@oracle.com>
In-Reply-To: <1543036529.4680.655.camel@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 26 Nov 2018 17:41:19 -0800
Message-ID: <CAFd5g45oPSp870hJLDSHiMfU7Mh-EvpYcFdAaOQxecXNde5PSw@mail.gmail.com>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Knut Omang <knut.omang@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, brakmo@fb.com, richard@nod.at,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        mpe@ellerman.id.au, Tim.Bird@sony.com,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rostedt@goodmis.org, kieran.bingham@ideasonboard.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org,
        khilman@baylibre.com, joe@perches.com, dan.j.williams@intel.com,
        jdike@addtoit.com, kunit-dev@googlegroups.com,
        hidenori.yamaji@sony.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 9:15 PM Knut Omang <knut.omang@oracle.com> wrote:
>
> On Tue, 2018-10-23 at 16:57 -0700, Brendan Higgins wrote:
<snip>
>
> Brendan, I regret you weren't at this year's testing and fuzzing workshop at
> LPC last week so we could have continued our discussions from last year there!

Likewise! Unfortunately, I could not make it. So it goes.

>
> I hope we can work on this for a while longer before anything gets merged.
> Maybe it can be topic for a longer session in a future test related workshop?

I don't see why we cannot just discuss it here as we are already
doing. Besides, you are mostly interested in out of tree testing,
right? I don't see how this precludes anything that you are trying to
do with KTF.

I think the best way to develop something like what I am trying to do
with KUnit is gradually, in tree, and with the active input and
participation of the Linux kernel community.

>
> Links to more info about KTF:
> ------
> Git repo: https://github.com/oracle/ktf
> Formatted docs: http://heim.ifi.uio.no/~knuto/ktf/
>
> LWN mention from my presentation at LPC'17: https://lwn.net/Articles/735034/
> Oracle blog post: https://blogs.oracle.com/linux/oracles-new-kernel-test-framework-for-linux-v2
> OSS'18 presentation slides: https://events.linuxfoundation.org/wp-content/uploads/2017/12/Test-Driven-Kernel-Development-Knut-Omang-Oracle.pdf
>
> In the documentation (see http://heim.ifi.uio.no/~knuto/ktf/introduction.html)
> we present some more motivation for choices made with KTF.
> As described in that introduction, we believe in a more pragmatic approach
> to unit testing for the kernel than the classical "mock everything" approach,
> except for typical heavily algorithmic components that has interfaces simple to mock,
> such as container implementations, or components like page table traversal
> algorithms or memory allocators, where the benefit of being able to "listen"
> on the mock interfaces needed pays handsomely off.

I am not advocating that we mock everything. Using as much real code
dependencies as possible for code under test is a pretty common
position, and one which I adhere to myself.

>
> We also used strategies to compile kernel code in user mode,
> for parts of the code which seemed easy enough to mock interfaces for.
> I also looked at UML back then, but dismissed it in favor of the
> more lightweight approach of just compiling the code under test
> directly in user mode, with a minimal partly hand crafted, flat mock layer.

Is this new? When I tried your code out, I had to install the kernel
objects into my host kernel. Indeed, your documentation references
having to install kernel modules on the host:
http://heim.ifi.uio.no/~knuto/ktf/installation.html

>
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
>
> I am curious, with the intention of only running in user mode anyway,

I made it possible to "port" KUnit to other architectures.
Nevertheless, I believe all unit tests should be able to run without
depending on hardware or some special test harness. If I see a unit
test, I should not need to know anything about it just to run it.
Since there is no way to have all possible hardware configurations a
priori, all tests must be able to be run in a place that doesn't
depend in hardware; hence they should all be runnable as just normal
plane old user space programs with no dependency on a host kernel or
host hardware.

> why not try to build upon Googletest/Googlemock (or a similar C unit
> test framework if C is desired), instead of "reinventing"
> specific kernel macros for the tests?

I would love to reuse Googletest/Googlemock if it were possible; I
have used it a lot on other projects that I have worked on and think
it is great, but I need something I can check into the Linux kernel;
this requirement rules out Googletest/Googlemock since it depends on
C++. There are existing frameworks for C, true, but we then need to
check that into the Linux kernel or have the kernel depend on that; to
me that seemed like a lot more work than just reimplementing what we
need, which isn't much. Most of the hard parts are specific to the
kernel anyway.

>
> > A unit test is supposed to test a single unit of code in isolation,
> > hence the name. There should be no dependencies outside the control of
> > the test; this means no external dependencies, which makes tests orders
> > of magnitudes faster. Likewise, since there are no external dependencies,
> > there are no hoops to jump through to run the tests. Additionally, this
> > makes unit tests deterministic: a failing unit test always indicates a
> > problem. Finally, because unit tests necessarily have finer granularity,
> > they are able to test all code paths easily solving the classic problem
> > of difficulty in exercising error handling code.
>
> I think it is clearly a trade-off here: Tests run in an isolated, mocked
> environment are subject to fewer external components. But the more complex
> the mock environment gets, the more likely it also is to be a source of errors,
> nondeterminism and capacity limits itself, also the mock code would typically be
> less well tested than the mocked parts of the kernel, so it is by no means any
> silver bullet, precise testing with a real kernel on real hardware is still
> often necessary and desired.

I think you are misunderstand me. By isolation, I just mean no code
under test should depend on anything outside of the control of the
test environment. As I mention above, reusing real code for test
dependencies is highly encouraged.

As for running against hardware, yes, we need tests for that too, but
that falls under integration testing; it is possible to use what I
have here as a basis for that, but for right now, I just want to focus
on the problem of unit testing: I think this patchset is large enough
as it is.

>
> If the code under test is fairly standalone and complex enough, building a mock
> environment for it and test it independently may be worth it, but pragmatically,
> if the same functionality can be relatively easily exercised within the kernel,
> that would be my first choice.
>
> I like to think about all sorts of testing and assertion making as adding more
> redundancy. When errors surface you can never be sure whether it is a problem
> with the test, the test framework, the environment, or an actual error, and
> all places have to be fixed before the test can pass.

Yep, I totally agree, but this is why I think test isolation is so
important. If one test, or one piece of code is running that doesn't
need to be, it makes debugging tests that much more complicated.

Cheers!
