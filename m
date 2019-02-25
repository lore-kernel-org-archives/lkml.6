Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF9420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551113040;
	bh=dmDa4hjdTyJ3cwpHE/yB1uf3ccul33vNiXBOtTCLq1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2bqNxLRK8hJ6ERU7+3Z1Rlmx//NKRQPO9Qs31QdlmgkiGmzB4Y7GbHEjXYLcBJCa
	 sfkERoz+bHpw8QvP76t1f7KM19r/eGDl1w1HUBj634mEaNJJ01Sp66bxY/UpAARVrF
	 nbQmrI2vGR/mtrCLJ1cJdGzG4Apc5OQBj9s41Yik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfBYQn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:43:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53994 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfBYQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hacV0sTgo2NlE8e9KW4cAwSSE6koFNedrMuPncKYH30=; b=YA8LaTss15cGKciPIRa9s6SFG
        uK4+iLlQGwgKcibCBbtGEClRQfCRx0tta7r3CnqP+vKBkS4aLgJsGSKA/nISTSDOYwjGmoedC3SAC
        BnbOoMlxawRZM2vbQjoeiGDfPEtMUbMSiyQyfVzpHTLc9HelOjm2RkjiuZAwKjx8JtCok=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyJLv-0003J9-JB; Mon, 25 Feb 2019 16:43:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0624E1128354; Mon, 25 Feb 2019 16:43:39 +0000 (GMT)
Date:   Mon, 25 Feb 2019 16:43:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sameer Pujar <spujar@nvidia.com>, Takashi Iwai <tiwai@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
Message-ID: <20190225164338.GB13898@sirena.org.uk>
References: <20190225123615.49bce7cd@canb.auug.org.au>
 <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
 <s5hr2bw2k7m.wl-tiwai@suse.de>
 <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
 <CAK8P3a2Q7OAAYCU01TNpHR2SM7N=YunyqZEihSESnQwxzL5=Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Q7OAAYCU01TNpHR2SM7N=YunyqZEihSESnQwxzL5=Vg@mail.gmail.com>
X-Cookie: Neil Armstrong tripped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2019 at 02:38:50PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 25, 2019 at 12:24 PM Sameer Pujar <spujar@nvidia.com> wrote:

> > The motivation for adding custom sound card name is following,
> > 1. When for boards, multiple HDMI/DP ports are exposed, it is sometimes
> >     necessary to know the default port or any customization for that matter.
> >     Audio userspace can distinguish based on the sound card names.
> > 2. Multiple sound cards can coexist for a platform, the indication of
> > particular
> >     audio path is useful.
> > 3. It can help to customize audio paths.
> >     Generally people use "*,model" property in DT to name the sound complex.
> >     Ex: "samsung,model" [sound/soc/samsung/snow.c]
> >         "rockchip,model" [sound/soc/rockchip/rockchip_rt5645.c]

It's also useful since sound cards can be electically identical but
prefer different configuration due to the plastics (eg, a smaller
speaker was fitted, different outputs have different labels or playing
the speaker at full volume causes some models to have unpleasant effects
while others handle it fine).

> My impression here is that the idea of passing a model name
> through DT is well established, but for new stuff, we probably
> want to standardize on plain "model" rather than "$vendor,model".

Yes.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx0GzoACgkQJNaLcl1U
h9AoGwf/YtZFwMpwHz3bSYXmaNlmUCq3Uy7LDrDc/RlsJnUIPnIlqhk69mWJ/FjZ
LGyNQ2nJs1m+car7QLiPKFcuQRJ5eh6wtS2kYPm2jT3uiXlDPoU7t8gf7YDgiCsY
kOZC5vJ7j/nvITZx9qqlEZYprw0EIaxPsnn9PiKeQKET/yeSNvs1WF0SDrWjqPB0
drXMv47kVwY5rmPwB0NttbbMx6uXehd3Z2mcoO2/c4FvJpJXNTTLcUrfcm7EWJ+r
qCgbexpCZBQWyAJ9oGUG7O5tDyGAxwOQUzsyKEM8I+h+cZQmdP9qN2BomI0FH5uS
XXbspx4qWUnZFgawxDq+IbuZ0A2zvg==
=iv2n
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
