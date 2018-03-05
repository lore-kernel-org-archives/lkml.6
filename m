Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402221-1520246578-2-2832492681849103778
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
    t=1520246577; b=CIkFbWW0/2VifEuoyLD19OjPjqKrpIxNZLeHPd0xOPomJqe
    4I4mhk7LySYYprrDc17Gs3SL45uu7fhxidLQXXLLxXqpwXpGtDjr4BE0KYHMULm1
    dgIczD1W8CgxDrqmpoemjxQuTAI6t3i8VGaoquQwzoXPi0m8XlCsh1vlujssheHi
    qAzXSEk5c6q05jNRCqPbHtl/meguLFYUvSjvkKYQvTQdKr06KakQT/LzdRl3kmEI
    KgtjC9xn9/SITe9+7dokUwHwX+7cgldrgR6iAlJz8q6EhYOeL5C4HViYmt3glR1a
    ug+bHIB8jArVWuHf7mZuXpkqaeSrFY21Mg5mokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520246577; bh=KcHLELX4vWnKFPHr4m/AaBrKYM
    4wkbH/VDqHf/qNIlo=; b=Q58hRmpKtm+e98hyRTf8psZ5lHJjSI7XsA9Yc6zaWt
    wFjjYL6jModV/BFQ2ce2pZqm8/3JG32JdV+FubcDD2gcIYD7E/P/EImIIkejsuk0
    YUyCm07e3zYUPQPgMNuvZOJgh988Z/GEgzItsH+Gu83VMuqOZo1pk+rAaTTVxliD
    8+NwgnpaeilPphoN+k0Bu0xlfxdAE7sUaZqSWt1nidxFdW4hVa3xp1w6SaJ4mJpe
    KAat0/MC9JqRHBUerBV7Ke/12LXc0KbJ/X8VD0JAlUyeU8UH9EgdJxSwdFUoATQk
    ZQLnp5NTG+4vjSxPt68qcryaC70Z9iUk9c3mYCLVjC4g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=u9uUvgLa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=u9uUvgLa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934282AbeCEKmT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:42:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53952 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeCEKmR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:42:17 -0500
Date: Mon, 5 Mar 2018 10:42:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH AUTOSEL for 4.9 112/219] ASoC: ssm4567: Add OF device ID
 table
Message-ID: <20180305104215.GE8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-112-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <20180303222716.26640-112-alexander.levin@microsoft.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 10:29:00PM +0000, Sasha Levin wrote:
> From: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> [ Upstream commit 71c314d7ef2442cd798584a3dece8151215e1777 ]
>=20
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>=20
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.

Same here.

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdHwYACgkQJNaLcl1U
h9AU4Af/WP4P9ecsX6/9uBp5RxVo3cAKuziV9jOePq53+gG7IhkCHCrz11fjDd79
8TKYV8VHGq1lQ9xEhi6DXeuusU0eb6ZKZKxfz3zlxEtmxvD5TwJHT8vvHgsyAIO+
1BKBbTC/ggI3yEab8/SaY8qI+shPoGnzy3xLEOBejaGvbNBhfoL1difA9s/J4+a7
S+zqzMzI2nypEoDhs6EuVCO6nnZoritXkKiNaUwvbwmOSpjUoAdleUiayoPSt/xX
agsLRcQDblZaDQwAv4jbapHE5L7BVNf0qZbmwdtRgPd5AXEN/vhpvR802/5sXd0c
wmegL5XZwAbGreZrOz47LrY4RIjk1A==
=qe+D
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
