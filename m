Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5784FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vu6uRu4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D80D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeG3L7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:59:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeG3L7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Z/wSp0Eolx1PIBWyovKNFV2XnDJrV23k9vVqRPFwD0=; b=vu6uRu4kDsyCb/kIwTiXKWxnJ
        HZA2KWMDqPzFQI8qqFB9IIBfpn/LAN0ltIr73o2IVEriFNgdsEhVRV//Wo4hQyWiAr8iDH3yzBD11
        yb77rKRzKL5e6nXPfVBqpFQYgKCKnvBYc5mX3qmE4I4LtITDCNMN5Mzb2NwsvmiPjXXJY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5MD-0004ws-07; Mon, 30 Jul 2018 10:24:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 867FC1124216; Mon, 30 Jul 2018 11:24:52 +0100 (BST)
Date:   Mon, 30 Jul 2018 11:24:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
Message-ID: <20180730102452.GH5789@sirena.org.uk>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <06313062-70db-9c10-048e-78ca267da959@pengutronix.de>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 30, 2018 at 09:50:55AM +0200, Oleksij Rempel wrote:
> On 27.07.2018 11:32, Robin Gong wrote:

> >>  #include <linux/slab.h>
> >> +#include <linux/kallsyms.h>

> > Is it necessary?

> yes, for pm_power_off_prepare

That's a *weird* header to have to use for that symbol, are you sure
there isn't something more specific - if there isn't there should be.

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte53MACgkQJNaLcl1U
h9BsBAf9HfE13YI9qSd1GydHPbPMZnDKSMXtshjnwDivfR+hXUdAlsfgURLvs0V8
f/iR74SQjrH99baF0Fo9tSGQPkWxv4riSx2J+n4Kk7CxdcxK9OviyIdH4Ecg4uks
TdgBaVcRXwVgiRx3gIj9ij6xlEfljCPQt5uOBL/42JeJ+kH8Qt11P9BbudUvBR1R
CbjNPFILD4P5HJ+tIl3fyRru9+Q1rJAof1nP8iTczZRMutPmNGidM47Dg0/z5k/f
cr+pkjguyjyYCD6gD0S9+oAG6jcmYa6ddGPIT+47Qu+eTWpAHi+PVlzzhJ69L59K
BqyDpG9Pitz6iJDZYY51xye0o+fI3g==
=/6WQ
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
