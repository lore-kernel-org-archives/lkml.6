Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF969ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79681208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DJDaFHlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79681208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeGMMFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:05:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbeGMMFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VLolxv6UGVg/hcpEgt5gLutyZJnc7SXGkg4YWb90hNM=; b=DJDaFHlHRMfE4jFO/ug4XpIWj
        YXWnuJoW1Lu+d8J9KfZ0RvC1M9lnUloXVNT3kTF+xYBDzoG/YX2ZPWv79gEHLsubtEJGQR8wQ6ZOs
        cphdu60GSted4k0C/uocK96o8e6RM2Si54errt+UG/ARXIEwu9OfsI02o+wKHQYRk67Ro=;
Received: from 94.197.120.189.threembb.co.uk ([94.197.120.189] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdwar-000517-1j; Fri, 13 Jul 2018 11:50:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 57BE4440078; Fri, 13 Jul 2018 12:50:10 +0100 (BST)
Date:   Fri, 13 Jul 2018 12:50:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pfuze100: add optional pfuze-disable-sw
 binding
Message-ID: <20180713115010.GA16228@sirena.org.uk>
References: <20180712110240.3006-1-m.felsch@pengutronix.de>
 <20180712110240.3006-2-m.felsch@pengutronix.de>
 <20180712153121.GF10369@sirena.org.uk>
 <20180713083039.4z3ulwtg2ekx5n23@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20180713083039.4z3ulwtg2ekx5n23@pengutronix.de>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2018 at 10:30:39AM +0200, Marco Felsch wrote:
> On 18-07-12 16:31, Mark Brown wrote:
> > On Thu, Jul 12, 2018 at 01:02:39PM +0200, Marco Felsch wrote:

> > > +Optional properties:
> > > +- pfuze-disable-sw: Disable all unused switch regulators to save power

> > This is a bit of a confused way of specifying things that depends on the
> > Linux implementation, and the property sounds like a double negative
> > too.  I'd say something like "pfuze-support-disable" and then explicitly
> > say that this is a workaround for backwards compatibility.

> I can't find the double negative. Anyway your binding sounds better. So
> I will use yours. Should we add a vendor prefix too to be clear? I will
> also add some more informations to mark it as workaround.

The property doesn't disable the use of switch regulators, it enables
their disabling.  A vendor prefix is probably required but I can't
entirely follow the DT rules there, it certainly shouldn't hurt anyway.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltIke8ACgkQJNaLcl1U
h9ASxwf+I+jR/6P3ZK6bGKjK57+MO7Nxv16hDmOm0MCk3VaH5worcAEZpTBIkWk5
FvlNmlzEtJnKWmLaIk1mKw895Yrjel1ZqicsXrV2lrE8ic/E2xJJ4UGsoRWcws4G
a+Mm4ZoxlxNfowNQhDzH08dxFBdDh3xDcQ1Z+HGzsjFDTsBhXEyg6Hi20k2ZO6bP
jEwNQYdS8Y6Pn+v8f71+wlccLsXHQupnSgidQbVlUsBoTZOn5B6V5fVjZZPLhYcN
NsZkmzJieJv/qQTqpfQvfUc4oTOPZPKs0gW/Nrh3dFq6ygAoXwWCDVurn+tD2uCE
9WyqcbDLSpmfpRFDdRKnjDoppZBq/g==
=5Yj7
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
