Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C8AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ACE20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YjtaoIyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ACE20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeK1UvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:51:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1UvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=srswvCIjne1WAGaMQsf0zqYTzkY8Lq3WPS0zgIbkUFo=; b=YjtaoIyHBzLmNYZwjm3kR0eVw
        ntOwi4ylEHNiBa7H6vXOVpvEOTmtLpWpfj6BYuXDcwKFFmnqJi/leuyihRWOOzPJDCJji5+x06MiK
        xSVK6ofrH6LlmWnSvqOcq5HgmJphm7MDTgm3ULZ8qQhouVupsr/7Q70OuVY5x90PJ3VT0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRwTk-0004h8-0N; Wed, 28 Nov 2018 09:49:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BAD191125055; Wed, 28 Nov 2018 09:49:55 +0000 (GMT)
Date:   Wed, 28 Nov 2018 09:49:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Grant Grundler <grundler@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Message-ID: <20181128094955.GG6828@sirena.org.uk>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
X-Cookie: I had pancake makeup for brunch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2018 at 03:20:16AM +0000, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---

Not seeing a changelog here like I asked for :(

> Changes : Created max98373_reset function to minimize code duplication.
>           Changed regmap_write to regmap_update_bits. Other bits except LSB need to be masked.
>           Added reset verification step to make sure software reset is completed well. Software reset is done in 10ms in normal case.
>           Revision ID is available when the amp is in the idle state which means software reset is completed.
>           Software reset will be performed maximum 3 times to avoid amp reset failure. Generally it is done in the first trial.
>           sleep time after software reset is increased + 30ms for every retrial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).

This looks like it's supposed to be a changelog but it isn't one?

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+ZMIACgkQJNaLcl1U
h9BPnQf/c8ks2E8UVNO4yepGn9jIDQYg3qVpxKroJ5lilKjrSlrkErdUESolRMj4
dp+1KqWdPQJBYFRJvpy4xihm/wgCLUBh2PIslqhT4xRDX4E6dXyjvG8mNyzDPFXs
QuQZULSPfcYYy4KjeT4zvZO5pbKFp78Zrh/dXmq5xjNsgeMJUmstBjsghHImX3BL
JV8YHSHw00hXyd+jqMKe9bmmhFmw5/fbO7ZmxnYnH944J5bVuDyvsHWmpesjjp8R
v5Q4gV1n0cV9+jQABul4qe9ruZqtaAjZhlgXmuTo/Fb21KA4pv4YCpt/6a9AXIed
gcSyEF+KwN18VAbCWw9T0j9olkUVjg==
=VVqX
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
