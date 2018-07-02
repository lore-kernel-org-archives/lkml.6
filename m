Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B519325210
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ie1KOPhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B519325210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933966AbeGBKEQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:04:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933467AbeGBKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LS/Gs/1YPH4Bk3R6fH1HXxsqg9SjR0d/v9e6S5EKFaQ=; b=ie1KOPhWbfg026FpcLSK+53dw
        fY87d4i0P/RInqbSAeKX3IujEyHUJbrvfKLfXryCuIgIHhSPO0upaEFNii3qMpoY5jM1pLxgqlmlq
        oAaHIkNBvcb1VSuKC+YMB/doyjfd4VBAw0vQRSO3EN1MuDEbwGDE/yiAyhTUVe1I49BuE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvgr-00042G-41; Mon, 02 Jul 2018 10:04:13 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvgq-00067P-Mw; Mon, 02 Jul 2018 11:04:12 +0100
Date:   Mon, 2 Jul 2018 11:04:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: es7134: update DT binding with new compatible
 and supplies
Message-ID: <20180702100412.GC18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
 <20180629150924.18197-4-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <20180629150924.18197-4-jbrunet@baylibre.com>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2018 at 05:09:22PM +0200, Jerome Brunet wrote:
> Update the documentation to add support for the es7154 and
> optional power supplies phandles.

> +Optional properties:
> +- VDD-supply: regulator phandle for the VDD supply
> +- AVDD-supply: regulator phandle for the AVDD supply

Unless the device is able to work with a power supply missing (which
doesn't seem entirely credible) supply properties should never be
optional.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+JsACgkQJNaLcl1U
h9A6tQf/RMJFE/F2+O/Iq2z9XKnOKwVPp79wd62sg300HvCYFtp40j26jpCkqwdl
q4oEgG5TOeXTCPkeqGgjouPmGn4EGuXxPss0ZOGilYt87ZIRpa/Z/9K4rEciQV/J
i0AFst7A987fnITAZ7dh7F+Qosl3DWB+qo+ad/SknWOrMwZ4gp/AFLfB8qCD5xYO
SkoJUr9S+MMokfQYAl7J5mV0mg1WvJkMZ7LLyLCFyDH7jTcRzY185HmhJ8q0odDy
K24uVioUI8bxhoF9U3zVnbv0L2QMCcQtUMS29ojRWq9+iSEE3+y1Uqci8H1t0xlU
ZQlI2PybNkBevsgjfJZwcvn5libF0A==
=WrMn
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
