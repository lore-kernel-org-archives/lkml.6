Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C1FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F465208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gP2ntFxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F465208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeG3QnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:43:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3QnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xhFb0rLdfmWvEdFhaCBSBot3Hi8iz8zujSR2SlQzco4=; b=gP2ntFxawMXF6SUvSipqif9tz
        VkXSa6Mrrs2Qk4AVNaSW67soLK1iIEE21pw4VuiEDvndpDqtMt92ItzMqAyK/vq1+OFMN+UF48iWh
        8HLKQs07wbR/UN7wvskhUy2e61zf6+4bkxCOSBzMoz6egSK3QejKjElrPfj59cRtnbXFg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk9m1-0005W5-SY; Mon, 30 Jul 2018 15:07:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7CFFC1124216; Mon, 30 Jul 2018 16:07:49 +0100 (BST)
Date:   Mon, 30 Jul 2018 16:07:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, lgirdwood@gmail.com,
        thierry.reding@gmail.com, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 2/4] ASoC: tegra: Add a TDM configuration callback
Message-ID: <20180730150749.GK5789@sirena.org.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
 <2392df6f-12bc-74fe-ec0f-50dbb7b9a33a@nvidia.com>
 <20180730101800.GF5789@sirena.org.uk>
 <2a91268d-351b-d342-42bd-8ffbf33a316e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <2a91268d-351b-d342-42bd-8ffbf33a316e@nvidia.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 30, 2018 at 03:04:46PM +0100, Jon Hunter wrote:
> On 30/07/18 11:18, Mark Brown wrote:

> > DSP modes only care about the rising edge of the LRCLK, the pulse can be
> > any width without causing interoperability problems.

> OK, thanks I was not able to find a spec that defines this, but I saw a
> lot of codecs use a single bit clock width. So then equally making the
> default '1' should also be fine.

There's not really a spec for this, it's just what tends to be
implemented.

> I still do not like configuring the fsync width in this function. The
> fsync width needs to be configured for both DSP modes and normal I2S
> modes and so it seems it would be more appropriate to do this in the
> hw_params function for this driver.

You *could* just always use the I2S width, it's going to look odd when
people use a scope but it will work most of the time.

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfKcQACgkQJNaLcl1U
h9BB0Af+IyXKfsxp1Wb1UfKoIPDIVgYtmwl+1Y8/bfWN3+FAgD2w+KKS2NA5mRBg
WpXyuoJ1JxIj4016p+YX1JBtzQKAULHGaEK/GjWGHbh0e6hlG6uKgnAXTD2bGBjT
vz0SanSzblF0DTUHzH4gZHc+/K8TK/LUWjLdDmrOFePZ+Uk83fCDbtPuJWPQ4t/B
b57efuww3wXP0tAKIKFAtW+trIWXhByODi/tjqsR2VFE9gcUIsgpPtiq+dkbhPDb
3GJMrdExpTTIh5oG3oBu+8MyhJxw/Km6djZrC5cXPUXCV4B/dg0Y7TXcIRn5/lDI
8gaHajCblyhEYmfxnF+8ybq0yjffag==
=Bfke
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
