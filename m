Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1CC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91D221EF9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91D221EF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeFUUSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:18:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58242 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932922AbeFUUSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:18:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fW625-0003IB-GR; Thu, 21 Jun 2018 16:18:17 -0400
Message-ID: <1529612297.7898.181.camel@surriel.com>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Rik van Riel <riel@surriel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        efault@gmx.de, songliubraving@fb.com, kernel-team@fb.com
Date:   Thu, 21 Jun 2018 16:18:17 -0400
In-Reply-To: <201806210526.ySVyrZ56%fengguang.wu@intel.com>
References: <20180620195652.27251-2-riel@surriel.com>
         <201806210526.ySVyrZ56%fengguang.wu@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hkg54010osUHb60bQWju"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hkg54010osUHb60bQWju
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-21 at 05:32 +0800, kbuild test robot wrote:
> Hi Rik,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on v4.17]
> [also build test ERROR on next-20180620]
> [cannot apply to tip/x86/core linus/master mmotm/master v4.18-rc1]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Rik-van-Riel/x86-tlb
> -mm-make-lazy-TLB-mode-even-lazier/20180621-045620
> config: x86_64-randconfig-x016-201824 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> Note: the linux-review/Rik-van-Riel/x86-tlb-mm-make-lazy-TLB-mode-
> even-lazier/20180621-045620 HEAD
> 7f2e7d915758c367dd0515efc17af977592fa141 builds fine.
>       It only hurts bisectibility.
>=20
> All errors (new ones prefixed by >>):
>=20
> > > mm/init-mm.c:38:1: error: Only string constants are supported as
> > > initializers for randomized structures with flexible arrays
>=20
>     };

Fixed in my tree for v2, by moving all of the randomizable
bits of mm_struct into an anonymous sub-structure, and
making sure the bitmap is always at the end.

--=20
All Rights Reversed.
--=-hkg54010osUHb60bQWju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlssCAkACgkQznnekoTE
3oMwhQf9EI1yShafID8LohYN/S7nfeZcYiip06sf8mZg8sSExqYUxK3E96bBitbU
etTBrm7eIk4peaEHdoFYuOP8KPm+hiSaXZlFRZVZH2UW45ve9Sjfai4qjHy/7Yp4
0v03xMso+LBl7ZRjLCZWfgLCpYi8atQizmfTIGxdzhqccaY6yfG0hWV/UOrA66bx
ziE6NhmPw9rIvol3L+5t8ITTLWY4XJvWhPAHo4ODw3m7ENvgB2PorO15x5d8jG9v
sjHbu8RXCXASe77TUuF+sDVWJ5k4KQnQDJMxeqBcPoUDEl4tO8Dd/Cwil+ulG8iq
jfN9TUiMS1tZ69qp3O/La1QP+ruFhw==
=gLUA
-----END PGP SIGNATURE-----

--=-hkg54010osUHb60bQWju--

