Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96492098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96492098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJDXjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:39:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56326 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:39:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g86kO-0003AV-F2; Thu, 04 Oct 2018 12:45:08 -0400
Message-ID: <8ea44ae2bb4844df812ea4c6cb0c00ef12708c51.camel@surriel.com>
Subject: Re: [PATCH 00/11 v3] x86: load FPU registers on return to userland
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 04 Oct 2018 12:45:08 -0400
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CCYwfcJr17T/u8twOaRy"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CCYwfcJr17T/u8twOaRy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-10-04 at 16:05 +0200, Sebastian Andrzej Siewior wrote:


> In v3 I dropped that decouple idea. I also learned that the wrpkru
> instruction is not privileged and so caching it in kernel does not
> work.

Wait, so any thread can bypass its memory protection
keys, even if there is a seccomp filter preventing
it from calling the PKRU syscalls?

Is that intended?

Is that simply a hardware limitation, or something
where we can set a flag somewhere to force tasks to
go through the kernel?

--=20
All Rights Reversed.

--=-CCYwfcJr17T/u8twOaRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlu2Q5QACgkQznnekoTE
3oPwNwf/Zv/OpILcyjCSA6nTBdg+SHTgfDg/BUMtLnZZUzR09a6Wm5sD2keAzM5F
qFfC+ladBxbir0jRg/Y1lOFU3pUbiF9EUcVwS0Q1Umu8mqYSrdJ97Jh1U/waWQIa
Da2ommOp50I1rtWIF1ej30blt4c9IuDYiscYSO8sXAgu9DCWE0tK/wru2IaVqaFP
U9ibaSo0VO6J4x/ryqB54ic3tJvS0lJsJj7o4VLHreuwkLpJbhDzmyYchCidqO7J
OkuDh6WBPOZgGZX+DUmfl4lu5xyNqUq8k9GWoHvc0giAQC8xLgUutIIsw7rCn6TO
ecCMifRIthNeiHfsCYnD0W9wHq8i0Q==
=C+9y
-----END PGP SIGNATURE-----

--=-CCYwfcJr17T/u8twOaRy--

