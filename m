Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14921738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDlZdYad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfBSXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:20:31 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40621 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:20:30 -0500
Received: by mail-it1-f193.google.com with SMTP id i2so10929728ite.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l67ygQNslzxcrxU9G6uJ9P/wN+itEBjyIikGD8J/Q7I=;
        b=qDlZdYad6qWu59EFdOVPvCQsEn5D9Cu3BYPhyBIDHJchm2mD24Z8hXTv/YHpr+ydnt
         g877VrL2Szsi+v63crAD79l3i3CsaBKwUTxWIuLX37RsHOgAHJUOAp4xrfTtTQHVBezv
         kugi2d1ZZ6TohDEKBjBfDAzN/WiLQKxREY6bltbKJ2XroEpeqDdqOkzK98kavbzA8xMF
         y1QLHkrGbHAVzgxGudi5Xj3L6ggPFocGLD0+Z84CYv9lSnCyBtJ786PMXGhV2xofAjnx
         lKuXmj2G2i1F7dcVZEt8sVmGmEsl8wksWg9fm1LRu0CiIlYJEd68MzRRKS7GFbrjQv35
         zoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l67ygQNslzxcrxU9G6uJ9P/wN+itEBjyIikGD8J/Q7I=;
        b=oFJ86UWXhmwTMnrtou0MxN3YWsbBVwm6HpcqrQDm2/y3gVRfS1qS+B6sNdmQBJCTIa
         yS/p+e+HIP76g/mxecXs6qC8NH2Ec+EuCBJ3d13vOyD5+oySdkYIGZ6kAjMJbLlQPEh2
         UZDNwcmLxUAC+xKaHYEdtPE+2/Hn3xsx9BbJ8EmFNPMqUMLD0opF5vJO0opUboUCZKOR
         86ah6LK5Z9s2KOvxoXSamhqkzkY0Bj4XBNB0WzMVKl4Y5whIh6NqJwUpDevE66nTQgZQ
         qL23IHjT1E938IwuSHVhs/+/xsIYIEtk8nGGqoJRcG/GoT4e8Xn+7GkDAaGnWOG9G6MJ
         wINg==
X-Gm-Message-State: AHQUAubGJXaGzcJ+hKEBiRolCeCrU76KALqSjqmORPqVuv1tIy0x1ky9
        H9C/Tlj1YtkfwPNVc5ScuedZytlG+3SyYou6hCe2lQ==
X-Google-Smtp-Source: AHgI3IZREyOitwsG4PGatZHAROMcFyP1LyFFPjBy/FOqI08TObv8AINLRF8JaepyCMTmW3tGO6rNtB2ggGj1Hh/DYUU=
X-Received: by 2002:a9d:5549:: with SMTP id h9mr18034656oti.83.1550618429138;
 Tue, 19 Feb 2019 15:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-11-brendanhiggins@google.com> <155026408761.115909.17855438744578437385@swboyd.mtv.corp.google.com>
In-Reply-To: <155026408761.115909.17855438744578437385@swboyd.mtv.corp.google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Feb 2019 15:20:18 -0800
Message-ID: <CAFd5g44Dizk-VsFOmGn++E0d40sZmH6V+j05Eu6zUXaBj1xfcA@mail.gmail.com>
Subject: Re: [RFC v4 10/17] kunit: test: add test managed resource tests
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        amir73il@gmail.com, dan.carpenter@oracle.com, wfg@linux.intel.com,
        Avinash Kondareddy <avikr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-02-14 13:37:22)
> > diff --git a/kunit/test-test.c b/kunit/test-test.c
> > index 0b4ad6690310d..bb34431398526 100644
> > --- a/kunit/test-test.c
> > +++ b/kunit/test-test.c
> [...]
> > +
> > +#define KUNIT_RESOURCE_NUM 5
> > +static void kunit_resource_test_cleanup_resources(struct kunit *test)
> > +{
> > +       int i;
> > +       struct kunit_test_resource_context *ctx = test->priv;
> > +       struct kunit_resource *resources[KUNIT_RESOURCE_NUM];
> > +
> > +       for (i = 0; i < KUNIT_RESOURCE_NUM; i++) {
>
> Nitpick: This could use ARRAY_SIZE(resources) and then the #define could
> be dropped.

Noted. Will fix in next revision.

>
> > +               resources[i] = kunit_alloc_resource(&ctx->test,
> > +                                                   fake_resource_init,
> > +                                                   fake_resource_free,
> > +                                                   ctx);
> > +       }
> > +
> > +       kunit_cleanup(&ctx->test);
> > +
> > +       KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> > +}
> > +
> [...]
> > +
> > +static struct kunit_case kunit_resource_test_cases[] = {
>
> Can these arrays be const?

There is some private mutable state inside of `struct kunit_case` that
would be kind of annoying to pull out; I don't think it would make it
cleaner.
