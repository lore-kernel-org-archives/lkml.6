Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08FF214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547122031;
	bh=XibdCo3y2jKUGtyoKEFKDiIyZDI5hTTztXw+/pL+BMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I/CgVf1DiNZShQu1GLu40xjvG2ISVhFQ1hDlPfNkmp40+PR4PJXb9ir4sEAHncR5J
	 8XKN17+hj2aY1UQR1VcOoznSUoT4OREQSLkYStjaWXfgNwSEeXP37zYbMye5eO/Mpq
	 6jt+DV1ADh4CdqQ4Hk7gzmQJsYTmyJeVaAf/nceA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfAJMHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:07:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53664 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfAJMHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZXw9BqZb/Aet5fzaNYRORNmXuZoIi6XClOgJ81G5HoU=; b=cm0a/hwD2CFfoHOb95o4Wiss2
        Wi4YUZDlthML8NVl3kXsN3B9Ro7WIvUgMGGmApDbAHhvZcUMcqutj8666pOofM5ZckmdYRf7+bjLD
        HOvaEG18R5npPpV9cF1UwL0GCW56G205IkNHKP7kMnBwggpII1w+urD7FQVIFtpzuiKVM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghZ76-0003Qf-36; Thu, 10 Jan 2019 12:07:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AA9D81127052; Thu, 10 Jan 2019 12:07:07 +0000 (GMT)
Date:   Thu, 10 Jan 2019 12:07:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: Re: [PATCH 2/2] regulator: max77620: disable notifier events for FPS
 rails
Message-ID: <20190110120707.GD9541@sirena.org.uk>
References: <20190110041117.8216-1-markz@nvidia.com>
 <20190110041117.8216-2-markz@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20190110041117.8216-2-markz@nvidia.com>
X-Cookie: One planet is all you get.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 12:11:17PM +0800, Mark Zhang wrote:

> +		/* there is no SW control for rails which are part of FPS
> +		 * set always no contraint to true to avoid regulator
> +		 * enable/disable notification
> +		 */
> +		if (pmic->reg_pdata[id].active_fps_src != MAX77620_FPS_SRC_NONE)
> +			rdev->constraints->always_on = true;

A driver should never modify the constraints, you should register a
different set of operations without an enable operation instead and let
the framework handle this.

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw3NWoACgkQJNaLcl1U
h9BFxQf6A5L3JMfn39i9h3RNP/+qflBVJSYoaO13ri3YacNgdJxCDwFqGe3vqbLm
Vz5QIqN640305Wfet7N6mdOx9/K/sp75PgZl40ZQ4/muybAzjwLguNjKvW0sGlaZ
PsJ4vvDvK4WAQa2KiKTY/vidLEJ5uZ6Mn1RsW4Zhnxfs1gwQYouuRwY6sKooNtFZ
8DZEIUSecRvkFWgoYPbk39qBcAF99uh65Due0UCUw1PIuMy1BDsUYia701vh8vJf
Ey31LxCCCcP2fCETPS3ruvRfzPJEvdExSGC/3wpliwP7RBiuGza2eFkWIL/phox0
q4ESn6HVHluWdBTAbF3xGsqXoquRgw==
=zGSx
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
