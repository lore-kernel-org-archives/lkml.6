Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B4FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57DC2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782152;
	bh=neEVqxI62HSh/GSii2bA1jU0sPmvhXZXWFhx+WADyKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JI5gpoUNJfxG+LXuqFb3K8ILyWwHLUcFZp8j1nR521XBFtQyks34WSj4xcsvgd3pM
	 eY4DvlHSkuCXwfh5HOXTBwQ1XZ83pkSzfxCsh6TRWjoM7DSRhK4czm5Gve1MbBQIBy
	 LlXyDKa0nkM8P5/9rjXzKwKjP4pvgsAkvOwvIhkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfA2RPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:15:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2RPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N/XmHESboUUMJJBSD+32AfmHQP/9IBFP/cJxLE6FwcQ=; b=I/M1J8Peo7tXO9tySrEQX1WYX
        RGQG+qPY7kKRvw+MzqFWBxfq2ZypNA44s/f5T+VEZW5wbor3mcqUXYv8vkkTIP7RhIB9T3UMBxjk6
        KN+8JZB+luQ3hFcyO8W3UHZx+wIX/JlgWa7/tXKYsBnHILb5fvLXPUQ+XdX9HMMkyzrFw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goWz9-0000jO-SL; Tue, 29 Jan 2019 17:15:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3ED1B1127D50; Tue, 29 Jan 2019 17:15:38 +0000 (GMT)
Date:   Tue, 29 Jan 2019 17:15:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171538.GH10524@sirena.org.uk>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
 <20190129171151.GC5720@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
In-Reply-To: <20190129171151.GC5720@atomide.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 09:11:51AM -0800, Tony Lindgren wrote:

> OK. Let's see if Sebastian spots where pwm_vibrator_start()
> and pwm_vibrator_stop() might get called multiple times
> or something similar.

Given that nobody has noticed that the driver stops working entirely
it's possible that the pattern is something like:


    pwm_vibrator_start()
    pwm_vibrator_stop()
    pwm_vibrator_stop()
    pwm_vibrator_start()

so it's a temporary underflow that gets corrected (or it could be that
not many people are using mainline kernels on these systems).  On your
system it's the dummy driver but presumably some other users have it
connected to actual regulators.

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQijkACgkQJNaLcl1U
h9A4cwf/aclPNONX4zH51MhkLG5+5pZu6gbqGvweUIvCUzuMLek/X/ryb4N6TYlo
ku47rPQwnXAif8zc1WEHu3cbPxoPW5duseH8192orcrGc0KPSGnFkJVhU6fvNVu4
qIlZRwy7EMzWsPq/BXIz6WEQCMa/RcRGL0I7jpKd136ROJRQbrQxWF2iixSMHOuU
qtMyEgni1HZMFYt1nB2EUlkwMiWdJmMBQgfMzQMORKoiPWWZvebeayTohFsjbGIM
mu8Bu6AkJ/BEOpH4KKlC4FA+8SVHc0bGDvrfu/BG0ykfh6O0m/uC3f4aUztfIrLe
1Si0xmVD0bI64+AYC2bQUMmB0g0Gag==
=9aT2
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
