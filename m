Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA725B1C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="U1ojdEHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEA725B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965214AbeGBKMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:12:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964922AbeGBKMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6hZm04DwS5WbuqxLhwSqXXopzKDduqQ4yEw78tgy1NU=; b=U1ojdEHVWvTSsJv76+E9F3PaA
        XMj50SgW0gZWFIFU1eiWVey96t6UdRCJAvV7yeR1vZPIARC53OS+4LS9nRggFpVe7lKL3V0L0ht3Y
        mtNFHUtui9Dtj2Exk93qQMD0xswbcIJ2hNQVeSjfxGXR24X1oTNWq6/6j/7UVig/Qyh+s=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvok-00045Z-RH; Mon, 02 Jul 2018 10:12:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvok-0006lI-Db; Mon, 02 Jul 2018 11:12:22 +0100
Date:   Mon, 2 Jul 2018 11:12:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: es7241: add es7241 codec support
Message-ID: <20180702101222.GF18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
 <20180630172241.10806-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <20180630172241.10806-3-jbrunet@baylibre.com>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 30, 2018 at 07:22:41PM +0200, Jerome Brunet wrote:

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		break;

These two modes are not the same so either there should be some
different handling to select between them or one shouldn't be supported.

Otherwise this looks good.

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+oUACgkQJNaLcl1U
h9Aa8wf/dTruuIVc491yHsEFn7v66TTYBsqp6sndJaIy3KbCwH/KZfEc1KSKK3zf
0gpuiPdNgKAFibcp0x1sylNtY2E/HTWMcrf+2TolhWxO4C4yvS7Ih1qnuBqEmJKJ
VLllaBMWaO93hE9SfO7zUGDhqo47Tr0NT8vitatetYlun6S+uz04OrPrkc/M8a8+
SC3SfbdGAmdr73QRipZv6H5pGg0CoqgSHQwvV4EDPlsG+O34HKh7VXLWCN5bLOJp
77yzncpZbuDLtdpZMYflhmHQ4Z70+nkP0zowSDH603W3GQZEj/C6RQvjI5Ylr/DQ
g3Rh7X6OgTiG4pS+X0M43HC5aRkICA==
=M0sR
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
