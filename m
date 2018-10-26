Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C6ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7BF20870
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="H0F+v72a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7BF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeJ0A1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:27:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41392 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJ0A1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PRgV+FKftVz6tRkk9BLMxLe+S+GCm+0zLaEE23Jl2u4=; b=H0F+v72aSRRQEhOC9brrySIT5
        Ga6fHY8ZkVKtTbQzWmX7ZOcr7sRbB6kKElaBrP3/cX/WMAB6JtcVby4WqLuEtMFRbM3jgMXNd7lqQ
        aUNSDr+8MHE51Kd0avHR263I9cTGFBlQ87BuAM+5KLwM8NpgXl1g8867b4rieQkFru8CA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gG4My-0003ov-G9; Fri, 26 Oct 2018 15:49:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3A43D1122667; Fri, 26 Oct 2018 16:49:52 +0100 (BST)
Date:   Fri, 26 Oct 2018 16:49:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181026154952.GB27137@sirena.org.uk>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <20181025124905.GF16508@imbe.wolfsonmicro.main>
 <20181025132043.GG16508@imbe.wolfsonmicro.main>
 <d0e76752-1b31-e9e3-d684-9d78ddc98172@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <d0e76752-1b31-e9e3-d684-9d78ddc98172@opensource.cirrus.com>
X-Cookie: Kin, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25, 2018 at 02:47:59PM +0100, Richard Fitzgerald wrote:

> access. What does regmap debugfs do if you don't have a readables
> list? Just reading a debugfs shouldn't be able to kill the hardware.
> You might need to add a precious list which is more error prone
> than listing the valid readables we are using.

It assumes everything is readable unless it's explicitly told otherwise
or the register map is overall write only (like a 7x9 one).  You could
mark the registers as precious to cause it to only do explicit I/O
operations on them but that's not what you mean and won't be as good a
guarantee that nothing can trigger a read.

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvTN58ACgkQJNaLcl1U
h9DKSAf8DrGd/YKE8uiDncD7yHUOAm5PmrEulBdc2Kx0IjDAheyuOQdPuEBzwipb
E3rAWQartSyoTM4K3fgxJm45N1Be73cqlt271sdxrVuagBOqz/UJFXtUSGr80dlo
/KY2l7w/Z7LPatZT1QvnBuMop/0sZ5FDCB9a2rbAJ7RWoyJaY0uMC4SrznNEn60g
Ac0ppAPREE9oZqlaCLFNCGGC6jYig20LjH27kR4ZdW36mDo9IoRuoBMRpWlIoHZ/
yYcSyo/f2aKGWHosiOZ4Bfe8kodcxkDHjX0uMX5G+nacdY1y2IFfNYg0zOZwrI69
OJkiD2i4sLZ6cJBK9MI8O4X2wpCYkA==
=i4X0
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
