Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39623C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEB32086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hxjXg+BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEB32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeK0WsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:48:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46286 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeK0WsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eXiFuGEYL063RlTNRT8iWSBcS71jHHw57uP7Nz7aM7Y=; b=hxjXg+BOawFwbRG2lWLovBhOx
        cIAa0I1+FdkQABM44HnsXNhnfU9MNj39+hrvGUBqE5rO1i7VitYo5PHZC5rtruqvw94+DjZiFvNQ5
        9mQQAPXa4PboR5sEWIEePISubuWrZEwImRuH44Upk4OJt3WP8UW/HTAczC0Plm0Mv5vxg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRbsx-0008Ts-Lp; Tue, 27 Nov 2018 11:50:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4D1041125056; Tue, 27 Nov 2018 11:50:35 +0000 (GMT)
Date:   Tue, 27 Nov 2018 11:50:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Grant Grundler <grundler@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Message-ID: <20181127115035.GB3206@sirena.org.uk>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
X-Cookie: This end up.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 06:46:05PM +0000, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---

This really needs a changelog to explain what is going on here, and we
need some more documentation in the code.  It is *extremely* unusual to
have to poll for reset like this, and if the failure mode is I/O errors
that's going to be pretty painful.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv9L4oACgkQJNaLcl1U
h9A9dAf/YNgemguFt+88Dci5UTRiy8trzQVPKNreg51M7R/0pOnk/fyAC76I3xUj
F545w42n+Crp2QiRzn8ONI3Vn4ycdTS9LaUI4jNmubYLQ3cYODGHPREvciFEmpqH
cPoCmhPytfuIwf22bUdMgL2BI13WQDSpJJwskYjz66wcu1HRlZyGLUq7Lk2p+nrR
gr1Rq+2yCCZiUzTs5eEvEwNP07ePngofy7gMNVeuSWzdiT9fBRPEio0rs8+VXvwr
rm+btK3IOGcB6Yc/weV1djHZbxDo6fUhiDS90gSb99sE0J+RX/vhXsjHL+LtYxqJ
wWkk7OOlNy9WknhGx6wmXEnhStRK/A==
=5YXq
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
