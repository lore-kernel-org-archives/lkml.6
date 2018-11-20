Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E0FC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E020684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="M1NrgFCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624E020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbeKUD3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:29:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKUD3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zs1mImhqZI3duLB3B6GrulsBx8PID3j/SPo0HW9tjHw=; b=M1NrgFCCD/MKefUSlV0oCk5gq
        IAA4RJWVC39nu3FH0EUuMSkOWgcHKGFvGzhsND7S7GhTQilwm5qClo8nO1P2VrpfrD9/V35YQKAIi
        U3+XSXTlvzbKcuiTXFrn05kjxmkZ3JKbmTipYXek65JHeZW8Yviqzvz85b/IuCp5XHsGM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP9N7-0001p3-8F; Tue, 20 Nov 2018 16:59:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E78EF1124DC2; Tue, 20 Nov 2018 16:59:32 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:59:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in
 regulator_force_disable()
Message-ID: <20181120165932.GN3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-7-dianders@chromium.org>
 <20181120155458.GG3894@sirena.org.uk>
 <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
 <20181120162504.GJ3894@sirena.org.uk>
 <CAD=FV=VncEViv-mUJzUdjA8qvEouHHtiVfV2EpYi6bLAMW7S7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="95CBLwa+io9O2zXc"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VncEViv-mUJzUdjA8qvEouHHtiVfV2EpYi6bLAMW7S7Q@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--95CBLwa+io9O2zXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 08:57:32AM -0800, Doug Anderson wrote:
> On Tue, Nov 20, 2018 at 8:25 AM Mark Brown <broonie@kernel.org> wrote:

> > I do wish there
> > were a way to flag API calls as needing review :(

> Would it be worth adding a WARN_ON(1) splat here or at least a
> "dev_warn" so people knew it wasn't really an API for general use?
> ...or is that going overboard?

That might work ehre but it's not just this call, and the trouble is
that there are legitimate use cases and we can't exactly have a magic
"no, I know what I'm doing" flag that things need to pass or anything.

--95CBLwa+io9O2zXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0PXMACgkQJNaLcl1U
h9BEWQf/YALGgDhe7vExtg+3DBwOz8l2OGOw+KcdvIvAntF5cgNJDoPRj3VWfnc7
ZduD9EOGmWTHsxi0a+1f2ugr9YP0erOTLbwxg9ZWcEjMxtVejqepyycC+W13Vt/2
UnbbMyMHek9zDN2QiUMMJdPYbYsR1wO6C19ELAnYvog+wJ3CZ7AnOLAHdvh9pNkY
t9ymfuBGbCpbOACp1bZgZCm9GVjcMw3G4Q5F9mZ3QGjQsC/R1gMaux1WdCocmB5m
REexWFwEHjB7R2tJu9LMcDIqonBjDsjC5rYCuwvHN+EYdXmvpLREr0FRKHNqL0XU
T6qJI3Kd20P+945AOLzO0oppJz71xA==
=wlye
-----END PGP SIGNATURE-----

--95CBLwa+io9O2zXc--
