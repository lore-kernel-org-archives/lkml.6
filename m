Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DAFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBE820881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Dth/Aluv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBE820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeG3KXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:23:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3KXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G2uVkwMjctupkoc/6Az3OdtcbFkEZnbjMhX/QFKgFRc=; b=Dth/AluvYkZSE/uQWfb6Rt/xF
        8DEeTv0KR8dwZJsyQDH1d84O9b5zQrPEx/3uSCyKgyxZHN9uPbrNSArO2IC6uVxeeYji5CXTT0oNf
        ksK8j0LbFVPnc1xLqeSf9hENvDsiNsa5y7iJsutRjFh3t3rSIvBNDlB935pczrhtg4nCc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk3rZ-0004hN-A8; Mon, 30 Jul 2018 08:49:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E8E351124213; Mon, 30 Jul 2018 09:49:08 +0100 (BST)
Date:   Mon, 30 Jul 2018 09:49:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc:     lgirdwood@gmail.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 2/4] ASoC: tegra: Add a TDM configuration callback
Message-ID: <20180730084908.GB5789@sirena.org.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 01:59:29PM +0100, Jorge Sanjuan wrote:
> From: Edward Cragg <edward.cragg@codethink.co.uk>
>=20
> Add a callback to configure TDM settings for the Tegra30
> I2S ASoC 'platform' driver.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>

This says it was britten by Edward but there's a signoff from Ben before
his?

> +	dev_dbg(dai->dev, "%s: setting TDM: tx_mask: 0x%08x rx_mask: 0x%08x"
> +		"slots: 0x%08x width: %d\n",
> +		__func__, tx_mask, rx_mask, slots, slot_width);

Please don't split log messages over lines, it makes it harder to grep
for them.  Just use a long line.

I'm also not seeing any validation of the parameters?

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte0QQACgkQJNaLcl1U
h9BuNAf/cfHPyby2vIiYiBtKNjYyarPLvjsq0p2Q2DrR4uZY3N47QsCyaOYBw7BU
715N9S7k42wEkRpVzHXzYj2MzCj9Zvc2fJCRfnbWWCSUT75cRfzRZi2z8g7yBCsB
cFe/IpO48eFpMBNOlGQbTqa40dtu6SXRMAEa8q63aS34tq35lzB2hEt/WDwdO+J0
XiMXF7Cq9VxDKjOnTW7SOxu5PB2iCTvRSWxr/ts1Ij1cQl1emawM6bsfZeLJxBf/
DFEfvWY0I/U/MUftupOUqA1HSpYrUQ0ADhu8QzY4Kxvj3tPR4DGGj5vA50C8GBjS
VE6qk2lVUgz4pLECIh6wdo8+uIvEtA==
=aGL7
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
