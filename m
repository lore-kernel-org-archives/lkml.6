Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD215C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE4F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549551253;
	bh=QZ8eZseL12DgHER1z1Mmbg6u/2uiYfQcbMHSdmr9/6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dwGxz/cikhtEe2kqOwQcer6uBcqG2yiSFqgNDLa0pjqVFGlj7xw/+L4X/389SMyq2
	 aeOw7COYwkHEjFoY3707m/QBxpN3X+oPP3j8iWbDsLihO/6dElb58PTeYteJTx4/QA
	 mHjuRSJuBmmufnS2w+D0Y6nEzFTQv2QnxXk8eNM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGOyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:54:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QZ8eZseL12DgHER1z1Mmbg6u/2uiYfQcbMHSdmr9/6I=; b=cPeZnbPg1TVvSijmlU5DkkmdM
        FM6WzQQcJWtkpPAZgkIVfdbZkrxs0awpKVrMTQSlvwmLhXmEyIhv6bFNROd8SoLByjwCCEUEtwysK
        1Yys9abzwHYTfPxEXfHH5A9pV+eyztMpF2PZeOhY/vgIEf4Y+0W9IGo9B0PZNbllB/wSw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grl42-00069n-Nc; Thu, 07 Feb 2019 14:54:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 270241127EF9; Thu,  7 Feb 2019 14:54:06 +0000 (GMT)
Date:   Thu, 7 Feb 2019 14:54:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: Prevent clk_get_rate() calls in atomic
 context
Message-ID: <20190207145406.GD6190@sirena.org.uk>
References: <CGME20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a@epcas1p2.samsung.com>
 <20190207142041.19394-1-s.nawrocki@samsung.com>
 <20190207143214.GC6190@sirena.org.uk>
 <21b8ccd7-e379-b4aa-3257-c9644ce3664c@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline
In-Reply-To: <21b8ccd7-e379-b4aa-3257-c9644ce3664c@samsung.com>
X-Cookie: A day without sunshine is like night.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 03:47:14PM +0100, Sylwester Nawrocki wrote:
> On 2/7/19 15:32, Mark Brown wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative then it's
> > usually better to pull out the relevant sections.

> OK, let me trim the backtrace some more and resend.

It's fine, I already applied.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxcRo0ACgkQJNaLcl1U
h9BwYgf8C1wS4SbsPYJfIJffKguSMIG2PsJNdhD6sjPzrZy8INW/8DEB/oJWpFbo
U4YTznjK0tz/aLPGm7XS4qliocS6x1QcK4dq+E1DhtUGg5WUoehyS0pxJJnc6Mn/
lX62rgFrCbHz3g9CGh/IxsNdLtkRTeh2jS64tmK/Mp/gLJ/I1Xv6AtsPtjWnZXIe
6b6Wo047tPUHcOto0Ud4yZcf9rUeVYNDSU8dU1/EJVMQdRc7Qs54OCa0mo4KpTW7
07dmJNqCaj3RBt1T8WBpy2uMfoYkghpow9N6XnnpDMwlovAbS52oxDzlmNALZ9wJ
5+fLAdrwdirSHTp2Sg9+4dnutCl53Q==
=9x5Y
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
