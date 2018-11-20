Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403CFC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C065B20684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="h3rwxnyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C065B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeKUD20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:28:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53420 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeKUD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+0BJ+oOrAhIs6pbR+2gNDWdvStfwUVcd4odyDq5JR1s=; b=h3rwxnyQm6wsK5np4HPU/ydDa
        hEVDcT+3R8Nfqu/otxWS71YlOB68/V0AqM9Qi+wn8OgAgjkk75Zslqn79xGvyN7Kvp9/ubYHlP+An
        XBL+9JSk/Bx19IQfVhYMKqPONS1qMzECKFfPTH4+L+Mr2Mmlm+pIw04e/Cep6sHIcZKr8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP9Lr-0001ou-CR; Tue, 20 Nov 2018 16:58:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E951A1124DC2; Tue, 20 Nov 2018 16:58:14 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:58:14 +0000
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
Subject: Re: [PATCH 5/7] regulator: core: add enable_count for consumers to
 debug fs
Message-ID: <20181120165814.GM3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-5-dianders@chromium.org>
 <20181120161055.GI3894@sirena.org.uk>
 <CAD=FV=UO1Dt3SeDs22EgH-95dWX+jq0sU7zzRgew11_DVw43cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F7w+4yMapWozG0Ib"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UO1Dt3SeDs22EgH-95dWX+jq0sU7zzRgew11_DVw43cg@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F7w+4yMapWozG0Ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 08:52:14AM -0800, Doug Anderson wrote:

> I don't want to send v2 of things while you're still reviewing.  If
> you have a chance give me a ping when you're ready for me to send out
> v2 of things.  ...otherwise I'll plan to send it out later today or
> tomorrow morning.

I'm pretty much done for today so probably easier to just resend now,
I've got other things in my queue to review anyway!

--F7w+4yMapWozG0Ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0PSYACgkQJNaLcl1U
h9CwNgf/SgaXlhuqiNRv/lXtD2mLIzDTktcmdbLW5fZrcZOJ6mePEJWVdP5ARBUz
EAjA9FvRebY1kf8eE2by9LNVHU9XJYJF7qCEwh7YcV2yd2ri0cipW5IgyoA036x9
ACbEukCpP0DXvrIny+XqLlCLRpW7qLForPn3Tzsek9WT0XbjVtcOUxJFQvHQfqNw
J5dEBfqae5JLzEFKN3yZba288tot6k2F8hjl9nYRRryPDD70iNKQVS7gJHIFABtD
c8UrQk4DvoyV1XEJZcoXeHY++qhPvCbwH3GxnrRR75OAj1PuxHE7gAqFdJel3WrF
5Ify5U7b9oLKsTWft0N0723rLpJvIw==
=5XJc
-----END PGP SIGNATURE-----

--F7w+4yMapWozG0Ib--
