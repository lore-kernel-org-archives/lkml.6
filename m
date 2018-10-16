Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2C2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NiFYDswH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF2C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJPQwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:52:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJPQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cYOZ0BDs8ZWVNPKyAgkgVMMgHqsX9yxw118gICx17co=; b=NiFYDswHqEVFPpNA0afzKmWnk
        aAzule1DZjJxvYI+YxpOyjzLqP4PtmN2pjjnidQIcq7hbaf18xmBiQjNc6ooPTUHSOcKTNLLiey2O
        7IbtnI1j959F2UiVQNrFOYvegQO3xFjKB5lvTP6xaLhl4GQwRzFnnGtwfLQ1cNEc8Bsbo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCLFu-0004jr-Te; Tue, 16 Oct 2018 09:03:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8A66711224A9; Tue, 16 Oct 2018 10:03:10 +0100 (BST)
Date:   Tue, 16 Oct 2018 10:03:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Message-ID: <20181016090310.GA7449@sirena.org.uk>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
 <1539628457.30311.5.camel@impinj.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1539628457.30311.5.camel@impinj.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 06:34:18PM +0000, Trent Piepho wrote:

> What about the calls to spi->controller->set_cs() after this? Should a
> driver provided set_cs method be responsible for checking SPI_NO_CS?=20
> Or should it not be called in the first place?

This seems like something that should be done entirely in the framework,
no point in every single driver having to open code the same thing.

> I imagine it depends on what set_cs needs to do, which might not be
> solely related to changing the CS line.

It should be.  If something is hanging other work on set_cs() then it's
going to break.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvFqUsACgkQJNaLcl1U
h9B40Qf/TWJfMXhUwEge5VIGkgNJ235s7i0tQoLwS4JTQM243PCrC82le63VYmD2
Eki8KRNtCo94pMOPeIXMwu1SIfnt8FYqDZElPRNBHb+rruJtXwOLEbKOVoiFbO4j
J2Gv7hmiT3XmP2t0Bvkg31eTaqp5r5iyxSrbWP2Hw4ehMqgm5t9eh2+03skLOcGI
AfyGjbIxEK6weMp1otBBWnM5KftDtSTaTgajbRtX0wvtv15sGqxX8P/9+mbUlfZx
3JcZxdhMtBfIYqSJm8XfKMg7qonEKA9QxyV3RLFy1xjkt2+DgoZkdHt2GaYzZy8O
aBz685qXms+1TN2LD3HY0gFY5cXsaQ==
=oQmb
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
