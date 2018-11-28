Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC92208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UDw5tku/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC92208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeK2DYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:24:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37580 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeK2DYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+37/QIRXjv4NIee5gBXGDuXrFmx92seresqS5VI3v1U=; b=UDw5tku/3fQmzG7XN26uSlVQ4
        x82EvWy7+wom0ChfHpEtOyXEGY6q9NyZeob9tQlu+23FOZOUjvyc3bn5nAtTP8XixjHmuxqLrRBhJ
        zzW/WGpNlh/yilfaAZmZZK9Q1LOYZjGUWoIG2VTdpnreIoMLQzx5C4FbP2Txanwax5FRA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gS2bL-000616-M8; Wed, 28 Nov 2018 16:22:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1FF1C112521B; Wed, 28 Nov 2018 16:22:11 +0000 (GMT)
Date:   Wed, 28 Nov 2018 16:22:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     jiada_wang@mentor.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: pcm3168a: Don't disable pcm3168a when
 CONFIG_PM defined
Message-ID: <20181128162211.GL6828@sirena.org.uk>
References: <20181128122612.17820-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wA9WyeW1yVBM2Q32"
Content-Disposition: inline
In-Reply-To: <20181128122612.17820-1-jiada_wang@mentor.com>
X-Cookie: I had pancake makeup for brunch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wA9WyeW1yVBM2Q32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 09:26:12PM +0900, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
>=20
> pcm3168 codec support runtime_[resume|suspend], whenever it
> is not active, it enters suspend mode, and it's clock and regulators
> will be disabled. so there is no need to disable them again in
> remove callback.  Otherwise we got following kernel warnings,
> when unload pcm3168a driver
>=20
> [  222.257514] unbalanced disables for amp-en-regulator
> [  222.262526] ------------[ cut here ]------------
> [  222.267158] WARNING: CPU: 0 PID: 2423 at drivers/regulator/core.c:2264=
 _regulator_disable+0x28/0x108
> [  222.276291] Modules linked in:
> [  222.279343]  snd_soc_pcm3168a_i2c(-)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--wA9WyeW1yVBM2Q32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+wLIACgkQJNaLcl1U
h9AE6wf/fUj43xe+OXVuc4QSIiRt0payrWXBKKvyj+KhVPvnLZF1dKaQdhV9bejr
TMx+Kdxj3ZpkL/UBmJHgL5XeveqVz9qHKVfYSe2bYqYUKWznEcyMGyRcSAuoTeAr
+dhvGr0OUuEaQX0zUr2N1H4az3tUmsXBSR+qVZGfOREe58NFFAflD/Q14ODAa7tp
9NxsbhmubVVPAMuv2vO6ez4nUOj14lh4Dml6xDKOCohTjTTYxl6BcrGV9E7SZNa0
IyU1fMkAzDIzRXcjzcGYN4hdi+q5vdPDYaTn7mzt3ZGcndiLMb5Rla4l/SuUAngm
xO8COaqgn8H8ZLJCniula7hdxCQiUQ==
=gA+C
-----END PGP SIGNATURE-----

--wA9WyeW1yVBM2Q32--
