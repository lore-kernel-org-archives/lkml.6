Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A076C2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQQM3wwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A076C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeLDLkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:40:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46060 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDLkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:40:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8073879pfd.12;
        Tue, 04 Dec 2018 03:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hjfXjb12qx3T2MAIYL9kuTx72dXQuRtYKZQPzpLsvF0=;
        b=AQQM3wwaPA82Z3V/4V9nOII38Ax5MpkArocEj2+jLMwGP0HQ8IA7OxjqsGFSJOqB8A
         DFRiUnyDmWi8M/9k81ur72tPo7InUl9BvEmfAVlYB9etmFA9dzx9kepFZESfoH+2Skpm
         ml27o8XDSqQMZ3nE/uTtRGjt2ob/8kX1COmT29kgLRBGV1Y+5PqDJQv86YmaSOrO6BLx
         95hW/9oBRC/FLXPAXQaWYeD6+26r0taY4vjIcPf7p+U+5/9+FudZveUd0zMGN9BP2Zx9
         x4GU0KgrlJHg1CqbiQPSNHYs0Xh10nrsaASAuXzBqCyhkkNjTsM6gneSn9ZNQz1kAMFp
         T3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjfXjb12qx3T2MAIYL9kuTx72dXQuRtYKZQPzpLsvF0=;
        b=fJaQwpH1soQjoYJTvZSMPax4VAMrpbMm9u1Ja2aYF7U2oqlf0RYcnDJCYZk6ZnYqUH
         FZbxYr6ORRbMZxsQuwLmsOcddV4BbCBvYc+QG16/tdNo/ORwC7mYIcWA2adke2YaN6F+
         pkoGhLqvIc+v4tvH94NlM9vdaTWhPfb5SN91UmqdEvlXbCCXZ10WvljZswpS0MX0h54p
         SwHB+FH/yl90bNoFqHwnrN2g65POWFADfcN2bM9tL5xMKu27CpLKmWHS7ebFQstPrCAA
         Y8D725rcSgtjD2JxKIwbOzf1m4F4DBKxRE/JHIgOcw49JZLODIdNRt4tvqlZGBYSnKzW
         TJ0w==
X-Gm-Message-State: AA+aEWYB0iKPOKv0EIFz9msMIPZy9XcdX6ozpqGaPIzNNVPQoJnmDDyV
        uRL5IAcbblr2+lnQFpPQfQw=
X-Google-Smtp-Source: AFSGD/UvLqRS49WtNS2kfrSIEZl/3ip1Pf656i5V3Gej9lWQJulVVbZoQ8XeaGkn32LsmXKrETWjcw==
X-Received: by 2002:a63:d5e:: with SMTP id 30mr16451838pgn.54.1543923644646;
        Tue, 04 Dec 2018 03:40:44 -0800 (PST)
Received: from [10.231.245.170] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id d69sm22078198pfg.168.2018.12.04.03.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 03:40:44 -0800 (PST)
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, knut.omang@oracle.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com>
Date:   Tue, 4 Dec 2018 03:40:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan, Rob,

On 11/28/18 11:36 AM, Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
> 
> ## What's so special about unit testing?
> 
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.
> 
> ## Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
> 
> ## More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> Additionally for convenience, I have applied these patches to a branch:
> https://kunit.googlesource.com/linux/+/kunit/rfc/4.19/v3
> The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/4.19/v3 branch.
> 
> ## Changes Since Last Version
> 
>  - Changed namespace prefix from `test_*` to `kunit_*` as requested by
>    Shuah.


>  - Started converting/cleaning up the device tree unittest to use KUnit.
>  - Started adding KUnit expectations with custom messages.
> 

Sorry I missed your reply to me in the v1 patch thread.  I've been
traveling a lot the last few weeks.  I'm starting to read messages
that occurred late in the v1 patch thread and the v2 patch thread,
so I'm just coming up to speed on this.

My comments below are motivated by adding the devicetree unittest to
this version of the patch series.

Pulling a comment from way back in the v1 patch thread:

On 10/17/18 3:22 PM, Brendan Higgins wrote:
> On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:

< snip >

> The test and the code under test are linked together in the same
> binary and are compiled under Kbuild. Right now I am linking
> everything into a UML kernel, but I would ultimately like to make
> tests compile into completely independent test binaries. So each test
> file would get compiled into its own test binary and would link
> against only the code needed to run the test, but we are a bit of a
> ways off from that.

I have never used UML, so you should expect naive questions from me,
exhibiting my lack of understanding.

Does this mean that I have to build a UML architecture kernel to run
the KUnit tests?

*** Rob, if the answer is yes, then it seems like for my workflow,
which is to build for real ARM hardware, my work is doubled (or
worse), because for every patch/commit that I apply, I not only have
to build the ARM kernel and boot on the real hardware to test, I also
have to build the UML kernel and boot in UML.  If that is correct
then I see this as a major problem for me.

Brenden, in the above quote you said that in the future you would
like to make the "tests compile into completely independent test
binaries".  I am assuming those are intended to run as standalone
user space programs instead of inside UML.  Is that correct?  If
so, how will KUnit tests be able to test code that uses locking
mechanisms that require instructions that are not available to
user space execution?  (I _think_ that such instructions may be
present, depending on which locking mechanism, but I might be
mistaken.)

Another possible concern that I have for removing the devicetree
unit tests from my normal kernel build process is that I think
that the ability to use sparse to analyze the source in the
unit tests is removed.  Please correct me if I misunderstand
that.

Another issue is that the devicetree unit tests will no longer
be cross compiled with my ARM compiler, so I lose a small
amount of testing for compiler related issues.

Overall, I'm still trying to learn enough to determine whether
the gains from moving to KUnit outweigh the losses.

-Frank
