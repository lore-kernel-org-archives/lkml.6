Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FDCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8618221566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8ij4LGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8618221566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeI0HXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:23:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeI0HXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:23:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11-v6so715686wru.9;
        Wed, 26 Sep 2018 18:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eBDq8VDkFISLSvSWtCk4k/FO1Y2UjS2zHoeNYPpRWMQ=;
        b=k8ij4LGxmMaSNsNgyQiVof3yJkf43EAefVERY+ybvZWgmVLFrEdhAx60F1rdDLcCNj
         5iWo9zC5+0lj8bphxr1kmMY8+WVlfgHg/7fweePKeiLx7yHny1agey7K7MVRXDJwgHCP
         0sMEB+Vt3c6S2fuYbTmJipoRNk3XaUoSMjzjDdC9kKMOyRlx7YF41siQinmYrnmtbqx9
         9i/yMVkqbr7mKM2bcQrqiIjTAUMYeBteYw1VuSN/Hep5YP/imjDydf0TlquHJ/rj6cW+
         KLEqH6rO1WPt4SCoEMiJd21yco6yGfggBn8NbtGDJ71GLMPcZ4GKxzK+hxHR7MjBH9Ng
         t9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eBDq8VDkFISLSvSWtCk4k/FO1Y2UjS2zHoeNYPpRWMQ=;
        b=O5WpB+0/vFDHHweVIOPo0o1UhZNhPLDvl5dGWKuL9AF8KHviwdDOQwglvaL9MVT+Vo
         c56XhvLkPz2U/ADI0phDHgn6DvjeScJLvGW87hGe3vY6vFgf9a+q0ceGIdb3v4FfieSc
         5NqgjPpalFRltVTSelu9ncp0vM571s7nCVZphMSvR+ET7QqrgTAvGRFFXxZMDqlBAflU
         e95Ot9NNyof5AZrWN5O98512R+oFD0MxTwwTD0uOQiOFF+prhREwrE0tddJtBdxrY5uJ
         VDC2Xd8o0GCrO47WTqXLylZI0uIOrj19pavmW4y/7XCP4X6zNd8Za0MkDE9oScSGVTV8
         9EOQ==
X-Gm-Message-State: ABuFfoj2dtYBToxpOutJWLTJMolIy/eIEZSbFrUcVRdHKRr3FBa/8G7J
        aqXEPkNRADk3l/eKWdSxoumfj3i8VAoSHw==
X-Google-Smtp-Source: ACcGV61meMW0IZHTCoL1ipujtCpNcvcwZtZWlhbyPTH2UkPh9zRKz0amfWqPy/lwt2hJVLZko7s5sA==
X-Received: by 2002:adf:8324:: with SMTP id 33-v6mr6857614wrd.130.1538010486055;
        Wed, 26 Sep 2018 18:08:06 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d4-v6sm386776wrw.70.2018.09.26.18.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:08:05 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:08:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180927010803.GA7640@flashbox>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox>
 <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925023722.GA32600@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 08:37:22PM -0600, Jason Gunthorpe wrote:
> On Mon, Sep 24, 2018 at 03:29:38PM -0700, Nick Desaulniers wrote:
> > On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > > > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > Clang warns when one enumerated type is implicitly converted to another.
> > > > >
> > > > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > > > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > > > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > > > >
> > > > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > > > create_flags type to u32.
> > > > >
> > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > >  include/rdma/ib_verbs.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > > > +++ b/include/rdma/ib_verbs.h
> > > > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > > > >         struct ib_qp_cap        cap;
> > > > >         enum ib_sig_type        sq_sig_type;
> > > > >         enum ib_qp_type         qp_type;
> > > > > -       enum ib_qp_create_flags create_flags;
> > > > > +       u32                     create_flags;
> > > >
> > > > I think it might be better to just have explicit casts at the
> > > > assignment.  What do the maintainers think?
> > > >
> > >
> > > That's fine with me, I tend to explicitly cast if it is only one
> > > location but it certainly makes sense in this case as well. I'll
> > > wait for the maintainers to weigh in before sending a v2.
> > 
> > Yeah, I mean my opinion on this might seem arbitrary, but based on the
> > pattern and the comment in ib_qp_create_flags, those enum values are
> > reserved to be "subclassed" in a sense, so they should always be in
> > sync or this code will have bigger problems.
> 
> One should not use an 'enum' type name for bitfield storage, as once
> you start or'ing things together the values no longer fall on the
> enum. Some compilers and tools even give warnings in this case, ie
> 
>    enum x foo = X_A | X_B;
> 
> Is an assignment from 'int' to an 'enum x' with an implicit cast.
> 
> For this reason, usually bitfield enum declarations should be
> anonymous.
> 
> Jason

Hi Jason,

I apologize for not understanding but how should I adjust my patch so
that it is acceptable? Do you want the explicit casts like Nick
suggested?

Thanks for the comments,
Nathan
