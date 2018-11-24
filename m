Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28345C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8732082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xK+vEpHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8732082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeKXQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 11:03:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 11:03:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAO5DoT2112308;
        Sat, 24 Nov 2018 05:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=2dzrkc9EJQmBLkdjj96+/0CCtK0Dhu0Ne7UhRd+b+J0=;
 b=xK+vEpHadVvZQj1Rd89IF1h0/Mg5R8BVHrGRqnEM9kYApnRUVKnvK31hPJb4TgQdeOkq
 Qx0jufEA0/Muayqi8chchW5eLSGKq7vxgrCw7x9bJw4vhx0MVummvCAMYTnu96ZkV2Ka
 letyrFSfwnqpCQs9b3kpOWe261Tcvi5o31y7Ki19zZ0j80nKJDOh/WBgurcwqVJinCK7
 E98yKIEX77kXpSBP+mZmiGrVWUFOK0uWNYLh3Sl1go7rv/0TxIAcO1TGXyZ3ikE4TOl8
 DoTRRHbpOOYFPjMnzj8ODavLFvdf56JwT7p0SAMVSFtcdeY3PcC8Vsww3lN8ACp7WkMQ eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2tr4ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Nov 2018 05:15:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAO5FeYn010586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Nov 2018 05:15:40 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAO5FZ9f027418;
        Sat, 24 Nov 2018 05:15:35 GMT
Received: from asu.omang.mine.nu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Nov 2018 21:15:35 -0800
Message-ID: <1543036529.4680.655.camel@oracle.com>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     brakmo@fb.com, richard@nod.at, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Tim.Bird@sony.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, kieran.bingham@ideasonboard.com,
        julia.lawall@lip6.fr, joel@jms.id.au,
        linux-kselftest@vger.kernel.org, khilman@baylibre.com,
        joe@perches.com, dan.j.williams@intel.com, jdike@addtoit.com,
        kunit-dev@googlegroups.com,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Alan Maguire <alan.maguire@oracle.com>
Date:   Sat, 24 Nov 2018 06:15:29 +0100
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
References: <20181023235750.103146-1-brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9086 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811240051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 16:57 -0700, Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;

First thanks to Hidenori Yamaji for making me aware of these threads!

I'd like to kindly remind Brendan, and inform others who might have
missed out on it, about our (somewhat different approach) to this space
at Oracle: KTF (Kernel Test Framework). 

KTF is a product of our experience with driver testing within Oracle since 
2011, developed
as part of a project that was not made public until 2016.
During the project, we
experimented with multiple approaches to enable 
more test driven work with kernel code.
KTF is the "testing within the kernel" 
part of this. While we realize there are quite a
few testing frameworks out there, 
KTF makes it easy to run selected tests in kernel
context directly, 
and as such provides a valuable approach to unit testing.

Brendan, I regret you weren't at this year's testing and fuzzing workshop at 
LPC last week so we could have continued our discussions from last year there!

I hope we can work on this for a while longer before anything gets merged. 
Maybe it can be topic for a longer session in a future test related workshop?

Links to more info about KTF:
------
Git repo: https://github.com/oracle/ktf
Formatted docs: http://heim.ifi.uio.no/~knuto/ktf/

LWN mention from my presentation at LPC'17: https://lwn.net/Articles/735034/
Oracle blog post: https://blogs.oracle.com/linux/oracles-new-kernel-test-framework-for-linux-v2
OSS'18 presentation slides: https://events.linuxfoundation.org/wp-content/uploads/2017/12/Test-Driven-Kernel-Development-Knut-Omang-Oracle.pdf

In the documentation (see http://heim.ifi.uio.no/~knuto/ktf/introduction.html)
we present some more motivation for choices made with KTF. 
As described in that introduction, we believe in a more pragmatic approach 
to unit testing for the kernel than the classical "mock everything" approach, 
except for typical heavily algorithmic components that has interfaces simple to mock, 
such as container implementations, or components like page table traversal 
algorithms or memory allocators, where the benefit of being able to "listen" 
on the mock interfaces needed pays handsomely off.

We also used strategies to compile kernel code in user mode,
for parts of the code which seemed easy enough to mock interfaces for.
I also looked at UML back then, but dismissed it in favor of the
more lightweight approach of just compiling the code under test 
directly in user mode, with a minimal partly hand crafted, flat mock layer.

> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.

I am curious, with the intention of only running in user mode anyway, 
why not try to build upon Googletest/Googlemock (or a similar C unit 
test framework if C is desired), instead of "reinventing" 
specific kernel macros for the tests?

> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.

I think it is clearly a trade-off here: Tests run in an isolated, mocked 
environment are subject to fewer external components. But the more complex
the mock environment gets, the more likely it also is to be a source of errors, 
nondeterminism and capacity limits itself, also the mock code would typically be 
less well tested than the mocked parts of the kernel, so it is by no means any 
silver bullet, precise testing with a real kernel on real hardware is still 
often necessary and desired. 

If the code under test is fairly standalone and complex enough, building a mock
environment for it and test it independently may be worth it, but pragmatically, 
if the same functionality can be relatively easily exercised within the kernel, 
that would be my first choice.

I like to think about all sorts of testing and assertion making as adding more 
redundancy. When errors surface you can never be sure whether it is a problem 
with the test, the test framework, the environment, or an actual error, and 
all places have to be fixed before the test can pass. 

Thanks,
Knut



