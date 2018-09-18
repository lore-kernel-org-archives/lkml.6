Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A98214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A98214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbeIRUoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:44:23 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41694 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRUoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:44:23 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g2Heq-0001r4-Qp; Tue, 18 Sep 2018 11:11:20 -0400
Message-ID: <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
From:   Rik van Riel <riel@surriel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Sep 2018 11:11:20 -0400
In-Reply-To: <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
         <20180912133353.20595-5-bigeasy@linutronix.de>
         <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
         <20180914203501.qibhpmueosvkr74w@linutronix.de>
         <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
         <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
         <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-c268XyDDyxQNM28MvnHT"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c268XyDDyxQNM28MvnHT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-09-18 at 17:07 +0200, Paolo Bonzini wrote:
> On 18/09/2018 16:27, Sebastian Andrzej Siewior wrote:
> > > Likewise, move this to fpu__clear and outside "if
> > > (static_cpu_has(X86_FEATURE_FPU))"?
> >=20
> > okay. But if there is no FPU we did not save/restore the pkru
> > value. Is
> > this supposed to be an improvement?
>=20
> Honestly it just seemed "more correct", but now that I think about
> it,
> kernel threads should run with PKRU=3D0.  maybe there's a preexisting
> bug
> that your patch has the occasion to fix.

I don't think it matters what the PKRU state is
for kernel threads, since kernel PTEs should not
be using protection keys anyway.

--=20
All Rights Reversed.

--=-c268XyDDyxQNM28MvnHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluhFZgACgkQznnekoTE
3oNJbwf6AoBSP1/VOt6BOOQyRo7whsUYPZoXm/nP5aAUt6ujM0sf49T/gQUgO7Rw
O7I2zbvZUlKijD6Mf3be/2QNYjs8Y14hf84HvUmo2pSAPbq+wRTCVhvut6SHMnHd
sOeAfJHLUZ6olAZZt5HwXZUdU72hG85anEfMuy3oJU6G1bG4h46QiBkyICAgYKtt
ui4BopFK+mX+yPbohcjG448aitAXG5vNqNsdxYPGhx9ovcTpw3KDqJgUy5olrtPn
/OtqfNyKwmc9FYIEwyebfwnaWhsQ+UdA6p45Me2Ajx9gPpvci9XCsn/NnZkq5/RL
kM70oAa8N6bczzkf1byEvPMZWcUlMg==
=s8Yo
-----END PGP SIGNATURE-----

--=-c268XyDDyxQNM28MvnHT--

