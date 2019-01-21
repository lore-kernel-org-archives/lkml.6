Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB9C31698
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203C72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gOkL96IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfAURyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:54:04 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40838 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/EahbdAM9Rnmth+qyweFJkhqExHTte862R/SbOZwNqQ=; b=gOkL96INVf7DqOVneOBrPfP0a
        haT0bG+LMicOwesZMyXQ0qCFzQA7mTb1vA4sJrGTzxQZ+4Pf1DXY2OJCyy3DkWZN8R4YSmOG4UVwE
        I9w9c8JuXE20O78SVxZv43o90fik43djW8SwRiWpuSu/iZfxPbNq6Kiwr2FsbTAp3hafc=;
Received: from p5dcc3cf3.dip0.t-ipconnect.de ([93.204.60.243] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gldlk-0001UH-AH; Mon, 21 Jan 2019 18:53:56 +0100
Date:   Mon, 21 Jan 2019 18:53:44 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tero Kristo <t-kristo@ti.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190121185344.7cff9641@aktux>
In-Reply-To: <20190121170743.GB5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
        <20190118203832.3be7975e@aktux>
        <20190118194536.GY5544@atomide.com>
        <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
        <20190121170743.GB5544@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HnaydzaLFwE9HUO/Oh9Q2eo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HnaydzaLFwE9HUO/Oh9Q2eo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 21 Jan 2019 09:07:43 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Tero Kristo <t-kristo@ti.com> [190121 07:13]:
> > On 18/01/2019 21:45, Tony Lindgren wrote: =20
> > > * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]: =20
> > > > Hi,
> > > >=20
> > > > On Fri, 18 Jan 2019 10:36:30 -0800
> > > > Tony Lindgren <tony@atomide.com> wrote:
> > > >=20
> > > > [...] =20
> > > > > til the next workaround.
> > > > >  =20
> > > > > > That flags also causes the iclk being enabled/disabled
> > > > > > manually. =20
> > > > >=20
> > > > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > > > just means:
> > > > >=20
> > > > > "manually enable and disable ocp interface clock"
> > > > >  =20
> > > > well, if we want to manually disable it and not automatically,
> > > > we have to disable autoidle or it will be automatically disabled.
> > > >=20
> > > > Disabling it manually when it is already auto-disabled (by autoidle=
) is
> > > > just practically a no-op towards the clock. =20
> > >=20
> > > OK I buy that :) It should be probably added to the patch
> > > description to make it clear what it changes.
> > >=20
> > > Tero, any comments on this change? =20
> >=20
> > Well, seeing the flag is pretty much only used for a handful of hwmods
> > nowadays, it should be fine. OMAP3 PM should be tested with this change
> > though, as there are couple of hwmods impacted on that platform. I wond=
er
> > what happens to cpuidle when display is active... =20
>=20
> OK so that's a good test case. AFAIK, we should have DSS idle
> and have the SoC hit at least core retention with DSI command mode
> displays. I don't know if this patch would block DSS autoidle then
> or not.. I'm guessing 80% chance that we still need DSS hit runtime
> suspend to enter SoC idle states meaning this patch would not
> affect it :)
>=20
So this is a call to Nokia N950 owners?
Unfortunately, I do not have one. I have seen on non-command-mode
displays that dss goes to idle when display is blanked.

Regards,
Andreas

--Sig_/HnaydzaLFwE9HUO/Oh9Q2eo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxGBygACgkQfb1qx03i
kyRBuxAAuFR8hFsL6uh6ARlVEQO+wUdp/ISgRQmvcwvKthz33KSQJdXmbzleXtSM
mV03OE6dFkMHdKkQalC31sYIfRcjYHBrguvKyz1XAojZhQgWWJJkJLx1Lauw9Yk8
wGc4D1LqdwmXoIQPAycpZMF9+lalo/7yc11u+yDQIyZc8aifyDLZHrkRuriZbqfS
eY6WvmjXpC3VJJTTCvipJL76b9dbmAxHDx4CysHbec1/CVB6Tu3diUALCBj0J2Fx
szsgvJF7veWy2gnZGFIj65QKE6DmGXq82wahcvdIxiapcRJwGDZYOAtLlJclquDV
H1c+xJhdcQauC9rE2ELdWBb7mmbTd3WlCr5x2IZ7zc0PfwqlFh4c9HolYUBXLtvU
7A7bkDpfL2St3vrv2Gxm/V+EDOrr0SDrVPlxiI/tVDtJfxq+ZQSG7RrXbxFA4W3e
/RdH9RXCpYoSLCHs7xguOcbwt7jMEMErUmtv7mP/xTdXthPl33pp/ILWCtDBekBo
S8zHSZJqdoAVlgrTh7iIiDb8lf2eJN99iNgoEvTwjm7Duit55C9+S3NI2Z2Rm1DX
bJjFzdlzFbh1qr4jtZTcuSUseR0axh82T19+G2S1buT0wcU9Sa3aRonxNm5QZGJh
4xZtwS68RXx5fz+H2AHUvTzDuPF5i+zPnbnjEEVhAkoPg444AD0=
=nkFt
-----END PGP SIGNATURE-----

--Sig_/HnaydzaLFwE9HUO/Oh9Q2eo--
