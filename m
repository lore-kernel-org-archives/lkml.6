Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107823-1521505785-2-4628894282034282752
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
    t=1521505785; b=iPfZlwj3kHgfDIyPIIR2JPqp0wXWPYqPTr2HOnBkxEyGhpM
    rnXuQyA3Q6J4GAX7kL0GVm6nTZeUjKy7k8Z7bBZDA8BpBrh/nc9QyQK1QAlSIuM8
    vp7Su0O8FcdiFOZaFm3DOOQOKbR81NGPteqOxCr0+/qGCsZE1XWBAZTzquu9/hrJ
    4yqHOgz8sy4ykTKiFMN/YnDhzMLma4kUOvBJVS0EDFiEOndsVBfTw2k/kcvd417z
    2JoTInScE/S178oXewgQw7mT7kMXg0ccuB/XoswyHpVRv3qmMpxRs2R+cLTAbBJQ
    ldKCijWrsBOX+Sr9Oy1WzUZlq2UYHon7pH/7dEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521505785; bh=1++1U2rwUWuZPP4xl3Z/wVPbAy
    M1fsoa8dfz4TWXGTQ=; b=fbkZKf1hZ2mntbJAQA0WE9qByR4pwXtJ4E2Drilke9
    uzqI8eExKm79UNeT7jQe3qAfCXxuw3hfRnKa290wfE8D4W5pxZKtoybyHGa/dtzz
    eMar2SxMj/G9EbQ0NRFuav4ghWuJNpoo3RGziyqITeXUeC565DnSPIbbLKhejOyR
    n6I5tvwdC8tsA2yp9KyXkOEUw0lOTc6M0jOjov8JHO/ro3ucJYZMSNWGX6eUZrE0
    m1Lfe51UHFEGY59cOydCGmpiON8p4fL+Dca7FYE6ygu/tcw8eZ5DMBIZxvpcxg4C
    fv6qbUG1c1P/+d7d8fwu3CBr7cTQ+TMxgDkQCSCGLwmg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=sbZPT0DJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehgtderredtredvnecuhfhrohhmpeforghrkhcuuehrohifnhcuoegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpvddukedrvdehhedrleelrdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeefledvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=sbZPT0DJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehgtderredtredvnecuhfhrohhmpeforghrkhcuuehrohifnhcuoegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpvddukedrvdehhedrleelrdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeefledvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935008AbeCTA3m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 20:29:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCTA3l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 20:29:41 -0400
Date: Tue, 20 Mar 2018 08:29:35 +0800
From: Mark Brown <broonie@kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Applied "spi: Fix unregistration of controller with fixed SPI
 bus number" to the regulator tree
Message-ID: <20180320002935.GL2186@sirena.org.uk>
References: <E1etZqo-0001cw-Ee@debutante>
 <f224119b-f038-3e39-dd91-887f2c1b401c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7+XW987wMXbik5u"
Content-Disposition: inline
In-Reply-To: <f224119b-f038-3e39-dd91-887f2c1b401c@linux.intel.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--C7+XW987wMXbik5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2018 at 02:14:26PM +0200, Jarkko Nikula wrote:

> Was this lost in the regulator tree? I noticed my patch isn't in linux-next.

Possibly...  can't see it - could you resend please?

--C7+XW987wMXbik5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqwVe4ACgkQJNaLcl1U
h9At6Af/Wj+udjoAsR6JYWXgYkzHGWW7nHQOMwe2HrjK6GCmeAQo1lbG7ESW4HLH
v1vgQCOORC1HhBnyXLDM0qsvwREwmPeFQ6Fo4qUEwSrjsLrf58W76zOyOb1xWnvt
yAiKzt8Q/NrIkQ/UXCUFjlNoo+4+sJW0ar79N5+rpM2n0I/U17PMw63tTxiT7GfG
BPBQ4x7RU1vpPQVOTR0nVNTunoCOQZuAuWKAm6U2A8bcBGSTWYbU9HJvTLrRdbWw
vEm1UJYb3zBFxs14Lp3jq6KsWytHFWK+zbwrfO3TOOc6P5XnO3Dd/+C3fkJcaU++
BXen/L8ZAURwn+yXfsd2Ia7xKPXkuQ==
=98SI
-----END PGP SIGNATURE-----

--C7+XW987wMXbik5u--
