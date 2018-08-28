Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D5AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EAD2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OFs/5/rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EAD2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH1Xvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:51:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42766 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeH1Xvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zjBO0THqz1IKcUV7zmXYUbNn8wzAJRdEqXGUdJb/poU=; b=OFs/5/rf4FuAAvjpHACqfV7Sf
        4zKKjUfDN7AEMHneUUf7Z8Oi7T3JCuezjjDiGQlw+DrrjkOgi8QHzUgDQeW0IcTu/klTxZkorV5Vb
        RJvmzV565OQlj48ByGnAaDBSJ/jcjI7vt60CIT6bJQZkxo1GgCVh1uRzsYjUIkUyYBWLM=;
Received: from 94.197.120.143.threembb.co.uk ([94.197.120.143] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuk86-0007eo-0B; Tue, 28 Aug 2018 19:58:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 62C24440078; Tue, 28 Aug 2018 20:40:45 +0100 (BST)
Date:   Tue, 28 Aug 2018 20:40:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ASoC: pcm3060: Add codec driver
Message-ID: <20180828194045.GQ2414@sirena.org.uk>
References: <20180821165246.9479-1-kmarinushkin@birdec.tech>
 <20180821165246.9479-2-kmarinushkin@birdec.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZXg5XZblsOcYBG3r"
Content-Disposition: inline
In-Reply-To: <20180821165246.9479-2-kmarinushkin@birdec.tech>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZXg5XZblsOcYBG3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2018 at 06:52:46PM +0200, Kirill Marinushkin wrote:

This looks good apart from a few small stylistic things so I'll apply,
please send followup patches fixing these:

> +++ b/sound/soc/codecs/pcm3060-i2c.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCM3060 I2C driver

Please make the entire comment a C++ one, it makes this look more
intentional.

> +	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);

Please rewrite this as a normal if statement to improve legibility,
there's some other ternery operator abuse in here.

--ZXg5XZblsOcYBG3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFpTwACgkQJNaLcl1U
h9Bqrwf/VVAlTVTQQ9LMt6IWYuumhMu4EROxafwtcf2gyFjOQ1jK3la4FgIHTfIB
XiEJxv0Mc5rA4vot9saBSK/WgFT8iswPV5lm4nDOOnXwPmU+JVUsL/S0fnEFCA8X
xvUm0vBkNPcLrqvJs2HknKDnuf6BPCCbeovFOulsO/mO+/2t5lDgwiXuYs6aBOwT
yTv+uOfBI5XkIoPpyh+AA2m2/i59QWcJn+0JR45L+2o9ndMF82kqCsPmyY24lQM3
1J9Yd83MXisiVU7MJ+c74yr2b71SdkHZpLV6zBsTaiXgNMqhc4gan9omaVrqMShD
sPSS2p6SBk+fpq8fDMzA8Vlw0iOD+A==
=PyJX
-----END PGP SIGNATURE-----

--ZXg5XZblsOcYBG3r--
