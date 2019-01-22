Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6E4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69B217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548177771;
	bh=x7wlmIhJR3dHHH0/msvGkh0KD4G/S/9zsWzcmrFvTpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QZNdTU9LKMlhxU1L8gz5MvdIvUD1boyPL5Jc1vT6B8ycE6NpXCNfZ9ZVh3bDvJMYp
	 tuwe5Yp0o7LhF6kIBxDO29UnAbSVp64QzjPNvk2YMXgYVttVnhlUoAHu5Un7hhgQWO
	 mDvfhMCtajV7ZJERfk86W+cXxO/yMCcvYLbNMTi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfAVRWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:22:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54144 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfAVRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Zv/0KI3YZ77GMW71NZLeWP8lV4o2g/mi/SHg76E7a8=; b=lhD+u1SIaO5ddnW/LiHxMFfri
        7YK3UM5kPJBSK5KUd26qiZ+SlrM3SayhEDjvziMpDZ5nQdM2JYZb9iOJiesryi/qjyigupp47gb6K
        qL2oBPd6rKGc4H6hxrRk/2DKX23lwYjq293iJxx5lvdytPM4L7d8jVulAnxVi+MuYr6HY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glzl8-00074o-Nu; Tue, 22 Jan 2019 17:22:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 22D6B1127A85; Tue, 22 Jan 2019 17:22:46 +0000 (GMT)
Date:   Tue, 22 Jan 2019 17:22:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: no need to check return value of debugfs_create
 functions
Message-ID: <20190122172246.GD7579@sirena.org.uk>
References: <20190122152151.16139-7-gregkh@linuxfoundation.org>
 <20190122155606.GB7579@sirena.org.uk>
 <20190122160857.GD21349@kroah.com>
 <20190122163826.GC7579@sirena.org.uk>
 <20190122164352.GA24734@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20190122164352.GA24734@kroah.com>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 05:43:52PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 04:38:26PM +0000, Mark Brown wrote:

> > No, it also fails if there's already something with the same name in
> > debugfs which can happen as as a result of configuration.  This gets
> > confusing for users, they see the debugfs files they're expecting but
> > the contents don't match up at all.

> How can you allow a duplicate name for the other regmap stuff?  Will
> that not also cause a collision somewhere else?

No, the only place we actually use the names for anything is when
creating the debugfs.  Otherwise the driver using the regmap deals with
a pointer to the regmap which doesn't have any collision risk.

> Anyway, if this is that big of a problem, ok, but then your code will
> run differently if debugfs is enabled or not, which isn't ok.  Don't
> rely on debugfs to do your name filtering for you :)

I'd rather hope that the debugfs creation code runs differently
depending on if debugfs is enabled, perhaps that's just a strange foible
of mine. :)

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHUWUACgkQJNaLcl1U
h9BpuAf/W7ESqlXIYH61HDNQwBKFBAYpmw1MJ04HY6EXrOfbBX3+gfTbgWRVdNe5
LS6B94L5yapSc74PfTqdiwhTkmUH58FC/AwBfYHNJifv/yPO7sWvJW12ziky+AVz
TiTZ2mN9APMeXjG5AvOXeNwif6uuiBovbnw7bOnRfE2NPzBTUc/aOz30mhvZFXuo
HXxgPSltPOda9bt7W+ihmYqOIcZIFLJYpj/kl8UVUK53VH7TLyX0j0zjkxxLPF55
fLJ6N38zZ3DL07t6n0PowfQDVVvDZcH1p/74HIZ4fPMKqnZs+ts267cBmUMXum/y
r0z2SwxqPZigVVsqAmZTSt2XagqQNg==
=P/nR
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
