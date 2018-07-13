Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E94ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5856208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bZrZFvb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5856208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeGMMK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:10:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55750 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeGMMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hM+srReUTrP3D6iuwF3E0O0nR5yeFhLTMbx07e9asQ4=; b=bZrZFvb5Wk3lvlLFLK6jNzEOA
        oISS0G7YhK7NnFVYyEXGqh0EvndX6DtYy7h9wUonU/TT+C3IF2NUjkoR/uboAltxKd0Le9blWW7ZH
        6M64Sm+YG3hUeoTi/RFXwh78GRv+dnEDlaun0rnIk4UHu8od0dgUssD1fL0ZZlJofkDAA=;
Received: from 94.197.120.189.threembb.co.uk ([94.197.120.189] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdwfp-00052M-1S; Fri, 13 Jul 2018 11:55:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 99352440078; Fri, 13 Jul 2018 12:55:43 +0100 (BST)
Date:   Fri, 13 Jul 2018 12:55:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v4] regulator: fixed: Convert to use GPIO descriptor only
Message-ID: <20180713115543.GB16228@sirena.org.uk>
References: <20180710061112.28736-1-linus.walleij@linaro.org>
 <5893595.ygSzo8aE2W@z50>
 <CACRpkdZbT-CpvaG4ZG76T0vkU_uyt20W_=vD-n9T3=Xy_5WqOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <CACRpkdZbT-CpvaG4ZG76T0vkU_uyt20W_=vD-n9T3=Xy_5WqOg@mail.gmail.com>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2018 at 09:35:06AM +0200, Linus Walleij wrote:

> 4. An immutable branch with the ARM SoC change for Mark to pull
>   before applying this so I can rebase this patch on that.

That'd be ideal, though just waiting till after the merge window when
all these cleanups are in works too - like you say I'm not sure we're in
any hurry here.

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltIkz4ACgkQJNaLcl1U
h9CwSgf9Hp/WSxylxaioLXw1GziQ+XAchHnbl/IKjx9JTuU2KzNc+pGSHsDxS/Ga
pDPI/WnithM4Fi1JUTzPu/feKXrVDvaHcyie21fZp172M8gK1sAzndmyDp0qDAzs
4AvK2zPmRQcMzdT08N6NPmNjhHEwufnqARSvbHGQWNrC9llsWEzLSU59G/xvcxD+
sygpGvrQpdItomrdMz5YwbE0GGMcKoEUJPAXGZXxW7P+OScdEI//XX6RwhDHK3EL
Bi9pDY9ivgJLf4lG3gqrjhPCmSFyx7W3lYyCyADm74OKIE1gYmX4hhWsMuZb6uvs
/nLnU8G4VrIzs/5h2jgf3ML6yF+MIg==
=K2Di
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
