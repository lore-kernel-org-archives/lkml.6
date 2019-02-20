Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16921841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550687673;
	bh=4oILZq/h1yjAtk6DJXR4HYQoczLDgcKkg9Zb1oOOLIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lWWuB5xZG1nVFtcMJPxUv3dCG0W4SJKlDFtmNiJB6vzylPx5cO0qqhmCTV/7/zNWB
	 aplswaaEbXuFnilj/P49j9v8ddDC4jU8sWJGYvQU0lwMl7va3j2ZLwZCZ6DrLJ/GCy
	 CU2d18nxZOg1uGsKyCu6MNnRi7XULJyPfWDdck3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBTSeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfBTSeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:34:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0AF2146E;
        Wed, 20 Feb 2019 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550687670;
        bh=4oILZq/h1yjAtk6DJXR4HYQoczLDgcKkg9Zb1oOOLIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jEcxsR4hO8lc278sXBqg6z94ds8C56jzgA8ogz7vVqGbWGC43wbXY2KjYYyddtkxc
         7wdQM4RTlP4IHsa7BelgytWXIyGWrPyV3HbOzwhvWCtqF9r19vvCaButdohpUmi03k
         b2+ShtBvEPWFL+MW3G2N0s68cFOTiqCxxRm+9U6o=
Date:   Wed, 20 Feb 2019 18:34:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20190220183425.202d4d40@archlinux>
In-Reply-To: <CAGXu5jLsQ_Uc4kp=md2SrOERopjZmnQK_fAsru4MQUqEHRvEeA@mail.gmail.com>
References: <20181008172332.GA29816@embeddedor.com>
        <CAGXu5jLsQ_Uc4kp=md2SrOERopjZmnQK_fAsru4MQUqEHRvEeA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 10:20:39 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Oct 8, 2018 at 10:24 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> >
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> >
> > Addresses-Coverity-ID: 1397962 ("Missing break in switch")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 063e89e..d609654 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >                 switch (i) {
> >                 case X:
> >                         ec_accel_channels[X].scan_index = Y;
> > +                       /* fall through */
> >                 case Y:
> >                         ec_accel_channels[Y].scan_index = X;
> > +                       /* fall through */
> >                 case Z:
> >                         ec_accel_channels[Z].scan_index = Z;
> >                 }  
> 
> Shouldn't these actually be "break;"s ? It seems like the loop is
> stepping through X, Y, and Z. The _result_ is accidentally the same:
> 
> X: set X, Y, and Z
> Y: set Y and Z
> Z: set Z
> 
> result: X, Y, and Z are set correctly. But the code is technically wrong.
> 

Agreed, it's 'novel'.  Waiting for Gwendal or someone else to come
back and check it wasn't meant to be doing something else.

Jonathan

> 

