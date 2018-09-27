Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD12216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXmPOlp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD12216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeI1Cdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:33:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41796 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1Cdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:33:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so2730688pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FyQQ0NIMmZRmXd3FKKb/KpeS4oS4M0hqPJWwC3h+jA=;
        b=EXmPOlp4Rhf3wQPE996j0Jw6wNMx+8qgt5rKZfzfMO2ikoRxma9sk/CZH4T51DWfZy
         TlgTEgXC16Gr5IOFlHOHS8QOMAvTDrajnuTXaqSsDMGhenyFFRShjff1svX9YvOrbxgx
         kB0gTuN+G+7sS4ztlmUvwdazf4DtRSogOES8LAbMsecFSAlqbBa3jS6oYE+W5vA0qw3R
         12wWtw6tS3UB9AmksiuxAXFlxm9Zs3BOhtiZL9e/eLo+eFzFm14vYNEZ55B3q31AO6fo
         MV+IodnsACh+Nz+1qV0XCttg5p8E6uDIwCScu4W6G7/syOwMuLmd3mHM9B2Kq8PjFv9a
         hRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FyQQ0NIMmZRmXd3FKKb/KpeS4oS4M0hqPJWwC3h+jA=;
        b=iJO8Bk99AE9V+NmuGBeSE/y+SM2x8714lCBZGywUWrH2Pqtp6tFarwlQpIRswKVcdR
         Z5BWhIyOF+7j0tIk3YgDPSIvYJQVX9yIQC7NjDL7Q4XKxfOhgSZ8vR72qWz5dZvVUyfi
         Ft/2nlIoPmvbaiILPbjS8NLYYmGgu5vmOQzXxpHivZJT1CKuTxIHNEetYIPOlsPAAkhX
         v7U/nFTPFT3Li3qidd4ekFP2oryrftpyybtdek54+3XbIUHRDpVABM62PBDz/NjyoFqq
         1LKRFMZAMlHoDOV8rp9c8RmBQ4uL8Yq01B8Bi/nNXda7wIek3c17VJwdQ8UPozqVDxk5
         5sJw==
X-Gm-Message-State: ABuFfogdI5+1Ys8PpA3Q4zDwPdcL8/yBu1C4bwiRmfxj3/O47TqJJTPz
        lTGb9VRqxpGS159EweNo0FYq32arPQ2WQguSOFbe6w==
X-Google-Smtp-Source: ACcGV63B8lnzeLroic/Kwdpul4uXhaLvop5SR2GBIUfGKg5qinCM1FCAa2nT6s2BjsRZgqS5xZjWIMfUyuSQ58z6Tqg=
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr12946652plk.13.1538079222924;
 Thu, 27 Sep 2018 13:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox> <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca> <20180927010803.GA7640@flashbox> <20180927044826.GC24889@ziepe.ca>
In-Reply-To: <20180927044826.GC24889@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:13:31 -0700
Message-ID: <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     jgg@ziepe.ca
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Sep 26, 2018 at 06:08:03PM -0700, Nathan Chancellor wrote:
> > On Mon, Sep 24, 2018 at 08:37:22PM -0600, Jason Gunthorpe wrote:
> > > On Mon, Sep 24, 2018 at 03:29:38PM -0700, Nick Desaulniers wrote:
> > > > On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > > > > > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > > > > > <natechancellor@gmail.com> wrote:
> > > > > > >
> > > > > > > Clang warns when one enumerated type is implicitly converted to another.
> > > > > > >
> > > > > > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >
> > > > > > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > > > > > >
> > > > > > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > > > > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > > > > > create_flags type to u32.
> > > > > > >
> > > > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > > >  include/rdma/ib_verbs.h | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > > > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > > > > > +++ b/include/rdma/ib_verbs.h
> > > > > > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > > > > > >         struct ib_qp_cap        cap;
> > > > > > >         enum ib_sig_type        sq_sig_type;
> > > > > > >         enum ib_qp_type         qp_type;
> > > > > > > -       enum ib_qp_create_flags create_flags;
> > > > > > > +       u32                     create_flags;
> > > > > >
> > > > > > I think it might be better to just have explicit casts at the
> > > > > > assignment.  What do the maintainers think?
> > > > > >
> > > > >
> > > > > That's fine with me, I tend to explicitly cast if it is only one
> > > > > location but it certainly makes sense in this case as well. I'll
> > > > > wait for the maintainers to weigh in before sending a v2.
> > > >
> > > > Yeah, I mean my opinion on this might seem arbitrary, but based on the
> > > > pattern and the comment in ib_qp_create_flags, those enum values are
> > > > reserved to be "subclassed" in a sense, so they should always be in
> > > > sync or this code will have bigger problems.
> > >
> > > One should not use an 'enum' type name for bitfield storage, as once
> > > you start or'ing things together the values no longer fall on the
> > > enum. Some compilers and tools even give warnings in this case, ie
> > >
> > >    enum x foo = X_A | X_B;
> > >
> > > Is an assignment from 'int' to an 'enum x' with an implicit cast.
> > >
> > > For this reason, usually bitfield enum declarations should be
> > > anonymous.
> > >
> > > Jason
> >
> > Hi Jason,
> >
> > I apologize for not understanding but how should I adjust my patch so
> > that it is acceptable? Do you want the explicit casts like Nick
> > suggested?
>
> No, I think your original patch is fine, I was waiting to see if you
> or Nick disagreed with my assessment on bitfields..

It wasn't clear to me whether you were ack'ing or nack'ing the patch.
If we don't change the patch to explicit casts, shouldn't the change
be to make create_flags an int? (note: signedness)

-- 
Thanks,
~Nick Desaulniers
