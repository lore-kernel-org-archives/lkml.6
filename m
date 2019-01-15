Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FDEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39B420883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547587549;
	bh=nKz5gwnmxbo76rR43+eyQiGUEoy2jp9CVuVlPVWsUTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YmxhYBts7BTJCwWRBYfKS84YAvblFmb0H7x53fQs58KhiOWk3DVTmgebVpDIyybL6
	 ClRNuXCMKv9gpctVUH0CB/b1vt65/9CVEQANSsBNhbhqh4I45faCvuBbwtmPogDL4w
	 X38c3Sc+clsYpgzzXhYA5PxOkp1azAJaTgfPBrl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbfAOVZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:25:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbfAOVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=micwuTqkYINBkpkLBdnOyIQ+MIOXvCSz8SYpG2mgglM=; b=cjIBB/zQkOhG9U92+JuXtN6aS
        Rmu8uy0VW6qxG33mWb1MoxnftqKn4RPeynWbrRlKip6Unh9tHzlXTAvidBrmXzBMeT+qFeG8BIRmO
        P6SWPecHw7Q3EUeGuZvmKxfmNef3cITTQmHkt9DVbBO1peW6BBBQzmxhC9Sqc8yXsWSGI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjWDM-00033W-Ih; Tue, 15 Jan 2019 21:25:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B84D91127848; Tue, 15 Jan 2019 21:25:39 +0000 (GMT)
Date:   Tue, 15 Jan 2019 21:25:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190115212539.GK5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 09:58:55PM +0100, Martin Sperl wrote:

> Maybe a bigger change to the reduce the complexity of
> the state machine would solve that problem and also
> reduce code complexity...=20

Yeah, that's where I was getting to with that test patch I posted.

> I may find some time over the weekend if no solution
> has been found until then.

Thanks for volunteering :)

> The way I would envision it it would have a =E2=80=9Cstate=E2=80=9D
> as a level (0=3Dshutdown, 1=3Dhw enabled, 2=3Din pump,=20
> 3=3Din transfer, 4=3Din hw-mode,...) and a complete
> to allow waking the shutdown thread (and by this
> avoiding the busy wait loop we have now).
> This would replace those idling, busy, and running flags.

That's a good idea, yes - a single enum much more reflects what we can
actually do in terms of transitions.

> Drawback: it is invasive, but let us see what it
> really looks like...

I think we need to either drop your change (which would be bad since it
is a big performance improvement, I'd punted it for later when I did the
original refactoring to push the work into the caller threads then never
got around to it) or have a invasive changes to make the new situation
clearer.  Right now things are just far too complex to reason about
which isn't helping anyone.

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+T9IACgkQJNaLcl1U
h9ApOAf+MWM+IL1uhFKV6QS0+G2LKoICXpAb4txk4+PMZjEneaHHCPyywK4NC02y
gjnpm7BS+A4FuKfDvr2XRFBdd7fkj+08xBv9tGrmUpi4trayMablnZcwwZ293q47
rxGIy+BkUTmzBxhM0Rk6JgI91ZCoUN5gnPrP3LpkfGNS8tcECdPyCJsQDXKqcSwj
pNrVxHkArPPGFesoSQNxHDeuGvj0QNURq0kXCk4Dpiy9hvvucO6HImG38RNo5Yow
tWWx3K4otQ3+eqiGWxML49BqATXtEs+MvKdfM8beeJAJWmqwam/+MSjYCSLzfPfK
JB7+O0fGjQDtXFbkuA79qWMGmRENOQ==
=LWLb
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
