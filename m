Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF39C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18001205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586449;
	bh=FwXrjOGPHFQQI27pGA9oCfi/5DfsZjGGTvC4O1PucD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZyYENaoKZejdj3ZePSMY66YKsRy5/3OY3kxmVdmGjauH+HvNqjcdbgJ1ClFGqNVrR
	 FIbPV5QvIfHm19bHf/7eevVJvasB6e59/OtBdfpPHJ/VQ7z9hj9YVPE48x/IfMHM0J
	 yPF+udQR/TKROjTPfJbeZBb/keEdSNrpDemai2F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbfAOVH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:07:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfAOVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=niDBY0nIMb7v02CoXRusjFx7uJv7DZKQdNKm0laZBKI=; b=gJYhxsZdF5TljzXI9Oua1S4t2
        nYptV03cVFzeNYwovvwSZ5h2WnnQ7fuMR/RuMLrMhOM3S6PLLkiBOMcpYZ/WMyT3zvvat5Zgz8ewH
        BluVo9r2AjGDM6GG3kjirqvTkPYp4oQqFvuXKlb2T6tDRgdBcHO09ZfkUECHHbMjIGyBE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjVvZ-00030g-2p; Tue, 15 Jan 2019 21:07:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 62BA81127848; Tue, 15 Jan 2019 21:07:16 +0000 (GMT)
Date:   Tue, 15 Jan 2019 21:07:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190115210716.GI5522@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline
In-Reply-To: <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 01:35:07PM -0600, Pierre-Louis Bossart wrote:
> On 1/14/19 6:06 PM, Mark Brown wrote:

> > just pushing the breakage around rather than fixing it.  Can someone
> > with an x86 system take a look and confirm exactly what's going on with
> > binding these cards please?

> Beyond the fact that the platform_name seems to be totally useless,
> additional tests show that the patch ('ASoC: soc-core: defer card probe
> until all component is added to list') adds a new restriction which
> contradicts existing error checks.

Yes...  I'd been coming to the conclusion that it was a huge red herring
here. =20

> So if we want to be consistent, the new code should be something like:

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b680c673c553..2791da9417f8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1154,7 +1154,7 @@ static int soc_init_dai_link(struct snd_soc_card
> *card,
> =A0=A0=A0=A0=A0=A0=A0=A0 * Defer card registartion if cpu dai component i=
s not added to
> =A0=A0=A0=A0=A0=A0=A0=A0 * component list.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0 if (!soc_find_component(link->cpu_of_node, link->cpu_=
name))
> +=A0=A0=A0=A0=A0=A0 if (!link->cpu_dai_name && !soc_find_component(link->=
cpu_of_node,
> link->cpu_name))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EPROBE_DEFER;
>=20
> =A0=A0=A0=A0=A0=A0=A0 /*

> or try to call soc_find_component with both cpu_name or cpu_dai_name, if
> this makes sense?

I think calling _find_component() makes more sense here as it will do
the check it's actually there thing no matter how the link is
identified.  Assuming that does resolve the issue do you want to make a
patch given that you got there first?

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+S4MACgkQJNaLcl1U
h9BEmgf/StSJlLNq7xDriTlZVfHoP1uS7tq7ARPUsYy5hv82x0djcFHMfKwaaSF8
S0F7dCRPSko+Qn9l47VSnfC5d4u59YdEdfRJM+yktKgojY2EribB9Y7XldhNJRO1
FMnnMdPZWFHFMcGgs88h5xo/N7pr1lBvPcbksbXaSIAGead6WrrD8DTecYu8V+Kb
UEv2MEOmtSv+GJo+QT4Gi/NiKoaCn183hgulOkQSmkMLXGaBQedOSvxOt4fUvYKb
GIvJihjl7zjOohlf85V0l4wXVy0qKZm7szCz037yfiXWMPzr2Fo1sm0ZoGXd4BsJ
2JEQbrNH1hlj/8Jv6J1lZhVPScktHw==
=gEjB
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
