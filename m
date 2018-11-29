Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF84C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BFC20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DVkoI8WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BFC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeK3Dfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:35:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeK3Dfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+vSm4QFpPxQ7uARYvCftYJYEylVnkBZk3rtY48QsBj4=; b=DVkoI8WU6qOZY79vTMYQCmHWr
        r1ApyvtjL0i6Yz8onHEEK0786Sm9GB44hDU6s5UC7JNX48vLC9bEzxwc+uopGjsOuSDvLobXLKJSj
        hAKrA7W+z53tR8Pi0Zo9JvDU474m0zPxZEuNZDv8TLhA1DDSIufQYNkBDu1ba+8wCHbNs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gSPC1-0002lW-S0; Thu, 29 Nov 2018 16:29:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7F5D911251C0; Thu, 29 Nov 2018 16:29:33 +0000 (GMT)
Date:   Thu, 29 Nov 2018 16:29:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
Message-ID: <20181129162933.GG10570@sirena.org.uk>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <20181128152238.GV16508@imbe.wolfsonmicro.main>
 <CACRpkdbDWztKxjT4p8mfVSZRauPNOn4PBd9yjxHD1oYGecor1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline
In-Reply-To: <CACRpkdbDWztKxjT4p8mfVSZRauPNOn4PBd9yjxHD1oYGecor1A@mail.gmail.com>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 29, 2018 at 04:52:04PM +0100, Linus Walleij wrote:

> Essentially the semantic is that the  [devm_]regulator_register()
> call will immediately take ownership of the descriptor
> and place it in the regulator core.

I think that's going to be the easiest thing to work with, it's more
pain in the regulator core but simpler for all the users which is
probably a good balance.

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwAE+wACgkQJNaLcl1U
h9BmIwf/bKXcz9gdrg3/CUjPtC+BikVsM+wiiEC3qOo64EpB46Q+mooEN5Iw7Zce
b2UNxNz78PBRqFWf68c12gN6CZNDSVT4ljHX1rcOB8rJLcMbpzkyk12yk0FDAU0X
jM6JMTMaAcfTJvWZexvaQCcWSjj11EATlOR27Wt1Wy6OJrAitd/WfPpeFraU1cKx
W5qgsKDmxQFBUEsXSUk9m+s1+2q993ywTEJ6N49AhXolMaLzByfP4dNCaDtoCwVj
w3WDd9fddhUSDA0DamX5jl3OGk4JztT2xRrTbXnW7TG/qNbCmBHGSfU4yanqxn2n
iinP9Zrlr9BgYXj8+0wyKEHO8GqTXA==
=1LH9
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
