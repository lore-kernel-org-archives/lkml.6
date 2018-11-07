Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC7C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FED2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWoIMPII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FED2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbeKGKpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:45:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44086 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388934AbeKGKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:45:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id k19-v6so12478366oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bovs5aC7h8dAPPBUZ31FH5utHUUFD/vz9Vqn+hRJi2A=;
        b=SWoIMPIIW8aZKSqXjO0mLbJd3IrLaZ5/ldU7x3vmynYcRgPZXdl+QR4eOr50mBO6eU
         C4hL9RhxrI2mURIlFIx7js62L4VTPU/UiRF5UJz3DBoVo+/hyPFE8Hmo8IucMF3WUv7o
         QnywsnvhR1OF0Pw77itfffIRDyEqW6AQB1olx6QVveLJjswvmj3Srs9im1FpDa+etAWi
         98PC70mlSfZRCA/KjJ3XJdHZyce/5OSdeiyPB8IYtMV5t5FzRaufQCLmBcbMkI1WzVmb
         g3wgFggUZVHuMh6KzCO5HI/3MWZRx2RPdPUbbBeKNl3Vr3Q7JTj+xwhOOt6FoCk8ANhk
         sPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bovs5aC7h8dAPPBUZ31FH5utHUUFD/vz9Vqn+hRJi2A=;
        b=YrwY4lvUKku0WN4gsE/aOnAXYbcRrRt3G/PGQVPiA/RMfTKA1J1DlOTirDtCrfsBEQ
         bkqrhEMnPvpu4kJb0v9t0Nnd9cBdoFSXBahA4Zx6QVuZWZslA3nKB7Vo306C2rW0K9PH
         kRHpwBiCJOFbnbx6LCZCrl7TvJ930HupestuhOeOwbGug4SazRuRZoVyJLgaFNidronM
         clvLqf1EXLZvnSx/jqy51/JVRkrrSd1LC4QNPPj6/BJPSDCnI7MSz/EaKUBB2QfF1VZ1
         YKL5ygVIrVgj2UND8DZX813LMhKeX3s1Obq0sT/d0dN68nkbsI+Das4QS7f/6erHUsaE
         y0ig==
X-Gm-Message-State: AGRZ1gLFvjmlCD6H4DNmSRetxuHTKgEGSYL7SFkhg+skznwuvt19G6YD
        PWMgMHwOedhPHcDYgkYQJlKknaswSgudo5rXBDvXyA==
X-Google-Smtp-Source: AJdET5coaZ4kHZKAT1VvAwXVC/mK4m5MJNC2/Wc8hCJ0DejypMtFvvGyXYOIu5f5XjAliYnm7MsNaKHbQFHyS0rzTJ8=
X-Received: by 2002:aca:f154:: with SMTP id p81-v6mr17463997oih.348.1541553459147;
 Tue, 06 Nov 2018 17:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com> <f3682d48-6f27-5eef-8274-02f90dd65188@kernel.org>
In-Reply-To: <f3682d48-6f27-5eef-8274-02f90dd65188@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 6 Nov 2018 17:17:27 -0800
Message-ID: <CAFd5g45Tgcx4RisrCF8QHneR7ELezPfpEPKh_mH8KEUi3skE7g@mail.gmail.com>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     shuah@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:23 AM Shuah Khan <shuah@kernel.org> wrote:
>
> Hi Brendan,
<snip>
> Framework looks good. I think it would be helpful to include a real test

Great to hear!

> in the patch series to get a feel for how effective it is.

Alright, will do. Rob suggested converting
https://elixir.bootlin.com/linux/v4.19/source/drivers/of/unittest.c to
KUnit, so that might offer a good comparison.

>
> On one hand, KUnit stands on its own as its own and maybe it should be placed in
> under tools/testing/KUnit, however I am wondering would it be beneficial for the
> framework to under selftests.
>
> I am a bit concerned about the number of test framework we have at the moment and
> are we running the risk of fragmenting the landscape. I am concerned if this would
> lead to developer confusion as to where to add tests.

On one hand separating them makes sense because they are different
things. kselftest seems to do its job, writing end-to-end tests,
pretty well. Trying to associate KUnit with it could also be confusing
since they have different requirements and should be used for
different things. But on the other hand, you are right, it would be
nice to have a coherent experience for developers. In either case, we
will still need developers to understand when they should be writing
unit tests and when they should be writing end-to-end tests. So in the
end, I don't think it will matter too much, we will still need to
address this confusion either way.

The main reason I made it separate was just because I thought people
would find it strange to have essentially normal kernel code depend on
something in `tools/testing/`. You, me, and Greg had talked about this
elsewhere, in summary, I am trying to do in-tree unit testing, so
tests should live side-by-side with the code it tests, and the tests
run at the same level of abstraction as the code that is under test.
The tests do not run as userspace programs on an installed kernel
under test. The goal is to be able to run arbitrary kernel code in
isolation.

Although it would be *possible* to put KUnit under `tools/testing/`,
my understanding is that `tools/testing/` is for programs that compile
independently of the kernel, rather they do not link against anything
built-in to the kernel. (I saw there are some test drivers, but they
seem to be modeled as out of tree drivers that have no option to be
built into the kernel.) KUnit does not fall into this category as
KUnit links directly against arbitrary kernel code, and actually
reuses kernel infrastructure to provide an environment to run kernel
code in.

I do not feel strongly about where KUnit lives, but by my
understanding, putting KUnit in `tools/testing/` might break
assumptions about the relationship between `tools/` and the rest of
the kernel.

I know you previously said that there are unit tests under kselftest
(like maybe this one:
https://elixir.bootlin.com/linux/v4.19/source/lib/locking-selftest.c
?). I agree that something like this example is trying to be a unit
test, but the kselftest infrastructure is built around the idea of
booting kernels and running tests against them; I know that some
kselftests load test modules, but the point is the intention is to run
the kernel somewhere. My end goal with KUnit is that we should not
need to run a kernel anywhere (I know right now I am using UML, but
the goal is to get away from that). So I think that decidedly makes
them two different things.

The number of test frameworks is a problem, I definitely agree with
that. Most of the other tests I have seen for the kernel are
indisputably end-to-end tests; it seems that kselftest is decidedly
the favorite, maybe we should move those under kselftest?

I know there are other things that don't fit. Maybe we could start off
with some suggestions for best practices for what to use and when?
>
> That being said, I don't have a strong opinion one way or the other.

I think it is pretty common on other projects to have unit tests
separated from end-to-end tests in some way or another. You want to be
able to run unit tests quickly and all the time, whereas you usually
only want to run your end-to-end tests when you make a submission or a
release. Regardless of where we put KUnit and what its relationship to
kselftest becomes, we should definitely make it easy to run unit tests
separate from all the end-to-end tests.
>
> btw I started playing with kunit following the instructions and ran into problems:
>
> ./tools/testing/kunit/kunit.py
> usage: kunit.py [-h] {run,new} ...
>
> Helps writing and running KUnit tests.
>
> positional arguments:
>   {run,new}
>     run       Runs KUnit tests.
>     new       Prints out boilerplate for writing new tests.
>
> optional arguments:
>   -h, --help  show this help message and exit
>
> ./tools/testing/kunit/kunit.py run
> Regenerating .config ...
> ERROR:root:Provided Kconfig is not contained in validated .config!

Oh sorry, I need to write some documentation for that.

I take it you checked out
https://kunit.googlesource.com/linux/+/kunit/alpha/master ?

If so, you need a "kunitconfig" in the root of your kernel source with
the following Kconfig options:
CONFIG_TEST=y
CONFIG_TEST_TEST=y
CONFIG_EXAMPLE_TEST=y

I am guessing what happened is that you used the "stable" branch which
we have been using internally, but follow the instructions I posted
for this patchset. Some of the Kconfig options have deviated between
them. Sorry about the confusion.

>
> thanks,
> -- Shuah

Thank you!
