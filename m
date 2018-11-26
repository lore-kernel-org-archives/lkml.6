Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61744C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F9820862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="O8If0l0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F9820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeK0FYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:24:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725739AbeK0FYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MeoOJlKBKQpt8+S9E8v+Td+qCxQwFlK3A6p7QkIvL2Y=; b=O8If0l0ML0v1akO55KzqWNvsq
        6VVK4SZjevZrdicxJKTcAXV/sRsrlnOVteWOgoJzAMNfNaZbvusEfw8pTGUEhpNCffp7hD/Z3L2XG
        w8rfdKAqbwZO7sx15d+W+g3y4ZxRBsjWXLRZqWUZsolrrPDUsdkiZUQa9wiYCMb5vFzGw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRLdW-0005cX-Tr; Mon, 26 Nov 2018 18:29:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8D65B112519F; Mon, 26 Nov 2018 18:29:34 +0000 (GMT)
Date:   Mon, 26 Nov 2018 18:29:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     masneyb@onstation.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
Message-ID: <20181126182934.GN9715@sirena.org.uk>
References: <20181125093750.GA28055@basecamp>
 <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
 <20181125232450.GA3774@basecamp>
 <CAD=FV=V4WFYoKLQ72pico4HCGgLDTae7xougivv6VWOSoPhLpg@mail.gmail.com>
 <20181126175945.GL9715@sirena.org.uk>
 <CAD=FV=X+X1NmF1jwu0KyBm5FEupx-oU7D5paGT=ZaP=+KazPkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline
In-Reply-To: <CAD=FV=X+X1NmF1jwu0KyBm5FEupx-oU7D5paGT=ZaP=+KazPkQ@mail.gmail.com>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 10:11:48AM -0800, Doug Anderson wrote:

> just takes the load you pass it and sends it on.  It looks like you
> can still force the mode but it looks like it's using a custom
> attribute for that (qcom,force-mode).  I wonder if that should be
> changed to use 'regulator-initial-mode'...

Yes (with compatibility for old DTs of course).

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8O40ACgkQJNaLcl1U
h9DnTQf+N9REmETzh2M4K7iB9jHOWXtyVbuSavC8TCmoLebVLq1Kl37888d/9X0a
wzpXbBuDn5EaOF/mav8jFJypsxeMIcyly8mJVoeG/0yeYhulPZaCm2iAKsQghn9s
5ShaPRWdYKtLNZPghuWZvRwV42ixm0RGwrCSU4t1wFS1gxvc00wUB5GMvdpgnEdM
GX9tEEQbfsL+WIaQjSlqxs5vqi7fW/OyItnFHIROpPrWYKZiV7+B8fJq6oCk2O3s
FLMJMYdukk5YqCKmdQ1GtQL7JMEnCTWrGsvA7+4tn5Y9L8wNkNUY3nvccHkO952s
t4r7CVZ7YnbSC8atzHF/Bwx4Ca+sqQ==
=c2+Y
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--
