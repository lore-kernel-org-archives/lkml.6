Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD60CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975EB2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546877124;
	bh=XppA6qeEp0FE0Recg7XWyg/lSkKBRPtqjwsZpwc6WJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UNqQ0o0IJDxMCerXhiDvmNDBKwt/ImbN1t1z7RI4rkj5vULCvqcx5o466HOgXReRz
	 JVkVcSLYUAP6XlIjnm6Wkc6nQCxumfGU0TEsainKpoeInGsFL15WY6q97VPSN1lc7O
	 V+QV8LHRTIPQRa8xvtj91g1gioCf8Gsd/0X2joV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfAGQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:05:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfAGQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BHk6pAZ7AMOKZ56193m8j6RY+PTuUr5Vo0v1AKwGtgg=; b=qNenDot8oDTTrMwJLKPBrV8o7
        W8HVvvK1iGHe9Uo77s6pVFsvK+owHcLm8PAbw8kkjDQIGBQfw9WAHgNVXIhmtGmlVbWXhQFKiP5ko
        kJnTJieqce7qgv1p8c4UynVOYIJzlTOOUkU00Os9wBu24Owe8v81P/zeotkJYV++SxB6I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggXOd-0007RZ-SS; Mon, 07 Jan 2019 16:04:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5BE1F1127491; Mon,  7 Jan 2019 16:04:59 +0000 (GMT)
Date:   Mon, 7 Jan 2019 16:04:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5663: Fix error handling of
 device_property_read_u32_array
Message-ID: <20190107160459.GI9570@sirena.org.uk>
References: <20190105134427.1022-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Content-Disposition: inline
In-Reply-To: <20190105134427.1022-1-pakki001@umn.edu>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 05, 2019 at 07:44:27AM -0600, Aditya Pakki wrote:

>  		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
> -		device_property_read_u32_array(dev,
> +		return device_property_read_u32_array(dev,
>  			"realtek,impedance_sensing_table",
>  			(u32 *)rt5663->imp_table, table_size);

This is going to silently fail without giving any indication of what's
wrong which isn't great - it's not clear that completely failing to load
the driver is the best option here, and even if it is we should probably
tell the user what went wrong.

We're also not checking the result of the memory allocation...

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzeKoACgkQJNaLcl1U
h9BOCwf9FphVz+v+WezrJsnnKtKAX73L3q+F+LoFQ0sxXwzvHm15Q7+tUGL/75dL
NCYxGPw4LoGf/kZWUhhIX9dII37aIjsez8ss8KiLu6LP/+28oJDwqX7yT/SoIay0
ocmTlngVqm5ceU1j4lJl/8Irr7zCOJfZ63ZrfEUQ+FfX6Uoy1tdiIkHt+Cx2jsbm
erayQMF4JnKC3htgSP7eN80YuLKi6n2FXPQlETfNcQVgbpLXaOI7gFE+cGkvk6xv
+5fn5EuQJ/hmUP2NIkHEtJULV315KSc7Pg06UVNJ0DsEu0Zn6v9J4AwlXSIsT9Os
LZOkQe3w6jfF5yeejCKGFPzBIMLzlA==
=Do7P
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--
