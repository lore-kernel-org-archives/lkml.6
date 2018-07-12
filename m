Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0777C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51596208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YfZ5Ffz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51596208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeGLPlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:41:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeGLPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rbfai1TL8gYTh2J/bhDypnUhnLjvHpJJmemItE7Et44=; b=YfZ5Ffz0Fbo3gMaCcV9rrT7ua
        o9CyHggVZpGKNp0H8jSOA9pl2ZQWMrzhP3LWNQYUtTMbFsyc7yrDRNAwkUPYH/JQzK0My7appnNqx
        XVdPQINspukvY6lX4ZK/4njexa2LKkwe9fSoowI1QnxOU+vUn7CFgNLhgUzgnqBgUMyX8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fddYw-0003nG-5s; Thu, 12 Jul 2018 15:31:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fddYv-0006DP-De; Thu, 12 Jul 2018 16:31:21 +0100
Date:   Thu, 12 Jul 2018 16:31:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pfuze100: add optional pfuze-disable-sw
 binding
Message-ID: <20180712153121.GF10369@sirena.org.uk>
References: <20180712110240.3006-1-m.felsch@pengutronix.de>
 <20180712110240.3006-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <20180712110240.3006-2-m.felsch@pengutronix.de>
X-Cookie: Kleeneness is next to Godelness.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 01:02:39PM +0200, Marco Felsch wrote:

> +Optional properties:
> +- pfuze-disable-sw: Disable all unused switch regulators to save power
> +  consumption. Attention, some platforms are using the switch regulators as DDR
> +  ref or supply voltage. Mark these regulators as "regulator-always-on" to skip
> +  disabling these regulators. If not specified, the driver simualtes the
> +  disabling. This means the state of the regulator is set to 'disabled' but the
> +  driver don't disable the regulator.

This is a bit of a confused way of specifying things that depends on the
Linux implementation, and the property sounds like a double negative
too.  I'd say something like "pfuze-support-disable" and then explicitly
say that this is a workaround for backwards compatibility.

I'd also recommend changing the implementation patch to just register a
different version of the desc and ops that just doesn't have the disable
operation so that the framework knows what's going on.  While the
current implementation works now there's the possibility that at some
point in the future we might start relying on the disable actually
having taken effect somehow and will get confused.  There's some
existing drivers that optimize their resume paths if they know power
wasn't removed.

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHdEgACgkQJNaLcl1U
h9CaAAf/UU9njCozGSkAnCo5ZtAkrPB4iKYggp6MKxZsOBJgAXqMRBdJrWlI58As
aWTfq7UaLaaqOsumRWDt/NeX3Q39bRimIJaN0KXBWdFwUz/+/4x2NDpGAe9FQFPW
S7l4SwVATYbdqQdeJi5QRDgyTJwrjrlTixK4P9LLB8gS49UwIDG/PbKfHIxBrNRG
NPrZfavFaEEy8HZ4E0vmnNEJkrpTnzndsEBOi/mWT3CkaGpVUJRvUjDQgU+8bj1p
VHv1AD0pX+eJdClr7oMdGJhcbUScZrXRD1cKs7zG8gSAAgvTG3muhoWvB1pLYLrt
H7Fmx6YMLkVQ/L9KCPAsErpDhplZgw==
=fT4z
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
