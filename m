Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDECFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7BE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544451968;
	bh=Y1WKblEb/HRDkrjmGjYuIakZC1nr2xxcg2mHZCHc7Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hjn0+H2grGaMZvM1PC1zgglCCnD+F1SpwRrN2nXMj1OTWOTLk49jpUUum2pWdxHNm
	 I5XTIqAi/E77CYQS3hwnJfMIRYWqtwWWRMeje0KZQY7c7CwC4uqv3702hCN/Gc7T3F
	 0p9QMCSkFRVAULy78H0z5KRxMY05ULvj963VrkrQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7BE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeLJO0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:26:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeLJO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qAPJLdcLDm5Z0H026OAgX/VM40K3fylIRdPbml+Mv9E=; b=lm81OmVSdKOFHm0Cwy4EPjPfx
        zF2gENQKA9M3hG2tuQqHw9OPYXjgP0okQ3sS5wYDmD9WKlRM8Hyh8qch9O5i736p6k3SHBw7aDGkC
        ScGyKZ28rcLCnzcZU76QtgPNuvkcQjZHgHszivLf3MyexDUK/wQXt9wgLab2V/EXXJ1v8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWMVT-000562-SW; Mon, 10 Dec 2018 14:25:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 54E0911254C5; Mon, 10 Dec 2018 14:25:59 +0000 (GMT)
Date:   Mon, 10 Dec 2018 14:25:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Karol Herbst <kherbst@redhat.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: next/master boot bisection: Oops in nouveau driver on jetson-tk1
Message-ID: <20181210142559.GB6307@sirena.org.uk>
References: <89fa50d0-945f-d1ed-ae55-ee947187f209@collabora.com>
 <95255117123da3702da585491d2fdd74890937c0.camel@redhat.com>
 <16ca4f0f-6800-7204-6fc2-286caa7b850a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <16ca4f0f-6800-7204-6fc2-286caa7b850a@collabora.com>
X-Cookie: Do not cut switchbacks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:00:08AM +0000, Guillaume Tucker wrote:
> On 08/12/2018 00:08, Lyude Paul wrote:
> > uhhhhhhhhhhhhh
> > didn't we fix this weeks ago? with "drm/nouveau: tegra: Call
> > nouveau_drm_device_init()"
>=20
> Yes here's the fix from Thierry:
>=20
>   https://patchwork.freedesktop.org/patch/263587/
>=20
>=20
> and I can confirm that it does fix the Oops when applied on top
> of next-20181206 (what I used for the bisection last week):
>=20
>   http://lava.baylibre.com:10080/scheduler/job/71109
>=20
>=20
> However the fix doesn't appear to have been applied in any
> upstream tree yet.

This has been broken for a considerable time now with no response from
Ben - is there some other path we can use to get the fix merged?

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwOd3YACgkQJNaLcl1U
h9B6Rgf/bJtsIULPYVRHDpanZzM0vxe8mXIyPKGEXQDuiqx31rFQqH8gFpBlfbth
IFTG5eZ/8u88YVZkmCNTYBGQN/e+4m1bkBPLA7yOYivI9wvEQMxhqeIZk17TU2h9
RmASuzBghhL13HemWXo8qEy4dkMl60J2YiqGrOUFjFEdeupX50bLUZ52PgSKTaWI
xMiZn6F9EIC0nBpFS30AFKtl+rORHq2Psv3C9J6LiqEtODS+qLNp3WI+qELH+WaX
vvm4qfw0jtn329X3BgoO6SszYggGF/Za04tj6m5148lENqGXzHoSIKdIxlulLIdT
vccDmTSma5GrJRfbgbwxuhkSaifRzA==
=TjTM
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
