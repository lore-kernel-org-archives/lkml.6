Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B869FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC12146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lkmhKtY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeK3RYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:24:13 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:59526 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeK3RYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rs2HfXIjJLImDsru7nEbJEw10YaajG3LuMXDmZTci/o=; b=lkmhKtY2ikY6Lx6vzqt0nzE4R
        9C6mfh1yaa6OktG8l4k4R3KDTmquwquYWxA3s/RZLBf+ZaxInmfJQ3rJwTKLrypGf1HcXaeAOHrUj
        Xv41yKFhp5Tja0m+mqWDOgSwY94NdEvT7xuBNfpzZFc3o2DkYqA1LP8rHE3AOlwKq/cUI=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gSc5f-0002Ag-G4; Fri, 30 Nov 2018 07:15:51 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gSc5d-0001G7-QI; Fri, 30 Nov 2018 07:15:49 +0100
Date:   Fri, 30 Nov 2018 07:15:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     bcousson@baylibre.com, letux-kernel@openphoenux.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        paul@pwsan.com, t-kristo@ti.com, tony@atomide.com
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Message-ID: <20181130071534.0a6cd455@kemnade.info>
In-Reply-To: <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
        <20181110203115.13335-3-andreas@kemnade.info>
        <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FQLc6guxB0FULy.fZogCAyY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FQLc6guxB0FULy.fZogCAyY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, 29 Nov 2018 16:25:05 -0800
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Andreas Kemnade (2018-11-10 12:31:14)
> > Code might use autoidle api with clocks not being omap2 clocks,
> > so check if clock type is not basic
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > New in v2
> > ---
> >  drivers/clk/ti/autoidle.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > index 161f67850393..5bdae5552d38 100644
> > --- a/drivers/clk/ti/autoidle.c
> > +++ b/drivers/clk/ti/autoidle.c
> > @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> >  int omap2_clk_deny_idle(struct clk *clk)
> >  {
> >         struct clk_hw_omap *c;
> > +       struct clk_hw *hw =3D __clk_get_hw(clk);
> > =20
> > -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC) =20
>=20
> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> Maybe add some flag in clk_hw_omap() instead?
>=20
hmm, Tero suggested that.
But to check flags in clk_hw_omap I first need to know that there is a
clk_hw_omap behind clk_hw. And for that I either need to check flags in
clk_hw or do more changes in the omap_hwmod code.

Regards,
Andreas

--Sig_/FQLc6guxB0FULy.fZogCAyY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwA1YgACgkQfb1qx03i
kyQ+yBAAidDLhlhMZ7eEWFOsruVGpL8JqvsCCCMue6pw/Se8mDoITcbDfV4phKcN
1Krz5PbnrhYeFOsAS9+qmI2xOyh0SyhuA/gEZz1ANREt2DS0zVnpLVW27U23lg0S
mKmqOHmCGrHnMHj4U2rgwDG+zbJ3sQlyuS4Gp7rK8vpfzwPjc9cfbBRRsjyEOGgX
2KdW+LezWLsl8FwOmuzmSJSw8s+2/yswK5Sh6n8VbJc3ZXf3pjfhrF2a+ODZsLU8
2ku+JKz+245xWYwjNspGAxpuHD5ZOaeYA8v6eDs9FdUxZ0ic2aq/kn+UKLLRSAGN
BljwO010K9VY74CctZDkMBCehMbuTbdrOQ1MQWYxnVUX4emDtUS4kK7cYN849Juf
3Ao71tKvqpUkWyJJ8E9m0e7UuMytCgs76cpvSwUVRkp6QluCXuTlyILKvpjp/gTD
9pvP6vPVI7tciHt8NUsBY1D7lRQv/D/qYQ0Xucypt7U5pkV7yVtAvHS/4fIleO8h
TrDEfGrTKKpK2JDUn8wiePtQ9Z15A4C8v8bSa4qL3mB0j32EuZa1V/P0r3sC+b4l
4vWq4/qcY+4q8oASQG3zvtcV1qrVJUPW0yKuA0K9eMWXU8XUVQALZBsrr9zg8DcI
fAfx4GxyROA/fMPruZgC57wW3JV16lQhagoTKCBIgSmlZsnnh7E=
=l8Gp
-----END PGP SIGNATURE-----

--Sig_/FQLc6guxB0FULy.fZogCAyY--
