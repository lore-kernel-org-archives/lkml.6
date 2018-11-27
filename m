Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3CAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="F5nA28qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeK1A2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:28:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeK1A2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AJ3G8ZHnffCLd/JQmmILwA0IFDOiwrL2S1p6OX/hEbw=; b=F5nA28qT5ByP95g8EcHainNre
        gMqOjvcjtfMKSkqwNBozFfn3U6MtYoCIYjC7vrSd4AFXO0q5ywjqYOm0Q5xaJB+KTShglxvZM1upE
        5XoF/C8cWNFSvOghBfke2mGGCJ3ZKyUrHcKK3I+yfHsrqthz9BxM1HI8R1rAPuJo9kazU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRdRi-0000Ho-Jy; Tue, 27 Nov 2018 13:30:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D75801125056; Tue, 27 Nov 2018 13:30:33 +0000 (GMT)
Date:   Tue, 27 Nov 2018 13:30:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181127133033.GC3206@sirena.org.uk>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main>
 <20181123132522.GE2089@sirena.org.uk>
 <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <CACRpkdZKJGFmYFKBHdiayRsA2ona2zWfJ+xckJxD1UBsj39=sA@mail.gmail.com>
X-Cookie: This end up.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 10:53:40PM +0100, Linus Walleij wrote:

> The managed resources pretty much assume
> that you tie resources to the device model and let kref inside the
> kobject in struct device do all refcounting and that essentially
> collides with the refcounting inside the regulator core, they both
> want to control this now.

If a driver is handing ownership of an object over to something else
then devm is always unsuitable.

> I suspect maybe the lesser evil is to bite the bullet, invent
> gpiod_get_from_of_node() which is the missing API (we currently
> only have devm_gpiod_get_from_of_node()) and simply
> fix up the converted regulator drivers to avoid devm_*
> retrieveal in the same manner as wm8994 (the already
> queued patch). This will make the regulator core own the
> refcounting as it does today.

You're always going to need unmanaged versions of functions for use with
things like this I think.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv9RvkACgkQJNaLcl1U
h9CxQQf/ctY7AoS1CbYfXUlQZE7L/vhPX1/ZrjPHwFaAXIqt7DILnrLN0UVLUT9+
Y2yqj2M4a6MVv9cgUBKYjyGtJF2afHrvWj7oV4ec6LvOzHKvYvYYZRpDf/cebWRf
qbRJLz5JY75lofTTq5fP88XVkbMixXcTv1dfplHwk/+UnrYLR7+JxjxdMGnoMKmS
3QiiCZeyqFedyrO4FNMnEk4G3SDR3DfLuKLj926nvGdPalwT+vNibqWWjgHSTzgC
dVzk8WOrwsysBhMtywVNwS0yni6w9JxjJQZj99zWJ5Tgz5Dn8McgJtP+0V7zrXW9
Tr9/+FAta3GKRD9l6n5NMRLE1C5ciA==
=0TVT
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
