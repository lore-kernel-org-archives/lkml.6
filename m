Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3037661-1518371870-2-13074823843225038968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518371869; b=B0PiYy9aBaybWY9y5R+5JR172wZnFs8OFn0xvWXLxnUHY6E
    oWUfpBV0TIRaKriYEcwtFKg/hcyUEJw8uPyXx/qBt/oXzuJ4JtHDlKaB7F9HdwYF
    O9dRXET3Z4pBaZlQ5fMoUG+ot2qmjNAUT1EuBa3Z0F3lGvgOjUTvWHkT2r1WHBV4
    D1CrUrhy+FGY/xKY0JfkOKL+A5wk+WsmpRv5dsAAipSEo3rOB/z/+DBSnnO2GeU1
    eXeQQq7QoYz6wTqNQrXU3tJqfnpJO7hV2IWRvceZEHC27izAqXiQS3gfrZ/njChU
    PKgkotz5d6zTpZqQe/nxRNfX21rXrh+eeIi0aqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518371869; bh=+S2lm9RDSiZd0gagRwxMh5gHjh
    UhxAl61gRPVJITz3k=; b=fxzIfUw9KmvMgREvAVdAPl8C0NLlYmK/AQe1QEZmWb
    FBHDRqPnS+ElifQGmeJH3fkKn8Ve0ZQHh8Eip5bNAxJvSyu5fVSGMFHUyyWJePBN
    rxjPR7CNwrJLDNURr/CJxs2QQCGaxxy2LLtt8nIumixjUaEZX60FN6hD3rJdMSiC
    Fdztt58pjI3mFN4rsl7L8cnwssCoVhg+7o6NQn0pOaWpFIyFVOsp48LBGIjOHbWb
    j4twrPUX2/LArHTMDm6pZBN9y+emHquseJVhBBIVpbggPoqxVoqNPGycZSWDiMae
    p4iAWtueJcxmHS3cViTymMqSro2GLztKzuSkb/GOXhnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeBKR5q (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 12:57:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45888 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753587AbeBKR5q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 12:57:46 -0500
Message-ID: <1518371848.2617.21.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/136] 3.16.54-rc1 review
From: Ben Hutchings <ben@decadent.org.uk>
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org
Date: Sun, 11 Feb 2018 17:57:28 +0000
In-Reply-To: <6cf9290b-6a68-f39e-3473-e97dffdcaf8b@roeck-us.net>
References: <lsq.1518323469.348919605@decadent.org.uk>
         <6cf9290b-6a68-f39e-3473-e97dffdcaf8b@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-mxIx0iZqKlQLBy37Dy4r"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-mxIx0iZqKlQLBy37Dy4r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-02-11 at 03:19 -0800, Guenter Roeck wrote:
> On 02/10/2018 08:31 PM, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.54 release.
> > There are 136 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Tue Feb 13 12:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 136 pass: 136 fail: 0
> Qemu test results:
> 	total: 108 pass: 108 fail: 0
>=20
> Details are available at http://kerneltests.org/builders.

Thanks for checking these.

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.


--=-mxIx0iZqKlQLBy37Dy4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqAhAkACgkQ57/I7JWG
EQm8XBAAlmBbhEdBgKCXWHsbZAaG0ruzZcxMnNMywFgAjwIKVAfhP5tfp+RVk4pV
tsQfjTInYaDe5sC1UCLZdDANkVQ2oP8/6W6qwm1LROtXTyA/X7rPtNg7EGlX2Aew
cMejbTuq6r0GgJ63uynSTEWIJcISZWFtr08raKRMfYu9Mdv/pp79+SmZ3MPuslwj
DrEfdWJkxFf0bmXV0qFJzLfNbkgrpagbTwZfpnqqIaJRihexaZqtJcqfN75iaaD1
RasroDSadzMhn4/JjFQh3PHkVbLNcTBu2FbSA6FPFvsFNAvnbN91Kx7DEr1xfh9T
bhtGH36GU95Mw0O9k8TAKDvNeVCWzX7+vQ+U25QiUUnRSk8mgCANMZjDkPLDIRz6
ZgM21XKB+fHHu+J9oGUHzU2hl2F8dYqcMZoVjVo9FTzdYOuszug8stkQ9eu+/eO9
C+93J7tnEzC80zGE7XgLF3V8xc4cPRy/goHWsiLoP+oWxEbhyPCkrE0D+f9mdGh+
4qu2BU6im5C05QItl1XeMzTfQtatpSn6A8pufcKq0mOBDMHg+2qLCNnlsXVU+A9A
tnmMuFYG7F/E9JbOyPgUaN8FI8tCUffIYIt7XrzFtE0jgS0VcvwN8czixP3MqzxO
HtHs5o8JkFNQfdVNMTFywhXrKr9kjnqPc9AxKG+64CM+aOI0woI=
=GCiG
-----END PGP SIGNATURE-----

--=-mxIx0iZqKlQLBy37Dy4r--
