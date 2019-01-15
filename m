Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6BC206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547510878;
	bh=vG7AnFwP9ec7CKKsbfhvU/Aq8JTWeaxTFK4EjyYuOoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CyILdWv2IJvgzDuEQWAcs65nP4L850PBmoxVcs5SD8HMvbhLTaO3HyU9CMM8peqbA
	 jC66gR+fEhX0VDAdcXhc4FBs4Bc4kyWGRWiRC0pb8iyprqDwsZuYQAdcvJLdagtYtz
	 6PDPMjceGgqs/15FMzC7uNnJ4Y0/rkDGANwe1Mp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfAOAH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:07:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34284 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOAH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZT7U8c7FkipL5LXE/wg6guu1bLSKqplUm2bwb0xgkVY=; b=ila+VZ8IVErRbGK4n3t3gwF76
        f+2wPWrXeHnVB4JFHXuz8pABB9FbREsQzf8Ow22xe0IVpZQaUa5p9S4+VPH9oWRULCtIKQXQ9xBux
        BQb4ftWJNvg5E0fUj/pnjV0Yux/WQy3mCfuSTDl6KfHRlljQcFPk7T/NJmmO4IQoJkVAw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjCGl-0000rH-EK; Tue, 15 Jan 2019 00:07:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 182B3112349B; Tue, 15 Jan 2019 00:07:51 +0000 (GMT)
Date:   Tue, 15 Jan 2019 00:07:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to
 word length"
Message-ID: <20190115000751.GN11073@sirena.org.uk>
References: <20190113204905.29795-1-david@lechnology.com>
 <829bdc72-cf96-6aee-28d8-a47d0430710d@ti.com>
 <bb7e13ee-f6ed-a619-c56e-53aad91a1432@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="muT+E17Lr9urPYYJ"
Content-Disposition: inline
In-Reply-To: <bb7e13ee-f6ed-a619-c56e-53aad91a1432@lechnology.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--muT+E17Lr9urPYYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 05:50:34PM -0600, David Lechner wrote:
> On 1/14/19 6:30 AM, Vignesh R wrote:

> > Oops, that's unfortunate. I see ili9225 is using bits_per_word = 16.
> > I believe commit b682cffa3ac6d9d broke spi_transfers where
> > bits_per_word anything other than 8 bits.
> > I don't have ili9225 HW but was able emulate this condition using a SPI
> > flash as slave on AM335x and successfully reproduced the issue. Could
> > you test if this diff[1] helps in fixing the regression without needing
> > to revert commit b682cffa3ac6d9d?

> Yes, this changes fixes the problem. Thanks!

Excellent!  Vignesh, can you post a formal patch please and I'll get it
merged?

--muT+E17Lr9urPYYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9JFYACgkQJNaLcl1U
h9ApQQf+JngYgg+9axbvrDu2ynOzMBfQv4geh11lfBgwzY7SXADxRHuDtFh4VdQl
snxbKo8w1T3egW+Bde5rB+2+8N/vreWuVyiMldtwskxEfeDl15xNNM2gyBgVv3us
kf/h4Hg5r6YBdwawzrKu6VRt5QohWHlx89MxzzxWXe3YGLCLoLaO4GKgVNfr3KHU
jhlrJhj0fQ6cIxRx3Avln7I5xCOHnBSDyfWMzKaD2YFlkhLX4zbu85Veo6goWtCy
PST5E82nv6iAEydkLDYITBfenjKfOUHKysLUhWLbqaCYgcWMGej381hEFA+PXtGt
L0gQTFCRIsav8h64y4NSmBbR/gZUqg==
=9Wx9
-----END PGP SIGNATURE-----

--muT+E17Lr9urPYYJ--
