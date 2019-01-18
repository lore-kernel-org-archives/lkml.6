Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8466AC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504042087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Q65rpL5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfARTmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:42:10 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60746 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbfARTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tlHMtKZP/vH7+gVsdekkecetbeXORUQscA+CVZnfdtM=; b=Q65rpL5/RPUMuwRebL4L167xW
        DGhGgKL9fHTNTk8a+7rUrEf3/mltyLT9bU3yisITCZhnOM/5uy4gJ7yX8cVUfY1/2pGnmFBUXAr/G
        0w+zzaZs3PEiK8zXHteYngFOs03w+b4LkZ2mKDEXV9e2J8T8Y0fFD3I91E26kVER+O6co=;
Received: from p5dcc388c.dip0.t-ipconnect.de ([93.204.56.140] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gka1k-0003cx-CQ; Fri, 18 Jan 2019 20:42:04 +0100
Date:   Fri, 18 Jan 2019 20:42:04 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        paul@pwsan.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, t-kristo@ti.com,
        bcousson@baylibre.com, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
Message-ID: <20190118204204.44db353f@aktux>
In-Reply-To: <20190118203832.3be7975e@aktux>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
        <20190118203832.3be7975e@aktux>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cmRBVXiaf7fgX4boBy//94_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cmRBVXiaf7fgX4boBy//94_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jan 2019 20:38:47 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Hi,
>=20
> On Fri, 18 Jan 2019 10:36:30 -0800
> Tony Lindgren <tony@atomide.com> wrote:
>=20
> [...]
> > til the next workaround.
> >  =20
> > > That flags also causes the iclk being enabled/disabled
> > > manually.   =20
> >=20
> > Yes but SWSUP_IDLE for the interface clock to me currently
> > just means:
> >=20
> > "manually enable and disable ocp interface clock"
> >  =20
> well, if we want to manually disable it and not automatically,
> we have to disable autoidle or it will be automatically disabled.
>=20
> Disabling it manually when it is already auto-disabled (by autoidle) is
> just practically a no-op towards the clock.
>=20
> > and with your changes it becomes:
> >=20
> > "manually enable and disable ocp interface clock and block
> >  autoidle while in use".
> >=20
> > So aren't we now changing the way things behave in general
> > for SWSUP_IDLE?
> >  =20
> Yes, we are, so proper testing is needed. But If I read those comments
> it was always intended this way but not fully implemented because it
> appeared to be more work like needing a usecounter (which my patchset
> also adds) for that autoidle flag.
>=20
and there are quite few hwmods marked by this flag.=20
And then there are those clocks marked by this flags (on am33xx) which
do not have that autoidle feature at all, so the risk is not too high.

Regards,
Andreas

--Sig_/cmRBVXiaf7fgX4boBy//94_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCLAwACgkQfb1qx03i
kyRO7xAAwwh91blhaMQ/Mp4Os+lMhQQVtl7FMOfP3kaCWWC5kdmAe1Gk/6yYyst1
vL+zKBUSG4CW4EjVv5ihZOBP4pegYLVL851o6U2NWONNhJIi4+QIBEwZL6dRiYVi
RU7NM+AWAcpa1RMzusyUvUfusrw0vhsrHHsbzqJl0+R519fTnH9x7SeYmQBS2hZQ
aTdMLRD7BrZ+AgAN2AcLw3omXSfDB4S15hSwoV616JFTxuP50QZZM4rAVFgduUYL
zgIbSjAgM1OG71w171HH97VmxbS/rPuFDsDnSzhTMYv55/DfW9ObHZUnRnFAbFxc
2UodoKnN56uwPOUR8paJToZQ0AuVpNFyn3Td4jtd8KyD9QsIrfuYHUeLgcxbqZsT
0AbPcETW1cUnrofW5Y/d9vxjhb6L9jcmHh6mjJHlkM9Y/QQma3IUxntxuReE/su0
mffLNmAbtRD5xDylPuebvg19fnoVggcMow1BNn6/v0rB+UwpRa0m3bT+fBcBUIe5
wafau9J8Fbk0du2UbtJs291iajpps79asXpCjvrlfAnYKTUZpLJ/6D0XxKmy2k4T
lSOn2kYOv02n41AfRKQ9N9R8hQzOCDI3JaUEavyR2YGpJR4xtMpYlA80Ujxj5yUM
5tqBHdHPx5QI8YP+Fa+Rk46kVhbPsGSvr1KI9zZIj2RKfMx5naQ=
=MvR3
-----END PGP SIGNATURE-----

--Sig_/cmRBVXiaf7fgX4boBy//94_--
