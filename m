Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CADC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EEA2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cI0m408E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EEA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJCVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:50:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bFxlAwHeU1JIj2JffJCxvEszs3U8pqWcM/tYzKjl2cE=; b=cI0m408EvAoyhTLjcjHiTBQ5W
        S9LD5Ic5cjNK2bSfXic1xsXkdYGBmZIRk/UdPQGE/biZ5gNTinh1OAgTFTU/42zt/eFgGEvd4P303
        htyzjdqa4TJkWxUE3fho2ET71JRtiNbVdBmG47SXY5eAa5+BCzJoakCq0O+ls4etX5vJE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7ieG-00063h-BC; Wed, 03 Oct 2018 15:01:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F11CE1122286; Wed,  3 Oct 2018 16:01:11 +0100 (BST)
Date:   Wed, 3 Oct 2018 16:01:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     gustavo@embeddedor.com, linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Message-ID: <20181003150111.GD7132@sirena.org.uk>
References: <20181003123328.GA29471@embeddedor.com>
 <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
X-Cookie: The time is right to make new friends.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 04:46:45PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva

> >         case CMD_REBOOT:
> >                 dev_info(&priv->spi->dev, "Rebooting system...\n");
> >                 kernel_restart(NULL);
> > +               break;

> Alternatively, kernel_restart() and friends could be marked __noreturn.

Yes, that seems more sensible though there's no harm in this patch even
with that.  It'd definitely avoid other issues in future.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu02bcACgkQJNaLcl1U
h9CQ4Qf/UT41AauCZW2vahDh97EFbG6pfv9sqsby6e9VcHHAXooKhBXW0Eg891ob
qfa19xiKfDuFeWvTKWToTERdNKMIO9IHkBBpxKsjqNYSk+wos9qPIo2+/w7PHTNZ
Xs5DlCa+IPUE2IMVNZGkLnEVzUvENgL5BviES4f06JBNIJKiKuvS5A/I33eKABT/
6EOd989RQ8l1rDIvhJPvES5L3+r3aJicu/T/SJ647cuvY9i6EEXF7R7nixr1bT8F
JhKw3PjT5zWBOlhRzGabtKAC5aQVHqa34NYI6AmrKPVd69gCkyz5AqzKJ2P9J47E
XBdeMWbs4lyAtD1APyImZY520WpPqA==
=g23z
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
