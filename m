Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC266C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A779820849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544712431;
	bh=ySw6AfQq1chQWgDkXqPz1oolEhXXVS7NBI/h7h/dz3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SDwoK9ebvCfZWJHMeamyv7bMISH82o50e5jzwIrdvi2J+dq5xLSoMzdO9yA6WjAa/
	 2WvrnbFGrqtwSwjk5JFhzjZTDrHP53RPbjbF9q9DvorDIgAfO3w+TAiDGtliRDLq5m
	 I6EqCc3BEK6wVRU9J7LyZ7O9qGiYlLmEbWl4RCtU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A779820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeLMOrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:47:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33068 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbeLMOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qRtWbz/XRT/w+V4fwIVLyDmZ1S91tp+ygosT3Sp06Nc=; b=we8wQ/tDBNfLiFPiVLOzXxDMj
        RTKxNr/oNV2dYfFqhSaaFfoS996vWHujpbcFYr44q4JqSkv9DEZ68MU9m3ga+cK+Pou7QYC64y3Yx
        YGXwRRp0xXQJtmPUOCkosm3NC6Qqpl8e5xSbpe1vOe+sgvuKDBkZq7fCVYR/BSEWIC//k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXSGP-0001Vi-9I; Thu, 13 Dec 2018 14:46:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B933311254D1; Thu, 13 Dec 2018 14:46:56 +0000 (GMT)
Date:   Thu, 13 Dec 2018 14:46:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Priit Laes <plaes@plaes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181213144656.GJ10669@sirena.org.uk>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
 <20181213115506.GD10669@sirena.org.uk>
 <20181213132802.GQ4497@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <20181213132802.GQ4497@dell>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 01:28:02PM +0000, Lee Jones wrote:
> On Thu, 13 Dec 2018, Mark Brown wrote:

> > What's going on with this patch?  Will you be applying it or is this an
> > ack for it to be applied with the rest of the series?

> I don't have anything else queued for include/linux/mfd/axp20x.h, so
> you can take it if you want.  Just make sure you 's/-for-MFD//'.=20

Great, thanks!

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwScN8ACgkQJNaLcl1U
h9CADAgAhszym9ayUapGaP8xybHHtlq59rLNx5BSeXxz6VSIeaHuXtLZ6rQeb3/2
PtLTejwmQTTguCSfPTRAVqG/d0bI/oAfdCCZkft3/FKGvB+CacwhJ3c5RfVav9Y+
kJ6JRArQNYJ4jeDi8/2SiXqrrof3nl9JjCvSZ0RXULKsxdsNa9t7I5DtOU4z90wy
YkB9Gi3ICyCbu5Q1x51LdWiuMVWXwqgCKUQhsVFjhZGTiwM4iOjW7l9exoCp6DdZ
UAcfeYLMg+LxL3COGKZN58KUuQTZ/T3kDf4fgba0BPHNW2nz1btBsgZCLh0gOoK6
tcX4IsdA7ruOOQnBzmh1fI/VXb6x5Q==
=FLny
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
