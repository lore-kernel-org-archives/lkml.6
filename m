Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nQfRwTD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324A420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbeKGDxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:53:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58420 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeKGDxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Idpk5BakejRr5uF3qPhNQoa8ug7KDzS/Xzyr+1ixcY=; b=nQfRwTD9rHQ5HoMoj7Jrunz3z
        8AI4fseTkgtixyl6R5Ztto/szHGHNiJAViVf3zHbbcNCf3TlLtmDSgSdCzXkYduG+yAb1HENA0MAO
        nUqexHV7j0xuk5xVEWpz2Hb2nzWkp1ViP6cOSXksfO2hvIY6KmPigvIFVrHPv6ITTTeu8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gK63u-0002wz-IV; Tue, 06 Nov 2018 18:26:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3A952112266B; Tue,  6 Nov 2018 18:26:50 +0000 (GMT)
Date:   Tue, 6 Nov 2018 18:26:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sh: Provide prototypes for PCI I/O mapping in asm/io.h
Message-ID: <20181106182650.GI31950@sirena.org.uk>
References: <20181106175142.27988-1-broonie@kernel.org>
 <CAMuHMdVYK0SwkTDKrU+bfmCiQ2N5qERuGcqoaXzAsn-aPcCW=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYK0SwkTDKrU+bfmCiQ2N5qERuGcqoaXzAsn-aPcCW=w@mail.gmail.com>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 07:21:41PM +0100, Geert Uytterhoeven wrote:

> > +#include <asm-generic/pci_iomap.h>

> Is this sufficient?

> include/asm-generic/pci_iomap.h provides the dummies if CONFIG_PCI=n and
> CONFIG_GENERIC_PCI_IOMAP=y, while arch/sh/Kconfig selects GENERIC_PCI_IOMAP
> only if PCI is enabled. Hence it's not set in the failing config
> (sh/allyesconfig).

Ah, possibly not - IIRC I minimized the config when testing but I
could've got the GENERIC_PCI_IOMAP=y.

> Probably SH should select GENERIC_PCI_IOMAP unconditionally, like most other
> architectures do (alpha and powerpc select it conditionally, though)?

I'd be surprised if it had a strong reason not to.

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvh3OkACgkQJNaLcl1U
h9CKVwf+J+aejeLw8Rk9RF3JtSHhUwN5wGi1xkCxKFxGbeH6IXrJ15eb9xKd969o
wlte3j0iKbDuc4Oioq46oNIKr+qh5L01uozQFIqL3o8BdF1K4HiX4B4r5Ob0juxK
qSDjd4X9W7dEgTVbokxy6dtTI8lYUn/kIq8nTWU8OBvBgEZLsUVfRbvaWN7eTABx
nN5NWQTq4Q2qbcltN34JQ3lvUFe95SLmRPYnTo+x6i2c9hikH3Z1T22Orz4/3v36
20THn3Oc879rTMJFAzhJsY/mArNyrVZ00xRKPoLl6chEIpbblx/zQq67q7XF/Zsm
H9LR8dPRUFc7hGNEgxefCTfurtWyMQ==
=2v0p
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--
