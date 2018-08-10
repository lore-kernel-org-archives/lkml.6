Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD362240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JZoBNjq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD362240A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeHJNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:21:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeHJNVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eRkf8MZjB9fV3uG7KtTTVSTd/J+Vveb7784OxD99u4I=; b=JZoBNjq4C9axYJ/O4B8ZxDOVg
        ZYP3nsyI+GgB4YVmobcu8whNtZngOlnBmXYQjCYLatYV91nmCbht3IC/apu3ejvxUsLptXJyjtXqM
        fWQ78oZsUskFAa2ua4Pldbr56lvL5/2UfElOSNBMQ+ye8PHQ3OOBzI36oRDGsGq4nvzG0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fo51Z-0004gp-MD; Fri, 10 Aug 2018 10:52:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 569BB112435B; Fri, 10 Aug 2018 11:52:05 +0100 (BST)
Date:   Fri, 10 Aug 2018 11:52:05 +0100
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
Message-ID: <20180810105205.GC20971@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
X-Cookie: Words are the voice of the heart.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 09, 2018 at 11:03:55AM -0700, Doug Anderson wrote:
> On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:

> > Also, spi core framework will set the transfer speed to controller max
> > frequency
> > if transfer frequency is greater than controller max frequency.
> > Please mention if you have a other opinion.

> 1. It sure seems like the clock framework could be enforcing the max
> speed here.  SPI can just ask for the speed and the clock framework
> will pick the highest speed it can if you ask for one too high.  Isn't
> that the whole point of the "struct freq_tbl" in the clock driver?

This is more about matching the data rate between the two drivers - the
clock framework could (and possibly should) reasonably return an error
here, we're trying to ensure that drivers and controllers work well
together here.

> 2. The device tree writer already provides a max clock speed for each
> SPI slave in the device tree.  ...shouldn't the device tree writer
> already be taking into account the max of the SPI port when setting
> this value?

Yes.  We're overriding this because drivers can set a speed from code
(this is especially common when devices have variable maximum speeds for
different operations).

> 3. If you really truly need code in the SPI driver then make sure you
> include a compatible string for the SoC and have a table in the driver
> that's found with of_device_get_match_data().  AKA:

>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";

A controller driver really shouldn't need to be open coding anything.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlttblQACgkQJNaLcl1U
h9AxPQf+KQEahUMu2kQO6OtDeFtXBcZ2ksAZDlIgWK3EgE2V+1e2o14Fqk5f5wbO
6ex/PhWVOQXpYlRVe5o8cREjTfNwskhtAlFTAvKQjlCS3LGAYA/Xi0Izu77QcQwJ
hGpwQl8Md9YsUXaywBBMWm/NJ55geKhOs/moNVs08yaBZ/vtPDzaJuHgbqSy3YUv
B8CwCcGmjZUdepp6Z/4S7pX5+KWkeuC1OiHTzh7b8FIMIB5Yd+FEznM+rFB0HjFe
KSWr+QHs+dtsba7kQmXqG1MnTzhD+KSOoQaeLaa4PLWMtGIKsp5+qpiQ9QmN3pSN
75PgrlHdMHzMsV3bGseTOrGzR0O5Fg==
=6XJu
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
