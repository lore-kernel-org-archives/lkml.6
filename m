Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3804CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0617620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfBENHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:07:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBENHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:07:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAFA6118EA4;
        Tue,  5 Feb 2019 13:07:38 +0000 (UTC)
Received: from [10.40.205.61] (unknown [10.40.205.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7794761522;
        Tue,  5 Feb 2019 13:06:36 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
        dhildenb@redhat.com, aarcange@redhat.com
Subject: Re: [RFC][Patch v8 1/7] KVM: Support for guest free page hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-2-nitesh@redhat.com>
 <20190204231122-mutt-send-email-mst@kernel.org>
Organization: Red Hat Inc,
Message-ID: <ae7935c2-92d2-f6b8-49cb-7184bc205b30@redhat.com>
Date:   Tue, 5 Feb 2019 08:06:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204231122-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HIr98nCtS0YwgnsIfzRlZw2Spa61qNGhU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 05 Feb 2019 13:07:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HIr98nCtS0YwgnsIfzRlZw2Spa61qNGhU
Content-Type: multipart/mixed; boundary="V8HMvq59Pn2Q3bNORDfelpmpESXqugqDH";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com,
 dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
 aarcange@redhat.com
Message-ID: <ae7935c2-92d2-f6b8-49cb-7184bc205b30@redhat.com>
Subject: Re: [RFC][Patch v8 1/7] KVM: Support for guest free page hinting

--V8HMvq59Pn2Q3bNORDfelpmpESXqugqDH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 11:14 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 03:18:48PM -0500, Nitesh Narayan Lal wrote:
>> This patch includes the following:
>> 1. Basic skeleton for the support
>> 2. Enablement of x86 platform to use the same
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  arch/x86/Kbuild              |  2 +-
>>  arch/x86/kvm/Kconfig         |  8 ++++++++
>>  arch/x86/kvm/Makefile        |  2 ++
>>  include/linux/gfp.h          |  9 +++++++++
>>  include/linux/page_hinting.h | 17 +++++++++++++++++
>>  virt/kvm/page_hinting.c      | 36 +++++++++++++++++++++++++++++++++++=
+
>>  6 files changed, 73 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/page_hinting.h
>>  create mode 100644 virt/kvm/page_hinting.c
>>
>> diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
>> index c625f57472f7..3244df4ee311 100644
>> --- a/arch/x86/Kbuild
>> +++ b/arch/x86/Kbuild
>> @@ -2,7 +2,7 @@ obj-y +=3D entry/
>> =20
>>  obj-$(CONFIG_PERF_EVENTS) +=3D events/
>> =20
>> -obj-$(CONFIG_KVM) +=3D kvm/
>> +obj-$(subst m,y,$(CONFIG_KVM)) +=3D kvm/
>> =20
>>  # Xen paravirtualization support
>>  obj-$(CONFIG_XEN) +=3D xen/
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index 72fa955f4a15..2fae31459706 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -96,6 +96,14 @@ config KVM_MMU_AUDIT
>>  	 This option adds a R/W kVM module parameter 'mmu_audit', which allo=
ws
>>  	 auditing of KVM MMU events at runtime.
>> =20
>> +# KVM_FREE_PAGE_HINTING will allow the guest to report the free pages=
 to the
>> +# host in regular interval of time.
>> +config KVM_FREE_PAGE_HINTING
>> +       def_bool y
>> +       depends on KVM
>> +       select VIRTIO
>> +       select VIRTIO_BALLOON
>> +
>>  # OK, it's a little counter-intuitive to do this, but it puts it neat=
ly under
>>  # the virtualization menu.
>>  source "drivers/vhost/Kconfig"
>> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
>> index 69b3a7c30013..78640a80501e 100644
>> --- a/arch/x86/kvm/Makefile
>> +++ b/arch/x86/kvm/Makefile
>> @@ -16,6 +16,8 @@ kvm-y			+=3D x86.o mmu.o emulate.o i8259.o irq.o lap=
ic.o \
>>  			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
>>  			   hyperv.o page_track.o debugfs.o
>> =20
>> +obj-$(CONFIG_KVM_FREE_PAGE_HINTING)    +=3D $(KVM)/page_hinting.o
>> +
>>  kvm-intel-y		+=3D vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.=
o vmx/evmcs.o vmx/nested.o
>>  kvm-amd-y		+=3D svm.o pmu_amd.o
>> =20
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 5f5e25fd6149..e596527284ba 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -7,6 +7,7 @@
>>  #include <linux/stddef.h>
>>  #include <linux/linkage.h>
>>  #include <linux/topology.h>
>> +#include <linux/page_hinting.h>
>> =20
>>  struct vm_area_struct;
>> =20
>> @@ -456,6 +457,14 @@ static inline struct zonelist *node_zonelist(int =
nid, gfp_t flags)
>>  	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>>  }
>> =20
>> +#ifdef	CONFIG_KVM_FREE_PAGE_HINTING
>> +#define HAVE_ARCH_FREE_PAGE
>> +static inline void arch_free_page(struct page *page, int order)
>> +{
>> +	guest_free_page(page, order);
>> +}
>> +#endif
>> +
>>  #ifndef HAVE_ARCH_FREE_PAGE
>>  static inline void arch_free_page(struct page *page, int order) { }
>>  #endif
> OK so arch_free_page hook is used to tie into mm code,
> with follow-up patches the pages get queued in a list
> and then sent to hypervisor so it can free them.
> Fair enough but how do we know the page is
> not reused by the time it's received by the hypervisor?
> If it's reused then isn't it a problem that
> hypervisor calls MADV_DONTNEED on them?
Hi Michael,

In order to ensure that the page is not reused, we remove it from the
buddy free list by acquiring the zone lock. After the page is freed by
the hypervisor it is returned to the buddy free list again.
>
>
>> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting=
=2Eh
>> new file mode 100644
>> index 000000000000..b54f7428f348
>> --- /dev/null
>> +++ b/include/linux/page_hinting.h
>> @@ -0,0 +1,17 @@
>> +/*
>> + * Size of the array which is used to store the freed pages is define=
d by
>> + * MAX_FGPT_ENTRIES. If possible, we have to find a better way using =
which
>> + * we can get rid of the hardcoded array size.
>> + */
>> +#define MAX_FGPT_ENTRIES	1000
>> +/*
>> + * hypervisor_pages - It is a dummy structure passed with the hyperca=
ll.
>> + * @pfn: page frame number for the page which needs to be sent to the=
 host.
>> + * @order: order of the page needs to be reported to the host.
>> + */
>> +struct hypervisor_pages {
>> +	unsigned long pfn;
>> +	unsigned int order;
>> +};
>> +
>> +void guest_free_page(struct page *page, int order);
>> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
>> new file mode 100644
>> index 000000000000..818bd6b84e0c
>> --- /dev/null
>> +++ b/virt/kvm/page_hinting.c
>> @@ -0,0 +1,36 @@
>> +#include <linux/gfp.h>
>> +#include <linux/mm.h>
>> +#include <linux/kernel.h>
>> +
>> +/*
>> + * struct kvm_free_pages - Tracks the pages which are freed by the gu=
est.
>> + * @pfn: page frame number for the page which is freed.
>> + * @order: order corresponding to the page freed.
>> + * @zonenum: zone number to which the freed page belongs.
>> + */
>> +struct kvm_free_pages {
>> +	unsigned long pfn;
>> +	unsigned int order;
>> +	int zonenum;
>> +};
>> +
>> +/*
>> + * struct page_hinting - holds array objects for the structures used =
to track
>> + * guest free pages, along with an index variable for each of them.
>> + * @kvm_pt: array object for the structure kvm_free_pages.
>> + * @kvm_pt_idx: index for kvm_free_pages object.
>> + * @hypervisor_pagelist: array object for the structure hypervisor_pa=
ges.
>> + * @hyp_idx: index for hypervisor_pages object.
>> + */
>> +struct page_hinting {
>> +	struct kvm_free_pages kvm_pt[MAX_FGPT_ENTRIES];
>> +	int kvm_pt_idx;
>> +	struct hypervisor_pages hypervisor_pagelist[MAX_FGPT_ENTRIES];
>> +	int hyp_idx;
>> +};
>> +
>> +DEFINE_PER_CPU(struct page_hinting, hinting_obj);
>> +
>> +void guest_free_page(struct page *page, int order)
>> +{
>> +}
>> --=20
>> 2.17.2
--=20
Regards
Nitesh


--V8HMvq59Pn2Q3bNORDfelpmpESXqugqDH--

--HIr98nCtS0YwgnsIfzRlZw2Spa61qNGhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxZilkACgkQo4ZA3AYy
oznjow//eE8XdPPkiZJBR2mAg17PibCUXHDftOUhSl07Yxxr0gmlMaepDKKIUd6l
UI/+frN/Wt9iiC1D4cLP8ueWpwXLTKAZMw+TYzBU6vBUV6MaV9GGu3srPKxu7vea
+ULOFBDl6vJsKQfLFywNw+1n2WkrPI7wUSgMceXzOy7c6g/rDJjsesPOYcoeoiwX
US2Qr21z2jsnCqDPATmNqMrc6trJrxtu9LG6EOmTELe0C2BwcgJlK1nBH+7642E2
Hlo4ck2UuSnxctQPp/fL9FFaJkqes8eRrZMFzWD6ljP7UR767ZKTz0C0bxyQLt8u
2V4SM+RdMzc9Za98T1o9nXXO5Aeq/UW01LX5MjJszViWTEwcDzBPKnDThOv1JeFw
rbB7dIn79cvI7UdN6FAkk9fdWjltQzdzJ9rz+Lph/QPb5dgsonnHFhhPfB5jjAD3
WIabHiBEBwdjwXO3dGpodtv7BvgmqNokssXEFpmPzmBMK1vQg5+jQfLu/QVcJdVd
hXuc3naJBckcye25wOLlEEs1x9Mqc9i2G3vH2Vp8EEekwNYoNKYjFME+i4ASY5jF
axfPf8mkSyr6nSyzfgnov3gIu6l0+R4TBtruqfcCYpW6Jk63oWTbgACdYYA2Wbpc
c62WFnJHfx6ybFjjFiZM+3PvanLDKJ2r1tYjH/dBbZ/hb0OES5w=
=YND1
-----END PGP SIGNATURE-----

--HIr98nCtS0YwgnsIfzRlZw2Spa61qNGhU--
