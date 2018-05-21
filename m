Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-994429-1526920782-2-5410286336614399043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526920781; b=Fda17uGAyuuLM2LlGV+GCyNX21qZ9bbPPgnrXsB17A+hUy8jo0
    wv/16QSd5gIEZ+ulUY2YMJrarMf5lYAuQiRq/+MWyNCdJZnyGVp51xY1sS1/KPBV
    B6SLa4ijLxVnu1wU/Ki6cF1TZZwLpp9dyo9zgt8D/NhRNbuT2D2BOaV/htx4L49d
    yebyCpbR7eAdozkZWky0To6Mlsjpeme1W7mfviueMOYq7tXus53C45WwjWzvvhDB
    pWrCCZBegIK5WIcrZsWFXlkJxaF8lK8CsLlAwcjwOVA3yOcxhXDemylkGE/iHaS4
    6heNcY5VNtjoC+ZPo0Uv0RqAj0TUXgDwRoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526920781; bh=JUrffgIJ23nwUJZ6xqHytVuugToynz
    pjTFb1L3lqknU=; b=lljPMmEQJ9Tegi+0jsqXPYl0d4CrL6yNXu+RHza8Zh1Xnw
    1Dv1PLuqaau0LteOO2lEiAaF2h3lfgpxydwfcUxMf+6ZmZuNyWTpA+vZTeBixur5
    Ck2fijJDEwWcwR2Z2wDRlCcoIgm9XgPF22oD9XGrCttJjII6RLr2DofB6QFIR2dj
    BtlxJf24XBpFpIpfN4wvxbQ3JXdz0bsEpASxeDwWp+TQDMjPsDElnKn3KYZnvDMz
    ZkyWrXBi0zJqyfqGTE9eQ3DYxQcuOiXOnwx4meEp/4lo4hkuY97tU8U6MNANV2Ef
    N+ePJFs81xO/1O+BX91hv5GsWKTaoDk70WHXucOA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=nDLsTs3N x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=nDLsTs3N x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKSMVqncojwkY+IVRf439eRk9aH3+nY/Dr142tjSC1a+LAXYc8R9VZjD2u4bT+TKATR6ZltGCAfckkdb66lw9c+A5OpLSfrbW2YPje8FRTvOcbA3eA+E
    /pc3Ek7VW9Af73jwi6CD9G4ahD8+qzTxd7MZjFkBiaC4Y49zgiRtlXqDfP7n+1+wUCuUVS9tq9beKKCsc4On7ddHfvkB2f/rJsPemPmPOMxfdB6frbg74J1x
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Q0lVrt0h0enRR_aG0gkA:9 a=QEXdDO2ut3YA:10 a=MoJo_Drphb_vB-DR4jAA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbeEUQjj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 12:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752761AbeEUQji (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 12:39:38 -0400
Date: Mon, 21 May 2018 17:39:33 +0100
From: James Hogan <jhogan@kernel.org>
To: Mathias Kresin <dev@kresin.me>
Cc: john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Message-ID: <20180521163932.GA12779@jamesdev>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1523176203-18926-1-git-send-email-dev@kresin.me>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 10:30:03AM +0200, Mathias Kresin wrote:
> While doing a global software reset, these bits are not cleared and let
> some bootloader fail to initialise the GPHYs. The bootloader don't
> expect the GPHYs in reset, as they aren't during power on.
>=20
> The asserts were a workaround for a wrong syscon-reboot mask. With a
> mask set which includes the GPHY resets, these resets aren't required
> any more.
>=20
> Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU =
syscon-mfd")
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Applied for 4.17. Thanks for the acks/reviews folk!

Thanks
James

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwL2PgAKCRA1zuSGKxAj
8rK8AP0SVYNW7NEA13xPomDmbyz2GyrZgOSsEOtpLYO1Q9nJfQD/TP6iEOWkftpf
ZVv9xJSbsuXgiteRcmpW1dId20KZVwc=
=Z5bm
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
