Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ADDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4D3214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rB6iNJiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4D3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeHBN05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:26:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbeHBN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PA318PA398RgiV1EN02U21BSIzEod9WStdClzGcN3U4=; b=rB6iNJiXdIAeqeuygeYTUPxi2
        wlrtRej55WhzhL+2vfVmGQ/E+AM+0DoXt1l3GmS3otl+ue0kir1b+ClwLav0i1GS1MigIjYmku5Jj
        5jNxJwOvzE+VTKG4jWhjqT4PdZ+PK5yKEoSf0q8XHOiWneEcruRToTMV+LYocyDVAQD7Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flBtZ-0001zv-D0; Thu, 02 Aug 2018 11:35:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D5CB611242E7; Thu,  2 Aug 2018 12:35:52 +0100 (BST)
Date:   Thu, 2 Aug 2018 12:35:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-ID: <20180802113552.GJ9117@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Content-Disposition: inline
In-Reply-To: <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2018 at 12:47:27PM +0200, Oleksij Rempel wrote:
> On 02.08.2018 12:44, Mark Brown wrote:

> > I thought we'd got an ack for this from Raphael on a previous version or
> > am I mistaken?

> No, we got an:
> "Anyway, I have no particular problems with exporting
> pm_power_off_prepare via EXPORT_SYMBOL_GPL()."

> Should i see it as ACK?

It's probably good enough. =20

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti7JgACgkQJNaLcl1U
h9AhdAf/TbZVRZ28YFMBoAatxLryUYP178QUB6AlI/U68p5IlMOnGK/xFGaPJ7G7
bSyJWiVfHFTB2nKwoltQy219TQuUwr0c3RJ3t2kpFm06L5a/f9YyEZCndUxFOrgy
dMSAeU5QaiOmQvGcWNrCmoIJ3K38xDm03FOLnzjUZ2Mk0WIyCuZkuacRDqHPRkgX
t4WI4xTsEHJWybjs8fcfjmnyp8GAwAilOTGT0AeyuXJvTp4s629YzI7njDbcSqxS
GLaE1Lrat9D/H6exC9UqfOSvP4OCjWCXYeSUPUUCgoMlWjYNtT0QVyM60tfizgtE
4vMkCluS9U/eszAJV2Vchh0RIFiw/Q==
=2d1o
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
