Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5D421907
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661226;
	bh=b5Njt9tGDpmzQ6r0bHdr7Zc3ILeYJr0oD/W7czhsxFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FI8j3czjT/pSAZWsBqjtDXNRrOWtfYKHdxr293uqiuQtc69RUdCl/7ru5b60RPoum
	 2VtLmgIuqmUzKpnjnOOFYyTfEYkHWtPSPwBsnDJXWMMxjO3Hq4gve2RUp53XH9Ro3n
	 vLmr0ONZpCMmSghQeOCl8j2y0sW8RClDzGrV2mY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfBTLNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:13:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44922 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfBTLNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t+9XtomNxnCfqjyQosVjXIS7pcULQvH0srTAS9DdopU=; b=Xlk0Ltx7yqLma+4rrgluzrMLB
        0eEinbKjrzjq992AzLD0YADvydOONap7TWhUQTy8sceMh9Ky8sGEIBZloNkJYaZuPy6IEWyGkAxq7
        BV1GKL04hnEmVtiCGfmdP55xIXDDauM+TefeOxsH82O7EM5TYwrFwc2No98wSNtV7XJlw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPon-000123-2K; Wed, 20 Feb 2019 11:13:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 60FC811284DA; Tue, 19 Feb 2019 16:39:29 +0000 (GMT)
Date:   Tue, 19 Feb 2019 16:39:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v1] regulator: core: Log forbidden DRMS operation
Message-ID: <20190219163929.GA20883@sirena.org.uk>
References: <6e471922-2850-97b8-c555-34e1708cbc38@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <6e471922-2850-97b8-c555-34e1708cbc38@free.fr>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 19, 2019 at 05:02:46PM +0100, Marc Gonzalez wrote:
> When REGULATOR_CHANGE_DRMS is not set, drms_uA_update is a no-op.
> It used to print a debug message, which was dropped in commit
> 8a34e979f684 ("regulator: refactor valid_ops_mask checking code")

> Let's bring the debug message back as KERN_INFO, because it is very
> useful to diagnose missing regulator-allow-set-load properties.

No, it's perfectly normal for machine constraints to stop drivers from
doing things so we shouldn't warn on this - it would get incredibly
noisy if we started printing every time constraints didn't let us do
something at info level.  Debug level might be viable, or definitely
vdbg or trace points.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxsMUAACgkQJNaLcl1U
h9CAowf9GAmS8hcLl0o/rxec1swCX7HJJ0y1J82se4bF7u2xRoHiozAGKgLe7qOp
zEQYZi9UiXFCuRbXTVvHN3WngkRBPs+H8IEd7HGQdnGmNibN9mnwe53Ms6nkKxUS
TlbdC2dwPgX50cLQqkZWwJBGtfPjCFY2t0lglj2A+pixur9ICnJ0aJAuHsJ5jncV
kZ9nfqmmM3N0b5aFHB6BmmZIeieujKKag7M+KpQLQJlYOogh2du+NjT9uRRRbCO1
/8hUdj0scwDZJI3KCnYsHUQq3akuaBcp4VGwhpJzokvx4Z+VScwaNXWZo6pLHq1e
0KTvHtAJ7koqO0bDts19+H+1ABjyjA==
=Pb90
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
