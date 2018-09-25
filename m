Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0FFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C862145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DkeGWQpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C862145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeIYIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:42:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54964 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeIYIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:42:41 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so13488118ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHhrvvNc/RfF5pSjanDkAuxnYYOE+43+QLbLkE8JM10=;
        b=DkeGWQpYMUlglFqgv6iYokVVa3BIj1g/+louEr1YZUtD03VLUUrSoEq6ycbtsjds6s
         RkCJr8AHjN2g+2d3GB9M7GltlnbAqLk6SoHz0qgnCFjCdOeiRTUSNc8PYe0Pg3quaJm9
         YfouRzqcwl32zOiALUiQx+0zPXxUWvlCHZbm+zFFNYTt5FvYdYd4vqMDJr3FFqX9783o
         1f80FvAQ2+/Z/jVmCRfueyGOZSOkaag2AgXN99ax8CoCfxSPsxjWPZOo1VvFTI7y9Jox
         6GpkMB4JnBEjVZoH9oAllIxQyYZGkmJGCJeqALL2EPnZ5sn+iyNfFREXrb/BUMifobFI
         dV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHhrvvNc/RfF5pSjanDkAuxnYYOE+43+QLbLkE8JM10=;
        b=mL5+IkirKqu7z/3W5tctiELjk1b6YSmJ5NKkZSRWAGpCoV1b/mn6ag/E4AtxeZRH+o
         u/RqfFRwMdex5w4SMsuwCuDLVqv+PWnkAmaciqFMQKXs1EEUwHop0+friv5DrVLGa1I0
         tsKAuRb6XO0QVRX+EjS2CkgBwKPeWne7t2xKHTVbS/WwTZ7BfxEG+AfOTd6TTXZxJoAv
         I+18i5JG2wZJaLwMf0cZtjXYU8uehkRwsp72FksE3ukh82WISBpkqZIQ65dRi6mQf4ga
         wI0KeubPm/x6ldtnkX8H3cZCLEMs1GVn3hgnvMAgmd0MjXp5l61/rDnAWLESWgz3SNCA
         y7Uw==
X-Gm-Message-State: ABuFfoiFlWXhUWAnlzibsV1OmL4Gx6nq/3xB7XYPmw420Uy5towRwuPq
        TN1293592iowVT3HZEPqlpE0sQ==
X-Google-Smtp-Source: ACcGV63jfDPM+9huJwLnlWvKn4+nY9/kjtdRp4HLRHJI3l3/CVb6tvShtlk478d9YguIfm2hPzalAQ==
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr1578680jaa.55.1537843044537;
        Mon, 24 Sep 2018 19:37:24 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l3-v6sm2351868ith.4.2018.09.24.19.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 19:37:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g4dE2-0000A1-Ax; Mon, 24 Sep 2018 20:37:22 -0600
Date:   Mon, 24 Sep 2018 20:37:22 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180925023722.GA32600@ziepe.ca>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox>
 <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:29:38PM -0700, Nick Desaulniers wrote:
> On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Clang warns when one enumerated type is implicitly converted to another.
> > > >
> > > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > > >
> > > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > > create_flags type to u32.
> > > >
> > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > >  include/rdma/ib_verbs.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > > +++ b/include/rdma/ib_verbs.h
> > > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > > >         struct ib_qp_cap        cap;
> > > >         enum ib_sig_type        sq_sig_type;
> > > >         enum ib_qp_type         qp_type;
> > > > -       enum ib_qp_create_flags create_flags;
> > > > +       u32                     create_flags;
> > >
> > > I think it might be better to just have explicit casts at the
> > > assignment.  What do the maintainers think?
> > >
> >
> > That's fine with me, I tend to explicitly cast if it is only one
> > location but it certainly makes sense in this case as well. I'll
> > wait for the maintainers to weigh in before sending a v2.
> 
> Yeah, I mean my opinion on this might seem arbitrary, but based on the
> pattern and the comment in ib_qp_create_flags, those enum values are
> reserved to be "subclassed" in a sense, so they should always be in
> sync or this code will have bigger problems.

One should not use an 'enum' type name for bitfield storage, as once
you start or'ing things together the values no longer fall on the
enum. Some compilers and tools even give warnings in this case, ie

   enum x foo = X_A | X_B;

Is an assignment from 'int' to an 'enum x' with an implicit cast.

For this reason, usually bitfield enum declarations should be
anonymous.

Jason
