Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35943C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3965206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547038437;
	bh=Dv5QSL5046OU14WaDc5ngmggBjPB7be+g6ThooBnLCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CdrqAWY18GXojIcuNA9WNg21LfKbpMdrLGLMaejwifD+pLXqOwG3RT7pAFN9Vhlqi
	 Q5TzJ2+VfO1Y8LQYW0af4HZIELvhZjkXR/Qf5aA03IA28PSHK6U0rXDmdD9dIEqZza
	 NdAuTNS9k3voPTq9hAa3Fo8USZpnk2TTeXM/JOzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfAIMxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:53:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57286 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfAIMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BcoIGHPMGUm3GN1U/z0BUReNVYNAlQdtFgQRREGBPw4=; b=Gb4kvTNS2Lg2rS9qFBm0p2WsM
        2PphZdvYdfwc/S+QAWRlrmBGqTfsErTrJRMS0DBW18pKtMZigQ44kBOMqOe+UKkA0GyViYu4A7lkG
        ah0iCjamLG9opkdbfxKRmvbskffvN71JK89UCp9kOcGUQVOBts3SzBXOA36k4mDJotUFc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghDMa-0007zr-JM; Wed, 09 Jan 2019 12:53:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 226F81127528; Wed,  9 Jan 2019 12:53:40 +0000 (GMT)
Date:   Wed, 9 Jan 2019 12:53:40 +0000
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
Message-ID: <20190109125340.GD10405@sirena.org.uk>
References: <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
 <20181218174040.k7u26vnnoplllnwb@camel2.lan>
 <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
 <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
 <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
 <87k1je38w7.wl-kuninori.morimoto.gx@renesas.com>
 <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 09, 2019 at 11:03:44AM +0000, Jon Hunter wrote:
> On 09/01/2019 01:51, Kuninori Morimoto wrote:

> > "multi platform" is no plan (?).

> I would like someone to explain what multi-platform means? Even if a
> soundcard supports multiple platforms, there is only one platform you
> are using at any time so ...

Platform in this case means DMA driver (for historical reasons I've
never entirely understood the DMA drivers got called the platform
drivers).  It is possible that a system might have multiple DMA
implementations in a single sound card but fortunately we don't seem to
run into that.

> > I want to which to modern style immediately and remove legacy style.
> > But as you know, we have too many ALSA SoC drivers now.
> > So, if I posted "switch legacy style to modern style" patch
> > for each (= for codec, for platform, for cpu), it will be patch-bomb,
> > and Lars-Petter/Mark don't like it.
> > Thus, I'm waiting "multi CPU" support patch.

> Sorry, I still don't understand the dependency on the multi CPU and why
> we need to wait.

I believe Morimoto-san's concern is to minimize the number of
refactorings of the drivers as that gets disruptive.  That's definitely
a valid concern but we can't postpone fixing bugs over releases, we need
things to work for people.

> > If CPU/Codec/Platform can be snd_soc_init_platform style,
> > then, we can switch to modern style for all drivers.
> > Then, all driver will have *static* platform.

> > # So, I guess if your driver can switch to use
> > # snd_soc_init_platform style directly, your problem can gone ?

> Yes that is an alternative and I can convert all the Tegra machine
> drivers to use this now. However, that will not solve the problem for
> non-Tegra devices and everyone will have to do this.

We're going to have to go through another round of conversions that
touch everything at some point no matter what :/

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw17tMACgkQJNaLcl1U
h9BKZwgAgiM09pC/S8pF3GuNtiVWeTFJvT4K9Ys03qD/pYCXjk4xmwhrfrvB736w
kvJwQz0WGCYh96IYskAJMAfMKh8jzneCBHswcVCM9IruT0bTDXZll0VpC+6W0N1F
yavk0QNgg8hWkQ61EMP1XQy3gS++DIoljTsNGT/7B87ikf/O3g+vA8e/tzrrxp9U
CQt5cQH9lRfkHS6LGKZxGnuFnadmk+pRushWhfWeDRIQZESV4r4Wf8hb73d9SUJA
B5ffkYQJmR9Ae39eQDVXEw0duXk/z3SChCfyKdh19yEpEKfan+9JATb8XDlVTFpE
W6BCTdiNcQtc+3gfAjTTD9MOE56JBw==
=zUC8
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
