Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F357C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3220206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547043293;
	bh=D1F4L/xoHiYXuEHbB+jmB0uZHHtvpwnGM9DIfLHRJpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vHHReiQW796DfudtNSmoWOsV1HVYgHuSvqCoPt4r8lvEd1UCxrHQzoAkbEq0an9TX
	 PfZnOVv6ngPFADnQofplSlxBYjKDp4cFrwNXVF5QGtffPKU0n/5w7c1ZP3ZGUDGr2Y
	 /X+axvPHzIMSs55fGp08YArNyUkBSFZklH3pxHCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfAIOOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbfAIOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D1F4L/xoHiYXuEHbB+jmB0uZHHtvpwnGM9DIfLHRJpY=; b=CzU+RzIazmCSIIOPGXefv5sfX
        TPWvZ/CmxQIyo2UbQ3PusfaGcNUdA8vQ1NrPpMxKDtHJMdvUdTTLuD67jrhYpZxrwfDzr4DuIjExo
        u6STvW/j4xT5rgsRiLqQYBQqhLQbmZ4iHAYhHMxI+IpxnUX+b/8yiFLs/WpmAhfzhlnXo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghEcx-00089R-LE; Wed, 09 Jan 2019 14:14:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 30C621127528; Wed,  9 Jan 2019 14:14:39 +0000 (GMT)
Date:   Wed, 9 Jan 2019 14:14:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra@vger.kernel.org, Matthias Reichl <hias@horus.com>,
        alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name
 vs. of_node assignement
Message-ID: <20190109141439.GE10405@sirena.org.uk>
References: <20181218174040.k7u26vnnoplllnwb@camel2.lan>
 <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
 <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
 <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
 <87k1je38w7.wl-kuninori.morimoto.gx@renesas.com>
 <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
 <20190109125340.GD10405@sirena.org.uk>
 <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 09, 2019 at 02:11:58PM +0000, Jon Hunter wrote:
> On 09/01/2019 12:53, Mark Brown wrote:

> >> Yes that is an alternative and I can convert all the Tegra machine
> >> drivers to use this now. However, that will not solve the problem for
> >> non-Tegra devices and everyone will have to do this.

> > We're going to have to go through another round of conversions that
> > touch everything at some point no matter what :/

> Do you have a preference here? Do you think that we can fix-up the
> soc-core or should I go ahead and migrate the Tegra machine driver to
> workaround this issue now?

We're going to need to migrate Tegra regardless so it'd be good to do
that whatever happens, I'm intending to try to properly review the patch
today.

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2Ac4ACgkQJNaLcl1U
h9AjYgf9EvgU+L0fi5qtHIdBZBOJEXt8zxHplyCjLWZSQvJ9ZasVIZWn40mjttXT
JZ1PnMRftcHZ9OB3LEFRLVI27coE+bc9tAECVuWpIYsSih4pdLaFxz7RjlPnucwq
yd7ERUKkF8Z5dmqo+JaKoa3nzPsCynsBRN6ETD3u2zIDFbcYeA9Up0ImO/5G1TjD
jhkMDmZ/WqgRmF8IxnFQGYpNsW2n3GHr7Whbt75T/czieOw1/6DFBaxDc9JM3SKZ
8ac30r52eXFqtm6Pb1exD3MUEwblll1GeKZwA4BPiFSPsI8fM95rZ/J2Mli9WL04
xtSwIa0yvoHTkR6DgyqDu5dhfBTaUA==
=+KSw
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
