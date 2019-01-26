Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11249C282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFCC2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548526157;
	bh=rHuzDfPwjtqRyLzcYTXQWvdEoTAwNRFWp4WH2OxOSKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mkxS735ipEXUODJ+feiL5ByT7VxGFTpYFtgO5QQxbhtPorPj3A0VA3s+bPH+qZrOD
	 /r8iFGQPN1gyWsrIr+PHScgCJfGjz28CTKJWSzvZfw9GWY3pdCsCcDqhTPbfQO1Xq4
	 U7gGjP1mKWUXNy4iUBL0pW/AaTPX6HHcJXXq5l3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAZSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfAZSJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:09:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36AA218A6;
        Sat, 26 Jan 2019 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548526155;
        bh=rHuzDfPwjtqRyLzcYTXQWvdEoTAwNRFWp4WH2OxOSKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YlCBCLJc1qeT8tkDvuqw9wJsN+NKNzdke9ThA8+Dv4fuF/AcLZtbDImI+SgBAuckm
         tBWqcKt+FZlkjIvoFqhVAnpYnCSabAJckdp1bMdAPqAyl/o7AMAoVa8XznGEYOr+WN
         Sf/GMvzYnzXSzT/Jmy9GIZeUb9QjARbWOXOS1i2E=
Date:   Sat, 26 Jan 2019 18:09:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD ->
 RESERVED
Message-ID: <20190126180909.38380f05@archlinux>
In-Reply-To: <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
        <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 10:19:54 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
> >
> > Remove the checkpatch.pl check:
> >
> > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?  
> 
> Hey,
> 
> A bit curios about this one.
> Are you using this chip/driver ?
> 
> Thing is: the part is nearing EOL, and it could be an idea to be
> marked for removal (since it's still in staging).
> But if there are users for this driver, it could be left around for a while.

While it might be going away soon, I'm also not that bothered about
the small amount of churn that a tidy up patch like this causes,
and it might not go away ;)

However it is rather odd to have a 'reserved' entry for a register.
can't see that providing any useful information.  Normally I'm
happy to have complete register sets as a form of documentation
if the author wants to do it that way.  This however seems silly.

Alex, we haven't really gone with marking things as 'going away'
before.  I'd suggest we take a guess and remove it if you and the
team an analog don't think it's in use.  Happy to get a patch for
that if you want to send one.  Of course, Rodrigo could do that
patch to get started if that works for everyone? :)

Jonathan
> 
> Thanks
> Alex
> 
> >
> > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > ---
> > This macro is not used anywhere. Should we just correct the
> > spelling or remove the macro?
> >
> >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> > index 25f51db..c9da6d4 100644
> > --- a/drivers/staging/iio/cdc/ad7152.c
> > +++ b/drivers/staging/iio/cdc/ad7152.c
> > @@ -35,7 +35,7 @@
> >  #define AD7152_REG_CH2_GAIN_HIGH       12
> >  #define AD7152_REG_CH2_SETUP           14
> >  #define AD7152_REG_CFG                 15
> > -#define AD7152_REG_RESEVERD            16
> > +#define AD7152_REG_RESERVED            16
> >  #define AD7152_REG_CAPDAC_POS          17
> >  #define AD7152_REG_CAPDAC_NEG          18
> >  #define AD7152_REG_CFG2                        26
> > --
> > 2.7.4
> >  

