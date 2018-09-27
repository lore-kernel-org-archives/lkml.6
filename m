Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA203C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4257E2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RGE8rPkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257E2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeI1FTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:19:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47001 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1FTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:19:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so2962617pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vE/5nclRt9CHnDWAG3KLn1V8WzEjr3WEP5p7d/rMJFI=;
        b=RGE8rPkAxKjwBdcclFYzPA22IidqjPAzzq3i+2t6DUDqUAMVIqeIN8/IwO0AFoch/f
         NSjbBMSHgxITvXglYmVHhWa7cBqy3KWpyEB/nk5x6YrAkDsOqAf6jVEimO/pwQECBf6r
         QPleBkeWEKSUYOI0zJZrI/a+bS5KdZGVLvtzkdyCWR7/9B71J1vVsQSFhGZIVc3To/Po
         KZoPQAp7/iodiCC2V6yl0EEzzCiU4fD8eRMX7oTtWY/F6jhi8ND2FzCBiN5XDPDfXfhv
         L1ykF7kWvNH54kH7okLBo2fz0zTDPXIDZO9ZUEo9SmEh0QquL3n+QvyRX5ddRBgxVhWl
         RtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vE/5nclRt9CHnDWAG3KLn1V8WzEjr3WEP5p7d/rMJFI=;
        b=kgaF4GIA34lrHNtv6oboWqLbFjijMyIeNVvPbi2nubk8aGDDQ1cmdjT1r1cBgauIiS
         CUPfwHwFg4cvQVbOoreuYAcnxCRFXW/FPLd32/EYdMTtc1Uj5/iqCz4L3CBLaNISfoz8
         1NPtVWtB6tZgoy7yuK5iu6f7J3rlX1WQALFTzntJ9ao8TEhasw0fyYUJebW9N5x+TpOy
         dbU/JFGw3/UG2u8XrpslVRRiSnr9YNSpxLuSq1JF1uJde1xuqVKm8EXrnuU36AQhGq6M
         SPwWaGmRmarbjQ2l4z/DjLbldAdzc0nrGBI37NqTbEigTp1OrspMUKohlFJfTpKedOhs
         1Nwg==
X-Gm-Message-State: ABuFfoi3+hTLKlbFbrXahVkjw5Xgs1iWMsoYIWhlcUWvmONHvVl7/mBw
        UjE/iw+GTdFPhSM4QFjGNm8Z3g==
X-Google-Smtp-Source: ACcGV60wb1k1yoAwkfRU9rpW5xYG/0XASbbj/JriVAI5Q2IThs7NOdc07emEKDwlqcfOZ3M/FOmbEw==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr6582316pfl.67.1538089105899;
        Thu, 27 Sep 2018 15:58:25 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k83-v6sm4645452pfj.63.2018.09.27.15.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:58:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5fEl-00087q-NO; Thu, 27 Sep 2018 16:58:23 -0600
Date:   Thu, 27 Sep 2018 16:58:23 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org, Nathan Chancellor <natechancellor@gmail.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180927225823.GD28301@ziepe.ca>
References: <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca>
 <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca>
 <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox>
 <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
 <20180927222821.GC28301@ziepe.ca>
 <1538087622.226558.8.camel@acm.org>
 <CAKwvOd=qNZsfSFJUFZqBbSYt4T_T7TudohzhTqpigvDAHek78A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=qNZsfSFJUFZqBbSYt4T_T7TudohzhTqpigvDAHek78A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:42:24PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 27, 2018 at 3:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On Thu, 2018-09-27 at 16:28 -0600, Jason Gunthorpe wrote:
> > > On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:
> > >
> > > > > Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> > > > > signedness necessary?
> > > >
> > > > enums are by default restricted to the range of ints.
> > >
> > > That's not quite right, the compiler sizes the enum to be able to fit
> > > the largest value contained within, today that is int, but if we added
> > > 1<<31, then it would become larger.
> >
> > Hi Jason,
> >
> > Are you perhaps confusing C and C++? For C++, an enumeration whose underlying
> > type is not fixed, the underlying type is an integral type that can represent
> > all the enumerator values defined in the enumeration. For C however I think
> > that enumeration values are restricted to what fits in an int.
> >
> > Bart.
> >
> 
> To quote the sacred texts (ANSIIISO9899-1990):

> 6.5.2.2 Enumeration specifiers
> The expression that defines the value of an enumeration constant shall
> be an integral constant
> expression that has a value representable as an int.

This is the wrong part of the standard to quote it is talking about
*enumeration constants* not the 'enum X' itself.

Anyhow, the standard is hard to read in this area, but reality is
this:

#include <stdio.h>

enum a
{
	A1 = 1,
	A2 = 1ULL<<40,
};

int main(int argc, const char *argv[])
{
	printf("%zu\n", sizeof(enum a));
	return 0;
}

$ gcc -Wall -std=c11 test.c && ./a.out
8

I forget if this a common compiler extension, unclear standard, or was
formally revised in C11 or what, but it is the real world the Linux
kernel lives in.

It is even more confusing if you wonder what types A1 and A2 are!

Jason
