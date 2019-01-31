Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E471C282DB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050A218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548938783;
	bh=0kcH5paFMd8v7jWdjtp+yfA6kHd+z9TIaOdyNmwyyI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BvHcfiFNdDL8eWnfdZmFqhUUYWrlxjjMxbHnbR0o1xby3kvkJytbahnNGGc/Pu5U9
	 aKrmh5DNrontNLOi36usFARctAWnm8Fao8i8dzj0RhN8dyQnT0swRGQMkgIlmGHhj9
	 /2liZ+6GBpqlih3Rms5h0xAh+dKdkMHBSt2HxakI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbfAaMqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:46:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733036AbfAaMqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HVgDHNrJcgCcxe1Juj3PrWo+ZCcwEvtWDgEtgKXQAfo=; b=TGLQwLutfpnfCgsbX7Jzr91ar
        L2AA9eoojiSaTeuBNiaHLqoF87SrlAbfutWzPQoC+Epsiu9F5BGSgGC0CIEQPhO5dgpQV2qw/3FsW
        gb20iHpnEEsrv/JRVmdkSFky1MiPkJ9q69lejyoglKBJLmjMx5pnI8C3FkKbu5Bu2Gf7A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpBjR-0004uu-VL; Thu, 31 Jan 2019 12:46:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 27D4B440082; Thu, 31 Jan 2019 12:46:13 +0000 (GMT)
Date:   Thu, 31 Jan 2019 12:46:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] spi: support inter-word delay requirement for
 devices
Message-ID: <20190131124613.GD20797@sirena.org.uk>
References: <20190129205502.7741-1-jonas@norrbonn.se>
 <20190129205502.7741-2-jonas@norrbonn.se>
 <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com>
 <d9c495ac-825e-6dd0-5455-817c3f27b840@norrbonn.se>
 <CAMuHMdXAjLBpQ6OXLwRsCzt5ydjuGFK6M6dKuFU4EL+6o0NB6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXAjLBpQ6OXLwRsCzt5ydjuGFK6M6dKuFU4EL+6o0NB6Q@mail.gmail.com>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2019 at 09:15:09AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 30, 2019 at 9:10 AM Jonas Bonn <jonas@norrbonn.se> wrote:

> > And with that said, if you insist having a u16 for this, I'll change it.
> >   Just let me know.

> I'll defer that to the maintainer (Mark).

It's an internal kernel thing, if we end up needing more space we can
just change it.

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxS7hQACgkQJNaLcl1U
h9Blbgf/UdZ/fY6wb4r2MpFasZi5arBoDtRp9jFfNtbLbH/ydhvLOQbNDVX3Kcs2
sUbSgUbzBwmyK8vG4IgAKSLZIDenVwmlQNsIamLzo5sHHz0XWfMD4hWRlPrEc3zK
FR7Xb7A3HugGnruRQM8WNJmGABn2Zv8XP7G8NuQ0WuoPip5UO9H2up46PTtqQXOV
h042QZGPXO1AuFJfeFmPeUF+XIstPdX/HwvebpKAev8pZJ87Qg8IBE+NwgldmxgS
0xKV08PhvDlHF0JqUsaMuSYtSpBKBQFxy56pEf0EyedJIcLXg2U05hsR2DyAHx1b
kIvh/KifBVjBDBVcgnFJxznRWwopiQ==
=Og52
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
