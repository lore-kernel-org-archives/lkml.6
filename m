Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9672063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547506418;
	bh=2Qoi6DMaVrpuaGnWpqb4qtYn0GMBNO6k/v1JAoHUXyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUjY61ge47nqwfPFpfkCCtonDghbZdt++CNefdnlLFWKsxZG1pZan7Cly6uOEYU/e
	 2dWC/p5i112siKJfyla9dwOX7KHZ48ghK3GJ1QIsgVJalCRCmj0jEeQkUEHQ7sJsB8
	 pIWp6qL/dDYkVYpvkWHJkTNGoCrT8DlsDd6mW1Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfANWxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:53:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfANWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kG964s3QJ6dVq0pAT4r1IAmzesInDHvBIVsbqE/lZvo=; b=qyx6qokOfbJ8Lq29u8BAL1fdc
        h3NANVm4qOtgAXCqNYquS3UEsy3tcW5LEgoPQDNbt8VCIza/OGyt51PuqIoH2v5EZ5MXokNAepH3x
        LTcJEsEs5XAfbOE2pvexOrlFDYfwKxWuqv5FKDNibyyK8XO+VRSvI6lAhBY3McS0/cT2M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjB6b-0000OE-3q; Mon, 14 Jan 2019 22:53:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6F47A1127AD1; Mon, 14 Jan 2019 22:53:11 +0000 (GMT)
Date:   Mon, 14 Jan 2019 22:53:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux@armlinux.org.uk,
        lgirdwood@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Message-ID: <20190114225311.GJ11073@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
 <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
 <20190111123913.GA2804@sirena.org.uk>
 <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
Content-Disposition: inline
In-Reply-To: <40a2dbb6-56aa-173a-4be0-d7072ed32b53@microchip.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:08:19PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 11.01.2019 14:39, Mark Brown wrote:

> > Like I say I'm working offline so I can't check the links but it sounds
> > like you're saying that the existing suspend mode configuration features
> > are enough for your systems?=20

> Yes, if we rely on the fact that core's regulator device tree bindings for
> suspend-to-mem/suspend-to-standby were filled correctly.

> The function I added here was to double check that core's regulator will =
be
> off in suspend/standby based on what was parsed from DT.

Ah, so it's being used as a consistency check?  OK, that does make sense
to me. =20

--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9EtYACgkQJNaLcl1U
h9AV+Qf+OscuST0WWOE2flYrj4veE7kRdI2nnKYgIWKwk1OvlpNJ4kQy4ZvDXITG
oUMIOLImOSCAMHh+RnSP9ee0inU38wsnbLEnjGBhGf6l/Jybe8ARemNoPO4KJ3tj
Sb4zJjhkrxN66N0KqJM5vh6mqrzz7jA1sfktIxRffRGTEZ4hx3gxVrH3Zwk7xUth
NQIxW9YF8pXZ1j2jnf9NZ3sF8ZRkL9GjN5JdYoS6sRvFcsSF39Of6Nmh3OA6o1rP
g77Jh2rns/BLphp3566eaDBE35QLq+tFELEc0oNWe33x/Dqok8rmC8+nWrOfIYC1
A0pfshgAEcqeDQLac9tYXo6h3sfvfA==
=KGpl
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--
