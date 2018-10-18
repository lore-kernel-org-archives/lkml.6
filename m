Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C426C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6242145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Kz97SF5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6242145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJRLyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:54:47 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:38102 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:54:47 -0400
Received: by mail-io1-f42.google.com with SMTP id n5-v6so20191831ioh.5;
        Wed, 17 Oct 2018 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDu+3+spCZ3AcS3AY0EP4+m8cefNQYjNiRLlE0jz9N8=;
        b=Kz97SF5Y3hjf6QCjkPIrHooFsP9uku5clh03bG3IM5+LseUySFj+b+6uYUy2YUHFud
         pcL1TRdwUVJbUvZf4uRuCfWpTJr89P2ZwtAd8PDVeR1Dfyxf4dS+F2TSoLj90f0/r8wr
         mI9o/BCdujxmrBEqzRtTI9clCk/R0EidCZgG/tcUBFT4FRBEREjPXn0fqKKiokmYHfNP
         bNsV6aesdgXfCl75A8OWOHOk0bWWFlKf6TJsxv3oXmAr8CFmUbCL7CvZfiALEvn4EHzT
         59ERpJvdDyz7ceMm+EqS3QXcDErn+WlGGBlnujYWJ2ysC6BUbG71mEMygZwE/Ny2S3MC
         B7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDu+3+spCZ3AcS3AY0EP4+m8cefNQYjNiRLlE0jz9N8=;
        b=ZJRKPJIKDQOz1TE5VBdCpQbPDpAr2VJsx6dQeIoLz/Xsz68upyt5Cc8da2V34G96gj
         64X84iwnNdSiqVqMXK4XoKBW6YnDT7YeF5RZt4hLEt1chgSX0Z6l2x1/uwcri5E9A2io
         YFIVK3hG9/n3kBqQu69rGtBX3tFu2kugYw30nhv1vGRDNi1d3pRQ4Pxw03DodyGnModt
         1nJajXFcL2nOOmmPY9r9JVYKE2RLMyAmyvnITKUOEbb/1nAumaFKtZYAZw2ZhK1/NX7u
         8K1lCkPhfcy39l8/nZtKTllIn3Df2iWyf+CFB6PXxdjQ7wQoqgq9UlZkgOdc316va5og
         bZHA==
X-Gm-Message-State: ABuFfoi7Q+MtX8YTKBHILMqIeq/5a7/opedKSzpY2qCTiIGHmL0T1Mkp
        vGlEr36qpMLJt0zU0xHvTMDP34Y29BccR7puano=
X-Google-Smtp-Source: ACcGV62UUF5/FR8ToCBORHaYcyPe9wPYRuEHsLZrm0Ewmwv3GxZ6NgRCQeIS0waK3ZrllgscMHyk+/BXt4DUWBgT3mI=
X-Received: by 2002:a6b:5a0f:: with SMTP id o15-v6mr17729503iob.136.1539834952548;
 Wed, 17 Oct 2018 20:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Oct 2018 20:55:41 -0700
Message-ID: <CAA9_cmeRE3mPvxb3NciGFYjNu9aMFx4iTMeUq2fC3UtsyXky2A@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
To:     brendanhiggins@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, joel@jms.id.au,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:54 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
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

Nice! I've been using mocking techniques in kernel code for the
libnvdimm test infrastructure in tools/testing/nvdimm/. It's part unit
test infrastructure, part emulation, and I've always had the feeling
it's all a bit too adhoc. I'm going to take a look and see what can be
converted to kunit. Please include linux-nvdimm@lists.01.org on future
postings.

I'll shamelessly plug my lwn article about unit testing
https://lwn.net/Articles/654071/ because it's always good to find
fellow co-travelers to compare notes and advocate for more test
oriented kernel development.
