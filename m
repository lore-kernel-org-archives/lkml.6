Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413CA2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="eVzfrA9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413CA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJEC3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:29:45 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:33778 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJEC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BuQLrtChRyBTYyuIDcmVQimPper4LvVNyYDui4Vrnbw=; b=eVzfrA9hJG2ZzbhxL38+6OJZz
        eNqBoA75HNA/gdm+7kwByDRlj1dTjVb3gGI2XwK8Y37qThGR1b9E+yt+kKULqjXd+mwvg52odJUny
        AhZL+puW3nzzWqcg9gssxoPEJnWdPeUWi02T8QDeCEkL9Qg/EypdNd4aKyBUbdRrmHmHY=;
Received: from pd9e2f808.dip0.t-ipconnect.de ([217.226.248.8] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g89Og-0006NZ-9k; Thu, 04 Oct 2018 21:34:54 +0200
Date:   Thu, 4 Oct 2018 21:34:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <paul@pwsan.com>,
        <tony@atomide.com>, <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 1/2] clk: ti: add a usecount for autoidle
Message-ID: <20181004213448.55c08208@aktux>
In-Reply-To: <d3119268-2716-c5e6-5ed8-28495f597fb0@ti.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
        <20181004055147.23048-2-andreas@kemnade.info>
        <d3119268-2716-c5e6-5ed8-28495f597fb0@ti.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DI2+y_6kLlI.i7YQdkdRjJF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DI2+y_6kLlI.i7YQdkdRjJF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 4 Oct 2018 17:40:06 +0300
Tero Kristo <t-kristo@ti.com> wrote:

> On 04/10/18 08:51, Andreas Kemnade wrote:
> > We have the scenario that first autoidle is disabled for all clocks,
> > then it is disabled for selected ones and then enabled for all. So
> > we should have some counting here, also according to the
> > comment in  _setup_iclk_autoidle()
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/clk/ti/autoidle.c | 20 ++++++++++++--------
> >   include/linux/clk/ti.h    |  1 +
> >   2 files changed, 13 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > index 7bb9afbe4058..be2ce42e4f33 100644
> > --- a/drivers/clk/ti/autoidle.c
> > +++ b/drivers/clk/ti/autoidle.c
> > @@ -48,8 +48,11 @@ int omap2_clk_deny_idle(struct clk *clk)
> >   	struct clk_hw_omap *c;
> >  =20
> >   	c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > -	if (c->ops && c->ops->deny_idle)
> > -		c->ops->deny_idle(c);
> > +	if (c->ops && c->ops->deny_idle) {
> > +		c->autoidle_count--;
> > +		if (c->autoidle_count =3D=3D -1)
> > +			c->ops->deny_idle(c); =20
>=20
> This code is racy as you have no locking in place. Please fix.
>=20

hmm, yes, it is. Due to low risk (things are only called from init
before the drivers are initialized, if I understand that correctly). I
kept that for final polishing and not for a rfc patch.
The deny_idle/allow_idle are also racy themselves. Multiple clocks with
bits in the same register changed at the same time would also create a
mess.

> Also, this should be verified that it doesn't cause any PM regressions,=20
> I hope you have done that?
>=20
Tested things: I checked various autoidle registers for changes.
I checked registers by reading out /dev/mem
Seen changes: hdq iclk no autoidle (that is the goal of all this)
dss iclk no autoidle. This one is really interesting: There are
multiple users of dss_ick, so that is a special case. I will check
whether I can handle that (I have already an idea) or just delete that
flag there for sorting out that later, we could somehow live with not
disabled autoidle flag there but needed some strange fixes in the past.
Now dss_ick does unecessarily enabled, so yes, a little regression.

CORE/PER idlest seems to behave as well as before that change.

Regards,
Andreas

--Sig_/DI2+y_6kLlI.i7YQdkdRjJF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlu2a1gACgkQfb1qx03i
kyTUJw//bk67LvreD5J0A92GGWjzLptxyyqnzPs6JmSzGymmvcNzCfwUFHri76CT
xDBs5DyRUWcTg51aRFmjcYS1yBx3UJSscDX52V2CPYF6zvhfWL3w92VDlqawdQjt
ADIRnpiFA/JsaRakszMia/2Yvqybf/eXchmE/PVZgn8IQnFJW0SgcvBXrUmFVznX
55nkSeBThO8Rt/1JWmeaUp73m4MPZ0IDp0/5a2nFRMoIp1Arkd632MbWKesT7sD+
d84LSP5MEslEpB0mHdXNgkuJfxS0WcgrkXeVuvTJq3JkJSy+LQLYlyDwAJkfC8TV
/FO8lYFFnH7GcgdNhPmv3r/iUrdSUIujIat5oyUpuz00AVMA0+tstrQxQ2mIRIpM
P/2+h8AL+4el+bNQRYCPMCckCVj/zvzSD2XVnAc9N5q+GD4UYQQ3+9CZanpETr16
XFMAK5nzGpxPI0f13utAsunRMk+7RNX3ECybnO/402T/CQYepITQWhjig5n5nDx8
ZHvBHKLmWBxVPvg0ml598m5PHRO/FCbCBPK1hfSd1fhy9HN9Ya/LW6EjAyjY9s9c
v8jOw3eik4iokdz5zSxhhdArqU0mO4FwA8p5/lTLC/Fuurr9gnpxIm1Xr5nMIWik
0O0/1OqtM2LwgQ1IvfAenwODCaKcwSG1VupZzG8rj0+mt2DbNuE=
=xAN8
-----END PGP SIGNATURE-----

--Sig_/DI2+y_6kLlI.i7YQdkdRjJF--
