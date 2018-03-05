Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520246530-2-13251632934505697819
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
    t=1520246530; b=CliJd5IT1U+imwZX6tk9yZmGA/wYjgzRp3mtjCmCXZoypD5
    QgIqNiTHmgk50tbg+ps8BbuzIr/eUQ3zXBemK7FMPlRZjS36q1O+O3jUvacx3O72
    0DkWfkp78wdienRJ0lT/TaU1/U2uRTmHsjXDh/pLoXaAEkQK0DpW8kWPRl71noBU
    JkSsWn7KAGS+jbm7LBrb1dhQ96w5B8yPEuSE5WaADuJRWSY6UC7WnXB14W5tdz/F
    BLbxuqeFRpuNDBLo6cn6bnyvfbIKT2A35hp5UY6HOfU9VeridocM+4BSuhsFzMxM
    vnalupGAB+LsyIOv5Dx2kwt0b0d7qlnBtwlAVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520246530; bh=8x+Wyhyl2GqPSCr1l74LmpZ3tf
    hG53uSYQuPX+r9tUo=; b=CjMXBdMzTZkLg04Ya5A60Z/4lLsluPyBLggJwLUKjb
    8GQiIu/FoghkRsq0K7GiUzGXAtfCpAq7X0tbbD8TTGZLWVLEYVlADkSitKzQ1nem
    Qy+/VMClSs1THk0mLO0daSY5BP6vp5G1eo3z7e7wFKVDdUh3uwph1Wql04oFdtg2
    ZlaHKTHuOZSOPCUZzO+1NUC8TkbnSVSCUxLKVcnahxbz+zAmN0ttmQZvepalboBk
    +6LMAhkwQheVZcNmoGgB2bCAIxs0Iy6VpB98tAT6pb0Mco8acp3AB+XAkVF1FyLE
    kw2L0EwjRXp0GneQp2xrwRLzXnATn7ptQe8kpTS2YhHw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=k6KzFymc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=k6KzFymc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933623AbeCEKmH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:42:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933579AbeCEKmG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:42:06 -0500
Date: Mon, 5 Mar 2018 10:42:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID
 table
Message-ID: <20180305104203.GD8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-111-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <20180303222716.26640-111-alexander.levin@microsoft.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 10:29:00PM +0000, Sasha Levin wrote:
> From: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> [ Upstream commit 9ba2da5f5d18daaa365ab5426b05e16f1d114786 ]
>=20
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>=20
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.

As the commit message itself says this is not fixing anything, it's
defence against future changes.

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdHvoACgkQJNaLcl1U
h9C/wgf8C46FVefXMmhXCA2bYLBCvD7d7nNL7ohQL8xEiO4WSDrlqT145Vg85EEu
OQddwHl3OM0vHgO9i/L7tkjh6ujKYFT7xkIQdWxX/q4DP6kpcQIh6pvtG6T2/dMh
5NZFVrXMRSd38kNHwusrN+d6S+qOPbpI8w6R6JO/aSqSSplOALO62ZMeqrlRBEHk
hUJglN1Kv7sug/ofzf0EV3TRhEhykYkYLIaKN32Aksh1qnhydQJAZb3iCl022D0o
Yty9U5LX29JPFTSgcVxmZw8NUQ0oZkxwM1jyKtB7N33EznPpGm9WC804bNqG4Yju
xspDdDCfaArGd3BK8/Tg1O1kBI2bhw==
=9t9S
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
