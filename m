Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EDBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF522172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKodx13e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF522172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeI1HRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:17:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42592 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeI1HRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:17:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so3051327pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 17:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++HiQfU7re2DrF9C+Ij2+4fPfX5OPn59EdWttBF5SEc=;
        b=nKodx13eMMRL0RObJ4wlfc57ry/X4B4FLkoIFYdUHFzSPjwgO8zUMJMN6RtLsMzRav
         xYwWcOFJ5UfsaulHi8QM90Tx4/mv9IaIYq0mTENjQh5DswvXBggkVOQA1Rq3Q1wnwQVb
         yQqh6jOo6jcFEmI1pikYErMA3O0REvWDEZdXwGWgVKBKP6DSTvWofbnys70f7148kLfW
         X8ekSttIJ+28TvKplKHxNnhSOzLepDbCbDUnQgEs3gqPGRgj6TY5luQlAKqbKGKtJPkF
         +JA66kSl3vaLB3ZPkSQzEXjjOJ8IzoHRS/0JW3Uv7nyIQv8ZV5QjaFHmYD24orv1Ba2E
         Dygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++HiQfU7re2DrF9C+Ij2+4fPfX5OPn59EdWttBF5SEc=;
        b=YFNjc9KXjRRqS/+Ppj/R3COdTRktVhtcEhm+fAp+5Tb98TFXuG5Uf7DgnYIrp3nHP5
         nDgrhJflZIOnjslGQdxeUo2L7MpR+Qr05chg1kVLeLzuZpSyOPz9APavZCujdO2hbSKi
         xg3XbDx4hLIMKnMV3gpWyv8P6A9IEHGZj+6iTO1sR4cZslWzT9frKLXBpYZq2yXwftIw
         GOHYgLt9JF+GdKwJs6DKNRjQweItKyA09SWIuczl4abPEAyxdH7I49J7T5z0fmn15y+n
         TGvqNWT6AHKU4wVrBPfRl0F3jhmQZkJu3q89/fgmTS0StK26VGYZ6rNvkXZlF1NqO+OW
         Zwmg==
X-Gm-Message-State: ABuFfoiWWmTFdAavorVba4Oh9oSlBGnscVxSMFdDN9Y49q/xYPSHn9H6
        f6qbhcA1Hjrc7nBqZ2PSaEZHBNVCRqDEzrGzd58tRg==
X-Google-Smtp-Source: ACcGV61YbGTophAiq5SmmERijib97F+U+ps+WZmIGzwWjAs2N0a33XT5FpQ4JVf+IysthTAWYWnBokdwKqPVnO76Tus=
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12-v6mr13713971plq.229.1538096156054;
 Thu, 27 Sep 2018 17:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca> <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca> <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox> <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
 <20180927222821.GC28301@ziepe.ca> <1538087622.226558.8.camel@acm.org>
 <CAKwvOd=qNZsfSFJUFZqBbSYt4T_T7TudohzhTqpigvDAHek78A@mail.gmail.com> <20180927225823.GD28301@ziepe.ca>
In-Reply-To: <20180927225823.GD28301@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 17:55:43 -0700
Message-ID: <CAKwvOd=9AjrKu52bEvdgsZ_eK8uwiqRjgMHz3j069Q+w97FO2A@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     jgg@ziepe.ca
Cc:     bvanassche@acm.org, Nathan Chancellor <natechancellor@gmail.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:58 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Sep 27, 2018 at 03:42:24PM -0700, Nick Desaulniers wrote:
> > On Thu, Sep 27, 2018 at 3:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On Thu, 2018-09-27 at 16:28 -0600, Jason Gunthorpe wrote:
> > > > On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:
> > > >
> > > > > > Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> > > > > > signedness necessary?
> > > > >
> > > > > enums are by default restricted to the range of ints.
> > > >
> > > > That's not quite right, the compiler sizes the enum to be able to fit
> > > > the largest value contained within, today that is int, but if we added
> > > > 1<<31, then it would become larger.
> > >
> > > Hi Jason,
> > >
> > > Are you perhaps confusing C and C++? For C++, an enumeration whose underlying
> > > type is not fixed, the underlying type is an integral type that can represent
> > > all the enumerator values defined in the enumeration. For C however I think
> > > that enumeration values are restricted to what fits in an int.
> > >
> > > Bart.
> > >
> >
> > To quote the sacred texts (ANSIIISO9899-1990):
>
> > 6.5.2.2 Enumeration specifiers
> > The expression that defines the value of an enumeration constant shall
> > be an integral constant
> > expression that has a value representable as an int.
>
> This is the wrong part of the standard to quote it is talking about
> *enumeration constants* not the 'enum X' itself.
>
> Anyhow, the standard is hard to read in this area, but reality is
> this:

You mean undefined behavior?

>
> #include <stdio.h>
>
> enum a
> {
>         A1 = 1,
>         A2 = 1ULL<<40,
> };
>
> int main(int argc, const char *argv[])
> {
>         printf("%zu\n", sizeof(enum a));
>         return 0;
> }
>
> $ gcc -Wall -std=c11 test.c && ./a.out
> 8
>
> I forget if this a common compiler extension, unclear standard, or was
> formally revised in C11 or what, but it is the real world the Linux
> kernel lives in.
>
> It is even more confusing if you wonder what types A1 and A2 are!
>
> Jason

This example is a strawman; we're talking about the minimum sizeof an
enum when all initialized values are representable within an int,
which is well defined behavior by the citation I cited earlier.  The
point is, unless you use __attribute__((packed)) on your enum, it will
NEVER be *smaller* than an int for compilers and C standard that the
Linux kernel cares about.

And if you're going to throw type safety out the window by converting
values from one enum to another, for storage you MUST use an int
(anything larger as in your example is undefined behavior).

I don't disagree with your point that values should be unsigned for
bitwise operations, but it's not clean to reconcile that with
converting values between different enums.  I suggest explicit casts
to unsigned types before bitwise operations.

https://wiki.sei.cmu.edu/confluence/display/c/INT13-C.+Use+bitwise+operators+only+on+unsigned+operands
-- 
Thanks,
~Nick Desaulniers
