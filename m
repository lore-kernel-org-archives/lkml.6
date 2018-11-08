Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3299C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D41208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="C/V4OE5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D41208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeKHUoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:44:22 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:47452 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeKHUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jh+TPwUjEZmGc14dCDcKbC39suRDG/TmQcp7a9qQ1TA=; b=C/V4OE5w6Kx7vwaWL9O082cu7
        qbWpGet2GLdYnAjz1V+DGsG93avRstDp41mzUhS6JImPcVQSEGU3BfL8uZzswW780pZZj2RCLZILR
        EVYP4TatjXjmXmLei12xDFZyp9qdsONSCejLA65AiI3h+AnREfeV0nMCIQ98uE7tHTnPo=;
Received: from [2a02:790:ff:1019:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gKiBZ-0005oA-QT; Thu, 08 Nov 2018 12:09:18 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gKiBU-0004ov-TV; Thu, 08 Nov 2018 12:09:13 +0100
Date:   Thu, 8 Nov 2018 12:08:47 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcousson@baylibre.com>,
        <paul@pwsan.com>, <tony@atomide.com>,
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod
 requires that
Message-ID: <20181108120847.1ef7ec02@kemnade.info>
In-Reply-To: <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
References: <20181004203817.22101-1-andreas@kemnade.info>
        <20181004203817.22101-3-andreas@kemnade.info>
        <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DNrPM6vl+hRXWj1jQJVW_UG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DNrPM6vl+hRXWj1jQJVW_UG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 8 Nov 2018 12:26:08 +0200
Tero Kristo <t-kristo@ti.com> wrote:

> On 04/10/2018 23:38, Andreas Kemnade wrote:
> > Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> > that makes hwmods working properly which cannot handle
> > autoidle properly in lower power states.
> > Affected is e. g. the omap_hdq.
> > Since an ick might have mulitple users, autoidle is disabled
> > when an individual user requires that rather than in
> > _setup_iclk_autoidle. dss_ick is an example for that.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
> > index bb641e6c93d0..0078b0e1d242 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
> >   		clk_enable(oh->_clk);
> >  =20
> >   	list_for_each_entry(os, &oh->slave_ports, node) {
> > -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
> > +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
> > +			omap2_clk_deny_idle(os->_clk); =20
>=20
> I think calling this unconditionally across all platforms / clock types=20
> might cause problems. Checking kernel, am33xx seems to have one clock=20
> with this flag that is not of omap2 type. Do we have any testing data=20
> that this doesn't break things?
>=20
Somehow I have missed that am33xx clock. I have not tested it on that
platform. Concerning am3xxx I have only a beaglebone block but it not
am33xx I guess. So I have to recheck I guess.
But I think the intention of this flag was to control autoidle
vs. sw-controlled idle according to...
[...]
> >   		if (os->flags & OCPIF_SWSUP_IDLE) {
> > -			/* XXX omap_iclk_deny_idle(c); */
> > +			/*
this comment. So we need a if (clock_is_omap2()) or something like that
or remove that flag from any other clocks?

Regards,
Andreas

--Sig_/DNrPM6vl+hRXWj1jQJVW_UG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvkGT8ACgkQfb1qx03i
kyRPvA/+O3wf6sLIltlhj735JbtwBPTRgBqSE3bhiI0zhdEqGBCGC1yDF1NDRKxQ
ALw1g1MRyLbswezPvJhxbuvF3c3kSpPbGRjVNRW15ypI9gOeu6k05m1Ikj1I6J0p
tsYiL0oEIWi37pynfT3oQerS7sUxBKCp7Nf2OU0HMrsVNFLMVVUlJBm2WUv07RuM
lOJefgdVH5VElEsrjb+Ug/0l1lD8DxC8Cs01oD8Yr7zT06npPtOgOTCvWDPsEMZS
DFddlAcPju4gblQ5Ihf3jDxc7sqlKyqnt2wZy9yAS/tCGDmcvU+6AbTEgwC4p6IN
SM3KpMmRiaL0SQWZYW9NLPFFWlXl8QIaPaITlG/ZN5aG8dqIEmMUE5hjqHTu6e6s
rUfbcI6RmJ/11HlQC6ONBArIvQ2NSk4G9Myj/lcBoHtJtqE5sRXr3sAs/60FbWMa
hcB7wiXl7XrUTYYjAj7AbEJQO/CuArtc6OrL1wbo5guNmcBXOOc8KnNARhJdsaLq
gtBkQWovGZQ8E/6tjTU1q7U+UEFgS8OcTneR/791q9nDocKZgm73CX8jZSo6mOHU
Kwzat2k2VgqqwV1m9+7upJk5o8Ov3hDk2y2RtfJkdUw4K2aqiEBi0bBUAKb4IZPf
6stpkeWo0GJaBhkHy6T4Jujy/GZoxG8+uFd+6VXkOBneAy7Qyck=
=AU3Q
-----END PGP SIGNATURE-----

--Sig_/DNrPM6vl+hRXWj1jQJVW_UG--
