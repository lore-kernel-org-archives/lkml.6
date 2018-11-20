Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED95C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C120685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IhGfiRRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6C120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeKUDaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:30:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BsMc9i1U4MzFpeEpg8dION7DbxdbT9JOzYTgsGqmsbI=; b=IhGfiRRzbdUvLcXBMESROewpy
        pCOBa+VlLJGUa4vnMptCE6QILSsDUkZZeiJD95NyB9RdV+qdBVhGwfHT6qhwqmdoNiwrrDf2AA4Em
        idOYI3nynr9Eale/OahfzzItr7eGtWIe79JVVKwCpm3Z9d1PSwaznn4ds83EJwcx4IIQY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP9Nd-0001pB-Qv; Tue, 20 Nov 2018 17:00:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7D1C41124DC2; Tue, 20 Nov 2018 17:00:05 +0000 (GMT)
Date:   Tue, 20 Nov 2018 17:00:05 +0000
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
Message-ID: <20181120170005.GO3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-7-dianders@chromium.org>
 <20181120155458.GG3894@sirena.org.uk>
 <CAD=FV=UHiwjt2a8GFZKG3ZrRfjTgQDWD_mZu_qZP7Ve-HNTMYg@mail.gmail.com>
 <20181120162504.GJ3894@sirena.org.uk>
 <CAD=FV=VncEViv-mUJzUdjA8qvEouHHtiVfV2EpYi6bLAMW7S7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lLR1BQqf7txDtYcF"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VncEViv-mUJzUdjA8qvEouHHtiVfV2EpYi6bLAMW7S7Q@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lLR1BQqf7txDtYcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 08:57:32AM -0800, Doug Anderson wrote:

> OK.  I guess for now I'll just change this to disable the parent
> supply as many times as this individual consumer enabled it and call
> it good enough?  It can be for someone else to figure out how to make
> it really usable for system recovery.

Sorry, missed the question mark here - yes.

--lLR1BQqf7txDtYcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0PZQACgkQJNaLcl1U
h9C9pgf/UcfnnBt85DuLwmlN7iJdd5pZjSJpLnkoLaPJB8BUBnbG0nEu900Wz6oI
1bRCGcWejHAY9+FJJEty8DXz2MuH7qXpBexsPH/u+U4tLgH5oAF6IUwvZgDeRR4v
vI8Rw1O75+AYVBhm/VghTk4MtZ43C0rimHr0g5SaHTGY6kMXzneNKBoy4VyRovCu
5K+I+eCc90uXbOCFqu3Fy4bwdpfBKubbueTKTW2kRWAbCzYJZAfWubrdyuMNaYL7
p+c2C9JvWJkWPhNTySPxRM8Tm0DAGIZy5e/hkfPswRm8h4irzUGWBm1eJG7sy9U/
l7kcUCcl22P/D9ZsWikeuPxQNio7lA==
=YIOP
-----END PGP SIGNATURE-----

--lLR1BQqf7txDtYcF--
