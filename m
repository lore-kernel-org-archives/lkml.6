Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6130CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F3C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ov7gOdrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F3C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIFOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:50:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeIFOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oNwk6Ug0sOTdhF8+xw4FGpIKYeE2/tGou53mkYclrOM=; b=Ov7gOdrJLKUJCtb63h5R/04r8
        DvFfEUgtC4QDxA0zxJ916Z4VaJvGNfWPCO4MXnLVgULxSoHDdrGXtrowv6oIQ/uyiA36ViP7sW/Od
        Pu7Iim3p6GqRjrU3oi7YZX+k1xISo1QXdPd/CCRyWlZWyboYF3I33euj/xJwnVm9BVep8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxrJl-00046t-Ee; Thu, 06 Sep 2018 10:15:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 084D91122A1F; Thu,  6 Sep 2018 11:15:17 +0100 (BST)
Date:   Thu, 6 Sep 2018 11:15:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <20180906101516.GA5360@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20180827014815.GD29208@dragon>
X-Cookie: You will lose an important disk file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 27, 2018 at 09:48:16AM +0800, Shawn Guo wrote:

> Can you ACK on those two regulator patches, so that I can queue this
> series up on IMX tree?

I was expecting to get a pull request with the precursor patches in it -
the regulator driver seems to get a moderate amount of development so
there's a reasonable risk of conflicts.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluQ/jQACgkQJNaLcl1U
h9Dbpwf+MZa+AjERwuP4i++2zvh8VAZqhxPFy+ijMGRaJATDNumhfGA/bycWyDdN
r1Lp0EhBmeGqiMtrhDoqw+4kjF5H03mhTvrjG0U4C8vOUainMOEWSSpBeq9ST42t
wvScVpuLON1EZUt6n23wPMmc4fDlvKbhlY2QRTl3NP6eIAafaym7CzC49rS0PdnI
Pi5qCQrlt9X8eChyKmUkD6oENeFAvUAZLlf8Elxz8Is3bB7lNIzaIrlImSoGRMUQ
TZx37KNyvsEcCrzq47ALMySZe5auC1fc97ghqmIpxIcL2hmmGPYY8U86i6UOsXyq
a0AnQkQOjdWb4Dm+IHQD3tT4vgsIoQ==
=Ytj1
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
