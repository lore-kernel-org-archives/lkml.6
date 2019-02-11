Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E010BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE700222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895974;
	bh=gfQxNgsl6yCjYeA8gu5K8uJhodht2Oyh/nzKvxCIfSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UqusCU9Gxi6d/zWGumyjD15UwMP8t1VgxXFv9kcJbIG80alWCadotvzSQjOqCw7nZ
	 CDsWifohOVczF3wqWYREGFc24grrLQeOsoC/sGF88qjbaR24VPXaKm4YV3ZmEKXggD
	 cKKKPjCA4Rm5KJ+sI0Q0n/V73dRs6ca95jdFD+2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfBKOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39458 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfBKOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gfQxNgsl6yCjYeA8gu5K8uJhodht2Oyh/nzKvxCIfSU=; b=Nv6b67kiqrkWS2aBzU4bzMp2h
        yQTrI6Fg4gXoOEEbMs4oEhstPoGWZM9jYvGZL8DyWjU4UZfwM3uMDSPN8wYpx49BSaqo1pDM+lvMw
        0Ds6PpTCd7AWLHrIBDB60Stm/dTfBCt5D3Eva3vH1Kso0xwGiR9F4V7k28d8/fqCE7NIo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtCk0-0003gF-Sm; Mon, 11 Feb 2019 14:39:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 22DF711280BD; Mon, 11 Feb 2019 14:39:24 +0000 (GMT)
Date:   Mon, 11 Feb 2019 14:39:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 066/352] ASoC: sunxi: sun50i-codec-analog: Add
 support for cpvdd regulator supply
Message-ID: <20190211143924.GD22391@sirena.org.uk>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141850.315232314@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20190211141850.315232314@linuxfoundation.org>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2019 at 03:14:53PM +0100, Greg Kroah-Hartman wrote:

> On the Allwinner A64 SoCs, the audio codec has a built-in headphone
> amplifier. This amplifier has a power supply separate from the rest of
> the analog audio circuitry, labeled cpvdd.

> This patch adds a DAPM widget for this supply, and ties it to the
> headphone amp widget.

This is more a new feature than a bug fix, it doesn't look like obvious
stable material.

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhiRsACgkQJNaLcl1U
h9DHcwf+NmG9GjdRMUlbcBVpGX7WDOP7PsZpvBBYtA/+mrvUG6oKsvVmE2Cfd+6z
/BdnnOofowF1L58VE4PDDc7ymRX24iryc/pFSYxy5teKjlisLQo+xI07YwFEPw4f
48qeKE8mEaoICbFodEbsSjiPk/y2DjAS8OrTsNqL2e6UHZSMuw/1DshQ1mWbS9K/
LxGdfg/5a0kRZqnUZ/P/NEgE1cNWVlHfO/fhcAev+kmoYe34XHakZ/Hki5g10e+U
kKJGSrKZvTIqKmlH5RXwBau1eMr+KJDCwCy6RbnXx5nrZT4+8xCh3QUFSJAfUNu0
ufA+6ZfB6HB4bSBbCKLn1J2mvWKC4A==
=TWIs
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
