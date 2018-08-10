Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A96C208A2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KCEO56gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A96C208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeHJSoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:44:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeHJSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wzTghTF77tAeBFjRr6pR9+nUB0Dsn+wNLR0E8XhYiNA=; b=KCEO56gVIOscFqgVoZl76/mqH
        9FKQfn+DDdt8E1pCFA9z36l6SR/cTAEeUqTSEz2a0GbcNNKu+IEKEhz0t2uVG6H8+aoPuOia00+B/
        g6XHEhDJFNm3GyzI4EkMj6wR3cEOKccW8KtL2yhWLFrGiyXiNrYH6PacvCYY2g+5CVzOE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1foA2c-0004rR-KG; Fri, 10 Aug 2018 16:13:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E9D63112435F; Fri, 10 Aug 2018 17:13:29 +0100 (BST)
Date:   Fri, 10 Aug 2018 17:13:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180810161329.GF20971@sirena.org.uk>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
X-Cookie: Words are the voice of the heart.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2018 at 08:40:17AM -0700, Doug Anderson wrote:
> On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> wrote:

> > This is more about matching the data rate between the two drivers - the
> > clock framework could (and possibly should) reasonably return an error
> > here, we're trying to ensure that drivers and controllers work well
> > together here.

> The clock framework should be able to accomplish what you want.  If
> you just request the rate it will do its best to make the rate
> requested.  If we want to see what clock would be set before setting

The request could be massively off the deliverable rate - 50% or more.

> is "close enough" in this case?  I haven't gone and dug, but I've
> always seen people only specify a max rate for SPI.  ...so as long as
> the clock framework gives us something <= the clock we requested then
> we should be OK, right?  If / when this becomes a problem then we
> should add a min/max to "struct spi_transfer", no?

On the other hand if I ask for my audio to be played at 44.1kHz and the
clock framework says "yes, sure" and gives me 8kHz then the user
experience will be poor.

> Note that there are also clk_set_rate_range(), clk_set_min_rate(), and
> clk_set_max_rate() though I'm told those might be a bit quirky.

They're certainly not widely used at any rate.

> ...but maybe we don't need to argue about this anyway since IMHO we
> should just use the clk framework to figure out our maximum speed.

It looks like that's true in this case.

> >> 3. If you really truly need code in the SPI driver then make sure you
> >> include a compatible string for the SoC and have a table in the driver
> >> that's found with of_device_get_match_data().  AKA:

> >>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";

> > A controller driver really shouldn't need to be open coding anything.

> It wouldn't be open-coding, it would be a different way of specifying
> things.  In my understanding it's always a judgement call about how

If you're saying we need clock rate selection logic (which is what it
sounds like) rather than data then that seems like a problem.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttuagACgkQJNaLcl1U
h9C56QgAglrArQUJ8e6VWpysiJHTDYTQiBTMu44TKWqCmHfwRIcunxD69KplacD2
fEfFpx7jophEdqkW/cOlEGs5F5cQcRweUpQwCilAPM1zGZGddHTW4ieKg4gsm7Tx
PuyvAUuMlU3iKeBJQq+DxJHSiaJoVDeg/gtE/3rGcWTlkFhRfa3IhOOmewIGEVEr
p852aA2Coj7twDyGDx/rHei1LcduMzSjppgJ3oEzT97isv5ZeDYAHdzOxVrz6sFY
eUACwerhO2Q/M96goAT7p2Evq47K4iIDccrlYeR+BPMXGtIotJY6MnGuHoBE9KJB
fJyMD6/A93ah3utqPgP3o5sfOWJPaw==
=GW8t
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
