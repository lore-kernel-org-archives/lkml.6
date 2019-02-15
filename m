Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C37C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3E421A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xzm4QLWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406007AbfBOK4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:56:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35960 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfBOK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:56:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id v62so6987156otb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/SrG8SG8JhxVh1IuqKx3oJpU293JRwzcn29NDcZ5uw=;
        b=Xzm4QLWdMT7MMzBncuyic7vcvJFAW33XfRzqK76W8XigEYMJ3rIdWIf/pnGdK893Gx
         1iwCzUubKz2UkX5OuR7XPAXf9V/dP2gfiBNSp+on/vnCsvCE3ObkjmkjACyVryBNI2EZ
         Duij31dd6RRmlgJiZ3YRV2vl9voDhJhzjU3bpaMSCdWyOpIQaKkd/xw8L8CVPq+ov6Lz
         41Az92ACr/7+2c2ed1htAOtvWg0WrTXeYzfNxETqZTlS6zamxFe199JoVwoAbkyPln6A
         hBSaA6VAzDzltWaxeBp1gMgtYCoBFJZdrMI6+8yxqbuvV3CszuL3SJPlibN7EAMgSFBE
         RPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/SrG8SG8JhxVh1IuqKx3oJpU293JRwzcn29NDcZ5uw=;
        b=mNm0EX2vS/XF7z7y5IIS571jAozysF7yCG5Ep22+m80VTRVYydEc7dRmUH7lc8qXwK
         hxQ/ZpKTFB2gfE+gzYLDCFC2we5aXnnCsJ4hDhbC6hxc5jMUooU49IfwpwC6QVd98KOW
         LvPrf+NR5wYCDg80P84XyeNnWLyykbrMSYrk2jku01ZY1wrNkvxboMJc33izMoMmLu+3
         aEyh0+BSHdNUgSEXl9tvXDenXfO0HfcT5gW84gHeYXJlw8Sukbb9ftZuFLC1aJqbbUVu
         uZCWUA+XtyjITmQN0AkKIviRU1sn37sPsqeDdF6Fj1gvw9RkXVyrusLKutjVdS5pE9Q0
         zdYg==
X-Gm-Message-State: AHQUAubetm5VE+MCMuj6a7+WGADNF3FByd041QkS0G8YEK+e0OMCQryb
        82jKtCWTyn8XjZxBFP4SydMzTBL3fO5El7Rhfn1Txg==
X-Google-Smtp-Source: AHgI3IaZ+2pZ8ouxgwIWMfCFoEwQpUa5+gSFzeGJ2HXWuxidyykW9gUyUG9iawwFdHbfV3pSc18ogs4W2w7ILGa1/0I=
X-Received: by 2002:a9d:6206:: with SMTP id g6mr5242362otj.338.1550228201822;
 Fri, 15 Feb 2019 02:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com> <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com> <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
 <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com>
In-Reply-To: <0e311e88-c4d4-e98d-1720-53a04bd526fc@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 15 Feb 2019 02:56:30 -0800
Message-ID: <CAFd5g44NTZoSAJPMvXP2xvJgn7m5QoV-KJu2AMrr67+eL+CKrQ@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 6:05 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 4:56 PM, Brendan Higgins wrote:
> > On Thu, Feb 14, 2019 at 3:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 12/5/18 3:54 PM, Brendan Higgins wrote:
> >>> On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> Hi Brendan,
> >>>>
> >>>> On 11/28/18 11:36 AM, Brendan Higgins wrote:
> >>>>> Split out a couple of test cases that these features in base.c from the
> >>>>> unittest.c monolith. The intention is that we will eventually split out
> >>>>> all test cases and group them together based on what portion of device
> >>>>> tree they test.
> >>>>
> >>>> Why does splitting this file apart improve the implementation?
> >>>
> >>> This is in preparation for patch 19/19 and other hypothetical future
> >>> patches where test cases are split up and grouped together by what
> >>> portion of DT they test (for example the parsing tests and the
> >>> platform/device tests would probably go separate files as well). This
> >>> patch by itself does not do anything useful, but I figured it made
> >>> patch 19/19 (and, if you like what I am doing, subsequent patches)
> >>> easier to review.
> >>
> >> I do not see any value in splitting the devicetree tests into
> >> multiple files.
> >>
> >> Please help me understand what the benefits of such a split are.
>
> Note that my following comments are specific to the current devicetree
> unittests, and may not apply to the general case of unit tests in other
> subsystems.
>
Note taken.
>
> > Sorry, I thought it made sense in context of what I am doing in the
> > following patch. All I am trying to do is to provide an effective way
> > of grouping test cases. To be clear, the idea, assuming you agree, is
>
> Looking at _just_ the first few fragments of the following patch, the
> change is to break down a moderate size function of related tests,
> of_unittest_find_node_by_name(), into a lot of extremely small functions.

Hmm...I wouldn't call that a moderate function. By my standards those
functions are pretty large. In any case, I want to limit the
discussion to specifically what a test case should look like, and the
general consensus outside of the kernel is that unit test cases should
be very very small. The reason is that each test case is supposed to
test one specific property; it should be obvious what that property
is; and it should be obvious what is needed to exercise that property.

> Then to find the execution order of the many small functions requires
> finding the array of_test_find_node_by_name_cases[].  Then I have to

Execution order shouldn't matter. Each test case should be totally
hermetic. Obviously in this case we depend on the preceeding test case
to clean up properly, but that is something I am working on.

> chase off into the kunit test runner core, where I find that the set
> of tests in of_test_find_node_by_name_cases[] is processed by a
> late_initcall().  So now the order of the various test groupings,

That's fair. You are not the only one to complain about that. The
late_initcall is a hack which I plan on replacing shortly (and yes I
know that me planning on doing something doesn't mean much in this
discussion, but that's what I got); regardless, order shouldn't
matter.

> declared via module_test(), are subject to the fragile orderings
> of initcalls.
>
> There are ordering dependencies within the devicetree unittests.

There is now in the current devicetree unittests, but, if I may be so
bold, that is something that I would like to fix.

>
> I do not like breaking the test cases down into such small atoms.
>
> I do not see any value __for devicetree unittests__ of having
> such small atoms.

I imagine it probably makes less sense in the context of a strict
dependency order, but that is something that I want to do away with.
Ideally, when you look at a test case you shouldn't need to think
about anything other than the code under test and the test case
itself; so in my universe, a smaller test case should mean less you
need to think about.

I don't want to get hung up on size too much because I don't think
this is what it is really about. I think you and I can agree that a
test should be as simple and complete as possible. The ideal test
should cover all behavior, and should be obviously correct (since
otherwise we would have to test the test too). Obviously, these two
goals are at odds, so the compromise I attempt to make is to make a
bunch of test cases which are separately simple enough to be obviously
correct at first glance, and the sum total of all the tests provides
the necessary coverage. Additionally, because each test case is
independent of every other test case, they can be reasoned about
individually, and it is not necessary to reason about them as a group.
Hypothetically, this should give you the best of both worlds.

So even if I failed in execution, I think the principle is good.

>
> It makes it harder for me to read the source of the tests and
> understand the order they will execute.  It also makes it harder
> for me to read through the actual tests (in this example the
> tests that are currently grouped in of_unittest_find_node_by_name())
> because of all the extra function headers injected into the
> existing single function to break it apart into many smaller
> functions.

Well now the same groups are expressed as test modules, it's just a
collection of closely related test cases, but they are grouped
together for just that reason. Nevertheless, I argue this is superior
to grouping them together in a function, because a test module
(elsewhere called a test suite) relates test cases together, but makes
it clear that they are still logically independent, two test cases in
a suite should run completely independently of each other.

>
> Breaking the tests into separate chunks, each chunk invoked
> independently as the result of module_test() of each chunk,
> loses the summary result for the devicetree unittests of
> how many tests are run and how many passed.  This is the

We still provide that. Well, we provide a total result of all tests
run, but they are already grouped by test module, and we could provide
module level summaries, that would be pretty trivial.

> only statistic that I need to determine whether the
> unittests have detected a new fault caused by a specific
> patch or commit.  I don't need to look at any individual
> test result unless the overall result reports a failure.

Yep, we do that too.

>
>
> > that we would follow up with several other patches like this one and
> > the subsequent patch, one which would pull out a couple test
> > functions, as I have done here, and another that splits those
> > functions up into a bunch of proper test cases.
> >
> > I thought that having that many unrelated test cases in a single file
> > would just be a pain to sort through deal with, review, whatever.
>
> Having all the test cases in a single file makes it easier for me to
> read, understand, modify, and maintain the tests.

Alright, well that's a much harder thing to make a strong statement
about. From my experience, I have usually seen one or two *maybe
three* test suites in a single file, and you have a lot more than that
in the file right now, but this sounds like a discussion for later
anyway.

>
> > This is not something I feel particularly strongly about, it is just
> > pretty atypical from my experience to have so many unrelated test
> > cases in a single file.
> >
> > Maybe you would prefer that I break up the test cases first, and then
> > we split up the file as appropriate?
>
> I prefer that the test cases not be broken up arbitrarily.  There _may_

I wasn't trying to break them up arbitrarily. I thought I was doing it
according to a pattern (breaking up the file, that is), but maybe I
just hadn't looked at enough examples.

> be cases where the devicetree unittests are currently not well grouped
> and may benefit from change, but if so that should be handled independently
> of any transformation into a KUnit framework.

I agree. I did this because I wanted to illustrate what I thought real
world KUnit unit tests should look like (I also wanted to be able to
show off KUnit test features that help you write these kinds of
tests); I was not necessarily intending that all the of: unittest
patches would get merged in with the whole RFC. I was mostly trying to
create cause for discussion (which it seems like I succeeded at ;-) ).

So fair enough, I will propose these patches separately and later
(except of course this one that splits up the file). Do you want the
initial transformation to the KUnit framework in the main KUnit
patchset, or do you want that to be done separately? If I recall, Rob
suggested this as a good initial example that other people could refer
to, and some people seemed to think that I needed one to help guide
the discussion and provide direction for early users. I don't
necessarily think that means the initial real world example needs to
be a part of the initial patchset though.

Cheers
