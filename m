Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85784C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208C220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QdxsJNlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208C220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeILP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:27:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TdN/PfYMdVCxiI6/c/onp5CQXOPsEgvQ1dQFiR0rKaE=; b=QdxsJNlVFUdpODlQZizU7DCXi
        XkbOnik2ELAd58azQbVwx+S+M4cBzOG1Zi8bpSkNsVSpOOrDYwOj0+bWKLhVQ+Y1QlnHcvzmo685a
        7a3apRv02RV6ND5IKig+E9XpAcgovVyz4xjYx0/zfvCqRAdlVDVq/yGSBHvf/AC0IxUwM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g02Im-0006Xy-K5; Wed, 12 Sep 2018 10:23:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 56E311121C6A; Wed, 12 Sep 2018 11:23:16 +0100 (BST)
Date:   Wed, 12 Sep 2018 11:23:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        mazziesaccount@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for
 LDO3/4
Message-ID: <20180912102316.GC6062@sirena.org.uk>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911124029.GO4185@dell>
 <20180912074745.GD2381@localhost.localdomain>
 <20180912084251.GO4185@dell>
 <20180912085315.GE2381@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20180912085315.GE2381@localhost.localdomain>
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 11:53:15AM +0300, Matti Vaittinen wrote:
> On Wed, Sep 12, 2018 at 09:42:51AM +0100, Lee Jones wrote:
> > On Wed, 12 Sep 2018, Matti Vaittinen wrote:

> > > I m not sure if it is relevant but I think this was already applied to
> > > Mark's regulator tree.

> > Where is Mark's acceptance email?

> https://lkml.org/lkml/2018/8/29/644

Yeah, sorry about not saying something explict there - IIRC when I
applied it I knew you were on vacation and it's a stable fix.

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluY6RMACgkQJNaLcl1U
h9DVRQf+NAh/8JhCtcvZmbaYOoX1uJ8x6pdnBv8MBoExgtoPP/Bp4aeZV8DPhA6z
eEaiuQuFafUTEBdCnoKusdXQxy4aanr/rJW5qG4lEPD/OEtQypeaZoPLw8An7ptE
42jKcjnpmxf3cKsPKP6DWbNnJBXMwD4pmyFYCx8Ss2HByRLUgH/hmcgx9ag9igrz
R9yWMmpNouLzOQ2i6xMXWphbRSvo4JNp1FDJnKjtdmIioSECen/8sB8aGNv34M9D
G1/1fqg0qWbgcIVkJwRTCAJzIAksEIKDZJErgToyGGbWaHDdyOlf1tuItcwKSm2L
d19/aGJ3sYuokqjZJin4kRBwIlBphg==
=U4xK
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
