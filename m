Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A34C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFA4218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548354926;
	bh=AYyaHBs9oZI6aKoV2AOxgPU5ARG8zVp+32O90RVJnhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AFOdXZigPjSypALTrFb/+DHoS20ajA/fw059bHYxbidqOeN3buRhZrO4PVX5wY9xP
	 GV8sFNvCe/pAeu+F/w4HpX+z8SqIdhaBlQfYza05Is6cLyjQCiw+x9hKckfu1grYnV
	 Yio7LW084LRchwAl7AGpf00vcAhRZYrIMczINxsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfAXSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:35:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAXSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+ZRTLp/uSfeqKdlo/+njX6KdwZIPvc496YNVX1pjU94=; b=p4+Rp+/vodk59Xz6UUzauwlhL
        lIpTg6XkXxVR59+JkNXkKvYVP5WfEUPa1pvWCdOHzkufnFIVckpXMyu2wQ+BB/oTceKjP3wdL3BIX
        NzxSC3R54+JovxntEEsta3tRtlLhcXDmiD0G6+YC03ExssL3TqOHzT88DVz67rQU4tZCc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmjqP-0006ad-3F; Thu, 24 Jan 2019 18:35:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6D94E1121B6F; Thu, 24 Jan 2019 18:35:16 +0000 (GMT)
Date:   Thu, 24 Jan 2019 18:35:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20190124183516.GG5641@sirena.org.uk>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <VI1PR04MB5726F4A5073E3E4C01E61CEE99980@VI1PR04MB5726.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5726F4A5073E3E4C01E61CEE99980@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Cookie: Love America -- or give it back.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 08:54:59AM +0000, Yogesh Narayan Gaur wrote:
> Hello Mark,
>=20
> Can you please apply below patch in SPI tree?
> Patch has been reviewed by Boris and Frieder.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKBWMACgkQJNaLcl1U
h9DrBgf/REAKB4rWORx9/tToi7RLirNzI0JRdRCU7oYs6F4KmE5JdgPCdHGeRP3x
j2WNkMX3cLo5cQJ+hPqTiTYPzdmC7laIDjvJl+s0IUYZhLjxjpZfMrd57OliNd04
gER50xwNJowG0d71gepBkOwApy+HUpApFMP5GDzc3Lc6hSrVqphlzmlbxCZVhku9
Pb6Vgs8BYo6BhRQaTH2qUbtf6Euw7csOnY2ekiyE9WuWpoC4YTWTVXc6YOwFLu5C
hid26ImHy4QcsomHbqSTEH/gW1Eac8Z5/NFxYdHZv0uOGQRQk7PW09ddLEupbZ10
+vp3rTIIobw+kOiI/GHwRwubz+80NQ==
=bc1i
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
