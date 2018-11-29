Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F5208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3F5208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeK2M4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:56:03 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49596 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2M4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:56:03 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBV8-0008SE-8F; Wed, 28 Nov 2018 20:52:22 -0500
Message-ID: <cdd98047d6b8977f49bced95f8fd67f2953f632c.camel@surriel.com>
Subject: Re: [PATCH 01/29] x86/fpu: Use ULL for shift in
 xfeature_uncompacted_offset()
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 28 Nov 2018 20:52:21 -0500
In-Reply-To: <20181128222035.2996-2-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-2-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9h1MYVYAhemxwlPCV9gs"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9h1MYVYAhemxwlPCV9gs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
> The xfeature mask is 64bit so a shift from a number to its mask
> should
> have LL prefix or else nr > 31 will be lost. This is not a problem
> now
> but should XFEATURE_MASK_SUPERVISOR gain a bit >31 then this check
> won't
> catch it.
>=20
> Use BIT_ULL() to compute a mask from a number.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-9h1MYVYAhemxwlPCV9gs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/RlUACgkQznnekoTE
3oNvoAgArE1oDhD00rBCq+l5WcAoWgNdFAm0dCZyvKRMGxQQ1wR/Cju1lhD24U0j
KtY/p8q+fYSIH5AsTFTpFlJxLJxPv8Zf2xGU+Ktn2vVusED8bHBykDpJZ3Jc2JPB
QCwiPNOBr8hxGBxQoqcAcoVobk5YV+K6D5kFgjpAvNnNu+udKAS4pdxnZeAXuqDE
90MiT3ThqGzyCVvRRnqJTYe9sKGABH5R/U+ricbiDYHKkaFXz5Fd7/KfM/jqKBTP
b1IMS9QJ0s/xwD2nYATE0LOtmoQXfeMJcdRTxKkAQB0jkkCVYr8gfgITFAoTtUHB
DnwfQj9UpEPwhwIStB/oowVLc770zw==
=tgUH
-----END PGP SIGNATURE-----

--=-9h1MYVYAhemxwlPCV9gs--

