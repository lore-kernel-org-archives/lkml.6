Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F85C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED59920663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548259452;
	bh=6NFedqu1jCKzdb+ysfmaDQ3KgJcX/mc5Vhn5t8JEsDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enXVQf+XqhdQHd6P17w8UcGPS3hqo0e4NKxzKoPvYLOTgi63PlC8ouHG0e3YNNRgw
	 g9HrojnijcLJHbn6X/Vdaryh5OvdmlwIiHtVZDlpwNyvTOmch/3YYbP50BTzcpiedq
	 xI1VSMBrnOSC/z7j9g7hFE09q/ur2/TrjAkYymXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfAWQEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:04:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MmLLebF7f+XqdN31MMnvjZtqd3xYLYIpg/89UUtXhxY=; b=t2Xhrn1UbPNf6pdU93U2VhkWy
        qvBA4SF/vG0cDD4ze2P/ClNjTyRtV8uSDtpE/9KXJMxN1+dqsHx0S0xPO0i0tflkcJsxaG0+Hf8tw
        bpjySp0ReDM4eHvoQS9Sllz+71mZEt9JawuYksYtBgSe+P4cQzzW56Ciox3FjEq+kwXaA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmL0X-0005vg-T6; Wed, 23 Jan 2019 16:04:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6C2B41127ABA; Wed, 23 Jan 2019 16:04:05 +0000 (GMT)
Date:   Wed, 23 Jan 2019 16:04:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        boris.brezillon@free-electrons.com, thierry.reding@gmail.com
Subject: Re: [PATCH 1/1] regulator: pwm: suppress EPROBE_DEFER error message
Message-ID: <20190123160405.GD7503@sirena.org.uk>
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
 <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 07:37:23PM +0100, Martin Blumenstingl wrote:
> Suppress the "Failed to get PWM" error output if the actual error code
> is EPROBE_DEFER. This makes the behavior of the pwm-regulator driver
> consistent with what most other drivers do (which is: print all errors
> except EPROBE_DEFER).
>=20
> An example where this cleans up the kernel log are the 32-bit Amlogic
> Meson boards:
> multi_v7_defconfig has CONFIG_REGULATOR_PWM=3Dy and CONFIG_PWM_MESON=3Dm.

This also cleans up the kernel log in the case where you've not got a
driver enabled that you need (or it's not loading for some reason) which
isn't super helpful when you're trying to figure out why the driver
won't probe.  There's not even anything at debug level, that would
probably be fine.

The ideal thing here would be to work on setting up the dependency
information based on DT and using that to try to sort initialization
order so we try things in an order that minimizes the number of failed
tries.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIkHQACgkQJNaLcl1U
h9C2iAf+IUK6/NqYrZSnKXKFs5po37vD4k0INFl6laZHOktHTt2izMuRRZ0H6kFE
QjP+XYMJtlB70x+yqBwRW86eIVS515gkn5SK1aZJ4gTlmme72SEAvXf0qaEgr0iC
SjO6kLR5D+0ravK7d6MR0JtZwkpqVQ2XInwiEYyowXLvYjDmVx72IxCrjqUhG20y
9ZgV666cg56ZxNqeqGkjPagKX28ov/ToYbM/HXBnOMl3Q8pk211ZnsrXcimhrXPq
FpCno+7mlRALDucT+gtTRqJByR5zyeChS2+2emJIkp/HGkFE5LkRT/K75bp5/9+F
lV4i5W57zlHyubHWig4IH/jEB3Pplw==
=kBoW
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
