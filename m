Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3009CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA9322430
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NmlfXDzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA9322430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeHJTRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:17:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43672 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeHJTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bZVaoGrYJ6ZhwwlqYmr8oZagzYNwi1CCQNZEFOY1Ki8=; b=NmlfXDzIkFIg87THGgkqGH8Sh
        H06eyPLzwVZj1n3De77GoW/3PK4bN17COTAQitqYIWJLW98aRe39Kzyq7ncG7RNiruYN0Cmhdx5jh
        lpUbU7v2lPdIWFE2gk4WZo0ZSPe23Nm3DbCe22taupIZghGOTlYlg6J7WUkROG0faz4y8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1foAYf-0004sm-6P; Fri, 10 Aug 2018 16:46:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C0A4C112435F; Fri, 10 Aug 2018 17:46:36 +0100 (BST)
Date:   Fri, 10 Aug 2018 17:46:36 +0100
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
Message-ID: <20180810164636.GI20971@sirena.org.uk>
References: <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
X-Cookie: Words are the voice of the heart.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 09:59:46PM +0530, dkota@codeaurora.org wrote:

> Now the need is, how to communicate the SPI controller maximum frequency to
> SPI core framework?
> Is it by DTSI entry or hardcoding in the SPI controller driver?

If you've got a limit that exists in the IP the hard code it in the
driver.

> My stand is for providing the DTSI entry.
> Why because, this keeps SPI controller driver generic across the boards and
> portable.
> Also it is not against to Device tree usage because maximum frequency
> is describing the property of the hardware.

If the limit the controller has is not coming from the clock tree then
presumably it's a physical limitation of the silicon and isn't going to
vary per board.  If the limit is coming from the board then it should be
specified per slave since different slaves may have different
requirements on different boards.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttwWwACgkQJNaLcl1U
h9BPcwf+JNWdFryuW2eK9kP9w/E8+jHe6SMG9VTzvgwMXSdHOv7xs8iZYKUKoYJt
mXIOa8c2HKAK0BJYqXqceA5XtPZ4/+Xtw3PZGOaoQiv90WNHSdgN80ngek/ozRev
BjJyrrbiNTYbH2kq9nSCLu0Paw5kl1PfLRpZgfFrrZhn+H0W85+wGo7i0BkLlOmx
YfwbgV1WiawSv8UABQu/AJzWyj1trYZOqrF4NKKR9V3tFsoNwIZgtlOJpF4uz3u+
qeqe62thRBqRrX3jBVZuj77Fb3r5Pl13RaqngtG8BwWv8oZ0xx0qkkaX66GBf1OC
mco07vPbT7C7Y52ucvyNGWEte6b01g==
=wK88
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
