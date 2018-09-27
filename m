Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E946EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99935216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPPTbFef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99935216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI1Cyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:54:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1Cyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:54:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so2680189pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzP0SCHNefleytqhr8i61IkjqrEe7aWu5vzjf0fqhzQ=;
        b=oPPTbFefc2IT+lsvPohsztZ8FLRxP+oohgG2IjAfsyihGUF7gPvrWdrFW9ATB2o0kJ
         BuHWTSsLW+Oqvhlo7P79tDRteb1zQ7mtVO42rW9fn7uJE7Sw6OQ6Dlqj4HMF1SUTJnOt
         RIUo+A+6AsYIfor3J2ua72JDgmsDTiD+lunyBXUiUAcj9vq0ZpJJNHMs/GHNgTv26+mS
         lye0rRTtAmaKzbH5jz8FAs7MY0PkpKDG7Q3fZ5tMqLBdIKoZVt9lf5TNXzGqgvK/WuD3
         iBjRlTEpKKr+I6RISbrv2GZpbAg6ot6zX4UTVBNbHDC79AiV5MJbgZwSoBR5k7P/rQnJ
         7pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzP0SCHNefleytqhr8i61IkjqrEe7aWu5vzjf0fqhzQ=;
        b=MqQs7EHKgvSvMiQWHx9gXy5gDuClTbDN3OUeRuVejbqCg+VgW4F41C3KW6cWvLKh4/
         JRdaWM41Lo4+RYdeQotZopgymjHAk11T12HgJ1z5GGLVhL/U7Ozz+W20HvM3ynpSAN59
         yILcIiOyVNsDPOWuqKbyGWVo+ExRm4vfUZCsEyYl6LxoixEcTnuOfQTLhJxG/RETY5Yc
         8fAv3YfxvaCtWuHAy7EVshHQGvw+vjzO/Cq90ZFWyNEhnO+uvDGerN6Nwwgy+rB+OgDZ
         o9tVMOFc17a+DoIC4kt1CFE4Onz8gQHmancdsQEfEx01gmdaaWrlATdY2vLW7BXXNZ9h
         M0UQ==
X-Gm-Message-State: ABuFfog3ko/+7fzwZcUE3kEWkXPkquRgvqPFu8UxPsWqJdsPsX52LpL2
        T+vY0eIyDKmUvpw7/6cHmIlgnv+nZOt2C2OLurT6PA==
X-Google-Smtp-Source: ACcGV63bhOpqhE+63/CyxVp1zH2P8mMNVFpp7bSoQ8BPPd9rb5VYSy97FLBxQxpwtXu5gym2J2uqp2loNm5rJsekEDA=
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr12686708pls.217.1538080467557;
 Thu, 27 Sep 2018 13:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox> <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca> <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca> <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox>
In-Reply-To: <20180927202849.GA11120@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:34:16 -0700
Message-ID: <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:28 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Sep 27, 2018 at 01:13:31PM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 26, 2018 at 9:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Sep 26, 2018 at 06:08:03PM -0700, Nathan Chancellor wrote:
> > > > On Mon, Sep 24, 2018 at 08:37:22PM -0600, Jason Gunthorpe wrote:
> > > > > On Mon, Sep 24, 2018 at 03:29:38PM -0700, Nick Desaulniers wrote:
> > > > > > On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
> > > > > > <natechancellor@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > > > > > > > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > > > > > > > <natechancellor@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Clang warns when one enumerated type is implicitly converted to another.
> > > > > > > > >
> > > > > > > > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > > > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > > > > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > >
> > > > > > > > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > > > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > > > > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > > > > > > > >
> > > > > > > > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > > > > > > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > > > > > > > create_flags type to u32.
> > > > > > > > >
> > > > > > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > > > > >  include/rdma/ib_verbs.h | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > > > > > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > > > > > > > +++ b/include/rdma/ib_verbs.h
> > > > > > > > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > > > > > > > >         struct ib_qp_cap        cap;
> > > > > > > > >         enum ib_sig_type        sq_sig_type;
> > > > > > > > >         enum ib_qp_type         qp_type;
> > > > > > > > > -       enum ib_qp_create_flags create_flags;
> > > > > > > > > +       u32                     create_flags;
> > > > > > > >
> > > > > > > > I think it might be better to just have explicit casts at the
> > > > > > > > assignment.  What do the maintainers think?
> > > > > > > >
> > > > > > >
> > > > > > > That's fine with me, I tend to explicitly cast if it is only one
> > > > > > > location but it certainly makes sense in this case as well. I'll
> > > > > > > wait for the maintainers to weigh in before sending a v2.
> > > > > >
> > > > > > Yeah, I mean my opinion on this might seem arbitrary, but based on the
> > > > > > pattern and the comment in ib_qp_create_flags, those enum values are
> > > > > > reserved to be "subclassed" in a sense, so they should always be in
> > > > > > sync or this code will have bigger problems.
> > > > >
> > > > > One should not use an 'enum' type name for bitfield storage, as once
> > > > > you start or'ing things together the values no longer fall on the
> > > > > enum. Some compilers and tools even give warnings in this case, ie
> > > > >
> > > > >    enum x foo = X_A | X_B;
> > > > >
> > > > > Is an assignment from 'int' to an 'enum x' with an implicit cast.
> > > > >
> > > > > For this reason, usually bitfield enum declarations should be
> > > > > anonymous.
> > > > >
> > > > > Jason
> > > >
> > > > Hi Jason,
> > > >
> > > > I apologize for not understanding but how should I adjust my patch so
> > > > that it is acceptable? Do you want the explicit casts like Nick
> > > > suggested?
> > >
> > > No, I think your original patch is fine, I was waiting to see if you
> > > or Nick disagreed with my assessment on bitfields..
> >
> > It wasn't clear to me whether you were ack'ing or nack'ing the patch.
> > If we don't change the patch to explicit casts, shouldn't the change
> > be to make create_flags an int? (note: signedness)
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> signedness necessary?

enums are by default restricted to the range of ints.  It's not right
to tie these "anonymous enums" to a specific width and signedness
other than int.

-- 
Thanks,
~Nick Desaulniers
