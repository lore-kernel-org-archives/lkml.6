Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA740C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AD02075D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="eoyiuLKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeLaIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:30:39 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40494 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeLaIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dwOVJ/oq8m7hcvuIJ7iuf+eqFbwnOlo+POQGaqgUhLU=; b=eoyiuLKfDQPlXD/Mj1CXlc1GX
        E/oM28J0cU9BQScZsd0AeSjjYCygQ/Hwa2ipve1dFtppiiH3GzB4U2odN2fN+52vSlsvB5jR4Zlep
        69Rh5MLUdekVdTzzcP5mWsUcqbsMFw5J/XXS4F/YiA+7/hkGapEIi9+FrYYVB/jiwXl/Y=;
Received: from pd9e2f42d.dip0.t-ipconnect.de ([217.226.244.45] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gdsxu-0001vi-Ki; Mon, 31 Dec 2018 09:30:26 +0100
Date:   Mon, 31 Dec 2018 09:30:21 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>,
        <bcousson@baylibre.com>, <letux-kernel@openphoenux.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <mturquette@baylibre.com>,
        <paul@pwsan.com>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Message-ID: <20181231092944.014fc1c0@aktux>
In-Reply-To: <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
        <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
        <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
        <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
        <20181130153729.GG53235@atomide.com>
        <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
        <20181203153910.GA6707@atomide.com>
        <20181203172246.0e767a16@kemnade.info>
        <20181204164556.GB6707@atomide.com>
        <20181227211222.5996c356@aktux>
        <20181228200229.GY6707@atomide.com>
        <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uU6bRmK+3X7C1R5FajkKT9V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uU6bRmK+3X7C1R5FajkKT9V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Dec 2018 09:23:01 +0200
Tero Kristo <t-kristo@ti.com> wrote:

> On 28/12/2018 22:02, Tony Lindgren wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]: =20
> >> Hi,
> >>
> >> On Tue, 4 Dec 2018 08:45:57 -0800
> >> Tony Lindgren <tony@atomide.com> wrote:
> >> =20
> >>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]: =20
> >>>> On Mon, 3 Dec 2018 07:39:10 -0800
> >>>> Tony Lindgren <tony@atomide.com> wrote: =20
> >>>>> The consumer device stays active just fine with PM runtime
> >>>>> calls. So yes, the problem is keeping a clock controller forced
> >>>>> active for the period of consumer device reset. Other than
> >>>>> that typically autoidle can be just kept enabled.
> >>>>>     =20
> >>>> Are we still talking about the same problem? Maybe I am losing track
> >>>> here. Just to make sure.
> >>>> The patch series was about disabling autoidle for devices which cann=
ot
> >>>> work with it during normal operation. Not during reset or something
> >>>> like that.
> >>>> Or is the keep-clock-active-during-reset just a requirement for bigg=
er
> >>>> restructuring ideas? =20
> >>>
> >>> Yeah there are two issues: The fix needed for the issue you brought u=
p,
> >>> and also how to let a reset driver to block autoidle for reset.
> >>> =20
> >> Hmm, is this set now waiting for the famous "somebody" fixing all
> >> the stuff? =20
> >=20
> > Well I think we're still waiting on Tero to comment on this. =20
>=20
> The only item requiring immediate fixing is the point Stephen made out,=20
> removing the usage of CLK_IS_BASIC from this patch.
>=20
> Afaics, the reset related concerns Tony has can be handled later.
>=20
hmm, and there we need Stephen's opinion about having the allow/deny
autoidle functions in the main clk_ops struct.

Regards,
Andreas

--Sig_/uU6bRmK+3X7C1R5FajkKT9V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwp050ACgkQfb1qx03i
kyR0Yg/9Ez4PEKEZaVe/qnywZub7XESAii40MAwGrsvUC727+M/xPzpupttLutZl
SCF4QgDq+TpLd3xsRlx6IJZzux7hoLa29R+cAMz7YFkGbKxlZtVEydLcq4jWQfVs
yuNYi6WZriYAg5rBqhlqLWi0h162ELJzPOiuZN56aj6sizGFqaeCOyvGHIZJF5lo
NCazBMBiszNuCuk8W6V6vcqmyDDQY6EA2olIZUV8oThTcjETYuN0O9+9Yhr3Clzr
Hgztmk3zKA7B1Bi0G1irdgg4uF9MhMEkhtaNC5xTRtU7pFXoYoS1V40P6wtLxb6d
UI2tmbIBH4k9t4PqF+wt2Ly9FQn3xnDS1sZ4/qJWwhUluTM55r76o65DRfwHaj+Y
AZFccX3LS6ck6CA8T5SziUxuzUrBuGtMjhGEtrk23MvaZr942lMuYeJ16Kblh4tk
7yOpuUNt3wbXJZ32kUkMjgzUjs6/kua4YNXJW7t//ZLR5xZw5qSPZYF9DYd0yBcR
qzLQicqUq3DUs4RxA4i/9cf/h3Pp9sAnntw5k6pDYZcbgBeik4Ue3A4DPMl5FQK+
I+Nf/I7sXlSDtd+po4dDmBpo+ZtCAgRaVwfHWMHOAnUfaqH497dz6VZqzCHEQeoq
73zXbWMzrhk5fuordHOn98raOsDibCuJNFxuByNQxhLLkEDxsMc=
=ypiE
-----END PGP SIGNATURE-----

--Sig_/uU6bRmK+3X7C1R5FajkKT9V--
