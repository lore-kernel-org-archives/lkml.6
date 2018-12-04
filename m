Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62226C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE6D2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot8M1kUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE6D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbeLDNti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeLDNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:49:36 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9A9214C1;
        Tue,  4 Dec 2018 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543931375;
        bh=g4kDTDS6pldHhQc9NehMUFvt/MRg5/EkNX4xAVTtWbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ot8M1kUkjyV66hIi31UhnrMKWlfXyYLGWSlxZDXUJZWEJBBXKFUJlFy5OjnD7za8k
         kErJsyHiYNB7btmzbKBs+ZJNIxYeFLu6/uCYobmpl7pitOuDHpKN+vOvsv8GdimUEI
         Bz0COrLhFZZA8KZMr1n/j6kVGILx8KitaKC4xnX0=
Received: by mail-qk1-f173.google.com with SMTP id w204so9600466qka.2;
        Tue, 04 Dec 2018 05:49:35 -0800 (PST)
X-Gm-Message-State: AA+aEWbtkSl3r5PGTktlBkXOEfgo99D3VRUSHTrjvFXH9X6+F+xl/Xh4
        ipu05qEmVlSVkVlIdbl0Fum58RgGUzhrdoj4cw==
X-Google-Smtp-Source: AFSGD/U9YchkMS8xWtc58jOlXD8/P7OYuXYe+HCZeVM6sZDQTSuPUkEAllEHnjjIUaUFjA6FFZXoeAwWKNWNNfeYIJ8=
X-Received: by 2002:a37:7682:: with SMTP id r124mr18861001qkc.79.1543931374238;
 Tue, 04 Dec 2018 05:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com> <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com>
In-Reply-To: <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 07:49:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
Message-ID: <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Brendan, Rob,
>
> On 11/28/18 11:36 AM, Brendan Higgins wrote:
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> >
> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > and does not require tests to be written in userspace running on a host
> > kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> > can run several dozen tests in under a second. Currently, the entire
> > KUnit test suite for KUnit runs in under a second from the initial
> > invocation (build time excluded).
> >
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
> >
> > ## What's so special about unit testing?
> >
> > A unit test is supposed to test a single unit of code in isolation,
> > hence the name. There should be no dependencies outside the control of
> > the test; this means no external dependencies, which makes tests orders
> > of magnitudes faster. Likewise, since there are no external dependencies,
> > there are no hoops to jump through to run the tests. Additionally, this
> > makes unit tests deterministic: a failing unit test always indicates a
> > problem. Finally, because unit tests necessarily have finer granularity,
> > they are able to test all code paths easily solving the classic problem
> > of difficulty in exercising error handling code.
> >
> > ## Is KUnit trying to replace other testing frameworks for the kernel?
> >
> > No. Most existing tests for the Linux kernel are end-to-end tests, which
> > have their place. A well tested system has lots of unit tests, a
> > reasonable number of integration tests, and some end-to-end tests. KUnit
> > is just trying to address the unit test space which is currently not
> > being addressed.
> >
> > ## More information on KUnit
> >
> > There is a bunch of documentation near the end of this patch set that
> > describes how to use KUnit and best practices for writing unit tests.
> > For convenience I am hosting the compiled docs here:
> > https://google.github.io/kunit-docs/third_party/kernel/docs/
> > Additionally for convenience, I have applied these patches to a branch:
> > https://kunit.googlesource.com/linux/+/kunit/rfc/4.19/v3
> > The repo may be cloned with:
> > git clone https://kunit.googlesource.com/linux
> > This patchset is on the kunit/rfc/4.19/v3 branch.
> >
> > ## Changes Since Last Version
> >
> >  - Changed namespace prefix from `test_*` to `kunit_*` as requested by
> >    Shuah.
>
>
> >  - Started converting/cleaning up the device tree unittest to use KUnit.
> >  - Started adding KUnit expectations with custom messages.
> >
>
> Sorry I missed your reply to me in the v1 patch thread.  I've been
> traveling a lot the last few weeks.  I'm starting to read messages
> that occurred late in the v1 patch thread and the v2 patch thread,
> so I'm just coming up to speed on this.
>
> My comments below are motivated by adding the devicetree unittest to
> this version of the patch series.
>
> Pulling a comment from way back in the v1 patch thread:
>
> On 10/17/18 3:22 PM, Brendan Higgins wrote:
> > On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:
>
> < snip >
>
> > The test and the code under test are linked together in the same
> > binary and are compiled under Kbuild. Right now I am linking
> > everything into a UML kernel, but I would ultimately like to make
> > tests compile into completely independent test binaries. So each test
> > file would get compiled into its own test binary and would link
> > against only the code needed to run the test, but we are a bit of a
> > ways off from that.
>
> I have never used UML, so you should expect naive questions from me,
> exhibiting my lack of understanding.
>
> Does this mean that I have to build a UML architecture kernel to run
> the KUnit tests?

In this version of the patch series, yes.

> *** Rob, if the answer is yes, then it seems like for my workflow,
> which is to build for real ARM hardware, my work is doubled (or
> worse), because for every patch/commit that I apply, I not only have
> to build the ARM kernel and boot on the real hardware to test, I also
> have to build the UML kernel and boot in UML.  If that is correct
> then I see this as a major problem for me.

I've already raised this issue elsewhere in the series. Restricting
the DT tests to UML is a non-starter.

> Brenden, in the above quote you said that in the future you would
> like to make the "tests compile into completely independent test
> binaries".  I am assuming those are intended to run as standalone
> user space programs instead of inside UML.  Is that correct?  If
> so, how will KUnit tests be able to test code that uses locking
> mechanisms that require instructions that are not available to
> user space execution?  (I _think_ that such instructions may be
> present, depending on which locking mechanism, but I might be
> mistaken.)

I think he means as kernel modules as kunit is for testing internal
kernel interfaces. kselftest is userspace level tests.

If this were true about locking, then UML itself would not be viable.

> Another possible concern that I have for removing the devicetree
> unit tests from my normal kernel build process is that I think
> that the ability to use sparse to analyze the source in the
> unit tests is removed.  Please correct me if I misunderstand
> that.
>
> Another issue is that the devicetree unit tests will no longer
> be cross compiled with my ARM compiler, so I lose a small
> amount of testing for compiler related issues.

0-day does that for you. :)

> Overall, I'm still trying to learn enough to determine whether
> the gains from moving to KUnit outweigh the losses.
>
> -Frank
