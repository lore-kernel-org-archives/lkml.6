Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9584C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6601A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/L6ON6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6601A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIYEeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:34:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46430 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeIYEeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:34:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so9937299pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFrQhIX0GW00J6KqjbrEUvGWLJ5d8KinjIctlAo+s3I=;
        b=A/L6ON6bj/jfVSnQRoOkvbGGbVHlSsUwmEZrPWqeGV8nm5OQhWR0sqyClj8q315u4O
         XyBKK49/Iju+KrDgPU5B/CzcjomcBvjk7XrwxIxGslSTb47esSpAJf9cWbDPDRVPAH8r
         3VP8Z42nLQv5olXMHuivF86eVnS6Hg7pKDqj/Qc165baQ85Xv+3X84EcwMISlYu35gma
         P61aYH02tQrjaP9QFVKl7kX50uatwHGQr59p/PfSoVDrIfvrI8MPwHV8Z7qazfTuI3xD
         okejJJZUIgfQH/505TOEiMcSdABqvRkwB3E0i3A7A0ZAnfPzxQ/4R6HQja6s/1taE5BN
         UykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFrQhIX0GW00J6KqjbrEUvGWLJ5d8KinjIctlAo+s3I=;
        b=YSuq6EV8FYlCOjcDaBYvSQQ0EgT9oexgMFtWTrxNMFKcDGTyts3yggs+1nSDSzAE1c
         C/9Hcdok7g7KlzqE7w5P9uNS/fa/BlEK4qfbgvj/g1smWEIUZK7NBZNCnrw8954J23CO
         3K6kcuFdSZF/onECAmVHZolCDEX0YoQkxOZ8sgud7EusO7WKuj+uAxEKjCMXcCMJeiU3
         W0SKl4UvbC85CeSfWDWwaSSPNG7rH1QvEt9dgnK8anV/vkwEtbivPmPyihYqDkBH5uhc
         qgilFOJOv7hQQYEcIsGU0SpJazK697vJQ8eEn7lsnedR9WF6sImG9x2ndyokgIVg7PIe
         uFug==
X-Gm-Message-State: ABuFfojPVHMnNww5VQx6WaF5/R3tWsghZnhyZMRM+5eQvKB8aDxbmqRV
        Kb5ZI9EmrPK/IZ3N3A5+PtIER/JTSVSl0WMaOoy0u71721J6Tg==
X-Google-Smtp-Source: ACcGV62dmVqhUFmi1DD1Ff2dipE28MZJc2x/Ij4WGvTLva+6gtJK241DHupXGsFmw9vBs8QuJr1AHG4TA8S4jdNOUFM=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr608818pgn.145.1537828190100;
 Mon, 24 Sep 2018 15:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com> <20180924222737.GA26973@flashbox>
In-Reply-To: <20180924222737.GA26973@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 15:29:38 -0700
Message-ID: <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 3:27 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> > On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns when one enumerated type is implicitly converted to another.
> > >
> > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > >
> > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > create_flags type to u32.
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  include/rdma/ib_verbs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > index e463d3007a35..f6f4d9e3c8ed 100644
> > > --- a/include/rdma/ib_verbs.h
> > > +++ b/include/rdma/ib_verbs.h
> > > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> > >         struct ib_qp_cap        cap;
> > >         enum ib_sig_type        sq_sig_type;
> > >         enum ib_qp_type         qp_type;
> > > -       enum ib_qp_create_flags create_flags;
> > > +       u32                     create_flags;
> >
> > I think it might be better to just have explicit casts at the
> > assignment.  What do the maintainers think?
> >
>
> That's fine with me, I tend to explicitly cast if it is only one
> location but it certainly makes sense in this case as well. I'll
> wait for the maintainers to weigh in before sending a v2.

Yeah, I mean my opinion on this might seem arbitrary, but based on the
pattern and the comment in ib_qp_create_flags, those enum values are
reserved to be "subclassed" in a sense, so they should always be in
sync or this code will have bigger problems.

>
> Thanks for the review,
> Nathan
>
> > >
> > >         /*
> > >          * Only needed for special QP types, or when using the RW API.
> > > --
> > > 2.19.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
