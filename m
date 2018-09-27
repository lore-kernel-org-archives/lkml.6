Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F254D21546
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GmwzOF+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F254D21546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeI0LEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:04:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35988 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0LEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:04:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so966426pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEkSFyN0bfneeuQgF9kdb/yvJHWMtk2C+HyoNPCTTyQ=;
        b=GmwzOF+32gmUnPJGLIK83DVo+PLu47e6aQgyreM8fuXgzLmmWS4S0gB2vUGRhDttlB
         1UHVvflewZZHwq+FsnBpZ+C7X8Wjg/9ojPZmXd4kRkVI/RLAhABPPl+ehQUuwc+VXv7z
         R4NOm/eTZQMLE2e6hWL4HHD9Wqf37uEaeWvw90a3wBuEDiMlKYdBj65YjK3KQK60aISc
         hTS4LdpNAHW07f14eY5ATN08GQrPcOgRATVZmelwGUlPcqitvSjrVAOxHzgQMnxIdq1o
         7h88SxAVt5EXNri0XxxZ2M0P1MgWkjIiYLMkiN+IJ8iZ/6P3vCmXbI0muJj4nMvrPxMO
         SIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEkSFyN0bfneeuQgF9kdb/yvJHWMtk2C+HyoNPCTTyQ=;
        b=r2i/lbBNT4gwMMoG3+LappukqHBiwP+Pv0yJXn4luAvFABBm4E+RyNEVCzsKf9Ly3b
         1JQeeKYeG8opsgYRksLfKOTFPDIrl0PnItG6o81enZKDM/SNjDbhkPZ53GjC3OIUOp80
         Bfzd9qNmNIW4mDyJOkI/yqNZcETbWJmbkyeoQMf8ShRK5k7T05xv73W23LstMFXHVGvo
         rMtQXulQITIFTORd0Q/m1qjQGoIROAYspJi8IL9/xkZACYGqlzZOjDAYut/qzf0MDMG6
         BinQfZkirSTGuBvgXKTNJ5F3DgVXOW/9W8ypbBx2bi8R6ewWK3+70gV2+USO6sqpsVUi
         s1yQ==
X-Gm-Message-State: ABuFfogLc5GSKu/WtMTVwaavEY5rBVjQmiCMY8eeZB+rMQH/ztshllN9
        7qyf1ybKTg+J9hgihY4jG/HqAQ==
X-Google-Smtp-Source: ACcGV63xNFB1y4BATe4hrNdOJDd396aTTw3+B4UHik7FWQlbNrkTsssNwgvARJ8sOzcwwgAM2rT/RA==
X-Received: by 2002:a17:902:7287:: with SMTP id d7-v6mr9066147pll.54.1538023708194;
        Wed, 26 Sep 2018 21:48:28 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j191-v6sm1029767pfc.136.2018.09.26.21.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 21:48:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5ODy-0006g7-UH; Wed, 26 Sep 2018 22:48:26 -0600
Date:   Wed, 26 Sep 2018 22:48:26 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180927044826.GC24889@ziepe.ca>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox>
 <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca>
 <20180927010803.GA7640@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927010803.GA7640@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:08:03PM -0700, Nathan Chancellor wrote:
> On Mon, Sep 24, 2018 at 08:37:22PM -0600, Jason Gunthorpe wrote:
> > On Mon, Sep 24, 2018 at 03:29:38PM -0700, Nick Desaulniers wrote:
> > > On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > > > > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > > > > <natechancellor@gmail.com> wrote:
> > > > > >
> > > > > > Clang warns when one enumerated type is implicitly converted to another.
> > > > > >
> > > > > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > > > > >
> > > > > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > > > > >
> > > > > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > > > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > > > > create_flags type to u32.
> > > > > >
> > > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > >  include/rdma/ib_verbs.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > > > > +++ b/include/rdma/ib_verbs.h
> > > > > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > > > > >         struct ib_qp_cap        cap;
> > > > > >         enum ib_sig_type        sq_sig_type;
> > > > > >         enum ib_qp_type         qp_type;
> > > > > > -       enum ib_qp_create_flags create_flags;
> > > > > > +       u32                     create_flags;
> > > > >
> > > > > I think it might be better to just have explicit casts at the
> > > > > assignment.  What do the maintainers think?
> > > > >
> > > >
> > > > That's fine with me, I tend to explicitly cast if it is only one
> > > > location but it certainly makes sense in this case as well. I'll
> > > > wait for the maintainers to weigh in before sending a v2.
> > > 
> > > Yeah, I mean my opinion on this might seem arbitrary, but based on the
> > > pattern and the comment in ib_qp_create_flags, those enum values are
> > > reserved to be "subclassed" in a sense, so they should always be in
> > > sync or this code will have bigger problems.
> > 
> > One should not use an 'enum' type name for bitfield storage, as once
> > you start or'ing things together the values no longer fall on the
> > enum. Some compilers and tools even give warnings in this case, ie
> > 
> >    enum x foo = X_A | X_B;
> > 
> > Is an assignment from 'int' to an 'enum x' with an implicit cast.
> > 
> > For this reason, usually bitfield enum declarations should be
> > anonymous.
> > 
> > Jason
> 
> Hi Jason,
> 
> I apologize for not understanding but how should I adjust my patch so
> that it is acceptable? Do you want the explicit casts like Nick
> suggested?

No, I think your original patch is fine, I was waiting to see if you
or Nick disagreed with my assessment on bitfields..

Jason
