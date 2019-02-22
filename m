Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC322070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fqlXLAeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBVT0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:26:12 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18974 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVT0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:26:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c704cda0000>; Fri, 22 Feb 2019 11:26:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 11:26:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Feb 2019 11:26:10 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 19:26:09 +0000
Subject: Re: [PATCH v5 4/9] mm/mmu_notifier: contextual information for event
 enums
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>, <kvm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190219200430.11130-1-jglisse@redhat.com>
 <20190219200430.11130-5-jglisse@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <49d6489c-31b4-511b-2504-bc7aa5d44673@nvidia.com>
Date:   Fri, 22 Feb 2019 11:26:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190219200430.11130-5-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550863578; bh=moXzvZWQOYM4BGU5mDrtuh+EjDOFrbKUSqkEdU832nI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fqlXLAeFhKwY6TP5GVtaWTaO7QF5ITIk6dsvNamSzXK2iReHcI9lZ48Mb//cmCY+/
         uE9tA19tSn/+Zff+czY5HVk72LmXFOcALM8hJsBblpMTqXmiFrLaj4OApAI0MzsJm5
         doxUuI5qDGBijzL0lkZ/Ty/4kBR4a+UnNNjo/VipTYUYpmS5u7ZhEK9XQzG8PfMC1l
         Z5jjm5ohCfsTVOtJSgQmxG2Z3yV1mY5c/3iK80E71ric2ItAwo/93XNgi8M5cRSCxG
         vEGxe86P2ADW6EFrJFBNO+PFsNeQup4EKbWkuuBPZIWnfPBnjIQOWF+YKbbl3HT7EL
         gCgol5oBcGR8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/19 12:04 PM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> CPU page table update can happens for many reasons, not only as a result

s/update/updates
s/happens/happen

> of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
> as a result of kernel activities (memory compression, reclaim, migration,
> ...).
>=20
> This patch introduce a set of enums that can be associated with each of

s/introduce/introduces

> the events triggering a mmu notifier. Latter patches take advantages of
> those enum values.

s/advantages/advantage

>=20
>      - UNMAP: munmap() or mremap()
>      - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
>      - PROTECTION_VMA: change in access protections for the range
>      - PROTECTION_PAGE: change in access protections for page in the rang=
e
>      - SOFT_DIRTY: soft dirtyness tracking
>=20

s/dirtyness/dirtiness

> Being able to identify munmap() and mremap() from other reasons why the
> page table is cleared is important to allow user of mmu notifier to
> update their own internal tracking structure accordingly (on munmap or
> mremap it is not longer needed to track range of virtual address as it
> becomes invalid).
>=20
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rdma@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/mmu_notifier.h | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>=20
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index c8672c366f67..2386e71ac1b8 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -10,6 +10,36 @@
>   struct mmu_notifier;
>   struct mmu_notifier_ops;
>  =20
> +/**
> + * enum mmu_notifier_event - reason for the mmu notifier callback
> + * @MMU_NOTIFY_UNMAP: either munmap() that unmap the range or a mremap()=
 that
> + * move the range

I would say something about the VMA for the notifier range
is being deleted.
MMU notifier clients can then use this case to remove any policy or
access counts associated with the range.
Just changing the PTE to "no access" as in the CLEAR case
doesn't mean a policy which prefers device private memory
over system memory should be cleared.

> + *
> + * @MMU_NOTIFY_CLEAR: clear page table entry (many reasons for this like
> + * madvise() or replacing a page by another one, ...).
> + *
> + * @MMU_NOTIFY_PROTECTION_VMA: update is due to protection change for th=
e range
> + * ie using the vma access permission (vm_page_prot) to update the whole=
 range
> + * is enough no need to inspect changes to the CPU page table (mprotect(=
)
> + * syscall)
> + *
> + * @MMU_NOTIFY_PROTECTION_PAGE: update is due to change in read/write fl=
ag for
> + * pages in the range so to mirror those changes the user must inspect t=
he CPU
> + * page table (from the end callback).
> + *
> + * @MMU_NOTIFY_SOFT_DIRTY: soft dirty accounting (still same page and sa=
me
> + * access flags). User should soft dirty the page in the end callback to=
 make
> + * sure that anyone relying on soft dirtyness catch pages that might be =
written
> + * through non CPU mappings.
> + */
> +enum mmu_notifier_event {
> +	MMU_NOTIFY_UNMAP =3D 0,
> +	MMU_NOTIFY_CLEAR,
> +	MMU_NOTIFY_PROTECTION_VMA,
> +	MMU_NOTIFY_PROTECTION_PAGE,
> +	MMU_NOTIFY_SOFT_DIRTY,
> +};
> +
>   #ifdef CONFIG_MMU_NOTIFIER
>  =20
>   /*
>=20
