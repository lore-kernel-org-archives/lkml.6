Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7632F20871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a3gGH22y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7632F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGNBMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 21:12:30 -0400
Received: from ozlabs.org ([203.11.71.1]:60625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbeGNBMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 21:12:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41SB6k1NQCz9ryt;
        Sat, 14 Jul 2018 10:55:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531529726;
        bh=S8QjMzBqLclrHO8iaMhOlYf8OyM/vR5RnuLhnPC37Cc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a3gGH22yr2gFKtrUbd4vy63Pu38nyfwDlJ/l+earR7cUv89/c0nw7tQHN4OJCttnu
         KqTejn+WqRSRPHdxlDo2RKAGpTfGHJ4QSKQr/RjprDNodkZWW9lyl/UDuce/QZ4HJn
         ZFb8hqjT8LpMsF8DQABjbavMKRzWrrIvAJF3jnDwztzQOw4KLz0q52e7E2rguCjbHn
         xBsmX+eM7M89JsKYw1IeP/0QeYMlzFDcJxCyF1S3vfQGScOvZq+6x+t+voT7Rl24rM
         tKXmfoc3bcYdow9ZsECn02LyKcaOiAG9IQYAbBZ0UqO6D64zaGwAhEy6HppBdR8ItG
         3wPnhF6/xlWfw==
Date:   Sat, 14 Jul 2018 10:55:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        sachinp@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        sim@linux.vnet.ibm.com, venkatb3@in.ibm.com,
        LKML <linux-kernel@vger.kernel.org>, manvanth@linux.vnet.ibm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-next@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [next-20180711][Oops] linux-next kernel boot is broken on
 powerpc
Message-ID: <20180714105500.3694b93f@canb.auug.org.au>
In-Reply-To: <1531473191.6480.26.camel@abdul.in.ibm.com>
References: <1531416305.6480.24.camel@abdul.in.ibm.com>
        <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
        <1531473191.6480.26.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/h9o4dxATHYTD+EgczYGdc_="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h9o4dxATHYTD+EgczYGdc_=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Abdul,

On Fri, 13 Jul 2018 14:43:11 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.co=
m> wrote:
>
> On Thu, 2018-07-12 at 13:44 -0400, Pavel Tatashin wrote:
> > > Related commit could be one of below ? I see lots of patches related =
to mm and could not bisect
> > >
> > > 5479976fda7d3ab23ba0a4eb4d60b296eb88b866 mm: page_alloc: restore memb=
lock_next_valid_pfn() on arm/arm64
> > > 41619b27b5696e7e5ef76d9c692dd7342c1ad7eb mm-drop-vm_bug_on-from-__get=
_free_pages-fix
> > > 531bbe6bd2721f4b66cdb0f5cf5ac14612fa1419 mm: drop VM_BUG_ON from __ge=
t_free_pages
> > > 479350dd1a35f8bfb2534697e5ca68ee8a6e8dea mm, page_alloc: actually ign=
ore mempolicies for high priority allocations
> > > 088018f6fe571444caaeb16e84c9f24f22dfc8b0 mm: skip invalid pages block=
 at a time in zero_resv_unresv() =20
> >=20
> > Looks like:
> > 0ba29a108979 mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> >=20
> > This patch is going to be reverted from linux-next. Abdul, please
> > verify that issue is gone once  you revert this patch. =20
>=20
> kernel booted fine when the above patch is reverted.

And it has been removed from linux-next as of next-20180713.  (Friday
the 13th is not all bad :-))
--=20
Cheers,
Stephen Rothwell

--Sig_/h9o4dxATHYTD+EgczYGdc_=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltJSeQACgkQAVBC80lX
0GzEPgf+O8ZUulbaRgniWzhnLUmbpQm5/OWeEsLqXQOjU5/rHCoshZNJPaIJyJZJ
bBApGslZMfVpOqFwXAg0AyP3RHJwShjMaT/Et+9w7Q2UhxXV5DgPItJ9hvAmOBMk
9UvmL2gPbZ7UNMZQVnxpnSsPVMj9RWp5nNG59ANcgV8skYN/nPEEju/DtJ+QJFN/
utSHrk2BXD2juj1xgqQhAd8FGB0eRLFvWUFzMgLXWnl7ErTySkMSYYVYGtY9UBWN
RuKT/pMD/V6/DdJKLMODs9yQaPeP7s9pFAgXzYeqwxxcqfllxbCr6xhyP3po64kp
iDtz6xVa4SjoyUiR90n3DIPkbAHV2Q==
=mqb2
-----END PGP SIGNATURE-----

--Sig_/h9o4dxATHYTD+EgczYGdc_=--
