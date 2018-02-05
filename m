Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2346552-1517830930-2-861439196972263225
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
    t=1517830929; b=RrJ1dVe2b++9SSWyQcv/QWWcSUW4pLI2bRbchMQqFS4v6cM
    +StDcCet6JEPlbZaHXDS1HKHPFGpAWyhrCQZfDww7PukkjJCJumB65iE/MNellk+
    OnNDRqtQcM3IleLQzGhtavhVSfxXGSyy+dzGc5VrVU2qUXuBa4Ljx4Jll1nVO89G
    TI5dDLS1dv8h9XcADnwndaxPC2YNnOn0JEdCAcXmA/0cy1t5tv34niaGp8IVCFYW
    DcTPV0S94YyizCUdMefK34S82HlGj1NZ63ehA1Cvys6RFVINnG0ZGDCBcBNf3cB9
    lUM7SLhSjlmNFILzVSgrDe5x/YAjdsllTI2a4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517830929; bh=LdY+F2OuHNtuY5uec5WEltq0Jn
    L7oM3Iku3o4E1CnUw=; b=Vjbo9VN3kDDJmL8jCD3OyTwX6AT/L+bvkAjwmaKH6F
    AV82dK0Cd0m3NLgbm4vlZZAaybA6akv8YE/oZw8Fs4060tTrlTHni5qFSTEnti2w
    kkXbGSsXZnofW6ZKoK2AyspOUuNj0h5/U3bun7UFJ/ePsWQcLx/eBOaz3GR7R7Mx
    Cyo0mqUmZeJza1pCXjjrfGlUiiCfaaeYi44efrI3lPXmhr0b1A5AHuv0w/XFIZV7
    zjNb8rUHYZLTY9wK5YcOxGD9sOpiTF/oOjtMuojhOJ4TO0JG9TV9R54J0feIzmzU
    pmXq5vcxlRfHTOgxSFXP7PUpELBNqzq+lRvsVMNbFkMw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=TheO73Xh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=TheO73Xh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeBELmI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 06:42:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBELmH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 06:42:07 -0500
Date: Mon, 5 Feb 2018 11:41:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Abhijeet Kumar <abhijeet.kumar@intel.com>
Subject: Re: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that
 pop noise when start capture
Message-ID: <20180205114154.GB12384@sirena.org.uk>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-29-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20180203180015.29073-29-alexander.levin@microsoft.com>
X-Cookie: Isn't this my STOP?!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2018 at 06:00:42PM +0000, Sasha Levin wrote:
> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>=20
> [ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]
>=20
> In skylake platform, we hear a loud pop noise(0 dB) at start of
> audio capture power up sequence. This patch removes the pop noise
> from the recording by adding a delay before enabling ADC.

>  	switch (event) {
>  	case SND_SOC_DAPM_POST_PMU:
> +		msleep(125);
>  		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,

This is another one of these where I'm not convinced that backporting to
stable isn't going to introduce regressions - it will fix problems on
some systems but if someone really cares about a startup pop and has
arranged to do something like discard the start of the audio where the
pop occurs then this may cut off even more and cause them to miss
things. =20

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp4QwEACgkQJNaLcl1U
h9BY1gf/Z2AYW2wrykftBW3dBU/wkDBYN1y5uX9zRs2AUj+SgxzvBueBbKMqtmFw
p9v/4HBvvSPFBmAKDx2P0OeqlnKYb9AUcJklASlDugrHzOWZQ8JtGFXHgRMzpHb5
1Fi/FWICRHTnQ/wDeSFjisACyLMKm0a4t88cW8iWOrEoKA46PwlaWnNt6QIXh2t6
s2XqIby9Gdt5PZ+u+RfT2sURCdYVVrc7C6p7U3g9AdiQwxKaoobdfVRU9inUDiU9
djbT0Q0xSFjJDCHufg8euyeoPLD6vAGLH4nQXSJyO0eqxAOF7hY400hWrUEJeqXv
bi9dHdzJtMpi7sXvg90ODPl/0FSY7g==
=nfP1
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
