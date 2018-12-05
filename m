Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF80C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9772054F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUYFPLPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9772054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeLEXm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:42:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45248 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeLEXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:42:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so20337655ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILTDFbnKcrSbI/WOEOfgYOAsJJ/q92nb0Ki7PHqDm4c=;
        b=CUYFPLPnLvA7Y5BGp17YgnKx5e4b6OX2bXL+WGKSm3KAyKi7nAYMdlCvj4N+laipSe
         8H260LRWs3dDuhYUQi5hp4K0QJmG7ZSgbyrHFMPJf+upLgsfJC3rkVxqhCuTZFd+hYFD
         3dy6ngOp7+Y97nR40MTG5gQDk78bpi0HSSJzW6eG//BGWt9TiwgeWLxQG7qzWQNyJwW5
         hRsim8VeFtPmVZQoqDFrbNkkvWt9/x40bbi9GLbfLvJ/c91ZORM5jBC0NtRGxLRla/aE
         iteAghzeATzNPgcW8+xNz3l5ddTGw3veo/gDTs+Pph/cm2gm4sInt4cFJzyyhqaR0Xfl
         3xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILTDFbnKcrSbI/WOEOfgYOAsJJ/q92nb0Ki7PHqDm4c=;
        b=t0o96AxUDUv/9en6lxvurnQ1xMcnLeAs16kv+rEwenfTNLNAwJSOiFeOx0iwyI1TRk
         bEN2L1CKS4XdXq3QEKRyy8oeUpbmvBSOd06OXKZPECXtily3d9DsYjr9x29D5YEWQLcQ
         dnUsiT0+N+vPUXXmsjUXZT1IZlOO9/Ja9nIC165vZm4zxqK51s4CWcRkFIK2GCJ2rYzy
         RTkt7Ec9aSIArF/Keg0UeA91hVTLF7s+VY1CpuzNRkLO6MkM3ic+JG2KmHu018JEGbSL
         RMCV4v9siq/MYWi8FLqYpUOegW6Q5ZkBuGEcG+WmxldN8Qv4Dz1d+19CGG/BNKPCKTaT
         V0Ig==
X-Gm-Message-State: AA+aEWaG72XFaTfirOqRFaTn3iqFyJbF0gOm8I8bVemgPPAX0BonsTqN
        4O8gR2mfpCO3SzUJ+JXCTA4u8h5CzhPR8+G88NPsJg==
X-Google-Smtp-Source: AFSGD/VcGuZqItDIdSb9ej3wWzfLI/Y13oXdBNaj2MnIO2Y9T3kpxYWMyfO55rfFj0W7LF3N3bstxuPcJ5nqP7BdgyM=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr15878232otf.98.1544053377755;
 Wed, 05 Dec 2018 15:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org> <CAFd5g475RK9v9X4qxmXwuHiPMOs05WrZAw6EJWNdVoAHQWguFQ@mail.gmail.com>
 <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com>
In-Reply-To: <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Dec 2018 15:42:46 -0800
Message-ID: <CAFd5g45-HGytAPTx7OQD8B0oAdLncDGSMMTyHCTtyobeUJ15AQ@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Rob Herring <robh@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
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
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:41 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:14 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 4:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >
> > > On 11/28/18 12:56 PM, Rob Herring wrote:
> > > >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > >> index ad3fcad4d75b8..f309399deac20 100644
> > > >> --- a/drivers/of/Kconfig
> > > >> +++ b/drivers/of/Kconfig
> > > >> @@ -15,6 +15,7 @@ if OF
> > > >>  config OF_UNITTEST
> > > >>         bool "Device Tree runtime unit tests"
> > > >>         depends on !SPARC
> > > >> +       depends on KUNIT
> > > > Unless KUNIT has depends, better to be a select here.
> > >
> > > That's just style or taste.  I would prefer to use depends
> > > instead of select, but that's also just my preference.
> >
> > I prefer depends too, but Rob is the maintainer here.
>
> Well, we should be consistent, not the follow the whims of each maintainer.

Sorry, I don't think that came out the way I meant it. I don't really
think we are consistent on this point across the kernel, and I don't
feel very strongly about the point, so I was just looking to follow
the path of least resistance. (I also just assumed Rob would keep us
consistent within drivers/of/.)

I figure if we are running unit tests from the test runner script or
from an automated system, you won't be hunting for dependencies for a
single test every time you want to run a test, so select doesn't make
it easier to configure in most imagined use cases.

KUNIT hypothetically should not depend on anything, so select should
be safe to use.

On the other hand, if we end up being wrong on this point and KUnit
gains widespread adoption, I would prefer not to be in a position
where I have to change a bunch of configs all over the kernel because
this example got copied and pasted.
