Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2884524-1521728679-2-5838876089614976363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521728679; b=DA1S+lUj8KYb1+eL7BlzqJCxjL4j41CMvRCSDn7iJZI9W0t
    bxRegb6S3HZwP+P1FOcsX8OwTrz7ub8lWLT65scvD3YpI4ZJIU4Y8jQeuqe/vhKG
    dkB+ZXdDjwyfkh8j4wl5lpLK+8CQp+IswEEqIBxeA+/LapijzSJx0M5aU0vCjRWz
    vR4zz2YQSvdamXWsHorsF4CVPxd9B8CpGaFNU6XNwyCcbk7c4bzHBRLUk2nLno0Q
    e2hCHrrv8Era/GT3wubrPujZypU/I/eS+USdKYHisiaTUYtBa5Yt8ZG5KiO3jLEZ
    fm+gz9sgG671xXJ5yLPQGbAvkO8Yp00c6M2p0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521728679; bh=M3aTKS61gBw8EWj2JC+BxDCFcp
    9fvgll2xs8oIrzqvs=; b=N3yd2/nULOSnIWY36p/HaMxiFIelJBdIobkoXATPUt
    YS1gK+g/DLtKoMvOLrPjOVeDmVoC6ixmI0jxpTTHOfaJfP9DwcFSecTXActWxSur
    sk04Sf83cL4DLN9luDFsbZ811NwtN3mF3/cYmNxhhIqT67UXfVga1Ii+xR77NEA/
    kN1hCOKxSf2ORffXmrYLIATPCxNt6Ig1boooo+zkPfU7KLkRx9cPzo45Fy7kNcLu
    rZYoy97MH7JvqgGLoE2x4s5E60ejtsUnPSzx74RDNvwCVT3EbtLr4YzAAD8G7NDz
    vJhCQr7Z0eua1kvc4z5sn6jxLDnofCPrYRd0ZH3x8K/Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KdiDQPz2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gFV9wgp5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KdiDQPz2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gFV9wgp5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbeCVOYg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 10:24:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52114 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeCVOYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 10:24:35 -0400
X-Google-Smtp-Source: AG47ELtTWS9DymZOMidsZCQEwqvHTYSTXy1Ho5KSPM4Af15BUfwtPCWiqa2QZV5e4GRO30SiYDy+8w==
Date: Thu, 22 Mar 2018 15:24:32 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH] soc/tegra: pmc: fix child-node lookup
Message-ID: <20180322142432.GA5853@ulmo>
References: <20171115094458.31666-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20171115094458.31666-1-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 10:44:58AM +0100, Johan Hovold wrote:
> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
>=20
> To make things worse, the parent pmc node could end up being prematurely
> freed as of_find_node_by_name() drops a reference to its first argument.
>=20
> Fixes: 3568df3d31d6 ("soc: tegra: Add thermal reset (thermtrip) support t=
o PMC")
> Cc: stable <stable@vger.kernel.org>     # 4.0
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/soc/tegra/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqzvJsACgkQ3SOs138+
s6HPrRAApCkkMDOTQ5UGZnElEcAOQmZQFCeoRLNZgLLqA5UxqDm1wxsqnIaZsMG4
GQlmUJ8dtGsUeGsPCy019scvCCNewMdKXk6+mcMiCD2btzGwOlvCPmyH4eF2uL/c
ZcLQi+gJ3q0rqUptxhgbzsyrfly0TI1aVSJkOjLLuoEiqRjMdBc2pa6ZUh9zwWEQ
j39ncI0uH1Ny9KR68LPBX0u1XJtH0Ehk+4mMtKCThNbotJcGPrORGJitV8o0FoWq
X77H1m9TAnvE0FlHFkFvKyanA+bRpuGGg8ywQ3i7FHEwdQVb1M9Vio+tPj6IffBL
3gAmvbJ35VE7i2LXZqK3LXDLGFHmeJjvH/QVKuXwaDxwY1Ee2iiLFeGzKdabC5M/
Xup4QJpul2Qi4M1eGTLAeB2RnnM3kC78Ep1MNRraOLNs8xUxQciEbWSN5yAHKR1D
P/ZaIeh4PDI0ReGe8ujpYPs6dfLAiHKlvK1AI7j8zye+SfdvJZxUZ9Ui+bGhh8yd
Fgm+b+YcjYelldEvwndCsyk07Erb8Vp4RTc4Qk6092d9iXdjsxrWe5Tstm/iKaHX
mhoqk23/k8syd8CF5aWr3BAUDQcjoZI83i7IJhsIs3wcSMQ64S7KxWpFHWa0g15V
UNYrcIEQBStF0ky7Jdeh9mLPnucwVJ7qSqLJaK3O4OA5KqL0CUM=
=nOqv
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
