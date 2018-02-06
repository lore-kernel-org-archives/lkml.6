Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-991961-1517916371-2-7791539539891732520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517916371; b=cRXYo+xdhjNku6EXNQmL+85O9xzApEuH5nBORMUxSajvlMn
    II/v4PLBMClIZwEbMUXWWSmdIMJVPNXVusj6Srhgvxbjum746KJWdkGJw+uFpJsH
    UWna2nM+G6fbIbEzjE+5beW1/flYU7clRdxhBq0waN55YwNLticdoPZ6UTdMNdrA
    NiLSw87dqi9rOK8z8ShNdN11niTb+z4fkSuw96mU2gST1DOhbwROS/X8VlW0E0QY
    IQ+E2X+xk46qhnD638zgcLEsXDGLBAt6ikbx5ktp0pgBty/A+wR8Y0RyOn3ZHDAv
    UUxZv6mcwAB0N4An6Kdc9xgTKid7ulCVnML8bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517916371; bh=orBueL89mPJSnMkB3zTx/JR/gV
    Qocz2+M1F2cHL+sKk=; b=bC8Arq3skRKqdCznUJzw2zVyXaElGmypztQlQXO/Xq
    BKNbYoCRyQslbd195aiFOWNCe/4JCIO0S1A5Koj7IbqpL4e3zAAA1PeOi6VFKjEb
    I2QJY6QxD/aAfUENnMReySlwjQ4NZd3K7zaoq8xsG7D6TDYHebTbUbqRNoTTVkyG
    U6Zz3izfp1c4xJxdAb9ZnUcDS17dx6nAk4r9dfFFKSSYIgrO1LlmGSSh++zrp+ln
    nugwM7W0sOMeRvoyy8QHlvu/Mzu/XX8Ar901uYAMa7jaXN+T6UWpipGUYs+IEM7N
    xvYouFdwKqZXO/5pE3+z+9AeVfZvHS47l4EkZ3hcwn3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=TE73iGrL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=TE73iGrL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeBFL0I (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 06:26:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeBFL0H (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 06:26:07 -0500
Date: Tue, 6 Feb 2018 11:25:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Abhijeet Kumar <abhijeet.kumar@intel.com>
Subject: Re: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that
 pop noise when start capture
Message-ID: <20180206112558.GB5681@sirena.org.uk>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-29-alexander.levin@microsoft.com>
 <20180205114154.GB12384@sirena.org.uk>
 <20180206014120.pdudjvme5zwofdxp@sasha-lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20180206014120.pdudjvme5zwofdxp@sasha-lappy>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2018 at 01:41:29AM +0000, Sasha Levin wrote:
> On Mon, Feb 05, 2018 at 11:41:54AM +0000, Mark Brown wrote:

> >This is another one of these where I'm not convinced that backporting to
> >stable isn't going to introduce regressions - it will fix problems on
> >some systems but if someone really cares about a startup pop and has
> >arranged to do something like discard the start of the audio where the
> >pop occurs then this may cut off even more and cause them to miss
> >things.

> It might cause regressions for users who worked around the issue, but it
> may also fix the issue for users who didn't. I think that in general
> we'd rather have mainline and stable trees have the same bugs and
> breakage - we don't want surprises when users jump around between
> kernels.

The issue is a cosmetic one, everything works perfectly fine it's just
that performance could be improved.  It's the same order of problems as
speed issues.

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5kMYACgkQJNaLcl1U
h9BBagf/b645PGxQkf+HR0iFzOlfwIpERZH9rhAANNW02zjwtsBkbLTFjfuYAh31
DYDpElA7a7QCX2ddLvcLvdyzP3mlivgKLgmrfW0/NaxtHm4utIMRClEaYiHjAWkq
MExIWbuApiqz74YN+Rbas75XFPY6l4KMIuoKc4MDlzYRTl/xlLdwSWFjNq1UX3QA
FPjJ93IDiL6D9CUFPDUUHh+R3qUYK37e5GasKkIJW6a2c6eTaYdP+VYFvNPv0Adu
pwD4qJqKvA2n5MHsNrZH+yrKZxbVXOel9hKjtbKXfsGi6xLRMWlbdSRCysTzAzNh
jK8MI2qcGqXE4EkrhhASIudHZLsYdw==
=2lBy
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
