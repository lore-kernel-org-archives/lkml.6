Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326FDC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDA621470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8xDXOh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDA621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJDFof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:44:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32815 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:44:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so2389635pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BxD2J15AFeCUnar9QdtFIQnEk+5lu73YcBVDvSmMLs=;
        b=C8xDXOh2ZZjLAboE7IAvabXrBp4a6XD+lN8fGLk42wKzizRH6V3oWNgu8FnjFGuxef
         wvmGUm7BnbrTE9UklxKaYRGt+TvWzC31UBq2ndFN/mWJJnX2laOcuvFYN5cb8cato6R5
         aaB/1S4rZMMgyolY7aKeEb/l1YlSCIl85jmHJXSB5Rr9TQsxU9DI1V9I7D/5XrxEI3Vj
         DQGnia4xvJsvNXBPgEr1Q+xsBwjpgyIsdvdjNlBApcstfzqafRIm6WW7RVtqMa24Er8M
         Rnjyfy0YPPAVuKfEJbveVNUwEfkdQZ8oxL/QbfeJOXIHeqnl7mNZKnbi5n2P6TYyoNct
         vTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BxD2J15AFeCUnar9QdtFIQnEk+5lu73YcBVDvSmMLs=;
        b=WF5EOb1JTj7dLfcY/3xxO+3hCHIHxuZMBb/DwNVUP68Dg6IqUUcCP2Eyz+pRdr9Zc4
         X22mxi+DLU1ko4qVj7flARZQT644FGTwPGRG4vzdz+CJSJgucB2ozz2Tib5Mg/+hjFg8
         FWZ6EwsmI4MyiNB2PQCsANeI8tV+sg1HavnjU8xKjbXIskE0UW09e7Ue2I9A9hKgKXiO
         uiFP/ZrtYwlH+Vj6nfpyam5Xe07NwuyJ8z7R3fGZX0w4I78s0Bz/ObDWpkOWwDcdWGGb
         hCT4jmYWR7OyqdpI3onimBDayFIEO2FmdCo9IUtxo2RrgM0IWyCSI72ransYcIrdHUSJ
         A9PQ==
X-Gm-Message-State: ABuFfohN6i7/O35epX149iPid05oqauX3x3Wg+2mnxCJ1cC7PR8YCa0A
        wXGEynEKeNgRKDCw/dlNSLNhAZCZ/ImWUq5NmAlL8w==
X-Google-Smtp-Source: ACcGV63AKDdg8vjy4mOenOSX4yS5s86PAZpgQHLYc5lMc0l5vIWCmBMNljKd3Fwv1/fi1ApzN4dpmi61oLzWdzAcuh8=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr3262958pgl.302.1538607250055;
 Wed, 03 Oct 2018 15:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com> <20181003223518.GA8700@ziepe.ca>
In-Reply-To: <20181003223518.GA8700@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Oct 2018 15:53:58 -0700
Message-ID: <CAKwvOdnvXDtBAw_6_MSOEst3DBjbr8w6Pv6b4i=pC50s=gcq3Q@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     jgg@ziepe.ca
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 3:35 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Sep 24, 2018 at 12:57:16PM -0700, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> >                                                     ~ ^~~~~~~~~~~~~~~~~
> >
> > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > type ib_qp_create_flags. Make that clear to Clang by changing the
> > create_flags type to u32.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  include/rdma/ib_verbs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied to for-next, thanks
>
> BTW, how are you compiling with clang?

https://github.com/ClangBuiltLinux/linux/wiki/Steps-for-compiling-the-kernel-with-Clang
try it out, let us know bugs you find here:
https://github.com/ClangBuiltLinux/linux/issues

Still looking into the case you pointed out earlier.  I suspect the
signedness of enums was undefined in c90, then defined as
implementation specific in c99 (though I'm still researching that book
report).  Thanks for your insights!

>
> Jason



-- 
Thanks,
~Nick Desaulniers
