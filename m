Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30C72148D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LeZBr3Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C72148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeHOOFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:05:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47362 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHOOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B+7P47+Mv/OShRXbOEpmFk+FATWbrn7FDjz9xNNj+SU=; b=LeZBr3Yf5q1cGZODrxmjhNeZa
        YDfbubouCN5lOK3DeWchpvTd3nVUyWZWtvAaF0WsqXprn1pWdBQ6ANnASr5DQwSOFYSvwvAnVKyv5
        1MGpkBWRnrrExgku5qN8Q1iacVqqAGuFo5BdWMOUa38+eT9guZ1wqG8WN5x5gSCVvLLew=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fptjs-0001bZ-3Z; Wed, 15 Aug 2018 11:13:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1E33F440078; Wed, 15 Aug 2018 12:13:19 +0100 (BST)
Date:   Wed, 15 Aug 2018 12:13:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
Message-ID: <20180815111318.GY2414@sirena.org.uk>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
 <bf70f01d-41ac-dcdc-b503-5e0eb1e70329@codeaurora.org>
 <CAD=FV=VNCOyyq5+xvSudTmtBgPm4-s7gj7GRCvuL5vSmA6yDVA@mail.gmail.com>
 <aa2bd1f6-74b4-a63b-d115-88d6e16ed95d@codeaurora.org>
 <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o/BvujNCPFVhiGON"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WBw2SKgPq8Atb+SkziUku8p7N4GWemHYZZvoMSE0bK9g@mail.gmail.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o/BvujNCPFVhiGON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2018 at 04:56:42PM -0700, Doug Anderson wrote:

> IMO about the best we could hope to do would be to map "mode" from
> children to parent.  AKA: perhaps you could assume that if a child is
> in a higher power mode that perhaps a parent should be too?

That's not going to work well - different regulators have wildly
different abilities to deliver current which is the whole reason why
modes are so fuzzy and hard to use in the first place.  A high power
load for a low noise regulator designed to feed analogue circuits might
not even make it out of the lowest power LDO mode of a DCDC designed to
supply the main application processors in the system or (more
relevantly) provide the main step down for a bunch of LDOs.

--o/BvujNCPFVhiGON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt0CscACgkQJNaLcl1U
h9B+Kgf9HS5XAoJXshcYgt2CrThQDosEbnz78XdZ2lGsN6BNUXsumLPsHBnX3rzl
pyhsw60PmtVys2LqrZLnHnJ4GFh2Zv1wK3vqFHVJwW4Pvm1j2IoAYzIplZCVggtJ
qgTD++1e7JoIBlK5NU2UbqDTcueKijSqLVmzTuBYM/asgEb/sWRkav8f6ldMxa70
FflcQrxbtjTkPhKZoeyipt4mSgpor8f/FJBG45UK1fePouIFy97G1phNimXUCCSR
CKxrdrx7VrcDhjdoEcyGb2NwAyRS7UB3n2qX8j7RJ7W3mJ6z2WJM+ejofu4U+ILE
nqbVelxHMe4eKDFD6/btdJ9bY4xKvw==
=0y/O
-----END PGP SIGNATURE-----

--o/BvujNCPFVhiGON--
