Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D86C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4308E216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw9pqJP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4308E216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeI1C4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:56:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45195 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeI1C4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:56:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id m16so4009951wrx.12;
        Thu, 27 Sep 2018 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CDJktXrklMYbcknND26s5J1eFnYPJCqnsXYde5LFcrE=;
        b=Sw9pqJP6AjVhU1Mw83OMDkZmn2TjLvHRrgxa3lN7YVXnh3srT4VnCOkK/7iQU6ijTW
         0853meHzQbaCzDzqBQI9Vf6f0nBfYIo8N0PJWb1E/0935EWXepgYfiwLvHBO6jOCWswX
         lFZJcWvpbpIAD5tCa+isO/XHCxfQ7lI4FZhOCT29SQMLRSYX9IDTNkjrB7+2vxb5STEz
         i2HW65S7YGWu74XIB6qj9YLeX0+FsEO9pAZNFBWvMRDdSqvs6ODVVVY/O8YLlFZHVqAq
         jQ53CsEhS0ES0tOnOS6CXdPrmtltPhVJYftbQ8gJcnwFzGeYUKjx0/p0QdmRXEjmXHhU
         kwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CDJktXrklMYbcknND26s5J1eFnYPJCqnsXYde5LFcrE=;
        b=Z9UG8H6TYZY+dQv6yNOBFXHAWiEi/k65jp4Sq6Q4DiT6ePMdzsPd+TxRYZHYKeQQrc
         ruXyi4czC61XFGT2WBylF9EKIgIpwWFwSlfERPU/aMxaU4PVz18j9xyPhWJeEgTAM6ux
         YR8LzNIwMlmYIUBQLxP7e22F3jF/E8avk4J0MSs+GrZqTr9IaY0xA3TFFdx5QKrEneQt
         dCkXWl0+tdGDhmyLImg7a4ek1xVPpTN4HxrjnK6MyZrL2OHYHK4rsPvurF1Ph1yJM/AG
         0hrNrAAJZ6WY1amzj8fsd+e9zTsqqyxulPiOWF6TteZYIu2oDaily2jfL0Ug2FcCDGVb
         S44A==
X-Gm-Message-State: ABuFfogAQuBzU7Fv5bItm4NilcKINVlvqMxN1gAwpnc1wqQqftTNNn7k
        IQThfIbb5r9fWxcEN5kDDyg=
X-Google-Smtp-Source: ACcGV63WyQVHf6iC6ouzeATw+VKoAD/DLx4DMwwp9jvpzWByM2aZth2YDeWyvBEKq1mQjLy13YPITA==
X-Received: by 2002:adf:83c3:: with SMTP id 61-v6mr10239838wre.5.1538080597577;
        Thu, 27 Sep 2018 13:36:37 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w17-v6sm39289wmc.43.2018.09.27.13.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:36:37 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:36:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180927203635.GA15407@flashbox>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox>
 <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca>
 <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca>
 <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox>
 <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 27, 2018 at 1:28 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 01:13:31PM -0700, Nick Desaulniers wrote:
> > > On Wed, Sep 26, 2018 at 9:48 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Wed, Sep 26, 2018 at 06:08:03PM -0700, Nathan Chancellor wrote:
> > > > > On Mon, Sep 24, 2018 at 08:37:22PM -0600, Jason Gunthorpe wrote:
> > > > > > On Mon, Sep 24, 2018 at 03:29:38PM -0700, Nick Desaulniers wrote:
> > > > > > > On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
> > > > > > > <natechancellor@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > > > > > > > > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > > > > > > > > <natechancellor@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Clang warns when one enumerated type is implicitly converted to another.
> > > > > > > > > >
> > > > > > > > > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > > > > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > > > > > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > > >
> > > > > > > > > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > > > > > > > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > > > > > > > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > > > > > > > > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > > > > > > > > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > > > > > > > > >
> > > > > > > > > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > > > > > > > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > > > > > > > > create_flags type to u32.
> > > > > > > > > >
> > > > > > > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > > > > > >  include/rdma/ib_verbs.h | 2 +-
> > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > > > > > > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > > > > > > > > +++ b/include/rdma/ib_verbs.h
> > > > > > > > > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > > > > > > > > >         struct ib_qp_cap        cap;
> > > > > > > > > >         enum ib_sig_type        sq_sig_type;
> > > > > > > > > >         enum ib_qp_type         qp_type;
> > > > > > > > > > -       enum ib_qp_create_flags create_flags;
> > > > > > > > > > +       u32                     create_flags;
> > > > > > > > >
> > > > > > > > > I think it might be better to just have explicit casts at the
> > > > > > > > > assignment.  What do the maintainers think?
> > > > > > > > >
> > > > > > > >
> > > > > > > > That's fine with me, I tend to explicitly cast if it is only one
> > > > > > > > location but it certainly makes sense in this case as well. I'll
> > > > > > > > wait for the maintainers to weigh in before sending a v2.
> > > > > > >
> > > > > > > Yeah, I mean my opinion on this might seem arbitrary, but based on the
> > > > > > > pattern and the comment in ib_qp_create_flags, those enum values are
> > > > > > > reserved to be "subclassed" in a sense, so they should always be in
> > > > > > > sync or this code will have bigger problems.
> > > > > >
> > > > > > One should not use an 'enum' type name for bitfield storage, as once
> > > > > > you start or'ing things together the values no longer fall on the
> > > > > > enum. Some compilers and tools even give warnings in this case, ie
> > > > > >
> > > > > >    enum x foo = X_A | X_B;
> > > > > >
> > > > > > Is an assignment from 'int' to an 'enum x' with an implicit cast.
> > > > > >
> > > > > > For this reason, usually bitfield enum declarations should be
> > > > > > anonymous.
> > > > > >
> > > > > > Jason
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > I apologize for not understanding but how should I adjust my patch so
> > > > > that it is acceptable? Do you want the explicit casts like Nick
> > > > > suggested?
> > > >
> > > > No, I think your original patch is fine, I was waiting to see if you
> > > > or Nick disagreed with my assessment on bitfields..
> > >
> > > It wasn't clear to me whether you were ack'ing or nack'ing the patch.
> > > If we don't change the patch to explicit casts, shouldn't the change
> > > be to make create_flags an int? (note: signedness)
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> > Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> > signedness necessary?
> 
> enums are by default restricted to the range of ints.  It's not right
> to tie these "anonymous enums" to a specific width and signedness
> other than int.
> 
> -- 
> Thanks,
> ~Nick Desaulniers

Thanks for the clarification, I will go ahead and send a v2 now.

Nathan
