Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD21DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F90121564
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F90121564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeHYDmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:42:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35359 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHYDmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:42:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id f19-v6so10611115qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 17:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=F10aQn6k4WG2MYb5T2qBLPBy4b/yIV0tzlBEsFAXiGc=;
        b=IVkK7sTB1BJQiIF7m+8z3eevkeNZuBb4mSk85mIXu5Pr4a9ikeXYzR70Y4LC9xjrmz
         s/kOmQM7zfUJrkzhcnPisBP8GkxOMoIpNMVWZLjtsvu34GqkcAR57eebQSCxj4rBVOWq
         oN0sIXXMYmqu3jlSHiXmAV6J1fyyASS/xxtogm7LU1h7a+d1yAfQC7mz8LkKpjNQAE0s
         c1ktOsP8c6yfinKWJ1Dqkj/ZD3OotwBZQsBed3dnCargXEsgD83mlu8B9xaqYYYExMli
         g9S7/BjkIDTi/SYq04o6+ioYfvyvD03Swf9Fhpe/CkO0ew0RHoiznR4at6qm7/OgxOFY
         4WVw==
X-Gm-Message-State: APzg51BIAqdk/AN8lokh7I3Ha3JlTpnDAADqUvg8zJwbknA2iqVya3AX
        zpPXbMBLvV/2323PkDuZmt8kgg==
X-Google-Smtp-Source: ANB0VdbC5nhCq6WPlMVk5n3lSyu2DGAYBJvmySxMRyCk+YT8sMwWh38/Qf3ileoxY/gOSu3x/OaUEQ==
X-Received: by 2002:ac8:1b5b:: with SMTP id p27-v6mr4143490qtk.99.1535155549799;
        Fri, 24 Aug 2018 17:05:49 -0700 (PDT)
Received: from [192.168.1.153] (pool-108-53-39-217.nwrknj.fios.verizon.net. [108.53.39.217])
        by smtp.gmail.com with ESMTPSA id d11-v6sm5416282qkg.14.2018.08.24.17.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 17:05:48 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/7] mm/hmm: properly handle migration pmd
Date:   Fri, 24 Aug 2018 20:05:46 -0400
X-Mailer: MailMate (1.11.3r5510)
Message-ID: <0560A126-680A-4BAE-8303-F1AB34BE4BA5@cs.rutgers.edu>
In-Reply-To: <20180824192549.30844-5-jglisse@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-5-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_86A4A7E9-B661-45C6-8A35-BA7BDA284EA0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_86A4A7E9-B661-45C6-8A35-BA7BDA284EA0_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=A9r=C3=B4me,

On 24 Aug 2018, at 15:25, jglisse@redhat.com wrote:

> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> Before this patch migration pmd entry (!pmd_present()) would have
> been treated as a bad entry (pmd_bad() returns true on migration
> pmd entry). The outcome was that device driver would believe that
> the range covered by the pmd was bad and would either SIGBUS or
> simply kill all the device's threads (each device driver decide
> how to react when the device tries to access poisonnous or invalid
> range of memory).
>
> This patch explicitly handle the case of migration pmd entry which
> are non present pmd entry and either wait for the migration to
> finish or report empty range (when device is just trying to pre-
> fill a range of virtual address and thus do not want to wait or
> trigger page fault).
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/hmm.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index a16678d08127..659efc9aada6 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -577,22 +577,47 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  {
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
> +	struct vm_area_struct *vma =3D walk->vma;
>  	uint64_t *pfns =3D range->pfns;
>  	unsigned long addr =3D start, i;
>  	pte_t *ptep;
> +	pmd_t pmd;
>
> -	i =3D (addr - range->start) >> PAGE_SHIFT;
>
>  again:
> -	if (pmd_none(*pmdp))
> +	pmd =3D READ_ONCE(*pmdp);
> +	if (pmd_none(pmd))
>  		return hmm_vma_walk_hole(start, end, walk);
>
> -	if (pmd_huge(*pmdp) && (range->vma->vm_flags & VM_HUGETLB))
> +	if (pmd_huge(pmd) && (range->vma->vm_flags & VM_HUGETLB))
>  		return hmm_pfns_bad(start, end, walk);
>
> -	if (pmd_devmap(*pmdp) || pmd_trans_huge(*pmdp)) {
> -		pmd_t pmd;
> +	if (!pmd_present(pmd)) {
> +		swp_entry_t entry =3D pmd_to_swp_entry(pmd);
> +
> +		if (is_migration_entry(entry)) {

I think you should check thp_migration_supported() here, since PMD migrat=
ion is only enabled in x86_64 systems.
Other architectures should treat PMD migration entries as bad.

> +			bool fault, write_fault;
> +			unsigned long npages;
> +			uint64_t *pfns;
> +
> +			i =3D (addr - range->start) >> PAGE_SHIFT;
> +			npages =3D (end - addr) >> PAGE_SHIFT;
> +			pfns =3D &range->pfns[i];
> +
> +			hmm_range_need_fault(hmm_vma_walk, pfns, npages,
> +					     0, &fault, &write_fault);
> +			if (fault || write_fault) {
> +				hmm_vma_walk->last =3D addr;
> +				pmd_migration_entry_wait(vma->vm_mm, pmdp);
> +				return -EAGAIN;
> +			}
> +			return 0;
> +		}
> +
> +		return hmm_pfns_bad(start, end, walk);
> +	}
>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_86A4A7E9-B661-45C6-8A35-BA7BDA284EA0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAluAnVoWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzH0UCACrzspTKoppbPxVLBrUXSTqU8cT
CiBGJx9CoWUt8BYW+5kV1Ih/vUhPOIWINrtCUecy6VVd1+7OrdoSiq+AZ+9a+XCK
KXb/VKPv1r93iA8Mlo8E7DvwBYHMIBEjd35yUl4oJFkx4/6S7F0lCnyYRbi0sqDb
jVBOziuebcscpU25YMDNyozOB6EVYsxv/nRO9E1wxD24ag4QWnPJcVsYOSHp/G5i
Kk++tJcIZwMLAiNk2MlZqZ+QrjDszXNFPDy46UhcAYy0xvsodZyuFUvPM4w2LK3d
yFSJrE72K1QU6vTxwAYJ1Zf5JvkX4U32L4POaw6yrnpw+JxpzOV74NBnVB/5
=J6/i
-----END PGP SIGNATURE-----

--=_MailMate_86A4A7E9-B661-45C6-8A35-BA7BDA284EA0_=--
