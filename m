Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5906320862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AAES8+W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5906320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeICPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:46:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48132 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeICPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mLnx3ukU9VC1hqsFRBqHaLQk3ugoDO58+8aGIwRmK0c=; b=AAES8+W8MpdVr4s/5WsouZVAS
        gYbkQAF7aoO1dbeerlvq9HcZHJ+adRB4+bh0g+58c5xBQdjOwH1saYb+8odzT8s9wpD1GCFZZDDpN
        VyMA7VzyOkHoUkfKOb2VASd5RWs2lJgqTf6inI8y96dahNkWiOWM4NN937Syok8vm5dg0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwn0S-0000Bx-Ps; Mon, 03 Sep 2018 11:26:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8B28F11227AE; Mon,  3 Sep 2018 12:26:56 +0100 (BST)
Date:   Mon, 3 Sep 2018 12:26:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Message-ID: <20180903112656.GF10302@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <20180831180507.28867-1-afd@ti.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:05:07PM -0500, Andrew F. Davis wrote:
> Leaving microphone bias off is a valid setting and even used in the DT
> binding document example. Add this setting here and document the same.
> Although it may not make much sense to enable a microphone here without
> any bias, it is a valid setting that can be chosen by DT and may be
> needed for some boards.

If we really want to pay attention to something setting this up we'd
need to completely remove the widget - what the code is doing at the
minute is setting the voltage that the bias will go to when enabled,
there's still a widget for turning it on and off.  There's some chance
that this will break existing boards.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNGn8ACgkQJNaLcl1U
h9A6NQf9FIcD4SbCFvYGpIiui4wHjrOSFo04ImxUF1jAN578Ph5UsIi4GfFhfFDz
3z8ovw+6WC1R4o0KvI0VoInKHWEwib+CtPV329hdymhqoN9xOjZ+IElkIfILeInd
DOPf2o7x4n8YO1rNmuG5k61NrycD1+wpEwQKj9i7ArSPS5/FdqRMJPQz/0YL+DMr
2+MG8ntByql1MrlY34rWqDnChTRoe+JuoI5lFjXMP56Q4zX+aD9R7kgeAkkpg677
LzIFCkK2fq3PNYCufw5Mo77xBjMsolp1eVdDkAPCNaA58/3ceAzNoEXyEydF6a0I
yOEDUk7iuvnX9T2+cMVio2WD67bseg==
=4dIm
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
