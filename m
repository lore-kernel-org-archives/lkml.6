Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCCC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D791521725
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DBbTkO1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D791521725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHHMJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:09:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lyOh+E51IkJJarEp/Q6nRP0TBLHGLto+TqcobvCpjvI=; b=DBbTkO1WwovOmeiOEKYr+acum
        x1I3NgmOzf5txSYHX4JL5hqeVSyKjzJ1sFtkZntxWu5yDUQgYNcatg6NecYotYx0D93IGHpyV/dEu
        Ow/qCWw2mogWGV3ZUZiEVt8ObZCkGSx3hE71ZGc680GJ6cMOFyJCcKeoe8DgBmHCk3F0U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnL6o-0001ex-Bw; Wed, 08 Aug 2018 09:50:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EB3AF112433B; Wed,  8 Aug 2018 10:50:25 +0100 (BST)
Date:   Wed, 8 Aug 2018 10:50:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Message-ID: <20180808095025.GB9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
 <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 10:26:42AM +0800, Baolin Wang wrote:

> Sorry for confusing. Let me try to explain it explicitly.
> We can set the word size (bits_per_word) for each transmission, for
> our SPI controller,  after every word size transmission, we need one
> interval time (hardware automatically) to make sure the slave has
> enough time to receive the whole data.

OK, so it's an inter word delay.  Some other controllers definitely have
the same feature.

> Yes, I agree we should configure it at runtime by the device, but we
> did not find one member to use in 'struct spi_transfer', we just find
> one similar 'delay_usecs' member in 'struct spi_transfer' but not
> same. We can use  'delay_usecs' to set our hardware interval value,
> but we should clean it when transfer is done, since we do not need to
> delay after the transfer in spi_transfer_one _message(). Or can we add
> one new member maybe named 'word_interval' to indicate the interval
> time between word size transmission?

Right, I don't think we added this yet (if we did I can't see it).  I'd
add a new field to spi_transfer for this, then other controllers with
the same support can implement it as well and drivers can start using
it too.

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltqvOEACgkQJNaLcl1U
h9CY0Af/eBUJ7rNaApVEZ8zpR9awGuzC9IkLgzgDsXKKYPO7657rD75vSDe7NhbK
s+qaczqcFz7hBawHtE8wHyZP4WRyDVp5H7RiFxQ1XWCG8Sj31l3sEEXtNC3BuvLn
6sS+pqWgyyElqcyrysHOnqam2EI6VyMUTq2mNFSu+Z5GIAzMYtsQhg39aNbsG70E
F3xh/Wn84anaLdYqt+2kjLoD1FaS2snHcFWRAH7sop+bz7vzd02lDeczUOOPbdFT
sQ+33BqFpVb6wOaPP+lkOrACkoi0wIbHzfkZZifJ6olGqxlQpELH4hjP8M8zrXqa
rzHzUapZ1Duu7QuW0UyTQ/lgPtSFuw==
=vp/V
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
