Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C18ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41852147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="r9L5ASt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41852147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbeIUOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:20:18 -0400
Received: from ozlabs.org ([203.11.71.1]:46633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389244AbeIUOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:20:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Gn0D6bqKz9sBJ;
        Fri, 21 Sep 2018 18:32:28 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537518749;
        bh=dx217izqt7rHaNMllnT90V4fcJTtovn6uYUT4wcWSuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r9L5ASt2twGtoBCsYbNCiVb9QzI9MoS2KBI8mrIAy/WNXg87poiYpSq6OTw1ObB4a
         8mIOLdDxjvSenIu7hWlX9coTgKqJlWFeVvoBVy4jkLCnSm0SWombrZFEJdhljrJyL2
         SVZ2tqH0HhQ2PuhRyetsbhE0lRzIKLkWMAIts8V/ocnupsSXWB5PDfkdvRT44bbiD3
         qxefOhXt8Mxh4JhBWesNcVJS8gnMsrOKyDp5QORwDljPIXURPosgk5fLGxJAVfmxNd
         qXOnrmsWjHxPP2OiCooY7h65UiFoDTnOSva9n+800qSMNxIZjUhAatrjlUo78yH2ly
         NesCXcR9azpJw==
Date:   Fri, 21 Sep 2018 18:32:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 4/9] signal/powerpc: Remove pkey parameter from
 __bad_area_nosemaphore
Message-ID: <20180921183228.6140665c@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-4-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/95WVGHuS4Ewzn/t6D3.S4zV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/95WVGHuS4Ewzn/t6D3.S4zV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:45 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Now that bad_key_fault_exception no longer calls __bad_area_nosemaphore
> there is no reason for __bad_area_nosemaphore to handle pkeys.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Again, very straight forward given that _exception(a,b,c,d) -> _exception_p=
key(a,b,c,d,0).

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/95WVGHuS4Ewzn/t6D3.S4zV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukrJwACgkQAVBC80lX
0GyKbwf7BQb2XOvMXtY2v569PpZmtI/71bKz1VQmyj/9KFSIR7BVVVoyN3KvMAi6
Zd/XI2a9faGJkyb6qWIDnHxLHNktEiqzU+oyn/EjSwh270K+U4z9qEyfpAtXTO0e
yWFjpGY57WUxFyXWXNRz+quhG4QEnMswLn/QtOcNcIzZ9Xwb/VXaGmqf7dBWLCr+
sTgjTFUKl4a8ccyu4YotV+rSU/e/BFDt6VqU6FD8a0xJSCF1NKEu+fhs8GXMZFkz
uk2q86HJ3AhhksBz1mhjRMm8QKIjzliB2hBRw+C6bglkWijcUcE4tq0tfiujvFLE
fgHkjFe52spf3N4FFG0vMUwbcbForA==
=kobP
-----END PGP SIGNATURE-----

--Sig_/95WVGHuS4Ewzn/t6D3.S4zV--
