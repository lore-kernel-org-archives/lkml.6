Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8F5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B36208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B36208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeJAWpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:45:47 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48426 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAWpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:45:47 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g70j3-0007j0-0q; Mon, 01 Oct 2018 12:07:13 -0400
Message-ID: <b1e2648c6fe01eb160b6817a4d7ff37109d806ef.camel@surriel.com>
Subject: Re: [PATCH 1/7] x86/mm/tlb: Always use lazy TLB mode
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de
Date:   Mon, 01 Oct 2018 12:07:12 -0400
In-Reply-To: <20181001155857.GK3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
         <20180926035844.1420-2-riel@surriel.com>
         <20181001155857.GK3439@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-S8P432ZICcoSYajjJTQI"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S8P432ZICcoSYajjJTQI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-10-01 at 17:58 +0200, Peter Zijlstra wrote:
> On Tue, Sep 25, 2018 at 11:58:38PM -0400, Rik van Riel wrote:
> > Now that CPUs in lazy TLB mode no longer receive TLB shootdown
> > IPIs, except
> > at page table freeing time, and idle CPUs will no longer get
> > shootdown IPIs
> > for things like mprotect and madvise, we can always use lazy TLB
> > mode.
>=20
> But that's only so at the end of this patch series; either change the
> Changelog or the location of this patch?

You are right, I should remove that from the changelog.

Want me to resend, or would you like to just replace
it with something like this:

"On most workloads, the number of context switches
far exceeds the number of TLB flushes sent. Optimizing
the context switches, by always using lazy TLB mode,
speeds up those workloads.

This patch results in about a 1% reduction in CPU use
on a two socket Broadwell system running a memcache
like workload."

--=20
All Rights Reversed.

--=-S8P432ZICcoSYajjJTQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluyRjAACgkQznnekoTE
3oMYSQf+LJYnpkHUgytxcTAOljLyX5/T+SEmbuLkDI/pSpWVyyM7Vqv8E7jk+T3q
thX1PSu6i/NahvQE/A23I11CM/GTYo7kxZIbd3AdU9lxChq+BwemkHXKHv5jpRkl
0154AGZLSaaYqQGRN84nhL38v5JpDrTQoBLU2PS6XBSGV3RJpEkEJSyaRC3e+VoO
x2tsnZX5TqMRU3IhDxks4uKcW9QwC/Pk7I8DBfghVahDl1w2795CWshX+LlyA2ib
8gnXRIFXTXHS5JMhVsZcAf+3Ig935+U0+eyYnlSSoBMEhEE8uJ7gxL9ZyT4LUe94
k4C51LXP1tjT6q+1lQkZKnjQPV1G8A==
=J8G/
-----END PGP SIGNATURE-----

--=-S8P432ZICcoSYajjJTQI--

