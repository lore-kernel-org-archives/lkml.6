Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11821C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52FC2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dtFUj+2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52FC2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJCBbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:31:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeJCBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=McKGpCoKqKBjnHomXQIwNDOJkIlDS2W6oEnKsrZWXpM=; b=dtFUj+2QRRdecaE1mgNNBkMzW
        B3B0T3EIXkJ59IPb1mMijdbzPoSrQs7lpFggGIjkmg2WTIjhE9uJVVat8GhlKy0F7Doot0xk7Wjmh
        V0jS4Vq6zZClsDaKUMDfIiEXhcv6pVNPRUdSZwV2NoQX/Nn0itJ9V6909i2gfjHCr1Aa8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7PgY-0002Za-6O; Tue, 02 Oct 2018 18:46:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E93CB1121A41; Tue,  2 Oct 2018 19:46:17 +0100 (BST)
Date:   Tue, 2 Oct 2018 19:46:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, jmkrzyszt@gmail.com,
        rppt@linux.vnet.ibm.com, linux-sunxi@googlegroups.com
Subject: Re: [REGRESSION] boot fail due to commit efdfeb079cc3("regulator:
 fixed: Convert to use GPIO descriptor only")
Message-ID: <20181002184617.GE6338@sirena.org.uk>
References: <20181002183917.GA6824@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <20181002183917.GA6824@Red>
X-Cookie: Please take note:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 02, 2018 at 08:39:17PM +0200, Corentin Labbe wrote:

> The following boards fails to boot due to commit efdfeb079cc3("regulator: fixed: Convert to use GPIO descriptor only")
> - sun8i-h3-libretech-all-h3-cc
> - sun50i-h5-libretech-all-h3-cc

I applied a fix for some issues with that commit from Linus today,
hopefully it also helps these systems.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluzvPkACgkQJNaLcl1U
h9C+JAf9HRhEmIP0+jreSULWTdqhasqD0qrHlIqLsgZnU5XqC6EL9XAB1oH7pqic
LXWrDV2XfUv1HG3ycsu5OlkwZzZ4e861X5QGnwtbEMQ9dP/fCCpqhgH7eGaaHhXr
mMfLZx9gzxPJsannFg+7U95AfwUP0AV51THAQNiXhs5FVSUqDe93L+p/wNJSPoMk
rI1vxeKyxLgedpqTV0AZMoEWb/sSzxMb9N5atHJG455u+mqK1qAQGZnwz2hYP2ls
zSROoiFZ6YICtUcFeajHcRwaQRNGs+zU7qaQC/++syCYBeVGCyqiVNZUojgqoUaM
JBUNqIitf2d1cMgQzg0KWG6/UajztA==
=Jc8C
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
