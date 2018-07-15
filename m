Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A22220882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A22220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeGPAOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:14:34 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34518 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeGPAOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:14:34 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1feqlr-0000ko-Hi; Sun, 15 Jul 2018 19:49:43 -0400
Message-ID: <1531698583.26425.3.camel@surriel.com>
Subject: Re: [PATCH 7/7] x86,switch_mm: skip atomic operations for init_mm
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Date:   Sun, 15 Jul 2018 19:49:43 -0400
In-Reply-To: <20180715230430.GD30102@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
         <20180710142833.26231-8-riel@surriel.com>
         <20180715230430.GD30102@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Jv7csBWMhbNAR0R4j4i3"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jv7csBWMhbNAR0R4j4i3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-16 at 01:04 +0200, Ingo Molnar wrote:
> * Rik van Riel <riel@surriel.com> wrote:
>=20
> > +		/*
> > +		 * Stop remote flushes for the previous mm.
> > +		 * Skip the idle task; we never send init_mm TLB
> > flushing IPIs,
> > +		 * but the bitmap manipulation can cause cache
> > line contention.
> > +		 */
> > +		if (real_prev !=3D &init_mm) {
> > +			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
> > +						mm_cpumask(real_pr
> > ev)));
> > +			cpumask_clear_cpu(cpu,
> > mm_cpumask(real_prev));
>=20
> BTW., could this optimization be (safely) extended to all (or most)
> !task->mm=20
> kernel threads?
>=20
> In particular softirq and threaded irq handlers could benefit greatly
> I suspect in=20
> certain networking intense workloads that happen to active them.

Yes, it could.

Are there kernel threads that use something other than
init_mm today?

--=20
All Rights Reversed.
--=-Jv7csBWMhbNAR0R4j4i3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltL3ZcACgkQznnekoTE
3oMHfQf/bUuvm85W1kry6Ug4YOu2v9lRoxM/ksLi81IKmffW/rNv6VKf9TQ/IoYz
X1iOiiA66+1JuxlxvunG5M0+/idKIl23WcDr9LWUh/vKD6GVyH057k/5aoyoqlz/
88Srllj8vxq1oKKLloKjNcTISc1p62yctFt3xF3yqqh0O6EgiALHIV+cwdmeUdsZ
1wMEv1L87lGQO9v6ZLs9hppkMBKcNqMYscUK0TiVaj+B9s0RRgKpuGLE9Qthz1ad
klOvk2cEbT7uTvLmST1XfLIgOKqRLAuxihb249M1LlSNEhF5qwp2mqK0ISS47Cvi
MTuWQfUNJ2Hm1e1LPXJVu0S/+y7dKw==
=ZKWk
-----END PGP SIGNATURE-----

--=-Jv7csBWMhbNAR0R4j4i3--

