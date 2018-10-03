Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F34BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83C1213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lS3hWO4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83C1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJDF7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:59:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41329 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:59:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so2217397pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+sw9TwcjbRu4rPM2ON3FLr0EDifa1srxEzn+CMt8Zs=;
        b=lS3hWO4CaqqfpgaZ5jKWV//MPzeOReG/vjOMsfCGUz42W8eW4Ew0lTSW/2jKdPk4Jc
         NjO3vLrNagXjzZBsQpyt7F2xXTdFliysc4mMhCA1gcfSJJBiCYEv48dK8oEwk6MGHI1a
         iHL6j7Ev78/uY4PJM/pjCsZQHQbftnZBOtEqYlC1vuhE5kDtl1jBVuGzygPhPLgRXTpD
         dZpL5jwzmxh03v71f1Y4zOc9mpDtajwbT8HmCWyPzynoUnxSPnv+3IXkXO/jsJbi6A8Z
         31zDbxukovM/r1TLz8v44ydziYVZs+vB+ByJcgRFkpmJSfC2aQriqyDCEZ9y6BCivrX1
         icgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+sw9TwcjbRu4rPM2ON3FLr0EDifa1srxEzn+CMt8Zs=;
        b=JNwLiv0qF8rPnqJ3ovjqFGh/QybYnxQGO11dm06kC4HQHENtp+QhJG7Md+d/hqiC/v
         hCyqlIvxU9deGZHXVw/Bn70PdqF3b5I/CYWt0EhNc1WbqmKXBFiSNLPPS/TWj5vnxleI
         adNdfXjRPvSujAURb4TPKh0OK6Q4sDnambPPirvCmoE+2I8Kwrs95Mc6ovMSZT+8YL0F
         VRXb53ALwUIgyWv/alJlzZDwr0cwO18fCP4kDJUSXo7HQ9nX9/+dGB7n+C+1LTpeRmIM
         uNjxoRl7vUsJuyB0RTDjVCNQM88V5Qr1ns304wuHliAgg9wu2EiTRDxJ1iq19xyWDKoI
         YP4A==
X-Gm-Message-State: ABuFfohgKz4LbaMOztDMgnDFBg/tHx2FxN7tKsonh62l6OjeIIvkb17H
        wWfNyNcpr2/lJj+Q/AvchBZ3Ro//8Wnf03dtJ0IM4g==
X-Google-Smtp-Source: ACcGV63d3qxTFqNJwh71WFv6Jj0Dd4T0HjRQjW1W4lnDe3OMG+uRs3YyHTjRp5e4ydFosEjEFnI8egZ6wT4hLdDAmC8=
X-Received: by 2002:a63:f347:: with SMTP id t7-v6mr2661346pgj.255.1538608161966;
 Wed, 03 Oct 2018 16:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <20181003223518.GA8700@ziepe.ca> <CAKwvOdnvXDtBAw_6_MSOEst3DBjbr8w6Pv6b4i=pC50s=gcq3Q@mail.gmail.com>
 <20181003230101.GC3466@ziepe.ca>
In-Reply-To: <20181003230101.GC3466@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Oct 2018 16:09:10 -0700
Message-ID: <CAKwvOdmFy1t0MrcD1WKq1pKc0MiV2iTRgAbpvU0sbNUR63P3Zg@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     jgg@ziepe.ca
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 4:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 03, 2018 at 03:53:58PM -0700, Nick Desaulniers wrote:
> > On Wed, Oct 3, 2018 at 3:35 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Sep 24, 2018 at 12:57:16PM -0700, Nathan Chancellor wrote:
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
> > >
> > > Applied to for-next, thanks
> > >
> > > BTW, how are you compiling with clang?
> >
> > https://github.com/ClangBuiltLinux/linux/wiki/Steps-for-compiling-the-kernel-with-Clang
> > try it out, let us know bugs you find here:
> > https://github.com/ClangBuiltLinux/linux/issues
>
> Oh I see, you are doing ARM64!

Well, it's the first arch I'm focusing on.  X86_64 and ARM32 are also
a priority.  Open source contributors are filing bugs against powerpc,
x86, and even risc-v.  I'm helping them with code review or putting
them in contact with the relevant parties.

We're going to talk more about this effort at Linux Plumbers
Conference in November if you're going.

>
> > Still looking into the case you pointed out earlier.  I suspect the
> > signedness of enums was undefined in c90, then defined as
> > implementation specific in c99 (though I'm still researching that
> > book report).  Thanks for your insights!
>
> C enums details are a topic that seems more confusing every time it
> gets brought up :(
>
> Jason



-- 
Thanks,
~Nick Desaulniers
