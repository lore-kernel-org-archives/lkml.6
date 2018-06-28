Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D6BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510F272F7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BLreXZNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1510F272F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeF1Lw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:52:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33758 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeF1Lwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jew903GVJJtu2vMuTHs1HTOVKf2qpnKZFcq4ZAN+YsE=; b=BLreXZNgEUwp+xy5ARneUBFgz
        dqK0Y4i3fd+jysGQvKMG81RD1aTVdDKGGd07UpREQRUabg2GAhzcHuUl5Yy0/F9oUsc/+w9Qw04AP
        7PnDYN2lzk82E18UxVn+9FMME/esdi82xQZqhDWfbVZ74RoVuy5uvN1B+pL3nfbSMhI8w=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYVTn-0005QK-Ck; Thu, 28 Jun 2018 11:52:51 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYVTm-00075H-OA; Thu, 28 Jun 2018 12:52:50 +0100
Date:   Thu, 28 Jun 2018 12:52:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Message-ID: <20180628115250.GE14040@sirena.org.uk>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
 <20180618104159.24b9fffb@bbrezillon>
 <87d0wnrhqz.fsf@belgarion.home>
 <20180625130704.GQ9413@sirena.org.uk>
 <87r2ksl0wa.fsf@belgarion.home>
 <45a4e773-aaa3-6d43-f02d-5056a2a265d4@zonque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <45a4e773-aaa3-6d43-f02d-5056a2a265d4@zonque.org>
X-Cookie: Money is the root of all wealth.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 11:03:16PM +0200, Daniel Mack wrote:
> On Wednesday, June 27, 2018 05:11 PM, Robert Jarzmik wrote:
> > Mark Brown <broonie@kernel.org> writes:

> > Anyways, the immutable branch doesn't contain the specific ASoC patch "ASoC:
> > pxa: remove the dmaengine compat need", and up to my better understanding
> > neither does your for-next branch.

> > So until I see it in your branch it will dwelve happily in pxa/for-next. If it
> > has to be routed through your tree, so that Daniel can work on ASoC pxa, I'd
> > like to know at -rc4 time so that I drop it from my pxa/for-next branch.

> Ah, yes. The series I just posted depends on that.

Ugh, please resend this patch so I know what's going on :(  My
understanding was that I was pulling a tag with the dependencies.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls0zBEACgkQJNaLcl1U
h9CqMAf/YnJSuYfkDLsMJj+Ma+azKxHUUSNo2TTk7zLNL2f7sFayIkYng3Go7cw4
KcZhV5KILOySk00mHN8RmO+kW/j1sipOD9MaNoQfr3omL0upYyaa9gTs5SHm1e7o
s5yeLUrFCn1V0gSsuIsgEHDS0tA7h9V8p9ATAMRZcs94Zho490r/VeKya9Ouqxhw
qVYrApADDxxyvoiZ0W7SdfWYvottnqzNzZFAmTtEmbj7AAQcKI0fcn6tTlAZUcuj
fW9A4GdAvv+xZGHgD496oLaIe3yP4rhGpz6gIvmtFxBMJCU0BAEL5Rc/JVh7d/gG
RGrTKKeFKpwFciY7VgyEDzR/QQfJEQ==
=OPKL
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
