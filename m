Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871A520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547580444;
	bh=VICQ99r8uQY6h48INX+VWHhDZwavdNFCJGPHOs53kBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9SGnYrLogA5a5/XfNu0xaA/NAtjHBwrAfwY0lq2xn04D9tRHDPZ2eT+ponQv8nMr
	 4sgVLBzjau7JG+w0Y+4HAcy32iQ4ADXqo3/sdpo8bSN5SpAgZwd4RcMfhiF5khKKGe
	 s0EMShtXXMBwxFFOW9YDftadHW7Jwtw3Oh4sIVGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfAOT1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:27:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rxNP1q8+fbj2Rfo5AJpAyB+dKT5q/pWZSAwzdx78u1g=; b=gHDiQz3v2jnvuHB5ynTAKDtT3
        oKUfhczQDajHuIH2vN7KjnttnvgbX9gWL6+ycczfLCLav3cahc+LSDe4Rut3krt7eV3l2MCT8juj0
        6Jto+mjK/SYhUxws2LJGvG/5ZYG410GnggvZW5hyttPh37Af/LExhyf0kIzgTeu912+jk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjUMn-0002MG-8l; Tue, 15 Jan 2019 19:27:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D847C1127848; Tue, 15 Jan 2019 19:27:16 +0000 (GMT)
Date:   Tue, 15 Jan 2019 19:27:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Martin Sperl <kernel@martin.sperl.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190115192716.GH5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <20190115151009.GC5522@sirena.org.uk>
 <313fc9d6-a142-91c2-8868-188bc70c019f@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <313fc9d6-a142-91c2-8868-188bc70c019f@nvidia.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 04:09:14PM +0000, Jon Hunter wrote:
> On 15/01/2019 15:10, Mark Brown wrote:
> > On Tue, Jan 15, 2019 at 02:26:02PM +0000, Jon Hunter wrote:

> > Right, I think with the current code we just shouldn't be checking for
> > busy in teardown, since there's now a fairly big delay between idle and
> > actually turning the hardware off the name is just super misleading and
> > the logic confused.  I don't have time to test right now but does
> > something like the below which changes it to a flag for the hardware
> > being powered up work:

> I tried your change but the same problem still persists.

OK, I feared as much with the stats not showing any activity.  I do
think it needs a cleanup still but probably won't help here.

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+NBQACgkQJNaLcl1U
h9AjPwf/aq7uDvdaZWuPtnn04wHdQBQ6qt2pWHW9rQkd3gzm2K6t7I/K5bskpW6+
2D2brkBj9WluGaMbnUW1bzCc8Pfgeesifrb0vy0rjP8m+lMcFboCjjOYB0tloefp
17opY7PqAnk8476IFv7Am3g+InAoOhr3DdXDx2ETPRBCHDhTEd4wiHEVLG5+qkke
XGmjBKS1JHkhRT9TVvkiploszqO04E8Ff26T8hAgePEog8R7N0WoetrPsrwq1YAk
rn3YQcSLARLHkeLorTqM5C+49FKbj5JRtgNp6cNeo5WwZbSge0Kr470cCj4iTAS2
4mvqCuNjma2OumepNnm/EJuaMOgMtw==
=YvPD
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
