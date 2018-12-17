Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E4E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545067970;
	bh=AdDPIxN5+5WZeFnhn7NoDaXJZPBluspLRfM5qwNM+AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PNiHtG0BEHMCnP2hSDDBPjJpoNY75fWjjgK6A18bna4Zuc45el8LDCCF7hLH7IjSD
	 /JezKpN2ias6snspmTje6ko6EE4ZoYeVFY462T3GBrBqw4gKFpcPLttY3Affhpu68c
	 2UTRzH3dMFFUSj3TNZCSy0YiyyMIiBVriPq2zorE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbeLQRct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:32:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HEcX/uBpVQSulCnyRmuFthjZFVJsfgWh9aUsRvMLP+Q=; b=q2l4kjLo5FschWk+bqIICBUXm
        HddVIcfzDgvEPaYRsmzm9ZHN/2KObQXngU1J64grg08vdoW5M0hj4HV2eVoekglnG6mFYHc5uNECo
        PYo+iurVpQbhaehJ3QJeQijmNE3B43uuLmSVBrIMYcPfoxCADkibeeOBKbm1p3SUM2Apk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gYwl2-0002xb-VY; Mon, 17 Dec 2018 17:32:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 73972112593C; Mon, 17 Dec 2018 17:32:44 +0000 (GMT)
Date:   Mon, 17 Dec 2018 17:32:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [RFC v2] regmap: regmap-irq: Add main status register support
Message-ID: <20181217173244.GE27909@sirena.org.uk>
References: <20181214140812.GA28723@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline
In-Reply-To: <20181214140812.GA28723@localhost.localdomain>
X-Cookie: Cold hands, no gloves.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 04:08:12PM +0200, Matti Vaittinen wrote:

> This is draft for approach proposed by Mark here:
> http://lkml.iu.edu/hypermail/linux/kernel/1812.1/07117.html

> Pretty untested and diff is done against tree where the level active IRQ
> support for regmap-irq was added. So please consider this just as a RFC
> introducing the concept. I will format correct and better tested patch if
> this is the preferred way to go.

Hrm, so the parsing code is indeed quite complicated.  I suspect it
could be simplified if instead of trying to allocate just what's used it
was a bit more wasteful and allocated the biggest arrays we might need
but I'm not sure how much that'd really help so yeah, doing it the other
way around might be better.

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwX3bsACgkQJNaLcl1U
h9B1Owf9Gh5yNwcUtAa37SK9N2d5FO9oOkqRuyS5GxFc9UD9Yqsj/mwjLQFhFk/z
OrAmEPXe+yvSrKnh7Dd7cx/ZVmcxOhNhe+3rj3S5fRsxZAbuOSQ+KNBClg5brwKr
+IxWyncVxNaAO4Jwda52lCaAIQ4LhI4TRYW3Na5hk/gzPUTdph7nAvYxAM6FAHnu
cQTBwzvwsg9BaMZuPS4RSvtr6cg4hkph65EZXm9bZPthBoi3EzpHs4JZHKKob1o6
1LxSCMJ6p0UZUSotn7rGk53ALYMJ6a+7HFI5ISdioQVFrqM5noe8x7C0Vz46GmH0
/waKfaJprkwrrOTjo3BDsX7TpvyK4A==
=zr9H
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
