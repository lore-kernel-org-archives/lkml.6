Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3416C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE32080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aTpwl84j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CE32080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeJaB1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:27:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeJaB1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fWz6HrZ68bNUnNZpsN0wctLJUAmatCId4BX0HnC0y2k=; b=aTpwl84jSVjuFiK95OTYAiqCK
        EQRBkUlq9Coke7A1PUEiCgTfipPd4B04jHxgnpe9VHkcsxLivOd+EmE6DKd7zgG0MFcnE+ZjDEVgZ
        Cm8FiZKyjs3Kzkkrf+wB3q63HEs2nE4VFcl1bvTBkqLU3PEqD2ZB947amxuhse64rFzTE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gHWxD-0002eY-J4; Tue, 30 Oct 2018 16:33:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0FBAE1123997; Tue, 30 Oct 2018 16:33:19 +0000 (GMT)
Date:   Tue, 30 Oct 2018 16:33:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] ASoC: stm32: sai: fix invalid use of sizeof
 in stm32_sai_add_mclk_provider()
Message-ID: <20181030163319.GA6462@sirena.org.uk>
References: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
X-Cookie: Save yourself!  Reboot in 5 seconds!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 27, 2018 at 02:19:59AM +0000, Wei Yongjun wrote:
> sizeof() when applied to a pointer typed expression gives the
> size of the pointer, not that of the pointed data.

Someone else already sent a fix for this.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvYh84ACgkQJNaLcl1U
h9D2PAf8CQBR//hQIVawDMD9txVZHFp1FeTXTFRNmYHoG7e7Hukr3a2IEhRCBa4f
eM4kmf1UpVKD8V5kUPDKDllx9SGVxrxEeDPAQmu3detQ8vdWsS1p5+Q8fCvwbTsc
GuBk+IXKzFybzSqiu3tAf3DSPU9p0z+00mo4KmghbrwUAZuKAeu55KC32EEf85Cd
WDPAVGEQ9rUm+YcdNGidf604yjGQy0gB5DuwLpq+t5f41O1NscnLEeusM83if7Qh
fSpFccKSr+CN8yniLocbcRE/B2NUZymGfa7+ZMeqD+eU+G7fCHqQ1yBJH9OhpH/f
Swim64E6tY3M8WOeqe+ZLrLN/De0dw==
=Yi0e
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
