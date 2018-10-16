Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D165C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3362B2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lDp3KE41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3362B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJPSRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:17:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeJPSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gST3x3iapzQiJQPsp1Bg+v21mCKt4kAcIujj/47YLw0=; b=lDp3KE41/ViW1/dt7i6kaknLu
        kPBo58NaBOC58fVmJfjYvtzFKqB8iI3K5KvVkP8Hwrku+XWC2WQSY5UE3VbPVmMTJPy1TL/wC2LIn
        zBpzZOu0fF+/lnBHKrGDsqLRXF+hYwVsz/jXfR+zCRiqRz4Jo4aQVB9YjvWo3ToRZQ3V4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCMZI-0004oP-2k; Tue, 16 Oct 2018 10:27:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD1CC11223AA; Tue, 16 Oct 2018 11:27:15 +0100 (BST)
Date:   Tue, 16 Oct 2018 11:27:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
Message-ID: <20181016102715.GD7449@sirena.org.uk>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <20181016072244.1216-2-a.hajda@samsung.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 09:22:42AM +0200, Andrzej Hajda wrote:

> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;

...

> +	return err;
> +}
> +

This will need an EXPORT_SYMBOL for modules won't it?

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvFvQAACgkQJNaLcl1U
h9CinAf/TrDYBAP2p7l6s02TaGVagy5SrYDDXZoa+tlwnAxkQnbOBif/mtOyhFzL
uQf9am3fX2kIMiYkFxcreLeTVImmox0BI3G+JgtQXd2CiXxOWeIsonFye11TYXbg
EWpjHSWUDe5oPIRLK41U5gjUcZf3DwCheZs+sOc3AifXp6bScWHNc3OdQvzC3zlw
il+fMS9PKV6qyxL5ubque2N3tI6nrUA442MLzNG+am5gO3oP68JXK54ZyICmAW6S
wnJi6z49WV59/xzPUMnEEufxVNpqyrBUMQx4l3zgC+2sACawiSDOWAw+AcUruCRW
mUFxD5X24EQoW6STRjKpEAafQlXs9A==
=C834
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
