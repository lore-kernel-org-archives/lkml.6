Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520245289-2-9215839562270464816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520245289; b=TXA8YItyxZ83krjAVDVux+yJV5826Drb6fVM3cfZuHJ3D8V
    OWFmaxG4ISLwWEkn2ZgM2Ty+q+y8hx/Eze0fvPi3H9naU3hiJQmBn21kYoFUYItv
    gWMg6ORxTBMvh+1ZIhWt0AG4pxNShMqndy7NX5D7ZaIBxEBAej4AHvCg9IfXau7t
    cm8Re9ozID3F+dfM3djPGDcAwz/K5o3C+rA0+Jmz+Nixj8RuzRZzLH5UdP3jWftr
    ipl/FQkXh9t3vALEY43uFbqX0jBTDGJX6F8PzhCpIShVMADnlbX91FDcK3Sdnpnz
    1hmbwiFUAMSuKeKHpMHbP54li4ZmuH6xFzCGp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520245289; bh=K0PujQrIAsoh3AIHF7Fwxdl93h
    Gi3aqDsfqgksj6yLs=; b=ZjXgDlgjtNVx1sBEPmxFrP19XswjrYefPv1CaiG5RB
    luf6e3IHfiIQV5/Xrwk3AZN0LTN9kayFhOfv0skgs1BGsnTJPHIOnizBzg1ByWgj
    ls92olHiSGLKQgt5vqylB1eoRpr7kg1jrC9vUhPrPaXIyM3WW72vIp5sPTh+ohiW
    e9OYR7yL5mH01o4SaG1/9v7jLhSWwEjmk13GG4/W+TjhsuDHc75fGKuks5oTCqMq
    C0Bq7OybJ9zAciP9z3lE4UfuHF2ssyqfWH/mJlm/WB+AEfYkGY/4qGqa2hIRbx+h
    lKN4JWcxopHjz7kMQ3BppU+QGofTmtaX9G4wCcyAYDXg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=p+VGOE4j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=p+VGOE4j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933011AbeCEKV1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:21:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47192 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbeCEKV0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:21:26 -0500
Date: Mon, 5 Mar 2018 10:21:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH AUTOSEL for 4.15 043/102] ASoC: tlv320aic31xx: Handle
 inverted BCLK in non-DSP modes
Message-ID: <20180305102124.GB8588@sirena.org.uk>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
 <20180303222318.26006-43-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20180303222318.26006-43-alexander.levin@microsoft.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 03, 2018 at 10:24:34PM +0000, Sasha Levin wrote:

> Currently BCLK inverting is only handled when the DAI format is
> DSP, but the BCLK may be inverted in any supported mode. Without
> this using this CODEC in any other mode than DSP with the BCLK
> inverted leads to bad sampling timing and very poor audio quality.

This is a new feature, if this makes a difference to anyone in
production it's most likely going to break their system and introduce
the problems described in the commit log.

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdGiMACgkQJNaLcl1U
h9Aosgf/X8iHZOHL1iielVnn5dvBcXltZdvCY+67al6waHl/dE3h/ZX0fuMSU9NU
3LICgcZi1pxCLfj4kDWsQFD/AWaKZ5TAAhBeaOKGevXY5i45pI7vP6VmsjIZbDdJ
8A+r930u5XIZi+p28JZ4FIeNO/DvN+zqGMFnoa5ZlOEiXdi3nwanzxVQm2MUdscm
SeZyWjf5InBkKSkLU58pP9bKM/XZgMFPo82O79fwDB7rYk8evoLam9kT+UPgY9+H
0rIfDZ44jYgacdYRDTmN8R4YpBgGywbSajBYXNxZZypNTKw0LlFHTuGz16EPX34Q
d/4MjwNbutuadymlHElJlhTaOp//Ow==
=bylH
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
