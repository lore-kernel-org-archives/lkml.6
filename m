Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727090-1517907280-2-16376535377759131828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517907279; b=MCronWfRXa5iaeC5rH5HlalfOK4DJaIZUPyV1HiunR1mXfM
    BdT1oRyNG1OgVahXR65ntYmY2Nka8/34bIYtYhvFYI73IxU7lzUoue4kVxFS+Rwb
    yJPwwB2MaFxW0l2EdkH9/KZky/y1W3gji32m/z1IrGQ23evjoGibwULENVo32Pup
    lg+aVT4Vpb46TSybHlQCa9GTe3gMVZzHxlKiB6RMHnFkgn/X1I1YBDIyqBng2ygG
    iBDziM1PcjOBEX0t45uEMe1kh4kkAy0XTGHEoDa+Lec7o9QhuIHIJGFsZ1Ltcv20
    yHyylKUgy341wnFz7yg1xz+Il1JoglsZnWoapdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517907279; bh=CqlAyJzDta+K4LNj2B6UgAginR
    G044ig+7CuORk5kKw=; b=pDWEsTgJCPMdjRMFfsLPLhVEFei2qQhSuKEWKorvDH
    ym/xvy3g9R2y6XBwkSAMdTHABtGsfFQF2Hnmsd2ZsmAgnnJhQDJOawID0VhI/7ul
    r7lu6IDg+8mvVpk5YfYoUBCxCs02GSx78FlUO3kZ+jIy68KNFy6KByR7AcXmRT+N
    cRca1EfZJPBCTCKg4WJTM/pV+99ErPl09pEwIbBg6HDUGeh51xaX1cN8HUp/43rj
    OE7HSZsM78Sv82f8WrxtK+A/xt77Ubla+QDnSeS0e+9aUIpqLdfpQoKlKiQso4v1
    +vB3kalkg2l4nmxKsPsw0gCXUalpZIU4yJRjJSDOH9fA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeBFIyZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 03:54:25 -0500
Received: from sauhun.de ([88.99.104.3]:36858 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbeBFIyY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Feb 2018 03:54:24 -0500
Date: Tue, 6 Feb 2018 09:54:22 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: change comparison to bitshift when
 dealing with a mask
Message-ID: <20180206085422.qokhonesh6oqtaof@ninjato>
References: <20180206085040.3018-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pouaakhr7brj4bh2"
Content-Disposition: inline
In-Reply-To: <20180206085040.3018-1-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--pouaakhr7brj4bh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 09:50:40AM +0100, Wolfram Sang wrote:
> Due to a typo, the mask was destroyed by a comparison instead of a bit
> shift.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Only build tested.

Add. note: according to 'git grep', this macro is unused currently, so
no regression.


--pouaakhr7brj4bh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp5bT4ACgkQFA3kzBSg
KbZ7KA//QLqcAARl4SwJ6us+/7ONAlbxEUypFJIWc/z2VymBZCEqSGV+xk+OSZon
sRemx6vsRSLrGCQ3++Vx9T/aajE8m5kIqm+2oDYNuYr2CyteLE60yL1g3VvWvQE2
OtvyWHimxaYDriWv4AH+XGUPBXzvtzwRBa6ih+4e9EoCVNzKsuXdxWf+N7yOEQSs
mRl9htiOpxASYkdJ9q8fywn48oPjKjy6j0fTN88dsXpk0C/7E5YlsGyrHnVT2EtB
IYPEIwGNeOqX6zfZUDImH8thGMYVPxw94pXrG53/5i1gH6kEP7K5PtIRt7lqGtjD
zV8toebfyCwlxvTfNS+EmnNUq9wy7V6O5/n2unNT02IQBj8sPs/7TKATG5QrD5yB
ODiruPrbu5KCiEL8Us6r9SW573DIAq1ZqoHSPfgnc5XjBnZb7dFpJMwggjle/6rm
CKysNcxa3L9osq6B+jMz6sUiIMdm687jTTLm/B2DHmiu2fd8ANH2EG254mGNB28H
Wd/y4z+9iEyP24MtjLQMJascT5bagmyzZ3ZQCjWASWTndptjfEMWEvDQ091mWZyw
sNcUnJzp5l6GGqmfLwY9lShHJziZBjsV9lvWbhL8EY8n8k9AQ7iP1KsrGEIaqvWa
m5kt1RPKpJvPiHn5qclnPOprnPOu9Cn115B6bWovUyqI8A3w0mk=
=Ik6a
-----END PGP SIGNATURE-----

--pouaakhr7brj4bh2--
