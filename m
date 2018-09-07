Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607772075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Aw/xoY3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607772075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeIGPUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:20:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36786 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIGPUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FTAtw5774pMBq3PvE4S+C40zYALtjuNk8mQNPZQ2Cck=; b=Aw/xoY3KHHllawf0MJS9+J1Ec
        rCbjEkypY6Nxh+dsTQ3zG0ukGWSYkiMMyl1VjT45ukvvlQqPknSPtbNzRuSdTP68iR65hN1+BivC6
        f/5D258CRmbd3Z4CETpfPFSbIX38NiTz3ENc9/8HN/euVHrsfSfANmK4BSMk/pc8jIPlU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fyEAt-0005Jr-6O; Fri, 07 Sep 2018 10:39:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D25181122A6D; Fri,  7 Sep 2018 11:39:38 +0100 (BST)
Date:   Fri, 7 Sep 2018 11:39:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
Message-ID: <20180907103938.GB17459@sirena.org.uk>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-43-alexander.levin@microsoft.com>
 <20180903111626.GC10302@sirena.org.uk>
 <20180907002313.GB16300@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20180907002313.GB16300@sasha-vm>
X-Cookie: Do not fold, spindle or mutilate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 07, 2018 at 12:23:14AM +0000, Sasha Levin wrote:
> On Mon, Sep 03, 2018 at 12:16:26PM +0100, Mark Brown wrote:

> >I'm worried that if anyone notices this at all they will have already
> >compensated for the delays in userspace and therefore this will cause
> >them to see problems as they get double compenstation for delays.

> But what happens when they update to a newer Stable? They're going to
> hit that issue anyways.

Yes, but taking an entire new kernel release is something that'd
normally warrant a lot more integration testing than just merging in a
new stable release.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSVWoACgkQJNaLcl1U
h9CWVwf+PIg7RJUhayqWzGO70kdg/6gVyVmbK48vhPFX2J0Kzu+nAl80Gqn/dcDP
Yj3PrkT6YMy8K0swI8MTuUPuIbbjlbBhsos28X0PpNtd6nXexpp2JzRe/t/urjNl
lWYpQQUv/7KVBvyHShiyV+OlV7NzY3yieWj4Na6/uQUv2CihAkUnGpAOxE48Nz1m
uDcjgoeHKylIA6YPW2vU0AcOgGKvlwEafUNpD0TvQtbjcJ2juuCxW6LFMl8iBc3K
q5/UqU4oOSjUCKHHhX1s9Z0FTdqe0FmXSGfn0NrUQG0vVPaBxJfv5gqEL6FTCgFb
5xdLah+J2CSlkOosKRFsxf7k3694DQ==
=cT0y
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
