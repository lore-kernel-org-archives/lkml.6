Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E68C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301FC218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551255224;
	bh=KzKZUEW649tkM4fhsxinvnskLJSE+xoI3Ct2N6Jk0c4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FL+hj3lPeFk6k2sUJEKhaUtuglPY02dhHb6wgyy0RyuLiPn77ILfhcR3fvOFtxxPS
	 oIhTJhGkngX1A2pVHJqG63tsREE6JhjeCEXOcVLK1c74/xyUpMu+5qVM9jcXwSf7AW
	 TL5/trCdVJBV/5EfRAOIxdOvjStBHMTcdNqgysl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfB0INm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:13:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfB0INm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:13:42 -0500
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53814218CD;
        Wed, 27 Feb 2019 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551255221;
        bh=KzKZUEW649tkM4fhsxinvnskLJSE+xoI3Ct2N6Jk0c4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OGptlor0t2hRqIxVpiPqt/k8QJFMM1J2pKKQDgTToLNj3kZ/ooq3FuNxVHyH0NHA+
         m7V3K3X1CyCZlWLTMVrCpGdFZzDkkv/xaPN8L8dfAfBrZYxTMnGEw05cXxKXD1Z8de
         T79ykR1BCuwaozS/rx2jHCyocvBi6jOzKwAGzitQ=
Date:   Wed, 27 Feb 2019 09:13:35 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] i3c: master: dw-i3c-master: mark expected switch
 fall-through
Message-ID: <20190227091335.2a19e2a7@kernel.org>
In-Reply-To: <87e0a8c9-82f6-3f41-bdb6-162a4c264132@embeddedor.com>
References: <20190211221413.GA21822@embeddedor>
        <87e0a8c9-82f6-3f41-bdb6-162a4c264132@embeddedor.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 21:53:16 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Hi all,
>=20
> Friendly ping:
>=20
> Who can ack or review this, please?

Will be queued for the next release. Please be patient.

>=20
> Thanks
> --
> Gustavo
>=20
> On 2/11/19 4:14 PM, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> >=20
> > This patch fixes the following warning:
> >=20
> > drivers/i3c/master/dw-i3c-master.c: In function =E2=80=98dw_i3c_master_=
bus_init=E2=80=99:
> > drivers/i3c/master/dw-i3c-master.c:603:6: warning: this statement may f=
all through [-Wimplicit-fallthrough=3D]
> >    if (ret)
> >       ^
> > drivers/i3c/master/dw-i3c-master.c:605:2: note: here
> >   case I3C_BUS_MODE_PURE:
> >   ^~~~
> >=20
> > Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >=20
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> >=20
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/i3c/master/dw-i3c-master.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw=
-i3c-master.c
> > index bb03079fbade..59279224e07f 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -602,6 +602,7 @@ static int dw_i3c_master_bus_init(struct i3c_master=
_controller *m)
> >  		ret =3D dw_i2c_clk_cfg(master);
> >  		if (ret)
> >  			return ret;
> > +		/* fall through */
> >  	case I3C_BUS_MODE_PURE:
> >  		ret =3D dw_i3c_clk_cfg(master);
> >  		if (ret)
> >  =20

