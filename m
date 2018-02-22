Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-171462-1519306357-2-11570581444663912645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519306357; b=afhbrcHAEeRlmn3K1WkTyXd49XM3ZFcjv/dzyCHT4l7qReH
    ZUo3IbN3aOuftc1g5wNGgCFNVA7QOAstE8WwIizDWV6FpQm/ZjeUk/cI8ANld9UV
    TlC1BJivGzXXIaAmbzWjhygtU/62whG+LhesWQsgKBz2s2K5tK1SyFrdoaE3l8gi
    ELeexyKq7KpkNPK3IW0P0/TrItgKg5npt2uuSD2fN3Po93SXmErxAl/ARhpIc760
    DVfbTDEMZtMcIn8jjx1YkeoOIMCgcsoHjakETKdvWCfCVjPBKpmvE+4Drq7MqU89
    5afYo1+YbPcF8CpFa1SQCn4IT0R7jH9gM+OZq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1519306357; bh=KH1+MED5LBKpK+MVxGXx7cgLCg
    GePkcQswHdoU8ndeo=; b=hJsDaj+T4bnGUmys4ef5Yi7DSFoZnW7ODPg3LtLB/Y
    BPdrmURWwGER7MpXaPgz4qeQjlJKERS9rLyfRqOHGvi898smFZhYCOAlERlxXrX3
    sfmwpMXWXPT/jxpGRu9yfP6crsn6QXYI0A6Ifi6if8/yKaWyyW9y2AXj9EN9jMS2
    jVbCPa2P8hN5ZPZSD1zbC3qzg6XB7P+MJhUXiqrUL+WQkFV6RRBAA0VqzosHjW4h
    2m4/MGU8ZaCRxi380fjROX2FVuYzLl+8escI2BZO/XUXAB/uXjX29e5Nj85MdyXM
    P8E+Ec7KUrOZzIhn0POsBQaKFphiLF+6NRBsXPdROlrw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeBVNcX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 08:32:23 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:37796
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeBVNcW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 08:32:22 -0500
Message-ID: <1519306335.2388.18.camel@debian.org>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
From: Yves-Alexis Perez <corsac@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Feb 2018 14:32:15 +0100
In-Reply-To: <874lm9qi4t.fsf@concordia.ellerman.id.au>
References: <20180221124432.172390020@linuxfoundation.org>
         <20180221124433.618725458@linuxfoundation.org>
         <87k1v5rg66.fsf@concordia.ellerman.id.au>
         <1519292030.2388.14.camel@debian.org>
         <874lm9qi4t.fsf@concordia.ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hCeylf1X0b8M/tlX1zNP"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-hCeylf1X0b8M/tlX1zNP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-02-23 at 00:16 +1100, Michael Ellerman wrote:
> With the patches I just sent, for pseries and powernv, the mitigation
> should be in place. On machines with updated firmware we'll use the
> hardware-assisted L1 flush, otherwise we fallback to doing it in
> software.

So as of 4.9.82 meltdown is *not* addressed on those arches, but it should =
be
ok in 4.9.83 or 4.9.84 depending on when the patches are merged?

Regards,
--=20
Yves-Alexis
--=-hCeylf1X0b8M/tlX1zNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqOxl8ACgkQ3rYcyPpX
RFvslwf/aVnI05Nuqs39CHZJH9buIEFm2KLU2TmrvUGPHEN8yGg4AHlePfQCVuRw
jAHRYvIgdW318xR6cuq5qyjwfTivHb8LVKidP338g/7oZ7/y/gJvIjZnEQZoSmnA
0LVuNtjtGvCSvwSoRxBUS70/ScrVddUdgtpz53PZC1JT+ZDHn/41zkMX5ykpYRxz
wqDvk3yhV/8fL9KINROMUXyK3rARCxie4D6C0O6K9vYhx4S3KapEx7jG9fvji5ww
Dv9aPLBYk6QyzfGwg9JnKA+IBSMId7Sxc2UhxwfNxr+IvrOqcKLgyUC3WUVHMf3a
LdElfT1BeQkS5muGvN+jqgehUCvrdA==
=SY45
-----END PGP SIGNATURE-----

--=-hCeylf1X0b8M/tlX1zNP--
