Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44145ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E42084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rok9NSLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeGUKsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 06:48:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGUKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 06:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YQ2FtKawEf/QCedmxGVRSdKU2W6YOwbNVLV0j9e1AGk=; b=rok9NSLxD/uWjqjstksG8ixKm
        xeFRfBWVDbHlAPBmjCU0kBnJ91W1UcbbU5z8i10937jv8opaAnAzh9uLKIHHlVKnk36cv3y+lb/AP
        RuFIVE5U3Zrzo1CdQhEdTJS5ekWfr7SotwlojXDhEcqhdf+iLM0G89hkSXNPLqJYmHvWk=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgocb-00021Y-3b; Sat, 21 Jul 2018 09:56:17 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B14BB440078; Sat, 21 Jul 2018 10:56:15 +0100 (BST)
Date:   Sat, 21 Jul 2018 10:56:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Message-ID: <20180721095615.GG16228@sirena.org.uk>
References: <20180720080424.31505-1-marcel@ziswiler.com>
 <20180720080424.31505-2-marcel@ziswiler.com>
 <20180720121612.GC10784@sirena.org.uk>
 <1532089865.19673.13.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <1532089865.19673.13.camel@toradex.com>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 12:31:07PM +0000, Marcel Ziswiler wrote:
> On Fri, 2018-07-20 at 13:16 +0100, Mark Brown wrote:

> > >  	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
> > >  					    "nvidia,codec-sync-
> > > gpio", 0);
> > >  	if (!gpio_is_valid(ac97->sync_gpio)) {
> > > -		dev_err(&pdev->dev, "no codec-sync GPIO
> > > supplied\n");
> > > +		ret = ac97->sync_gpio;
> > > +		dev_err(&pdev->dev, "no codec-sync GPIO supplied:
> > > %d\n", ret);
> > >  		goto err_clk_put;
> > >  	}

> > This isn't reporting an error code associated with the attempt to
> > find a
> > codec-sync GPIO, it's the result of some other operation.

> What exactly is then the of_get_named_gpio() above please doing if
> not getting the codec sync GPIO? I am not following you, sorry.

It's not in any way involved in setting the value of ret, whatever value
that has it's nothing to do with that operation.

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltTAzoACgkQJNaLcl1U
h9Cr9gf/Uajueh0tP2ANyMJ75Z87P4f3b/nF3mN5D/jxrZYbr42S/NBnjkm+lhEW
6zDiWAkzrTRg+X9WrdphxFZOqitLmrkKycnS8UDQZh0M4ZPSFPTLnXMWS+LHhhoK
lDk1mX7s6unzTF2xGs7FTZKd1PW/BqGTKCDL0MHUoQwLriZ8qsz5qqKV/nnfUSBz
V+1WswE0mMF7eYsWx9J8/Asbslr4QZJ0zT29aqGVyVZnPmrXF6GMXM9Mgg0Se9yf
UjB5AoNSsjgY6Kmz5a68xb/doF7yW3YRfkbJjJg+XrA8R3b2DMYaASdDgi+e0fqf
u15lzygMG5fbKBXhW6758dt2isQd9g==
=8Lir
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
