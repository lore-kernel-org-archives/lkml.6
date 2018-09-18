Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA55C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F399F21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F399F21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeIRXCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:02:40 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44724 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbeIRXCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:02:40 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g2Jo5-0003mi-Gd; Tue, 18 Sep 2018 13:29:01 -0400
Message-ID: <11aa7d0f4ba36eff8b61a5dc1bd35ee5195fd576.camel@surriel.com>
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Sep 2018 13:29:01 -0400
In-Reply-To: <20180918160419.2zeru6xnufxixcax@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
         <20180912133353.20595-5-bigeasy@linutronix.de>
         <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
         <20180914203501.qibhpmueosvkr74w@linutronix.de>
         <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
         <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
         <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
         <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
         <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
         <20180918160419.2zeru6xnufxixcax@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qeo8C7RCdou6hmINJRZf"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qeo8C7RCdou6hmINJRZf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-09-18 at 18:04 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-09-18 17:29:52 [+0200], Paolo Bonzini wrote:
> > > I don't think it matters what the PKRU state is
> > > for kernel threads, since kernel PTEs should not
> > > be using protection keys anyway.
> >=20
> > What about copy_from/to_user?
>=20
> This doesn't work for a kernel thread, does it? I mean they share the
> init's MM and never do copy_{from|to}_user.

Indeed, copy_from/to_user only works if current->mm
points at an mm_struct with userspace memory.

--=20
All Rights Reversed.

--=-qeo8C7RCdou6hmINJRZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluhNd0ACgkQznnekoTE
3oN7+Af9GJYyy55zxm7fhdOa+X8DIovy7Le9zNpPgqRaoQLhctM69+uvP1wF7oQY
V3wf3MrXD9eXq+DJHKqKFpfGcTAlIgl8YclJaEVE1vQjoKeYvfRmaXvMd+7Wguhv
+3PeKQ9H5KD8w266Z/tUXJOh/Nxbtkd3Qvvx86bv6uiSkd4rqhYihi7x9n6biU2R
UgxsbfPh/rmPN0RpNtAbPaWdq6XQ3SU/Z364+bMNFpW7kBVhMMw53D/ldpwusfo9
q9uvmSrA+DUtZloPpGaEMopMfpnnyby3EZ5Q+scfwC6YO0x9BoxKk0fOS2ImE++z
6tiOxmI1os93JUV7NLCOOL7Bpd7WGQ==
=HdUP
-----END PGP SIGNATURE-----

--=-qeo8C7RCdou6hmINJRZf--

