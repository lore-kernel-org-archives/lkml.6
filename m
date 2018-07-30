Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F79CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10CE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YwHiyOZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10CE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeG3Lw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:52:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeG3Lw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LRRklxzKh3PGKaAk4gPruKmUVJhQ6sZ4PuzI+/uBJxw=; b=YwHiyOZHi9adnUzvkW1q8s2sq
        7G4wSJnKvxBACW2sk5TpAD4f2alzWnKhbqSRPY50KRu3vUUGqm7cBmQIrnFsb0s4NqzOIHMgUsEYg
        +e6cdqo8/V/a1QI9s2HkSWtdxnDwjsXLN1mVKOpmuW09D4bV4StXjH3ubIkwYph+nFKT0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5FY-0004vc-Jb; Mon, 30 Jul 2018 10:18:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 33F371124216; Mon, 30 Jul 2018 11:18:00 +0100 (BST)
Date:   Mon, 30 Jul 2018 11:18:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, lgirdwood@gmail.com,
        thierry.reding@gmail.com, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 2/4] ASoC: tegra: Add a TDM configuration callback
Message-ID: <20180730101800.GF5789@sirena.org.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
 <2392df6f-12bc-74fe-ec0f-50dbb7b9a33a@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <2392df6f-12bc-74fe-ec0f-50dbb7b9a33a@nvidia.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 10:31:16AM +0100, Jon Hunter wrote:

> It can be quite common for the fsync-width for DSP modes to be a single c=
lock and so=20
> I am not sure that is makes sense to set this here always to the slot wid=
th. It maybe
> worth considering add a DT property for specifying the fsync width.

DSP modes only care about the rising edge of the LRCLK, the pulse can be
any width without causing interoperability problems.

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte5dcACgkQJNaLcl1U
h9Cmmgf6A3ZVShnwGY8+CbCEKpg10pLzq0i/Hmy7ddaziG8FCQ6DzQDGV80EtWbI
OBpIRBNe9vIek89Z/ZTi3CFMrtF8wWVdREgHSqmGkAwfcvFd4zr6pqKcgVAs5ePt
wWpqWmOmIT+lA4zLbL9Rfg9W4tX9PiK5f+YESyz7fUPjrSPYNYJP1+VBWli4Srdb
/528dsJcuTi9YbOOpQ1JiJZD5DLc5BqjdJMjS9gbr+aqD/0XZaWNmnSVGAcI65JR
Og3Ipd8863WMsRIRO9lm+kVNp+InF9sZKUIgvP9xIbnzPQQeIeWs6xCYuWqVpGiY
HnjLSXrJBDuwU2gXh0ATRxC8GvU6xg==
=5Rul
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
