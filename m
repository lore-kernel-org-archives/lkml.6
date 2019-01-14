Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A72C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683F02086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547477825;
	bh=+S/7Lss8bik2BS8XTKTbW8rKCrNw+78g06qnDp/r5Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0nJ5b+XPSgdqZR9bjHBpGdWyHlVlG5b9lgJi/t3zu7SgGEFha9QdHKyZkreIgT8GO
	 MTcxfTOXl/Ccl58RK8FqAahBVxGUSj/CoJf6mgrem6oxt27xMuGfnZbAUd3OLHXl8s
	 d2/99RRtAZfQHxmfa6yvSlnTUnf2b6knkub9C+04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfANO5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:57:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41048 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+S/7Lss8bik2BS8XTKTbW8rKCrNw+78g06qnDp/r5Sc=; b=XrLvIZslfNebD7WbLFNJ76v2d
        aeK9tNkBUtEBTG6QLARW4RxGO3Hdl61WYJXF048SVRNt3pjDU1D1XhqjXJb+dILySBiYxIvZc2Ury
        JpvF/s+kSt3tG5fm/U0Szyn380aNq16NaFklZ7GV/O4TtrnHNsp+XUkYp6yTFzm+vObH8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj3fW-0005Vv-Nr; Mon, 14 Jan 2019 14:56:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 47D3C1127AD2; Mon, 14 Jan 2019 14:56:50 +0000 (GMT)
Date:   Mon, 14 Jan 2019 14:56:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/8] ASoC: dapm: change snprintf to scnprintf for
 possible overflow
Message-ID: <20190114145650.GD11073@sirena.org.uk>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-7-w@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <20190112152844.26550-7-w@1wt.eu>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 12, 2019 at 04:28:43PM +0100, Willy Tarreau wrote:
> From: Silvio Cesare <silvio.cesare@gmail.com>
>=20
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.

I don't have a cover letter or anything before this in the series.
What's going on with dependencies here?

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw8ozEACgkQJNaLcl1U
h9A3FQf9H+iUUnfAnW5Uo4QRV6XMzxZAkhTcOxgBUvL6Uo+Ckv1p1tAX2oqQ9aN5
Oeoslw6IyUbgJkfOFx3djpaJpCG1BMk2QyH1BlrLMTsH8pfIWwiNdNuS50SlHqv2
jWhn8KWLsrrj9l8lKkgVjxl4tYwZ1JBqg2Y6CNbpISBzTzO1JNEiORi9YaGc9qgI
4dG9Ft9tz++sH7Vm12Gg08fB8/EGISD9xITy0dgc69Z2BmUxS1aNLgN5M+may07w
/c9VjYrmKZ6Q9EqDdrcCRzczBS8KvBpStFRfmsEMnQMeqFsJx1v49eUz7KKHldfm
JPeRfdUGZYKqeDJyUCwXum7zymowiw==
=ZiF4
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
