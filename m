Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1700296-1520505574-2-382659219114840078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520505573; b=AJV8gju3+HGIadnUl1IMUnJ/pIkWoLdtsE52h3x+oXYlYt1
    dWmGm93TFoGmRm9zNAlf40Xr6M0n9hJmMuR+mfGHnbvOONZRUdEutI64MihpPqT/
    kfpwQTby5UUU0CsRormWFWFS9YOATHZ3NEQ1HhchRmwZqw6H7KcxMd3wjCKSivMq
    dLDtBSVc9nR+PqvYZ0f4CZWL2tq3IFtg0ww3l8I7RPKBWENlkGHctqcV02pMi1NA
    Qf4MAoQKLqSEtofb6tp+D4GNRe7FgE/uFW1AebQg7XPKjgLERDVBGZ4HueMj2AH2
    2f8dfjw4HT3EXS+MU4ZUofOQM5Fspy47j2JhMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520505573; bh=VmpHYAz1mXn+AWTrWUw3nWpmG2WtVjD6tmaF4n
    r61Ak=; b=HTPXbMvjzTUxs3FgfxtiCGJ3GLBtLRDSiBSSNlIxOSIeoxHzr4iNUV
    5Dp/C0mkzCyRnKBmr+PKb3FKVnzPueC1EtMXKjEyPtFswjWj1YHfTzXu5soLgPNX
    1Se8jkzhqFVzfOem7Y/Rv/19euKJH2FyWr5+3/ObebkidNzjTFTu1vYYXbTGaOTr
    qYs5+5f7Aehn6h1kHMOlhCTIvDd/M6efFpGn8fCu4h5VEBuxqdjdQHkCiO01+oou
    LcA3ohURbKBFhWd/X51vGAKg0SY8NVcZIK7fhgGJl6GmNSX+smfITKDGnbX4ya4p
    GAklNtccx4fWqZYiv3PL2azYv43cXbUw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935635AbeCHKjP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 05:39:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:53074 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755301AbeCHKjP (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 05:39:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,440,1515484800";
   d="asc'?scan'208";a="206498234"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: add dual role support using OTG block
In-Reply-To: <1519731019-2220-1-git-send-email-rogerq@ti.com>
References: <1519730952-2102-1-git-send-email-rogerq@ti.com> <1519731019-2220-1-git-send-email-rogerq@ti.com>
Date: Thu, 08 Mar 2018 12:39:05 +0200
Message-ID: <87lgf2vol2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger Quadros <rogerq@ti.com> writes:

> This is useful on platforms (e.g. TI AM437x) that don't
> have ID available on a GPIO but do have the OTG block.
>
> We can obtain the ID state via the OTG block and use it
> for dual-role switching.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

patch one applied fine to testing/next. But not this one:

checking file drivers/usb/dwc3/core.c
Hunk #2 FAILED at 107.
Hunk #3 succeeded at 122 (offset -5 lines).
Hunk #4 succeeded at 166 (offset -3 lines).
Hunk #5 succeeded at 365 (offset 5 lines).
Hunk #6 succeeded at 382 (offset 5 lines).
Hunk #7 succeeded at 1193 with fuzz 2 (offset -145 lines).
Hunk #8 FAILED at 1383.
2 out of 8 hunks FAILED
checking file drivers/usb/dwc3/core.h
Hunk #2 succeeded at 901 (offset 33 lines).
Hunk #3 succeeded at 1040 (offset 35 lines).
Hunk #4 succeeded at 1316 (offset 46 lines).
Hunk #5 succeeded at 1334 (offset 46 lines).
Hunk #6 succeeded at 1380 (offset 46 lines).
checking file drivers/usb/dwc3/drd.c

care to rebase?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqhEskACgkQzL64meEa
mQanfRAArgdNjyb2bkKunwegkYpqOauutQkxB436cSpEHCHPZSvirdJO5IBuOJyT
RUog5wDs4mAJnNouK100KTGoehi3HoHrLPmUmppqWDMfNzIqLwv0nEzG+bp3Fhm8
gpSfm2iZLOf2p/y7oJtGJGq52EkVahNrPerTKMFUYIrTBoZ4v4DUtdjibCCiS+LA
KlTSW8gCg1f2lCEVuQN8eUkZBnsI2IVcm1bnAY5f2+LH+ysTYEi0yVNrLok/OMOg
q1MvB9Nvmg7tUQS7Vfi/dZriYXgeM6LvHtkssFODg5tmpL9gQtcUuJ8ieV7kz03D
lYlztFyVAvJimJYD745P7APr3KQXxdUF7F0qsStn2Cq2Gy8qLvaDSlmhD1Hw4NvP
24kVBMh207T36z7a+0FsNIvwDI/9+yAH6VGrx1pgyOjjERdLLOdo3FDPIk2aedaq
Wzu8Or2bX6D8CULT9JKvs7xkw1NIqN9UXtF9eattRbaoyh046/oDkmrreiSpi17a
2tbCBraqLfz4Rv1ssydp6tHn1FFUEbTW+afvZrdCFmHzARP9WXys2X5eMGwOtIy4
MVB+vjOOatdL6ZuEA4l8D07Js2Ob93BlXatgjwRYcrPglYo1x24S0SBYSCQ47tfN
hZTR1obwYr6XY9LXwYom4mquxIcrPx80bx/zgKw6gvI+X2eUyMg=
=KH7K
-----END PGP SIGNATURE-----
--=-=-=--
