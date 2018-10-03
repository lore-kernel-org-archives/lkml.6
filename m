Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8823B2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ACzLd1nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8823B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJCWMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:12:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44106 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeJCWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dplS7b6kb0DbiBjH4McUkXWkCMCRs7HsWb0L7ftbrAE=; b=ACzLd1nRMx3C8v23JQ1MVkjg0
        jrT2VR3Pi7j8FP1A07feVTqw6L/Zoss0wfflHM95A3CwnCNrkm0tZ6UIxLWlOkKOjgv0gV00dSWx6
        jq0hx7IRZCJ/oglXqeIs9h90Fiy3pnfWUsl8CxNhuvFMrrEeag5ViznBxM5FH9ehD45Ds=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7j0K-00066F-Pl; Wed, 03 Oct 2018 15:24:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 88D201122286; Wed,  3 Oct 2018 16:24:00 +0100 (BST)
Date:   Wed, 3 Oct 2018 16:24:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Message-ID: <20181003152400.GF7132@sirena.org.uk>
References: <20181003123328.GA29471@embeddedor.com>
 <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
 <20181003150111.GD7132@sirena.org.uk>
 <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
X-Cookie: The time is right to make new friends.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 03, 2018 at 05:05:04PM +0200, Gustavo A. R. Silva wrote:

> I'll include the __noreturn in addition to the break statement.
> I'll send v2 shortly.

No need for a v2, I already applied this - adding __noreturn seems like
a separate (although desirable) effort.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu03w8ACgkQJNaLcl1U
h9AoBgf/XblnzeKCFq8Y+RvmPxZI4aKxu5DCn1XBQbor/kDEzvrfkjV4p06uvFsE
/VHvfH/IZVJ1sxMqU7GUQ6s/pOEmTRH2jH857dERMItTxB3RwL73g1zYTfDE9QsW
ifDn93bax2auLHxRCIXzKFo30kutXHR9+u4/N9Lut825Q3QBYQ25K+GbXCE5BwdF
Qr2KVWFC/8navypKrEIr8UzcTWcLe+WNZNQRhwmNWW/9X8zXUamdWQNpVOR3MHaf
NBs1iYIzT7NeweRTZnL8Zac9M7ity63AS7bJrKr1f0R8Bnmi+2+ohXf+/RwvHp47
6Dsm9QswTT763Av49x3CuelovYyrjA==
=H4K7
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
