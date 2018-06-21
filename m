Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EA320652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EA320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeFUAZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:25:28 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52610 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeFUAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:25:27 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVnPe-0005pi-Qy; Wed, 20 Jun 2018 20:25:22 -0400
Message-ID: <1529540722.7898.180.camel@surriel.com>
Subject: Re: [PATCH 7/7] x86,idle: do not leave mm in idle state
From:   Rik van Riel <riel@surriel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org, luto@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        efault@gmx.de, songliubraving@fb.com, kernel-team@fb.com
Date:   Wed, 20 Jun 2018 20:25:22 -0400
In-Reply-To: <201806210615.8NIETZnu%fengguang.wu@intel.com>
References: <20180620195652.27251-8-riel@surriel.com>
         <201806210615.8NIETZnu%fengguang.wu@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y7UBkHX/nvcJT0cFsnh7"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y7UBkHX/nvcJT0cFsnh7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-21 at 06:20 +0800, kbuild test robot wrote:

> All error/warnings (new ones prefixed by >>):
>=20
>    arch/x86/xen/mmu_pv.c: In function 'drop_mm_ref_this_cpu':
> > > arch/x86/xen/mmu_pv.c:987:3: error: implicit declaration of
> > > function 'leave_mm' [-Werror=3Dimplicit-function-declaration]
>=20
>       leave_mm(smp_processor_id());
>       ^~~~~~~~
>    cc1: some warnings being treated as errors

This was the result of a last minute cleanup,
erroneously thinking I had removed the last
user of leave_mm.  Of course there's Xen :)

Fixed in my tree for v2.

--=20
All Rights Reversed.
--=-y7UBkHX/nvcJT0cFsnh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsq8HIACgkQznnekoTE
3oO8GAgArxT0UvGTzddXQ7sXdXsPYFq8CPYGddN2LvWTBn67xXttgVNM0AfCKKp8
trRajJ6zcY1/iKICS8CEL3QFbe6BdoYu339icAm3AzQhAXeVXbsk+tH2D4Ez312P
56G7en9yZ6DyBAs2nGAlMIqMjSiYDpC+JfDhcr3ZRz8zo1fd4QPCZj8RDVkwhwq/
qgg+j1pICbbiD5v3jl3tdGtjmWSZ5+gJUeQaPShVKnNWYm1kuUVHtWiyK1EKm1sc
FQKreGU3OH+1Z48cGu2wow7zZ1UJh0mH197W7JIilBCU49b3pDrICNBYINtCYqnu
1Z9XmF0STj6gJnIa8TOzb6Z4+bUjeQ==
=3Wdz
-----END PGP SIGNATURE-----

--=-y7UBkHX/nvcJT0cFsnh7--

