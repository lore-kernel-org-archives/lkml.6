Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC78C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D487821841
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548172570;
	bh=VMR1P3fz1BLelsRzTA33RdulSTdgSx9LS7vR9NkYL5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sxDSKhYS4/sfv9yGLkKFPT2wOhd82XCV4QN2RGP4gr+zsMw5Q3JmdN4nlsS0KLbBG
	 r5GC4rP+td6BivkCxbKh3SKHqGJiA6kHrvoapBtpcpZquqLGPMXHtQAyUp9Ya9VMmE
	 prg9r8iwIVKo44SGicVOMd7rfsPkJc+ShUOAawrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfAVP4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:56:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49972 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfAVP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ro5D2zCeQvOREM/LogeMCX+eLwFXDuT8Zun1OM8TN6Q=; b=XdFipIde79NFmxJMQdlj7h/nU
        8co4BMjOlik+cJP0/1ZzUOCn7pcJXPEAqvPg85pgb7QkASq4wpTbMwl/o08aAHfBS1oryf8h2WoTk
        R84lilNc6XBQ3+Kzb7oE+SVDDTqiKr1OkSPfAC9cF5uhlM0z5xu9bMzvUs+kyBMZ8jXSs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glyPG-0006vn-Ju; Tue, 22 Jan 2019 15:56:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2823E1127A85; Tue, 22 Jan 2019 15:56:06 +0000 (GMT)
Date:   Tue, 22 Jan 2019 15:56:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: no need to check return value of debugfs_create
 functions
Message-ID: <20190122155606.GB7579@sirena.org.uk>
References: <20190122152151.16139-7-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-7-gregkh@linuxfoundation.org>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 04:21:06PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Given that all the rest of the function is doing is further debugfs
operations and when it fails people trying to use the debugfs do welcome
some diagnostics I'm not sure that's particularly helpful.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHPRUACgkQJNaLcl1U
h9ALvwf7BYcGHhJpXn67lf/fk7pN++Fa3eELUhCE+eVLiZ7XYPNUNz0Vmlej3f+1
8EMV7jNmWUPi2k3QpyaSoVPsV0jHtio/L+JDOnQJRLKTF40Xy5uaVHxY/Kz5HZ0T
7qpTnVRkIP6/gbZ/9U3SoBuK1CaC2Kg8c9oBfkDdk1LSRWNh20wyeRtMpfIvPL1N
DpYgg3BhRnx+ITF47aNEa8RRdzGfRUJXgAWxCcu7Z2sAYPMKU7dpFoIc/BEfmH8X
s9apPWAB2IY0GH9K5DNbQO1J4r+huuTVXA3hi0gtEy1nWrUod/yJyBLpE+aCYxVy
9iT6ntpxfJeXwGRVBE/wQXoKB+QiXA==
=AQlG
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
