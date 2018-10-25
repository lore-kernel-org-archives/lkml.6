Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9785C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D06420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpGwPseb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJZGAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:00:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46442 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJZGAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:00:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id u26so9442750otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwSlZRaJq68WPQg7LWgbVX20J9vQEquRlaHFibC3Lms=;
        b=rpGwPseboycknqCqZoQEEeNbNmt1XB0Y8XRowgwloWBm3Dq8hKVa0mliVKJAdxnC96
         kKfKpoxbpJV2bbVYDw9NLsQ1LSZMh0Z38wpLVtUAFYiDjPnysJ+1kQDDsFWm1ofiWMXM
         DAugmjNZU+Ex9YpAxrIob/81y7/doRvyScAxB+atyMYnEgHNZt5W3fegN7U0BhQFOWZV
         UxQrFiuG6W5oyFKsuwW5EbnJkLmvr/D+DIfU9ezvTcxjVQ8vQ91nWFQyj0NDafIH56AX
         Oxxo9ELV2uXiqisVkanWo66kw7RX2HuBMTJxJ9Z2FuyL/5IzAHgiTtmqh2wGT8cQGBlk
         8bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwSlZRaJq68WPQg7LWgbVX20J9vQEquRlaHFibC3Lms=;
        b=KQcFa7ZLykOvUkcpV9THyFBrgbCXuTKFdl8EUN331lzkPMtuwRfm2E7UpeLbwyExWw
         L7qWBNiM9XyZGQQDxb9t8ip0+MegqWlmhImOTd/IsOM1X0FXIm9HU4GvMKcJAMcolZTm
         6LNOLFIhqJ/h8AtQDHiZdPdg/PWisr+nrq6obZdOfko0LyHMn/LThh8SjtfXscj1rUYV
         q6PkVrV6FCAAEjg67T8PQrXkUiEBQzyQ1h70t6yf+aUUHR2creAwW4XXmzeFT9MfCtDB
         nheyAMb+t/eTYQ0YJ3Mf2SjsECS9ox0+0LJl9JNVXJ1ZaMqFVusx+7F5xCSoTH42lg4C
         0dgw==
X-Gm-Message-State: AGRZ1gInjulHzJ+ip2+r/z+qPqhKOCqIlc+y7Wo7t4CzNvtVgV585p3T
        aVRyaIt4riETgtqbfIQeeyydK7ugpN2EeodRj79tDw==
X-Google-Smtp-Source: AJdET5cGaHV93Aciav34VdKFd/3iq+JYJur9jxP8puW5x1OnOgyUwzbheyftGWRY6ZDkt+p4e3xhWbM6pfMAqCIupt4=
X-Received: by 2002:a9d:6509:: with SMTP id i9mr585698otl.338.1540502740694;
 Thu, 25 Oct 2018 14:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com> <20181024091449.GL324@phenom.ffwll.local>
In-Reply-To: <20181024091449.GL324@phenom.ffwll.local>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 25 Oct 2018 14:25:28 -0700
Message-ID: <CAFd5g44RGcYzEb68y0jBpcpZPhbY9=M-==+9cNvs0XyMamobLA@mail.gmail.com>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com
Cc:     daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:14 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Oct 23, 2018 at 04:57:36PM -0700, Brendan Higgins wrote:
<snip>
> > ## Changes Since Last Version
> >
> >  - Updated patchset to apply cleanly on 4.19.
> >  - Stripped down patchset to focus on just the core features (I dropped
> >    mocking, spying, and the MMIO stuff for now; you can find these
> >    patches here: https://kunit-review.googlesource.com/c/linux/+/1132),
> >    as suggested by Rob.
> >  - Cleaned up some of the commit messages and tweaked commit order a
> >    bit based on suggestions.
>
> Do you have some example unit tests somewhere? The docs are all neat, but
> real example helps a lot with the tried&true art of copypasting :-)

Yes! So I have quite a few tests for KUnit itself, but they are mostly
in the patches that I cut from the previous version of the RFC:
https://kunit.googlesource.com/linux/+/c58019fb4fe15f820e51f857ae4ff14cd34075af/kunit/mock-macro-test.c
https://kunit.googlesource.com/linux/+/c58019fb4fe15f820e51f857ae4ff14cd34075af/kunit/mock-test.c
https://kunit.googlesource.com/linux/+/c58019fb4fe15f820e51f857ae4ff14cd34075af/kunit/string-stream-test.c
https://kunit.googlesource.com/linux/+/c58019fb4fe15f820e51f857ae4ff14cd34075af/kunit/test-stream-test.c
https://kunit.googlesource.com/linux/+/c58019fb4fe15f820e51f857ae4ff14cd34075af/kunit/test-test.c

There are some in this patchset (like here:
https://lore.kernel.org/patchwork/patch/1002904/), but I should
probably include some more...

In any case, if you are looking for a more "realistic" example, you
could look at these sets of tests, which I think is pretty good, and
actually found a couple bugs in existing code:
https://kunit.googlesource.com/linux/+/e10484ad2f9fc7926412ec84739fe105981b4771/drivers/i2c/busses/i2c-aspeed-test.c
https://kunit.googlesource.com/linux/+/4b41b1594ffeab70f1b4364721940cb909509d97/net/ipv6/route-test.c

>
> I'd like to give this a test spin with some of the unit tests we already
> have in drm. And especially figuring out how we could integrate this with
> our existing infrastructure.

Awesome! I am looking forward to hearing how it goes!

Cheers
