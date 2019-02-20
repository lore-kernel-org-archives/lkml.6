Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5969021773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656169;
	bh=b0/CIC/3g6HjGTT/aSCcFLmZwYcBydbElzyyHpjyemU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lLP0nwLIs9hEd1V13w4TCTient9DdCjO5Ehf/QO6B6j8FqpeLithNYYZPQnTcDxvT
	 iV28UnIYLotzkoeyzyleA5iIruuGy/GeYTKFJdvVgjWASgcJXh3DO/u2bqbL0BvdSH
	 +pZvADmAq4MxDjr3SWKcrgp1I1A/jbYIEOUkVvEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfBTJt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfBTJt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:49:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56BC2089F;
        Wed, 20 Feb 2019 09:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656166;
        bh=b0/CIC/3g6HjGTT/aSCcFLmZwYcBydbElzyyHpjyemU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgEGcttpXfXIZolrISb4fbJrPZvRY2od1JDYtJjVMv8QBxOXuJb0onmtuKuflee08
         85kozmuBkornmsXSD5fxD+YRKOEDmZhKXtsxfWf1a27zdjdbfv1xyJCqZ2N9gftHtd
         0yvD1lcF4e0BJEIiuaPAUREfbXe3PwbUKQMOfAzw=
Date:   Wed, 20 Feb 2019 09:49:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Lucas Oshiro <lucasseikioshiro@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: Re: [PATCH 5/5] iio:potentiostat:lmp91000: add '\n' on dev_err
Message-ID: <20190220094921.6777d6f8@archlinux>
In-Reply-To: <d5d88a5acc984554240047944cb3071371025085.camel@perches.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
        <20190218172236.7781-6-lucasseikioshiro@gmail.com>
        <d5d88a5acc984554240047944cb3071371025085.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 13:01:23 -0800
Joe Perches <joe@perches.com> wrote:

> On Mon, 2019-02-18 at 14:22 -0300, Lucas Oshiro wrote:
> > Add missing '\n' at the end of dev_err message on line 215. =20
> []
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentio=
stat/lmp91000.c =20
> []
> > @@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_dat=
a *data)
> >  	ret =3D of_property_read_u32(np, "ti,tia-gain-ohm", &val);
> >  	if (ret) {
> >  		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
> > -			dev_err(dev, "no ti,tia-gain-ohm defined");
> > +			dev_err(dev, "no ti,tia-gain-ohm defined\n"); =20
>=20
> Perhaps a copy/paste error as the test is for
> external-tia-resistor and not tia-gain-ohm
>=20
It is an odd construct, but I think this is correct.  What it is actually
saying is that, given that we don't have an external resistor, we care
that the tia-gain-ohm isn't set (otherwise it wouldn't matter).

=46rom the docs
  - ti,external-tia-resistor: if the property ti,tia-gain-ohm is not define=
d this
    needs to be set to signal that an external resistor value is being used.

So, it might be ideal to say that tia-gain-ohm is not defined and we do
not have an external resistor specified.

So not wrong, but could be more informative!  So perhaps a follow up patch
to tidy that up would be good.

Jonathan
>=20

