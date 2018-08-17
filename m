Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ECC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8BF2187A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fYgjTyIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8BF2187A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeHQSC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:02:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c5+qQ/pO4jxuZOv2iHsM6szrghWCFEdESXXB+xSqBUY=; b=fYgjTyIrABe2aZlibkaiUTmnT
        CLOWfJIU8C1VrB8SGUvZOvAvc2RRbLqFjdksKPViMwIl82d90/0rcaq/bUN8MovJBEJWaWLWwvGXt
        rQBlXeHlslSiYSllmtrwHszLBwN3ZSiXgI/ppfa2ppyVBlECoA7bDxR9odUenrWdJ1mZk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fqgDa-0003y8-Rt; Fri, 17 Aug 2018 14:59:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8B1FB112442B; Fri, 17 Aug 2018 15:59:14 +0100 (BST)
Date:   Fri, 17 Aug 2018 15:59:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dkota@codeaurora.org
Cc:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180817145914.GA6885@sirena.org.uk>
References: <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
 <20180810164636.GI20971@sirena.org.uk>
 <b32c205955e0f42182b16e90f539a919@codeaurora.org>
 <20180814150340.GE5810@sirena.org.uk>
 <caea8294d20c515a33c090c4fddb15c3@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <caea8294d20c515a33c090c4fddb15c3@codeaurora.org>
X-Cookie: "But I don't like Spam!!!!"
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 17, 2018 at 04:06:06PM +0530, dkota@codeaurora.org wrote:

> Could you please clarify on below query.

I'm not seeing any further questions in your e-mail?

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt24r8ACgkQJNaLcl1U
h9CRrQf/QY2VEoFZ8MVOx54OTnkKwUUdcFT2wstHs9r1U40lnp6BfYdsH9a9fSnL
exMxIRIcdJ0Z/oJcXhbMS8y+bSRfyIww0KAU11R6u7LXihtugcBxLA+F1g6wa9zo
5UrWRU1ePRdy8k5xQ9Wg/Kx2LcD8JlwA0ILpr1P2k0wlUOkEnbKddu5aG9KhsPLy
dZ3UNzmA6JqgFt5NwmCEz/cjlINsq/N2Oc52lSSf36qgcOXzmvTmgSarhWys3sE5
vFASKAOIJJtNOn2Q7ZiN8Tj9wwwHlFaPfD3VkcykNkCNNSreXdei4nVnh6jMyubQ
eT1L/E1Ok7WsRWD82xFfSYSUb/Mvsg==
=c13b
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
