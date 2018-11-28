Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F76EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C087120832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFSe/cp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeK2G7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:59:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2G7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:59:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASJsKLA194176;
        Wed, 28 Nov 2018 19:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=PXJofRQSewxj/UovMyn2Y5Y38FbiNqrAklVRg2PbcJA=;
 b=CFSe/cp7Py4K7DIgrxLcP93wK7WzCGAs95iASjED3c3yksts1upImjmGMJNDo8pL0pVg
 l0ZQjD1UpGSdDvrBnJ3bTXF1qqBNqNNeLQCM0oWSKdM/cvrWsrHP2duqe85mmD7Mk1pz
 GDTJwUCR/v0KKAF71mEaYYLwEyi69mCgkcULWN044mw2sxObOTHytDkkJn4DoWz5D4Wt
 UL974RtO56f7rx3CAGcdzbVwt7Rf3yP0cxkhyEcpNAUDyUePcDGCaJTX4fZe+d1lMQj2
 Az8yOBt/olRhP2K7VtNnpM9DU2PZe0bAwgCL7co7Y0bEol1+COQHXbyZwLkxc78WDXXp UA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nxxkqmbtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 19:55:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wASJt2i4027207
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 19:55:02 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wASJssI0009673;
        Wed, 28 Nov 2018 19:54:55 GMT
Received: from asu.omang.mine.nu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 11:54:54 -0800
Message-ID: <1543434888.4680.862.camel@oracle.com>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>
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
Date:   Wed, 28 Nov 2018 20:54:48 +0100
In-Reply-To: <CAFd5g45oPSp870hJLDSHiMfU7Mh-EvpYcFdAaOQxecXNde5PSw@mail.gmail.com>
References: <20181023235750.103146-1-brendanhiggins@google.com>
         <1543036529.4680.655.camel@oracle.com>
         <CAFd5g45oPSp870hJLDSHiMfU7Mh-EvpYcFdAaOQxecXNde5PSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 17:41 -0800, Brendan Higgins wrote:
> On Fri, Nov 23, 2018 at 9:15 PM Knut Omang <knut.omang@oracle.com> wrote:
> >
> > On Tue, 2018-10-23 at 16:57 -0700, Brendan Higgins wrote:
> <snip>
> >
> > Brendan, I regret you weren't at this year's testing and fuzzing workshop at
> > LPC last week so we could have continued our discussions from last year there!
> 
> Likewise! Unfortunately, I could not make it. So it goes.
>
> >
> > I hope we can work on this for a while longer before anything gets merged.
> > Maybe it can be topic for a longer session in a future test related workshop?
> 
> I don't see why we cannot just discuss it here as we are already
> doing. 

Yes, as long as we are not wasting all the Cc:'ed people's valuable time.

> Besides, you are mostly interested in out of tree testing,
> right? I don't see how this precludes anything that you are trying to
> do with KTF.

Both approaches provide assertion macros for running tests inside the kernel,
I doubt the kernel community would like to see yet two such sets of macros, 
with differing syntax merged. One of the good reasons to have a *framework*
is that it is widely used and understood, so that people coming from one part of the
kernel can easily run, understand and relate to selected tests from another part.

The goal with KTF is to allow this for any kernel, old or new, not just kernels
built specifically for testing purposes. We felt that providing it as a separate git
module (still open source, for anyone to contribute to) is a more efficient approach
until we have more examples and experience with using it in different parts 
of the kernel. We can definitely post the kernel side of KTF as a patch series fairly soon
if the community wants us to. Except for hybrid tests, the ktf.ko module works fine
independently of any user side support, just using the debugfs interface to run and
examine tests.

I think there are good uses cases for having the ability to maintain a 
single source for tests that can be run against multiple kernels,
also distro kernels that the test framework cannot expect to be able to modify, 
except from using the module interfaces.

And there are good arguments for having (at least parts of) 
the test framework easily available within the kernel under test.

> > Links to more info about KTF:
> > ------
> > Git repo: https://github.com/oracle/ktf
> > Formatted docs: http://heim.ifi.uio.no/~knuto/ktf/
> >
> > LWN mention from my presentation at LPC'17: https://lwn.net/Articles/735034/
> > Oracle blog post: https://blogs.oracle.com/linux/oracles-new-kernel-test-framework-for
> -linux-v2
> > OSS'18 presentation slides: https://events.linuxfoundation.org/wp-content/uploads/2017
> /12/Test-Driven-Kernel-Development-Knut-Omang-Oracle.pdf
> >
> > In the documentation (see http://heim.ifi.uio.no/~knuto/ktf/introduction.html)
> > we present some more motivation for choices made with KTF.
> > As described in that introduction, we believe in a more pragmatic approach
> > to unit testing for the kernel than the classical "mock everything" approach,
> > except for typical heavily algorithmic components that has interfaces simple to mock,
> > such as container implementations, or components like page table traversal
> > algorithms or memory allocators, where the benefit of being able to "listen"
> > on the mock interfaces needed pays handsomely off.
> 
> I am not advocating that we mock everything. Using as much real code
> dependencies as possible for code under test is a pretty common
> position, and one which I adhere to myself.
> 
> >
> > We also used strategies to compile kernel code in user mode,
> > for parts of the code which seemed easy enough to mock interfaces for.
> > I also looked at UML back then, but dismissed it in favor of the
> > more lightweight approach of just compiling the code under test
> > directly in user mode, with a minimal partly hand crafted, flat mock layer.
> 
> Is this new? When I tried your code out, I had to install the kernel
> objects into my host kernel. Indeed, your documentation references
> having to install kernel modules on the host:
> http://heim.ifi.uio.no/~knuto/ktf/installation.html

That is correct. The user land testing is a separate code base that 
need some more care still to make it generic enough to serve as an RFC,
so you haven't seen it (yet).

> > > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > > unit test cases, grouping related test cases into test suites, providing
> > > common infrastructure for running tests, mocking, spying, and much more.
> >
> > I am curious, with the intention of only running in user mode anyway,
> 
> I made it possible to "port" KUnit to other architectures.
> Nevertheless, I believe all unit tests should be able to run without
> depending on hardware or some special test harness. If I see a unit
> test, I should not need to know anything about it just to run it.
> Since there is no way to have all possible hardware configurations a
> priori, all tests must be able to be run in a place that doesn't
> depend in hardware; hence they should all be runnable as just normal
> plane old user space programs with no dependency on a host kernel or
> host hardware.
> 
> > why not try to build upon Googletest/Googlemock (or a similar C unit
> > test framework if C is desired), instead of "reinventing"
> > specific kernel macros for the tests?
> 
> I would love to reuse Googletest/Googlemock if it were possible; 

I have done it with googletest, so it *is* possible ;-) 

> I have used it a lot on other projects that I have worked on and think
> it is great, but I need something I can check into the Linux kernel;
> this requirement rules out Googletest/Googlemock since it depends on
> C++. There are existing frameworks for C, true, but we then need to
> check that into the Linux kernel or have the kernel depend on that; 

I think that is limiting the scope of it.
Certainly developing the kernel already depends on a lot of 
user land tools, such as git for instance. Having another package 
to install for running tests might not be such a big deal, and saves 
this list from even more traffic.

So figuring out what to put in the kernel repo 
and what to leave outside is IMHO part of the challenge.

> to me that seemed like a lot more work than just reimplementing what we
> need, which isn't much. Most of the hard parts are specific to the
> kernel anyway.

> > > A unit test is supposed to test a single unit of code in isolation,
> > > hence the name. There should be no dependencies outside the control of
> > > the test; this means no external dependencies, which makes tests orders
> > > of magnitudes faster. Likewise, since there are no external dependencies,
> > > there are no hoops to jump through to run the tests. Additionally, this
> > > makes unit tests deterministic: a failing unit test always indicates a
> > > problem. Finally, because unit tests necessarily have finer granularity,
> > > they are able to test all code paths easily solving the classic problem
> > > of difficulty in exercising error handling code.
> >
> > I think it is clearly a trade-off here: Tests run in an isolated, mocked
> > environment are subject to fewer external components. But the more complex
> > the mock environment gets, the more likely it also is to be a source of errors,
> > nondeterminism and capacity limits itself, also the mock code would typically be
> > less well tested than the mocked parts of the kernel, so it is by no means any
> > silver bullet, precise testing with a real kernel on real hardware is still
> > often necessary and desired.
> 
> I think you are misunderstand me. By isolation, I just mean no code
> under test should depend on anything outside of the control of the
> test environment. 

And this approach is good, but it only covers the needs for 
a limited part of the kernel code. It can also be done entirely 
in user space, using user land test frameworks, the biggest challenge is 
in the mocking. Lots of the code in the kernel behave 
based on interaction with other subsystems, and with hardware.

> As I mention above, reusing real code for test
> dependencies is highly encouraged.
> 
> As for running against hardware, yes, we need tests for that too, but
> that falls under integration testing; it is possible to use what I
> have here as a basis for that, but for right now, I just want to focus
> on the problem of unit testing: I think this patchset is large enough
> as it is.
>
> > If the code under test is fairly standalone and complex enough, building a mock
> > environment for it and test it independently may be worth it, but pragmatically,
> > if the same functionality can be relatively easily exercised within the kernel,
> > that would be my first choice.
> >
> > I like to think about all sorts of testing and assertion making as adding more
> > redundancy. When errors surface you can never be sure whether it is a problem
> > with the test, the test framework, the environment, or an actual error, and
> > all places have to be fixed before the test can pass.
> 
> Yep, I totally agree, but this is why I think test isolation is so
> important. If one test, or one piece of code is running that doesn't
> need to be, it makes debugging tests that much more complicated.

Yes, and another dimension to this that we have focused on with KTF,
and where the Googletest frontend gives additional value,
is that the tests should be both usable for smoke test and 
continuous integration needs, but at the same time be easy to execute
standalone, test by test, with extra debugging, to allow them to be 
used by developers as part of a short cycle development process.
 
I think the solution needs to allow a pragmatic approach, 
time an resources are limited. Sometimes an isolated test is possible, 
sometimes a test that executes inside a real 
environment is a better return on investment!

Cheers,
Knut 
