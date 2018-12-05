Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B2EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257A920989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkcEX+/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257A920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbeLEXLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:11:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41218 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeLEXLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:11:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so19090409oii.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FJYholUWmCppwSnPL76u/cNBHsuxKqsf1HdstAB4mw=;
        b=rkcEX+/XPPvW5QP6TXhLF4gEBNraOuQwq9x1w0toiaMzIWZP7hN+la+r/b6WHupxNX
         WWo0RjehuqBpzepy9+IeXLy9f4TUeT5OTlmf8xF5SQBv2w/3ScXp+lw9i1fZBPRDMYNf
         vCYcMIGBMzaKsscgawTUe2yKgV9nmlaVQVKtRqSatrzszbd6pP9D1kIvRBZ3QxflhIJd
         BobKeeWMPXvYcAjzySLN1FuP6T8pkuZChrZYdlNTJVMbErzzvcrvY0rW7WCUCCJRo1P2
         xA/NO798A3xDeOy9wc8sP3O0cZLtv13MA0mTqQ4m2Mds0ZEQvwXIsH56aD37x+uMIySG
         gaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FJYholUWmCppwSnPL76u/cNBHsuxKqsf1HdstAB4mw=;
        b=SSULhwQ/rvWfTgWRIJjptc3YdaCkOIpA4HkCN0NRc4UOF3sZh/OwNZV1fxnePHQ9Ug
         URxD5ytenHmTzbg4nNUbnqY4A5eQFfKbdRWZQVdaen9DGCG6ZMSb3wUzM6pPAQOSxje0
         213OIfE1YhkpOrjO3e5zhHbvqRSrjU4wAcWRHtgyEF2gi+pwHsbMrfWD9VGZZcurgImT
         3qstlGfJMWXq4HQPUJUKMa4KJ2bh7qpOQJlBU+CtxEh8myTeICtD7bDmSCO/34gWGRlV
         utHX7OkfHg4RhfNJvjTpdTms3RRZK6ylgw8B62HC4KbhH4v49jTa6k/UsfPpibH5dwlQ
         Fh8w==
X-Gm-Message-State: AA+aEWZj6Zcntm4VeNS1QWjdhEqxqahhcWW3T6jL9FTbFonYCK0Rd0q5
        VkZYJnsOuD6L2WZ6X2C0o5oygTMNjQ29DZaWeUSZkw==
X-Google-Smtp-Source: AFSGD/VKJv02/RFqF0uLK5VbI93EeBTVcTRzgIf/nw0LiJ+EpHd2GHl0j2+W42WXZtOQZhz8Pfhr1e1C9jE1Ezre1e4=
X-Received: by 2002:aca:be41:: with SMTP id o62mr15379457oif.206.1544051461731;
 Wed, 05 Dec 2018 15:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com> <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
In-Reply-To: <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Dec 2018 15:10:50 -0800
Message-ID: <CAFd5g47cDKSdXGAL8pbDxEU2O8A-9Ajq1wCM+PtPF40T4wYKow@mail.gmail.com>
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:49 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 5:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > Hi Brendan, Rob,
> >
> > Pulling a comment from way back in the v1 patch thread:
> >
> > On 10/17/18 3:22 PM, Brendan Higgins wrote:
> > > On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:
> >
> > < snip >
> >
> > > The test and the code under test are linked together in the same
> > > binary and are compiled under Kbuild. Right now I am linking
> > > everything into a UML kernel, but I would ultimately like to make
> > > tests compile into completely independent test binaries. So each test
> > > file would get compiled into its own test binary and would link
> > > against only the code needed to run the test, but we are a bit of a
> > > ways off from that.
> >
> > I have never used UML, so you should expect naive questions from me,
> > exhibiting my lack of understanding.
> >
> > Does this mean that I have to build a UML architecture kernel to run
> > the KUnit tests?
>
> In this version of the patch series, yes.
>
> > *** Rob, if the answer is yes, then it seems like for my workflow,
> > which is to build for real ARM hardware, my work is doubled (or
> > worse), because for every patch/commit that I apply, I not only have
> > to build the ARM kernel and boot on the real hardware to test, I also
> > have to build the UML kernel and boot in UML.  If that is correct
> > then I see this as a major problem for me.
>
> I've already raised this issue elsewhere in the series. Restricting
> the DT tests to UML is a non-starter.

I have already stated my position elsewhere on the matter, but in
summary: Ensuring most tests can run without external dependencies
(hardware, VM, etc) has a lot of benefits and should be supported in
nearly all cases, but such tests should also work when compiled to run
on real hardware/VM; the tooling might not be as good in the latter
case, but I understand that there are good reasons to support it
nonetheless.

So I am going to try to add basic support for running tests on other
architectures in the next version or two.

>
> > Brenden, in the above quote you said that in the future you would
> > like to make the "tests compile into completely independent test
> > binaries".  I am assuming those are intended to run as standalone
> > user space programs instead of inside UML.  Is that correct?  If
> > so, how will KUnit tests be able to test code that uses locking
> > mechanisms that require instructions that are not available to
> > user space execution?  (I _think_ that such instructions may be
> > present, depending on which locking mechanism, but I might be
> > mistaken.)
>
> I think he means as kernel modules as kunit is for testing internal
> kernel interfaces. kselftest is userspace level tests.

Frank is right: my long term goal is to make it so unit tests can run
as stand alone user space programs.

>
> If this were true about locking, then UML itself would not be viable.
>
> > Another possible concern that I have for removing the devicetree
> > unit tests from my normal kernel build process is that I think
> > that the ability to use sparse to analyze the source in the
> > unit tests is removed.  Please correct me if I misunderstand
> > that.
> >
> > Another issue is that the devicetree unit tests will no longer
> > be cross compiled with my ARM compiler, so I lose a small
> > amount of testing for compiler related issues.
>
> 0-day does that for you. :)
>
> > Overall, I'm still trying to learn enough to determine whether
> > the gains from moving to KUnit outweigh the losses.

Of course.

From what I have seen so far, the DT unittests seem like a pretty good
use case for KUnit. If you don't mind, what frustrates you most about
the tests you have now?

What are the most common breakages you see?

When do they get caught?

My initial reaction when I looked at the tests was that it seemed like
it would be hard to understand what caused a failure and it seemed
non-obvious where a test for a new feature should go.

To me, the thing that seemed like it needed the most work was
refactoring the tests to make them easier to understand. For example,
one thing I found when I started breaking the tests apart I found some
cases that I really had to stare at (or run diff on them) to figure
out what they did differently.

Looking forward to get your thoughts.
