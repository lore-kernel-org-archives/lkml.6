Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B199EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF4720C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="i1bsR3wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF4720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeHTUe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:34:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeHTUe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V1kRQECdKaWJcegxuOr+U8XOomN+RhV36815ClDwiFw=; b=i1bsR3wqHJCNdCAq5LgvZOLHZ
        AY3XhDExDkGnRWk7ecuwzWB0KEpFScb6rvQuMW4hvZs81E5oZhwidxWYHgwXOw69mRt0q43ifdd8k
        ouPD/BMgTYYjBKmUkyGXMCNVFVOYUv2uV6ngn7iOMRJV1OxlzkjlGVLncN1FNL4dv2OCE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1frnox-00006u-4a; Mon, 20 Aug 2018 17:18:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A9A4F1124507; Mon, 20 Aug 2018 18:18:26 +0100 (BST)
Date:   Mon, 20 Aug 2018 18:18:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        swboyd@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
Message-ID: <20180820171826.GA22128@sirena.org.uk>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
 <20180817213601.GT30024@minitux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20180817213601.GT30024@minitux>
X-Cookie: Am I elected yet?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 17, 2018 at 02:36:01PM -0700, Bjorn Andersson wrote:

> FWIW, we've had this problem on other devices as well; where the eMMC
> won't operate properly unless the supply operates in HPM. We've worked
> around this by specifying regulator-system-load for said regulators.

You can set the regulator to work in a single mode all the time, that's
not a problem.  If you know the system needs to be in a specific mode
it's easy to configure that (some might require a mode below the highest
power one since that's sometimes the noisiest).

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt69+EACgkQJNaLcl1U
h9A5cwf/b6Q/LrKtp0tKUWns9H40nNXtjcAWIJ+BLm57NAtv9LchjNZjOjgsqW/f
z5olk+8UhQhl60CNNoZrlauJPbepNKFAkin7S+/jSbpdTt9PyYQsSYWaKDgT0u0S
Z2wgLSFhtl184QO/4S5ap99UOkPjNECavkbWb66JQjF/Tb+eXe3NqK/xD2pHCQNm
asoecgNrwjDJGyGr6l3rfkgkzK1PPZ3QGDQOt3qCRkCnTSLHmUKtC39HevYwoKyK
u5udd78GaITswV6R+qea/J8bcbin9HoymO3uw3HXcShNpHTUXQRc+ogNaQoIDWK5
e78imQThT9SblJtZipOVih4Nfikigg==
=usqJ
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
