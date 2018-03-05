Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1265376-1520245214-2-5357524652807736940
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
    t=1520245213; b=gwsGHvIGrhVAZC9DYCc2tRkcirgtjMFK38cUbHnDestg03v
    N78u+m6gPwRFOFXFRn8wbY5EB1AYg0eL5+MjSobU5VfEm99PKuMglkeLpxBDiMOn
    vVbvVlQTu0ejbWt77DaIMFcci6P6Ioz6DKw09xma7UrFywXVG0QsOhYS6HqKjsHU
    a+GSOkEgpCCg9Cd8ZhjVYLAWV7gnwCaBshF6WtSnZNw6FhF0/f7RrzhNRDnmMY5o
    uS2WuiuRlsf9fqZ4AxGO3rLd2LFJEMU1Ez4Y/C/c/ooY6KIeLyvuKJOgTXad5ASJ
    BA/hnalgkr1j/e9SSQs0IBgDw/gJqV4ljUPf3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520245213; bh=yXkxCYjv7xAS0KA2oxkoM7EVD8
    ssV6F56RkDlzCqd9I=; b=FWn7KopyJV3ZrCLtlhoZc0ifAVekKZhzI7449BOXny
    zbTo8pqYmk5GRJS1VRUGnGpSOcc400HGErDWuZCNIKn4c1qFQWdQJIddhDUiWt+e
    IJhbaK98vw1WTUwwZxD9fgzUm8WDq6zfjATfqriQ5IRrZjrqPNL5Z+NIndq+wNMH
    X8DfpHaHOlW7oxq0E1gba5tuelg7/sHrKO62DzQ97zTUOYSAE51AOFEbzOVsOtPz
    8AuQNBu8AoBf6cDqbzuhov0tce74lFVqc9Tdw0FSGXLWrU4+c+zTltzY9h5O8BZq
    pliwHdzpJGTlkolXxLTDqc4Cqjbah3DRQcVebiCnR1Fg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=f0mDu22c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=f0mDu22c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbeCEKUM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:20:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45114 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbeCEKUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:20:11 -0500
Date: Mon, 5 Mar 2018 10:20:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH AUTOSEL for 4.15 026/102] ASoC: fsl_ssi: only enable
 proper channel slots in AC'97 mode
Message-ID: <20180305102009.GA8588@sirena.org.uk>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
 <20180303222318.26006-26-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20180303222318.26006-26-alexander.levin@microsoft.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 03, 2018 at 10:24:24PM +0000, Sasha Levin wrote:

> We need to make sure that only proper channel slots (in SACCST register)
> are enabled at playback start time since some AC'97 CODECs (like VT1613 on
> UDOO board) were observed requesting via SLOTREQ spurious ones just after
> an AC'97 link is started but before the CODEC is configured by its driver.

This was part of a wider AC'97 rework IIRC and I'm very suspicious of
backporting it independently.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdGdYACgkQJNaLcl1U
h9CJ1wf9GJiP8lHfxcYHpfXfYxnE5aIn/c+VoNdeH54MF78RiRX/TAU4WiJYLJ3K
kIHliziUnXbnMHxIGJOAnnNs+HKZAK4HS+vTMuP9XmA9NPeKzLEV7FJDC7d4JlW0
lsjsRF3BTFGjggTH9NvBkDIqvw6hd4aJ70m5LxpXftvUCJTaOoStinAY4iQv6aOR
fmj6QJOPWSfNZQf9CwDLglvaVndLySeip5FhE3CDBxhnJj8vYGFyHjtYeL/XyPM/
WAn/ETfENcHf4XjHC3t+5avyPNOTmfubmVTzXqI5HGiCY3A2BndP1prFnrG9vsbj
r1Qoc5d/dPrNnxnvDgz/7IFUkqr9Jw==
=KbBB
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
