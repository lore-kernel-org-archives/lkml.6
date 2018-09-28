Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A4215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OtpZmQmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2A4215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeI1JZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:25:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54892 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1JZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:25:50 -0400
Received: by mail-it1-f194.google.com with SMTP id f14-v6so996307ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9va/yPA67W0kw6ODoxspUWkyedGAZsM8sgc3cip7d1Y=;
        b=OtpZmQmHBPmqDMwSXcfH99x8wEnDi6k9vWk5rDsur99Jsw/tm49KW0jKuGatU0tLA/
         y/QcH0fnKeJ0bAAeRVVCalUba2LMOLb0nzeklnSy7k58vMGiIlQ9vJSUURxYXVz3fzNO
         sqLt5cdfMaedrSS65orJwpcli9DXgoFkaPeQ/7CojXmOpWhGlzFJRrjJ/DZA3+i5Pi6F
         6tYZJDg7RSVq/apQbq3HtCdMgPLCldWFzU26MibH3NMmKAUlKONx2D5r7ZrmRSOGaDDU
         CYBKqwHvre+sBS8KkXLxyjHftEtQqC8eB711FOVRd1aQNkFPv9MPyBdUgt5DsrpZdTNJ
         hgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9va/yPA67W0kw6ODoxspUWkyedGAZsM8sgc3cip7d1Y=;
        b=XkpaO+S9wHsmzomD9XZa0o2/IfqDvipYViXFlduF+5icTPwYLY/krdGHP3aI0ee13m
         5LIi9hr9GHNNA+1SCrhkpFl+3fEFVAL0+LDDbP+c+U/cCFas8UTyHIIZjPQSKhilnzpJ
         uzVfRx8969dgayOT4ySThdalIpfmNAbfz2GnEA2xAmqN9T7enPO0tUV7ntd6o+Ftu1Ot
         KVCn9YUeoF5MudbkD6tbEZM8FgjKxY+/5o2b718ZlX/YSm2yUvLWSgHl7DAP4Cv1dTL3
         YNdI/0JSuk2TfXjl5S2/8nhQvIoGGf8SnDjocmacS0JnrKZKwQJQCKz3ZgTJffsqcbeR
         bSBg==
X-Gm-Message-State: ABuFfohP/TwiJ0tF7vhgwSWzrCnSV1ljw5IV/Ui+KpgQtN5W6Zvto9If
        U7xC2r2k6GQAddqRfGXYsektWg==
X-Google-Smtp-Source: ACcGV61geCsgRWOIGQ3w5S+CiaFA3auLvydRqjmF4ciDoG32kvsouPhlhM1JaJdv7dEaVVe9Mf2OzQ==
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr255485ite.123.1538103858727;
        Thu, 27 Sep 2018 20:04:18 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x188-v6sm458010ite.3.2018.09.27.20.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 20:04:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5j4h-00017Z-LJ; Thu, 27 Sep 2018 21:04:15 -0600
Date:   Thu, 27 Sep 2018 21:04:15 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org, Nathan Chancellor <natechancellor@gmail.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180928030415.GE28301@ziepe.ca>
References: <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca>
 <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox>
 <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
 <20180927222821.GC28301@ziepe.ca>
 <1538087622.226558.8.camel@acm.org>
 <CAKwvOd=qNZsfSFJUFZqBbSYt4T_T7TudohzhTqpigvDAHek78A@mail.gmail.com>
 <20180927225823.GD28301@ziepe.ca>
 <CAKwvOd=9AjrKu52bEvdgsZ_eK8uwiqRjgMHz3j069Q+w97FO2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=9AjrKu52bEvdgsZ_eK8uwiqRjgMHz3j069Q+w97FO2A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:55:43PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 27, 2018 at 3:58 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Sep 27, 2018 at 03:42:24PM -0700, Nick Desaulniers wrote:
> > > On Thu, Sep 27, 2018 at 3:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > > >
> > > > On Thu, 2018-09-27 at 16:28 -0600, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:
> > > > >
> > > > > > > Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> > > > > > > signedness necessary?
> > > > > >
> > > > > > enums are by default restricted to the range of ints.
> > > > >
> > > > > That's not quite right, the compiler sizes the enum to be able to fit
> > > > > the largest value contained within, today that is int, but if we added
> > > > > 1<<31, then it would become larger.
> > > >
> > > > Hi Jason,
> > > >
> > > > Are you perhaps confusing C and C++? For C++, an enumeration whose underlying
> > > > type is not fixed, the underlying type is an integral type that can represent
> > > > all the enumerator values defined in the enumeration. For C however I think
> > > > that enumeration values are restricted to what fits in an int.
> > > >
> > > > Bart.
> > > >
> > >
> > > To quote the sacred texts (ANSIIISO9899-1990):
> >
> > > 6.5.2.2 Enumeration specifiers
> > > The expression that defines the value of an enumeration constant shall
> > > be an integral constant
> > > expression that has a value representable as an int.
> >
> > This is the wrong part of the standard to quote it is talking about
> > *enumeration constants* not the 'enum X' itself.
> >
> > Anyhow, the standard is hard to read in this area, but reality is
> > this:
> 
> You mean undefined behavior?

I think we call this an unstandardized compiler extension :)

> > #include <stdio.h>
> >
> > enum a
> > {
> >         A1 = 1,
> >         A2 = 1ULL<<40,
> > };
> >
> > int main(int argc, const char *argv[])
> > {
> >         printf("%zu\n", sizeof(enum a));
> >         return 0;
> > }
> >
> > $ gcc -Wall -std=c11 test.c && ./a.out
> > 8
> >
> > I forget if this a common compiler extension, unclear standard, or was
> > formally revised in C11 or what, but it is the real world the Linux
> > kernel lives in.
> >
> > It is even more confusing if you wonder what types A1 and A2 are!
> >
> > Jason
> 
> This example is a strawman; we're talking about the minimum sizeof an
> enum when all initialized values are representable within an int,

Hmm? I said "the compiler sizes the enum to be able to fit the largest
value contained within", which is correct for gnu89 mode. 

It is not ISO C, it looks like it is a popular compiler extension that
Linux relies on.

> And if you're going to throw type safety out the window by converting
> values from one enum to another, for storage you MUST use an int
> (anything larger as in your example is undefined behavior).

No, that isn't right even without this extension, it is confusing, but
the standard you quoted is talking about the type of the CONSTANT, not
the enum. Ie this:

  enum a {A1=1};
  enum a val = A1;
  int foo = val;

Gives this warning:

t.c:10:17: warning: implicit conversion changes signedness: 'enum a' to 'int' [-Wsign-conversion]

The correct integral storage for that enum is 'unsigned int'.

There is another peice of standard talking about the type of the enum
itself, and confoundingly it is a different type than the types of the
constants.

C++ got this right, the type of the enum and the type of the constants
are always the same and always sized to match the largest constant in
the enum, and C++11 got this *really right* and allows the programmer
to specify the underlying type of the enum and all of its constants.

No more subtle bugs with ~FOO because enum constant values have
negative types!

> I don't disagree with your point that values should be unsigned for
> bitwise operations, but it's not clean to reconcile that with
> converting values between different enums.  I suggest explicit casts
> to unsigned types before bitwise operations.

Sometimes the casts are needed, particularly when using ~, but for |
it is OK to have no casts, promotion rules work out OK.

But, again, this question was about the correct type to use when
storing bitwise flags, and that type is u32/64 etc no matter if the
constants are defined as enum constants or #defines values.

So the first patch was the right one! :)

Jason
