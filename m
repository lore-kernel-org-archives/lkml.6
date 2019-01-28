Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A96C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8FC217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OshT1GdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1HXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:23:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34387 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1HXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:23:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so13842444otk.1;
        Sun, 27 Jan 2019 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpKSzmaRDODSwUyXeKk+KgJ41/j+0HcFQypPO2rAs+Q=;
        b=OshT1GdSwOflU25jR1S7/3xOtf7JR3ZxE2II8swufQF+Jtt7qtLkNbWpc2epL8Koyu
         00WWFMOiNvxyZjUqYu/0E7T8EBKaQ3z9pxXJSuGnbrxwsJFB/ioOA2Eq1kxHpGsTr7E+
         ZDpLE9DMrEJmff2KB696Y8mPx0rARM+IQFuj72ttpUg/dm2Qp3L1eg4FhjeG6//cQANZ
         mDGHggfQRGAkFFIWEHd0PEunDF518COsFHcGQCfI92ja/aQIcRZbgwBZ3F/upDeczLJZ
         UbpAG1j6PE2rMWpZjzbD1qhmxyha/jXwVh8KJIPGzR9OURciY5IEUhbUBqERFKj2UXRG
         QrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpKSzmaRDODSwUyXeKk+KgJ41/j+0HcFQypPO2rAs+Q=;
        b=PhAZNInB0KlfQ4b5UVy/10Lj7vFTa8vZk5T7bg9bHTnPPKdCG8YCZMgI6xRgKxJ6Lb
         4RRST2SH8HLp8HvvvI/hnHttULoZlr2owfv1PKQQBlXN3cN9RcrNs5OHgAv7mdEsSlE8
         TdkmEh2wd2ezvLPnId8PjrpL4YbtCk7gG8RkgR08FWaFeUAqa4np9zYjdf8/cAJP/Z2Q
         lgBTgkgMXPnLBRwBOPnjRzYJTY7m3U40aP2oPB2e7JimA1DoUGqBAg3hJ/OjaIbkGbHC
         qsCgEL+gKqlFFgnGU4HEXoV7YxSwHlM54s8Ci+DneWkPRr9hxvKaouOtVyth8CMzo5Jl
         VXLw==
X-Gm-Message-State: AJcUukdExuTd6m46ommPPT9c1cJn8SyvL3QavUdfnECRgp4E7K8M9PD5
        e3NOEqEdhafEyyfIULoJnHvDSARog1CYCUxbAbY=
X-Google-Smtp-Source: ALg8bN5GYj+D2d1PwenZBAQlNLo2jXh5vwhReZROXmsIQQG3xD0BB4Pj7RHT7/kp2xDwszHAli5WBoubnmssumiA+6s=
X-Received: by 2002:a9d:6d95:: with SMTP id x21mr14470233otp.99.1548660233519;
 Sun, 27 Jan 2019 23:23:53 -0800 (PST)
MIME-Version: 1.0
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
 <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com> <20190126180909.38380f05@archlinux>
In-Reply-To: <20190126180909.38380f05@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 28 Jan 2019 09:23:41 +0200
Message-ID: <CA+U=DsoP_Y62ONbb5OmU3r=0UFihDT0GC3ur4i_bHFjBMAeWpw@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 8:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 25 Jan 2019 10:19:54 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
> > >
> > > Remove the checkpatch.pl check:
> > >
> > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> >
> > Hey,
> >
> > A bit curios about this one.
> > Are you using this chip/driver ?
> >
> > Thing is: the part is nearing EOL, and it could be an idea to be
> > marked for removal (since it's still in staging).
> > But if there are users for this driver, it could be left around for a while.
>
> While it might be going away soon, I'm also not that bothered about
> the small amount of churn that a tidy up patch like this causes,
> and it might not go away ;)
>
> However it is rather odd to have a 'reserved' entry for a register.
> can't see that providing any useful information.  Normally I'm
> happy to have complete register sets as a form of documentation
> if the author wants to do it that way.  This however seems silly.
>
> Alex, we haven't really gone with marking things as 'going away'
> before.  I'd suggest we take a guess and remove it if you and the
> team an analog don't think it's in use.  Happy to get a patch for
> that if you want to send one.  Of course, Rodrigo could do that
> patch to get started if that works for everyone? :)
>

We'll also start a discussion about this particular driver internally.
And maybe a procedure for removing drivers that become obsolete [or
come close to it].
We also don't/didn't have one for removing "going away" drivers; I
just remembered that we took a look over this one and decided not to
invest time into it as it's close to being obsolete.

Thanks
Alex

> Jonathan
> >
> > Thanks
> > Alex
> >
> > >
> > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > > ---
> > > This macro is not used anywhere. Should we just correct the
> > > spelling or remove the macro?
> > >
> > >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> > > index 25f51db..c9da6d4 100644
> > > --- a/drivers/staging/iio/cdc/ad7152.c
> > > +++ b/drivers/staging/iio/cdc/ad7152.c
> > > @@ -35,7 +35,7 @@
> > >  #define AD7152_REG_CH2_GAIN_HIGH       12
> > >  #define AD7152_REG_CH2_SETUP           14
> > >  #define AD7152_REG_CFG                 15
> > > -#define AD7152_REG_RESEVERD            16
> > > +#define AD7152_REG_RESERVED            16
> > >  #define AD7152_REG_CAPDAC_POS          17
> > >  #define AD7152_REG_CAPDAC_NEG          18
> > >  #define AD7152_REG_CFG2                        26
> > > --
> > > 2.7.4
> > >
>
