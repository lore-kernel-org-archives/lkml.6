Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63133C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3157321773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515191;
	bh=UkXZIBbaYrvX934i4ctnApU4YHSeQaRb0IYRdyM8uQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dSlNKmvTlkQtyjFx2yeqT5Kt+YJ5isCv0Z7esF/SIUPLXakRJbCvNgueAYQYFPNU4
	 k7j9b2PD/VDRD9RlVvHUHF77Wz8auIgxivNM5uC5fhZQKM0j1lip3TsAPFNg50PuEb
	 D4wIomaWw8v5BSSd4LWko+LwdklQMoR6apCSGw8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfBRSjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:39:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfBRSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GmDXdx1avJwt1OEiG6XY+QjIIG5CZ7dyXr4TZoV5NBI=; b=KLoZOW1SYNozc8kL2HyYdRvlm
        fgL278SxxmtfSa0pVmhy3ZPkWqTHllcOafeyceu77zrKOir2ZnmsHt75kPaKFVF7hCa+mp+oIEPZA
        /gSPzvdJxzSIEXACOwPQ1uMf7yJHw1YodrS/vJYFCfxWmVAAiY+9ygOaP0kpzVPnYCoMo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnpR-0001bH-BM; Mon, 18 Feb 2019 18:39:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 93F7C1128008; Mon, 18 Feb 2019 18:39:44 +0000 (GMT)
Date:   Mon, 18 Feb 2019 18:39:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Take lock before applying system load
Message-ID: <20190218183944.GH10794@sirena.org.uk>
References: <20190215105533.10264-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYYhpFXgKVw71fwr"
Content-Disposition: inline
In-Reply-To: <20190215105533.10264-1-niklas.cassel@linaro.org>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYYhpFXgKVw71fwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:55:33AM +0100, Niklas Cassel wrote:
> Take the regulator lock before applying system load.
>=20
> Fixes the following lockdep splat:
>=20
> [    5.583581] WARNING: CPU: 1 PID: 16 at drivers/regulator/core.c:925 dr=
ms_uA_update+0x114/0x360
> [    5.588467] Modules linked in:
> [    5.596833] CPU: 1 PID: 16 Comm: kworker/1:0 Not tainted 5.0.0-rc6-nex=
t-20190213-00002-g0fce66ab480f #18

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

>  		 * We'll only apply the initial system load if an
>  		 * initial mode wasn't specified.
>  		 */
> +		regulator_lock(rdev);
>  		drms_uA_update(rdev);
> +		regulator_unlock(rdev);

This is correct in that it will shut up the warning but we're not
supposed to need locks at this point as the regulator is in the process
of being registered so there should be no possibility of concurrent
access.  Since I can't see a sensible way to conditionally assert that
the lock is held we're probably better off just removing the annotation
since it's no longer valid.

--mYYhpFXgKVw71fwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq++8ACgkQJNaLcl1U
h9CfQQf7BZp5BHXpjAQWoCMvuZsFJCDZYABNLNQbHiK3SWETGmDGMsB/bM7tAzaI
CKFjvduHrN9tNxJlwU3NE19omVR1mW3B8OVFZK6cxCUpit8id8q1U2QR7F/CND+/
Ebiaac8rMcp3jb9f9LVCSNurDEXUcnaWxTCuWzAUCPRIqnVsTPe7gaYARspzpehC
387KzhjTcbMafYNgBDkI5AeTi99TUXVxLRfAIl12ZYT4TPDc6OIrHHroOp+ak4IT
soY2z1yvqjTp7pnl+Iehs6JeaECEsl2u6TrIAYt5s5Fu9cN6PeNnY5WdkbUTQoek
cc91+Y+SbIp1ZztP/mPQmEo7BVhotw==
=fMxO
-----END PGP SIGNATURE-----

--mYYhpFXgKVw71fwr--
