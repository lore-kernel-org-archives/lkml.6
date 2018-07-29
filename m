Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E76FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F76205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F76205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeG2NbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:31:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46880 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeG2NbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:31:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjkNG-0004pL-RR; Sun, 29 Jul 2018 08:00:34 -0400
Message-ID: <1532865634.28585.2.camel@surriel.com>
Subject: Re: [PATCH 03/10] smp,cpumask: introduce on_each_cpu_cond_mask
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun, 29 Jul 2018 08:00:34 -0400
In-Reply-To: <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-4-riel@surriel.com>
         <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9StAdvISSn5n2ZKdNNic"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9StAdvISSn5n2ZKdNNic
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-07-28 at 19:57 -0700, Andy Lutomirski wrote:
> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
> wrote:
> > Introduce a variant of on_each_cpu_cond that iterates only over the
> > CPUs in a cpumask, in order to avoid making callbacks for every
> > single
> > CPU in the system when we only need to test a subset.
>=20
> Nice.
>=20
> Although, if you want to be really fancy, you could optimize this (or
> add a variant) that does the callback on the local CPU in parallel
> with the remote ones.  That would give a small boost to TLB flushes.

The test_func callbacks are not run remotely, but on
the local CPU, before deciding who to send callbacks
to.

The actual IPIs are sent in parallel, if the cpumask
allocation succeeds (it always should in many kernel
configurations, and almost always in the rest).

--=20
All Rights Reversed.
--=-9StAdvISSn5n2ZKdNNic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltdrGIACgkQznnekoTE
3oMuCAgAqdoD/Y8njVV+VYOQwQFWJ/lrqT6p7ol3hJr5H0jlrRL5knJz33m8FNTp
SSDjRTW0fVhqViNL/AqvHptIaq8TqCwMFgSwBzK0PQ86Uu4FrM74cfQIwsUT5mqt
xkitYNI1bkMLk9V3VLk05S/8QtF4wfrEmOmhjWm8VaNKg6VzpvTcpLZKLOV7XV09
sT55PRz6oDo6Z3YO0kSEP0mPPBb9jbxBt/QM9LmQlCjlDPUDBVL+ZRbhA9/VUoIu
c7iXB7H7OxAFJjAYKwLu8vZy0ycnyUHew3TMiqYTm4NMDphYRZ9n90suZKuJLtKB
ZNpXDlwacznCBBLNiNpWEzGmljpTig==
=YbxN
-----END PGP SIGNATURE-----

--=-9StAdvISSn5n2ZKdNNic--

