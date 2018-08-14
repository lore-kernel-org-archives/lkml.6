Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FEC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F3D216FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PosIJiL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F3D216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeHNRvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:51:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50090 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbeHNRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YN7IC7mVKEBE2m73ACk3iJCCeUmvgN9NiJU3scgudII=; b=PosIJiL9Rhj5MzBtkQFSJf8zU
        Mh20WXYA7I6haLVsR4/l192fqqj/d7vbSA4y+Mef7WLnHGv9l9vMyVAXpC+SofY6VBFoQZ9Lx2dwh
        bkgiyKGH771LVwB+gMVVZQuxahhVo58tuZNi4doO1uVCbmEI9+BmTXxZV2avWRaDW03OM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fparF-0000tx-5N; Tue, 14 Aug 2018 15:03:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CFB091124449; Tue, 14 Aug 2018 16:03:40 +0100 (BST)
Date:   Tue, 14 Aug 2018 16:03:40 +0100
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
Message-ID: <20180814150340.GE5810@sirena.org.uk>
References: <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
 <20180810164636.GI20971@sirena.org.uk>
 <b32c205955e0f42182b16e90f539a919@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <b32c205955e0f42182b16e90f539a919@codeaurora.org>
X-Cookie: All true wisdom is found on T-shirts.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2018 at 02:30:02PM +0530, dkota@codeaurora.org wrote:
> On 2018-08-10 22:16, Mark Brown wrote:
> > On Fri, Aug 10, 2018 at 09:59:46PM +0530, dkota@codeaurora.org wrote:

> > > delay_usecs is for inter-transfer delays within a message rather than
> > > after the initial chip select assert (it can be used to keep chip
> > > select
> > > asserted for longer after the final transfer too).  Obviously this is
> > > also something that shouldn't be configured in a driver specific
> > > fashion.

> > Hmmm ok, so you mean don't send these as controller_data, rather add
> > new
> > members to the spi_device struct ?

> spi_cs_clk_delay -> Adds Delay from CS line toggle to Clock line toggle
> spi_inter_words_delay -> Adds inter-word delay for each transfer.

> Could you please provide more information on accommodating these
> parameters in SPI core structures like spi_device or spi_transfer? Why
> because these are very
> specific to Qualcomm SPI GENI controller.

I'm not sure what specific information you're looking for here - these
things are not obviously specific to your controller, I'm even aware of
other controllers which can do them.

> If we define them in spi core framework structures, SPI Slave driver will
> program and expect it in the SPI transfers.

Sure.

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlty70wACgkQJNaLcl1U
h9C6EQf+MI9wpvQNCHMVn/4MvVEBuFzqeRkFsXgMF1dMQXli8MKY5y2plko5f9JV
Wu57KVeKDFx67EmDATZ0qIvDZYSBHL1zbNREffKZpOx6r5tuVTvqh5NiybpUWxor
gx9+NBTsV9lpZV1lkxQ2rAfEfRcBKDSjPxswCvWvBpFl+FC87mVexMZ1uhTUAdO6
uFMxlAtxS6OTMQvLdkctJOLh2b/TY1WKUtlZdqvWb3KvsUexsibevEJ9Gr3MoL4o
dKbcw0m5uJiWKpR9uRvpvA2QY4nZHUPV/eY60St7hK7E0x87BR2CjoXCvCD6PVGB
MsRMU5ODPSqRpXHYzM+bkEv6wqepng==
=6hLB
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
