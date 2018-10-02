Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE82083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tGGjReek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DE82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJBTxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:53:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeJBTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UVegUocUh1V+C4iex/SsT/n8Sipv6x8r2ZhndK8lB+0=; b=tGGjReekYT/NAXYSlWeDesQ6T
        o4l+09lHnLrWMIIVDnD+VNvo36/AAg3Tapjh1q3PADUOWhHptdg5uE0nk1f+i9+VAG17Wyhp2XR+G
        obqxAzI2CfMHHfoeSfkpnR34OroMGsT/vVeOp/SPA1yHTOKbKNMGTygggG0ky9UVE799w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7KQw-0001oS-JI; Tue, 02 Oct 2018 13:09:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3D8531121CA5; Tue,  2 Oct 2018 14:09:50 +0100 (BST)
Date:   Tue, 2 Oct 2018 14:09:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with
 spidev driver
Message-ID: <20181002130950.GB6338@sirena.org.uk>
References: <20180927223152.24990-1-lukma@denx.de>
 <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
 <20181001142219.GB19099@sirena.org.uk>
 <20181002101120.0f92f296@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20181002101120.0f92f296@jawa>
X-Cookie: Please take note:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 10:11:20AM +0200, Lukasz Majewski wrote:

> > As documented in SubmittingPatches please send patches to the=20
> > maintainers for the code you would like to change.=20

> I'm using the ./scripts/get_maintainer.py script to obtain list of
> relevant people.

Your patch went to the right place (and I applied it yesterday), that
was directed at Jan - the reason his patch got missed is that he didn't
send it to me.

> Please also document in the ./Documentation/devicetree the introduced
> compatible -> there are some examples (ge,ahca) in the misc directory.

Good point.

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluzbh0ACgkQJNaLcl1U
h9CCLAf+O8ovcnyt7n217i3PNbpBCy2tXuBEjw9QNZgqhrb5w4odEBh1nvZqHnH5
N0Eh0Ym6BFKxJoNu9u9478neqSNOo7EIy+jMOQ3JYRLDiuzmMRBz6KMeSpE5LqZm
PGt9xy4D1XwuCj1qLdjN875BIqS2gWAsbQUXFbVw7Bk8R0JTwjHb6A2w05lhu2nD
zCI9Hpzcqe0MzQAsQqvg1DVAXUNFBcI1vVdIFqBxDfjoCrAhM4dPgLAx3CteU1gt
xl7/uUCVEtnThIjp21wvaqs8rdsP0nWZDJULMLj+XfHxD5htLeep6MRbo8jFDttl
eFwV0QBMtC4i3Efe1+InfR9K+7mnUQ==
=mBMW
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
