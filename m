Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADD8C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87E2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A87E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJXVUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:20:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41738 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeJXVUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:20:18 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gFIds-0002F8-NC; Wed, 24 Oct 2018 08:52:08 -0400
Message-ID: <3faac660df4f52a0a4e140cd51715f0efede56d1.camel@surriel.com>
Subject: Re: [PATCH 0/7] x86/mm/tlb: make lazy TLB mode even lazier
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel-team@fb.com, songliubraving@fb.com, will.deacon@arm.com,
        hpa@zytor.com, luto@kernel.org, npiggin@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Date:   Wed, 24 Oct 2018 08:52:08 -0400
In-Reply-To: <20181024055319.GA73309@gmail.com>
References: <20180924183759.23955-1-riel@surriel.com>
         <20181024055319.GA73309@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DOaT8WT9ap6L9LGur/AZ"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DOaT8WT9ap6L9LGur/AZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-10-24 at 07:53 +0200, Ingo Molnar wrote:
> * Rik van Riel <riel@surriel.com> wrote:
>=20
> > The big thing remaining is the reference count overhead of
> > the lazy TLB mm_struct, but getting rid of that is rather a
> > lot of code for a small performance gain. Not quite what
> > Linus asked for :)
>=20
> BTW., what would be the plan to improve scalability there,
> is it even possible?

One thing I looked at was shooting down the lazy TLB
MM from the exit code path, that way the MM would no
longer be referenced from any CPU by the time the
memory gets freed.

Once we do that, we no longer need to do any refcounting
for the lazy TLB MM.

--=20
All Rights Reversed.

--=-DOaT8WT9ap6L9LGur/AZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlvQavgACgkQznnekoTE
3oNMAQgAiHFXw8tNipEdZT3mvRm42r5nHzbL9sCNEQeza8ZQW7de/pz4lfFOepN4
dBJFODEEAYLpjoBzJpAtQohZl3fZoPO5eE/1Q3fAi3q1tpdbnzyguTSgQgIaYF5r
Ab8jDKKSNw3OEt8kwCq6oyvvNc118ZmZ1ktJWhaA90n9Xutfc+9bHrreSTrNeg6f
YhDPG814O7m5Ys9ZFQLRdw8gSlmr8Gvn4mNOZrQgt8sKhzUCrdNVDIq4tBQisKVq
ivoDNksry7L3HFa/UD13EboHXU6SH2MMsAsKyLDbc5lzmfALV3toSkECE5QaFQBX
faIhrPN8GdTRYtwLiPzuZ/K1P6kIrg==
=HFGi
-----END PGP SIGNATURE-----

--=-DOaT8WT9ap6L9LGur/AZ--

