Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E1A2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547213001;
	bh=fauU9BmTa2guWK74+k+wzLf3j2offcRpUgBRq1lsW7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=00NH697zka5Iod6KwttB3sRyiCtC8UN6rdmskXrT7U1FzT2ZMxhqnMI8JnOEIEANJ
	 OoTVfMY8m0+vCozoQSZM6+xvCFwN1wW5N8ANAJPR7kKW1acKMRSDD5rswORAP7dY5Q
	 OExZq2Sep0or+1k//4TmOAH6HjKMKc8XsEIBwnww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbfAKNXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:23:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57414 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbfAKNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k8Gfe8M9BsxW/XjVgP/77XDKcQYHMglXnBzD+tL+GYI=; b=ux3ySoYj+D2WJY+jiKlLNaRvL
        p08k2iW9VJnIMNq5tP8v5qYAeKFcVqlmi6vTL9L/mJ9F/qsw4vBPHfrAP1cuGJTXr9p/jaYT+RBEx
        sWGlREr8axm2F/q0l2gpGTc2ocmv8TZ+gCqKht8PZ8iksl8XqLjltDCYY2oajJsfE2BMU=;
Received: from 94.197.121.207.threembb.co.uk ([94.197.121.207] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghwm8-0008OU-LP; Fri, 11 Jan 2019 13:23:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1F42F440085; Fri, 11 Jan 2019 13:23:03 +0000 (GMT)
Date:   Fri, 11 Jan 2019 13:23:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Marcel Ziswiler <marcel@ziswiler.com>,
        Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: core: Fix deferral of machine drivers
Message-ID: <20190111132303.GC2804@sirena.org.uk>
References: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
 <20190109183605.GH10405@sirena.org.uk>
 <44a64e6e-c9ec-8eba-60fe-eda092250d82@nvidia.com>
 <20190110164835.GF9541@sirena.org.uk>
 <96f2e729-8ec2-44ee-448c-255c07c068b9@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <96f2e729-8ec2-44ee-448c-255c07c068b9@nvidia.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2019 at 08:43:24AM +0000, Jon Hunter wrote:
> On 10/01/2019 16:48, Mark Brown wrote:

> > I'd need to find your patch again and fix the rebase issue.  It was
> > assigning a pointer to a platform IIRC.

> Sorry I still don't see it. Happen to recall the config you were using
> to build? I tried enabling the various SH soundcards (which I believe
> the SCU card is under).

Configure all SND, MFD, REGULATOR and SPI symbols y on top of a base
config which is:

CONFIG_COMPILE_TEST=y
CONFIG_OF=y
CONFIG_I2C=y
CONFIG_SPI=y
CONFIG_REGULATOR=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_ALL_CODECS=y
CONFIG_SPMI=y
CONFIG_DEBUG_FS=y

(I should add ACPI to that too now I think about it) merged with
defconfig.  I was reproducing on x86.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw4mLYACgkQJNaLcl1U
h9Bsmgf/VrAb5Y8CM9kh57w7bWVNWma09eAzafZhXLEn67IHp7wVlo2Tf1hn7o5H
r6SzNs11sE8BT5cpgbC8q69sUKkBWOYeYTuu39B8tzuZZn2pDsZ+7dDCX8aO9foe
Xrq7VUNfMvmQAV+vZ1sa5LK2Qw0BPnjLj0U0RmKcefODPOmwRExGbnBvbkX/UVdq
5bNef1Hc7TF0M8W4sEJ4/f2gNxR8Br4Z4PWt4AwNGVt+9IgxRBDH8Pa2MvsVD3L4
A8SriEM0XwZUcVt4iv5HaWNIdr/qyh7z0KM1ig/dcPPktDpUJgW+mQcxx5mESjz4
qwfz6nppU+e9TWS3E+Mx+XPKVQpfJA==
=vUzz
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
