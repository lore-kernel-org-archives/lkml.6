Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9650EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EC0214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EC0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeIQTr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:47:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32807 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeIQTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:47:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id r37-v6so15429174qtc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=l9u5yS9YGBOlI2a3pg43GNDTQasmydrJVi9oRbRWKn4=;
        b=fo/AwlSpn5vRVGJt7xmr8UZ6S7+EwjSE9jCH6ZNOQ4PbXG8usnHpqfOOn1sgUX4ytt
         mRRVKxDwcWXuLMVErLOrN10/gyMRAIByKV9Dei5uT2MuUc5u8yR437DVg/UKPVXhI+jD
         Lb+x9atIajfgPEkHHORJZHtlendBU07j+QcvbLi6WUVD7Ynyl7W/KFaxkovivJF0rm1H
         yYcj4w3PFnV1pAUqwGbGiNt9qtGvAOc1jiGZWixZZvv1tYLe185lOAaWWMhhV8EArzFw
         weRIspFB0Vp5LPtyupqLZFJihmuofPJp2sala9KSWjq/m4OHakN93mE0C/AQpNeoI9YE
         CXkw==
X-Gm-Message-State: APzg51AotrFUKijNzfoxNWltSNmipDSSDQRXwKCzNsNbsVrWoV7+yRc3
        yOKEgnXbV53hU478BXauQVFKcA==
X-Google-Smtp-Source: ANB0VdaWgIsrWK/TM3y0d6qx4TW+d1PEwCRiUkZPCe2vuz9MZNPOQCRJ4NRqZMGUmB/pdCA6Nb1MGw==
X-Received: by 2002:a0c:95f7:: with SMTP id t52-v6mr17846185qvt.246.1537193994158;
        Mon, 17 Sep 2018 07:19:54 -0700 (PDT)
Received: from [172.25.130.148] (pool-128-6-36-179.nat.rutgers.edu. [128.6.36.179])
        by smtp.gmail.com with ESMTPSA id n25-v6sm7711127qtp.94.2018.09.17.07.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:19:53 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Vegard Nossum" <vegard.nossum@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrea Arcangeli" <aarcange@redhat.com>
Subject: Re: [PATCHv2] mm, thp: Fix mlocking THP page with migration enabled
Date:   Mon, 17 Sep 2018 10:19:51 -0400
X-Mailer: MailMate (2.0BETAr6121)
Message-ID: <899A7C0D-26EB-4FEF-A9DB-02E134ED841A@cs.rutgers.edu>
In-Reply-To: <20180917133816.43995-1-kirill.shutemov@linux.intel.com>
References: <20180917133816.43995-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_77024829-9149-44E2-8585-7FAB1DBDD09D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_77024829-9149-44E2-8585-7FAB1DBDD09D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Sep 2018, at 9:38, Kirill A. Shutemov wrote:

> A transparent huge page is represented by a single entry on an LRU list=
=2E
> Therefore, we can only make unevictable an entire compound page, not
> individual subpages.
>
> If a user tries to mlock() part of a huge page, we want the rest of the=

> page to be reclaimable.
>
> We handle this by keeping PTE-mapped huge pages on normal LRU lists: th=
e
> PMD on border of VM_LOCKED VMA will be split into PTE table.
>
> Introduction of THP migration breaks[1] the rules around mlocking THP
> pages. If we had a single PMD mapping of the page in mlocked VMA, the
> page will get mlocked, regardless of PTE mappings of the page.
>
> For tmpfs/shmem it's easy to fix by checking PageDoubleMap() in
> remove_migration_pmd().
>
> Anon THP pages can only be shared between processes via fork(). Mlocked=

> page can only be shared if parent mlocked it before forking, otherwise
> CoW will be triggered on mlock().
>
> For Anon-THP, we can fix the issue by munlocking the page on removing P=
TE
> migration entry for the page. PTEs for the page will always come after
> mlocked PMD: rmap walks VMAs from oldest to newest.
>
> Test-case:
>
> 	#include <unistd.h>
> 	#include <sys/mman.h>
> 	#include <sys/wait.h>
> 	#include <linux/mempolicy.h>
> 	#include <numaif.h>
>
> 	int main(void)
> 	{
> 	        unsigned long nodemask =3D 4;
> 	        void *addr;
>
> 		addr =3D mmap((void *)0x20000000UL, 2UL << 20, PROT_READ | PROT_WRITE=
,
> 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, -1, 0);
>
> 	        if (fork()) {
> 			wait(NULL);
> 			return 0;
> 	        }
>
> 	        mlock(addr, 4UL << 10);
> 	        mbind(addr, 2UL << 20, MPOL_PREFERRED | MPOL_F_RELATIVE_NODES,=

> 	                &nodemask, 4, MPOL_MF_MOVE);
>
> 	        return 0;
> 	}
>
> [1] https://lkml.kernel.org/r/CAOMGZ=3DG52R-30rZvhGxEbkTw7rLLwBGadVYeo-=
-iizcD3upL3A@mail.gmail.com
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Cc: <stable@vger.kernel.org> [v4.14+]
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  mm/huge_memory.c | 2 +-
>  mm/migrate.c     | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 533f9b00147d..00704060b7f7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2931,7 +2931,7 @@ void remove_migration_pmd(struct page_vma_mapped_=
walk *pvmw, struct page *new)
>  	else
>  		page_add_file_rmap(new, true);
>  	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
> -	if (vma->vm_flags & VM_LOCKED)
> +	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
>  		mlock_vma_page(new);
>  	update_mmu_cache_pmd(vma, address, pvmw->pmd);
>  }
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d6a2e89b086a..9d374011c244 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -275,6 +275,9 @@ static bool remove_migration_pte(struct page *page,=
 struct vm_area_struct *vma,
>  		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
>  			mlock_vma_page(new);
>
> +		if (PageTransHuge(page) && PageMlocked(page))
> +			clear_page_mlock(page);
> +
>  		/* No need to invalidate - it was non-present before */
>  		update_mmu_cache(vma, pvmw.address, pvmw.pte);
>  	}
> -- =

> 2.18.0

Thank you for the patch.

Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>

--
Best Regards
Yan Zi

--=_MailMate_77024829-9149-44E2-8585-7FAB1DBDD09D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJbn7gHAAoJEEGLLxGcTqbMAtMIAJhhq7gAYdDlkf2IbQ8h3rGV
0Xi9sn44v7wMc3ToNgepO9PXpF0MGAEQ9/MaZawrPR7MtTiiMxAI6WGF0O62Pji3
2WKyEMN1SyGLk5wGaqLmZplzuDhanSlemjNK7R2zvtEeyEBATDDacTw3gnKfmsx5
MwqEvtdcctOQQMQrwEMgxoXGegrmYgrmHesoOrC+cvg6dVIpAnAcbczkRg5U7U2T
NpBdBxwuz3WSFFaZLphiG5gUCBZLztXtD5GoepQ4Q0iuuukJElUtbj0XcxAH1liw
dPP8Jb/S6QhxfU9RPGUcj3LHVROux6bbXOhLHZfMby3bmlnyATbIASf5ZQnFssU=
=ZICK
-----END PGP SIGNATURE-----

--=_MailMate_77024829-9149-44E2-8585-7FAB1DBDD09D_=--
