Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D419720657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547588509;
	bh=8i0Xe+biG0HE+zFm5Zqi7dMiFkH/96I50bOT0ks4Ts0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NheT0kCL2W6x/LLcRmS06wu7n/ijoQEWBUj1bZ+1BdmOxMIZ/smtp2wzk5MEDGMNZ
	 YlHKz4N6/w6AsetT31kQMmNJupPcKinbxEDTMIkyIsTTbBoxquYXhyICXMONNZMYtx
	 awkkKsLqMnc6MfSMGBVvDks/wa4kM8RKyaV8YvRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbfAOVls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:41:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfAOVlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tzG7x5dUDPPpFgNczCyMEm9pQeYaBaF6Sv7l5pfgrJs=; b=ktldLd9YCO3BCQ8PSLHMj2FqY
        IKM2XeIFxRQ31gbtOtCb5z3TwqxZj+I9QKBINOcID6lhh0O4B8TOJTTg6UjLSS5T8GGuOKf6dwyn1
        xa7oVtsqbPIp/OUabsyDzuk2vt7VYxcH5oEyPLoiy6Zng8OQjGe9kQyPoI0ZTXbgDZJbQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjWSo-0003CK-LI; Tue, 15 Jan 2019 21:41:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1D3DE1127532; Tue, 15 Jan 2019 21:41:38 +0000 (GMT)
Date:   Tue, 15 Jan 2019 21:41:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Matthias Reichl <hias@horus.com>, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190115214138.GL5522@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 03:16:57PM -0600, Pierre-Louis Bossart wrote:

> > Maybe the defer card probe logic needs to be extended to also check if
> > dai_link_name had already been registered (either cpu or cpu_dai_name
> > needs to be set), not 100% sure which problem the defer card probe patch
> > was trying to solve.

We were getting cards probing without the platforms being registered
(which in turn meant we were just skipping their init) and had patches
proposed to implement the deferral in the cards.  The deferral stuff is
supposed to making sure that everything is registered when we
instantiate.

> same here, I don't get why the deferred probe stuff only deals with one of
> the two options.

I think it's just an oversight - I think the change you were proposing
to check the cpu_dai_name is a good idea anyway as it makes things more
consistent and work more obviously by intention.  And more generally if
we can simplify the code by removing legacy options that'd be good but
that's a bigger bit of work...

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+U5EACgkQJNaLcl1U
h9B4Twf+IDkkxRFHywZyz/i5Uiq5yHfvR6SLLsoeMHo9aLX1z5Pm5mPIcw7nMe4M
xasbMImcQ172jVp+k9YySyZqHBKGqI4y72nU66WjCUEmAD3/080+eJu3SUFBBVVM
jbXeumfwTC0MfQ2QipJsIe4+7a2FvdTSzh8RGvBAErtF7GLC5I7i5vidE9iR/aKU
TJWNU0mB+rrnhDVZDAAtotZj4314oxG7HpL/9eMj+Vdv41j45sh0ALd2CU1ijymM
xTi7dXLT2R96+FVkl91u+HgoIcxrbaLxx5HFCMUjipLiXDjHdh50Qpi26C3rvzYq
tXa/Py+LY/FMSUAWgkR4TjbbpkP32w==
=IKZV
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
