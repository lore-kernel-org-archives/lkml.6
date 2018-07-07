Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F4FC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD64208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD64208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeGGVZM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:25:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58388 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeGGVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:25:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbuha-00066d-6o; Sat, 07 Jul 2018 17:25:10 -0400
Message-ID: <1530998709.5350.32.camel@surriel.com>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Rik van Riel <riel@surriel.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Sat, 07 Jul 2018 17:25:09 -0400
In-Reply-To: <1530951813.22672.10.camel@gmx.de>
References: <20180706215658.18018-1-riel@surriel.com>
         <20180706215658.18018-2-riel@surriel.com>
         <1530951813.22672.10.camel@gmx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-awYdHTKjwHjUmH5bKnh+"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-awYdHTKjwHjUmH5bKnh+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

   I. On Sat, 2018-07-07 at 10:23 +0200, Mike Galbraith wrote:
> On Fri, 2018-07-06 at 17:56 -0400, Rik van Riel wrote:
> > The mm_struct always contains a cpumask bitmap, regardless of
> > CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
> > simplify things, and simply have one bitmask at the end of the
> > mm_struct for the mm_cpumask.
>=20
> Otherwise virgin master.today grumbles.
>=20
>   CC      kernel/bounds.s
>   UPD     include/generated/timeconst.h
>   UPD     include/generated/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
>   UPD     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   HOSTCC  usr/gen_init_cpio
>   UPD     include/generated/compile.h
>   CC      init/main.o
> In file included from ./include/linux/cpumask.h:12:0,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:81,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from init/main.c:16:
> In function =E2=80=98bitmap_zero=E2=80=99,
>     inlined from =E2=80=98cpumask_clear=E2=80=99 at ./include/linux/cpuma=
sk.h:378:2,
>     inlined from =E2=80=98mm_init_cpumask=E2=80=99 at
> ./include/linux/mm_types.h:504:2,
>     inlined from =E2=80=98start_kernel=E2=80=99 at init/main.c:560:2:
> ./include/linux/bitmap.h:208:3: warning: =E2=80=98memset=E2=80=99 writing=
 64 bytes
> into a region of size 0 overflows the destination [-Wstringop-
> overflow=3D]
>    memset(dst, 0, len);
>    ^~~~~~~~~~~~~~~~~~~

I don't understand this one.

Inside init_mm we have this line:
        .cpu_bitmap     =3D { [BITS_TO_LONGS(NR_CPUS)] =3D 0},

which is the way the documentation suggests statically
allocated variable size arrays should be allocated=20
and initialized.

How does that result in a memset of the same size,
on the same array, to throw an error like above?

What am I doing wrong?

--=20
All Rights Reversed.
--=-awYdHTKjwHjUmH5bKnh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltBL7YACgkQznnekoTE
3oOaOAgAvzNAtMhfuKAutzsVKu2Gu33kVQFtmp+gEsBukxnlS2WUuXCJ9AXXNrcg
cHp5jDTt6F6pqv5zlJzTYTG2r0jIVlBdzg/y12LLyI0hrQ8r5GAP24Fl19ez/nDq
xsWEShJVK6uDXRjTUXGUK1/V9gR0F1sGlZp/SCg25uS1VRhV1H+cC7B2L9KxrSco
RA0WFCLs0iOmY7atDWL2cUdT/Pf8fDyf8/9+2A7T0UTmMrTHu1IvFenpjcpcI+e2
S803EQEsLREJZ7pa6S9njZ8bhrkEzgX/RQWDpXDspkFPeRhjnL8h2TtV8ehPVzVz
mGodNjf6UDMnhUezYbERGQe/+SII6A==
=ttpK
-----END PGP SIGNATURE-----

--=-awYdHTKjwHjUmH5bKnh+--

