Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E72C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C520645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547567092;
	bh=fysaGZ8PjVSToaWugl79UxSOkWQ+fbJSclgPFMBlz6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sAimnjLs6clYhew+hodkq3i1ZBuI6Cpg1GorAiY9lavcsC490oEYANpP+p1T0e/1s
	 2DRmXfJCo8MLrq6fB4oCocHSmXu0YaboNUm0CKQbPpYecQ2NFGm+LUdT3VppSs5OmC
	 Fx8AC5ZhJ8SyPKJplXmGe/u6EwHSYNJrE6r5u/UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfAOPou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:44:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53712 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfAOPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/NL7RxWNw3vYY5kx82945+wZ0WjtBo/zJIiaPI2ALII=; b=lemKjrj+PSr1JNxuli4z1VR+a
        plUjxh8cSjdghdMXo4K+W8z8HxETRwXkGRxygFM/UMIMeKqhs5ajdTCJKTHlR45Ezb3TXZUUUlI5B
        H60bzuKzAaVxbMghK4/itYUQh9SktRqEJHqP2z0OSMmlejtHGXysCG4N90US47zc4Ul8U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjQtJ-0000SD-Hd; Tue, 15 Jan 2019 15:44:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E84C21127848; Tue, 15 Jan 2019 15:44:36 +0000 (GMT)
Date:   Tue, 15 Jan 2019 15:44:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/8] ASoC: dapm: change snprintf to scnprintf for
 possible overflow
Message-ID: <20190115154436.GE5522@sirena.org.uk>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-7-w@1wt.eu>
 <20190114145650.GD11073@sirena.org.uk>
 <20190115031615.GB6416@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <20190115031615.GB6416@1wt.eu>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 04:16:15AM +0100, Willy Tarreau wrote:
> On Mon, Jan 14, 2019 at 02:56:50PM +0000, Mark Brown wrote:
> > On Sat, Jan 12, 2019 at 04:28:43PM +0100, Willy Tarreau wrote:

> > I don't have a cover letter or anything before this in the series.
> > What's going on with dependencies here?

> Sorry for the lack of more context, I was just involved in putting a
> subject line on each patch and passing them through get_maintainers.pl.
> These ones were sent to the security list after this article was published:

>   http://blog.infosectcbr.com.au/2018/11/memory-bugs-in-multiple-linux-kernel.html

So just to confirm it looks like these are just isolated projects with
no interdepencies?

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9/+QACgkQJNaLcl1U
h9AunAf+KxzmTOiZaSv0fL1bTNYswFbldI+H7F6TZXrdAlX9iArd4ieDZLoGsNFr
uHm5agFiHAFrz9Yyls9LFpmPJT/RnC/LHYQq9v1brMuCWv8rMwQQPhTjZ3rVeoY7
e+AzXHlIlM5xo6z+yEvBllFx1BBL1e5jLfXU1c9YIP70v/J/P0kgjBwd29QfVSYy
dB7WCNQIcwXYfIvCRO9MBDLicUjGnFD/60UoFvD2PXa+zOMSE02ReP3OMCuz1HDe
3oGMtfJWABn88WC1QsoK3RdnBsR2TwBL1abYy2VbpRQV5OjpY0JnBcuUe5LZf5rD
POuv5nSdNUNdo2cijvRwe/Qzu1oAUw==
=oF/S
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
