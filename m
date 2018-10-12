Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A2C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028D820865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KF7smIwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028D820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJLXnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:43:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbeJLXna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hg+zQeevhld+ER9boH3Z5OaJsDE/RzK/izUHG/1oeSM=; b=KF7smIwTQDZgEdgJYO/7ySS37
        cRT/ajfOTQ6WyH4Y355Iwv3PGrY8hp4gUzw8+hsJFQUcuf47gYWng8+rG/ZAdcYA8oggEhurkt4i7
        Pp2k2s1hSg8u4kgtxPRX2gZUY/knYHteMX1CsW1VXz9nd23+rvvCDdoEGe9TuOxSSo8FQ=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB012-0006ZY-CW; Fri, 12 Oct 2018 16:10:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CB76E440078; Fri, 12 Oct 2018 18:10:15 +0200 (CEST)
Date:   Fri, 12 Oct 2018 18:10:15 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
Message-ID: <20181012161015.GB2340@sirena.org.uk>
References: <20181011143531.7195-1-linus.walleij@linaro.org>
 <20181011144330.GF25351@sirena.org.uk>
 <CACRpkdbTnBQhPQARX77KfjtfWXY+t0oH6-B=WUN4hid8eQT0DA@mail.gmail.com>
 <20181011175406.GH25351@sirena.org.uk>
 <CACRpkdY=ya9CJz0HbsdgzR+05SdoHQ+V17fY8sBtNtF482eXew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <CACRpkdY=ya9CJz0HbsdgzR+05SdoHQ+V17fY8sBtNtF482eXew@mail.gmail.com>
X-Cookie: He's dead, Jim.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 08:41:16PM +0200, Linus Walleij wrote:
> On Thu, Oct 11, 2018 at 7:54 PM Mark Brown <broonie@kernel.org> wrote:

> > Other regulators that have GPIO control for their enables do their own
> > requests (as does the core) so don't they all need to set the flag
> > GPIOD_FLAGS_BIT_NONEXCLUSIVE when they request otherwise it'll only work
> > in systems where the regulators after the first that request the GPIO
> > are fixed regulators?

> Yeah ... I guess I assumed that the same enable line is not used
> for a fixed regulator and then some other regulator (which is not
> fixed).

> If this is common practice we need to account for it. Obviously
> I have no idea what is common practice :/

> Do we know some way to identify the affected systems or
> should we just tag on GPIOD_FLAGS_BIT_NONEXCLUSIVE
> on all the stuff we converted to descs to play it safe?
> (I can cook a patch.)

I think we need to set the flag everywhere, previously we'd essentially
been doing it by asking the GPIO framework if we resolved the same
regulator as one we already had.

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvAx2cACgkQJNaLcl1U
h9DvIAf9GAoKZfFM7/tYx9y34exCWfCjeOYL8EM1B0GPQKbvX6oyvnRRac+ZT2Gc
eXxg3FizrYEwcTGpZvZkQPsw70R1UwFNEvIxNCvrSWgBuS3MeCvY9vRZBcdeopod
VSKsiaDdIkwOFxOv6pLNVDm2BegL8Fy0mV+FCqsbuwihTHG807mIo3XphiBPacU9
T7tQiht4DdRifP9YBZtvglMNEfj+BraoDGaVXMNHpqGKeAo/BOjO+6+QSBxnj2tK
OpbhJhSdNmWlFwcymy9jtPHyWRr+1EV848wccgsuBCxxhhM2idCTfHCROzncegxE
HUWv63F9js2jiSjAestCXW84nii6fA==
=pQSS
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
