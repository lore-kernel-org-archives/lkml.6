Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A046EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD1620838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544099397;
	bh=N94kcTKToxF/NsT6M1R0nB+afah/DTywpBhEMvfQ3xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T38YOTP5SjsH67IK9CAkjRwhZN5j9Nj6TBp6kboZsJ37xH31g/p0QTJ8gBJr6mllP
	 FZ98e5okn6CGiNyGFc0T05+GukkDCNz3QoFHMdIwJehG1EsmnA0tw5zZuMUE+kC5Xl
	 R41MOD6Nktcj9sgPs/QwHctTJeDz4Q9G32RTKI8M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD1620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeLFM34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:29:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeLFM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x7u9+ZNUHxT7BzxGsqJEx1ta7zqTA862N8McgUZYmWQ=; b=lrrUkpsZFr7Fd0Y3CiAQJvuiL
        TNfdH9dZhBUhKLhWkFHGSSz4GoHyK7bNsurahwfhBGXW/N/XSwrTNewUoPzSANssoxF7J21C/nw9b
        SvgvmQpcbCXgyiNPyEDx1Qk/dfemk+B25VxtvuG9n7d00X+LBeDCgpCne9VQLKh01nZvA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUsmp-0000Xn-Lr; Thu, 06 Dec 2018 12:29:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4F59D11252F7; Thu,  6 Dec 2018 12:29:47 +0000 (GMT)
Date:   Thu, 6 Dec 2018 12:29:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add ASoC maintainers for sound dt-bindings
Message-ID: <20181206122947.GB7982@sirena.org.uk>
References: <20181117121452.6101-1-peron.clem@gmail.com>
 <CAJiuCceKdd4P_Bih138cUZWLRrXkmvysgmrneQ+2w4oduhbuOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <CAJiuCceKdd4P_Bih138cUZWLRrXkmvysgmrneQ+2w4oduhbuOA@mail.gmail.com>
X-Cookie: Tom's hungry, time to eat lunch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:45:34PM +0100, Cl=E9ment P=E9ron wrote:
> Gentle up,

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJFjoACgkQJNaLcl1U
h9ArsQf/ehw1NMeI1kYj4AQVUp6/PF7CLZdoBym3T7rOKy7pc6EhYGpV35Z6VXu+
x0gOxgptnqy0DELPmFfs5Sf/jGaWrOR1TKYjrstS2s1MYuCnuDPPf2n5nTmrO52a
Iso0pj4bbI7kJATxa5aET01rkFzzlDKygoGHYPYkgofSVPmcr5vMnUUIWjFTepyg
QxTqs4UCYSo6uSS8h2z8pYbf0oVQnzbXwW+6ypWDJrsrH2ekrBPhua1ma7TT2hky
Pa26H7w8PsAiFiH5oVwV5Xf9fomi0YEH1RAe1QsBrZx7dIK35i9qU7ju/KLayaFT
RMeSwMkgCd2WnPV3lb3aFvfmMR0ZlQ==
=o1In
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
