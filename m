Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4F8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1922087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546963758;
	bh=kuBFK2Lf8yRXyBcfrod7LIzuGn/sTfKQqVaG3QprrsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CrEvGeK0XeDwa5HN6ZSO1N4ULCRUROOrCvTt/UsPBwAPCs7b4T6kJPrHGsTYCJUlC
	 K7TlvVEE+c5HxvoJc7UAUUkifR6BFPixsGyaLoEN+zokcypVJ+/R2uyHtsIc6h4LOt
	 KAk+Kn8cRmPutXjTXf8z6Ui3rEYMS648SXe5R/Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfAHQJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:09:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57554 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfAHQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kuBFK2Lf8yRXyBcfrod7LIzuGn/sTfKQqVaG3QprrsY=; b=fd5vSs2+nPEEAQ4WdznmrfEBt
        InWCIExCcHWAUMAqZ/LR3tJEo4cXe0xb0gf1AjCecPa+NVRLHYfs1qnZXR92OEFwxdYK0gKTdipeV
        4V6fmZ/GjVi21leVZO7otYm/QuEXW2XqYIUn/51tNWKr/vNFCec+m4MycdSJsHM469Q8A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggtw4-0003Mc-PT; Tue, 08 Jan 2019 16:09:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 44FBD112778C; Tue,  8 Jan 2019 16:09:00 +0000 (GMT)
Date:   Tue, 8 Jan 2019 16:09:00 +0000
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
Message-ID: <20190108160900.GF6590@sirena.org.uk>
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
 <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
 <20181218174040.k7u26vnnoplllnwb@camel2.lan>
 <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
 <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
 <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 08, 2019 at 03:48:27PM +0000, Jon Hunter wrote:

> > Yes so this does workaround the problem. However, per my previous
> > comments, I would like to explore whether it is necessary to allocate
> > the platform link component or if it can be static.

> To be specific, the following also works ...

Thanks for working on this, that looks nice and simple - can you send
it as a real patch please (not reviewed properly yet but...)?

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw0yxsACgkQJNaLcl1U
h9Cnzgf+KQMt92KspZtvuefSfnyBMKF98VT6HZE9W2VwQ1GxX1vn4JA8SW5fGEJM
2Z4eIuTofVD8SPjTYCCZhTwJOVQBfykNA/6uvEsV22OxFJb7PGmq3wMj0yKA/NvC
64WqlQYtK+iOVPrQK8S2zfEse9pJT7FSciV+ayBDE3AxmwdgYe41C5bPbnkxul6k
/T83CiCkDwesrT+qG9wPFHvEDDEdF45qMuOP6pQc/mDg8kw9SKWGNaaIWfu7a8vD
CfpB5bBKfUVX/yqHVMaa5xrJu8zzH9NKCrWqRAORH55n7lb8x9GkXbzJrunV0Qrc
5MWp1KbEaMIDtFvGuohuUTVXOz8VFA==
=HgqX
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
