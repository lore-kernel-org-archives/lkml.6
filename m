Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07826C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF65D2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfBEVya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:54:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEVy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:54:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3950480F96;
        Tue,  5 Feb 2019 21:54:27 +0000 (UTC)
Received: from [10.40.205.61] (unknown [10.40.205.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62C8C61533;
        Tue,  5 Feb 2019 21:54:07 +0000 (UTC)
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
        dhildenb@redhat.com, aarcange@redhat.com
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
Date:   Tue, 5 Feb 2019 16:54:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205153607-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YSWSFOx2DDx856NC2X7WcbyY1QRAlwaHR"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 05 Feb 2019 21:54:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YSWSFOx2DDx856NC2X7WcbyY1QRAlwaHR
Content-Type: multipart/mixed; boundary="H1YmM4bITRO8YYteLwWF3AKmcldcFHyYM";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com,
 dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
 aarcange@redhat.com
Message-ID: <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190205153607-mutt-send-email-mst@kernel.org>

--H1YmM4bITRO8YYteLwWF3AKmcldcFHyYM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/5/19 3:45 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 03:18:53PM -0500, Nitesh Narayan Lal wrote:
>> This patch enables the kernel to scan the per cpu array and
>> compress it by removing the repetitive/re-allocated pages.
>> Once the per cpu array is completely filled with pages in the
>> buddy it wakes up the kernel per cpu thread which re-scans the
>> entire per cpu array by acquiring a zone lock corresponding to
>> the page which is being scanned. If the page is still free and
>> present in the buddy it tries to isolate the page and adds it
>> to another per cpu array.
>>
>> Once this scanning process is complete and if there are any
>> isolated pages added to the new per cpu array kernel thread
>> invokes hyperlist_ready().
>>
>> In hyperlist_ready() a hypercall is made to report these pages to
>> the host using the virtio-balloon framework. In order to do so
>> another virtqueue 'hinting_vq' is added to the balloon framework.
>> As the host frees all the reported pages, the kernel thread returns
>> them back to the buddy.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>
> This looks kind of like what early iterations of Wei's patches did.
>
> But this has lots of issues, for example you might end up with
> a hypercall per a 4K page.
> So in the end, he switched over to just reporting only
> MAX_ORDER - 1 pages.
You mean that I should only capture/attempt to isolate pages with order
MAX_ORDER - 1?
>
> Would that be a good idea for you too?
Will it help if we have a threshold value based on the amount of memory
captured instead of the number of entries/pages in the array?
>
> An alternative would be a different much lighter weight
> way to report these pages and to free them on the host.
>
>> ---
>>  drivers/virtio/virtio_balloon.c     |  56 +++++++-
>>  include/linux/page_hinting.h        |  18 ++-
>>  include/uapi/linux/virtio_balloon.h |   1 +
>>  mm/page_alloc.c                     |   2 +-
>>  virt/kvm/page_hinting.c             | 202 +++++++++++++++++++++++++++=
-
>>  5 files changed, 269 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_b=
alloon.c
>> index 728ecd1eea30..8af34e0b9a32 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -57,13 +57,15 @@ enum virtio_balloon_vq {
>>  	VIRTIO_BALLOON_VQ_INFLATE,
>>  	VIRTIO_BALLOON_VQ_DEFLATE,
>>  	VIRTIO_BALLOON_VQ_STATS,
>> +	VIRTIO_BALLOON_VQ_HINTING,
>>  	VIRTIO_BALLOON_VQ_FREE_PAGE,
>>  	VIRTIO_BALLOON_VQ_MAX
>>  };
>> =20
>>  struct virtio_balloon {
>>  	struct virtio_device *vdev;
>> -	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;=

>> +	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,=

>> +								*hinting_vq;
>> =20
>>  	/* Balloon's own wq for cpu-intensive work items */
>>  	struct workqueue_struct *balloon_wq;
>> @@ -122,6 +124,40 @@ static struct virtio_device_id id_table[] =3D {
>>  	{ 0 },
>>  };
>> =20
>> +#ifdef CONFIG_KVM_FREE_PAGE_HINTING
>> +void virtballoon_page_hinting(struct virtio_balloon *vb, u64 gvaddr,
>> +			      int hyper_entries)
>> +{
>> +	u64 gpaddr =3D virt_to_phys((void *)gvaddr);
>> +
>> +	virtqueue_add_desc(vb->hinting_vq, gpaddr, hyper_entries, 0);
>> +	virtqueue_kick_sync(vb->hinting_vq);
>> +}
>> +
>> +static void hinting_ack(struct virtqueue *vq)
>> +{
>> +	struct virtio_balloon *vb =3D vq->vdev->priv;
>> +
>> +	wake_up(&vb->acked);
>> +}
>> +
>> +static void enable_hinting(struct virtio_balloon *vb)
>> +{
>> +	guest_page_hinting_flag =3D 1;
>> +	static_branch_enable(&guest_page_hinting_key);
>> +	request_hypercall =3D (void *)&virtballoon_page_hinting;
>> +	balloon_ptr =3D vb;
>> +	WARN_ON(smpboot_register_percpu_thread(&hinting_threads));
>> +}
>> +
>> +static void disable_hinting(void)
>> +{
>> +	guest_page_hinting_flag =3D 0;
>> +	static_branch_enable(&guest_page_hinting_key);
>> +	balloon_ptr =3D NULL;
>> +}
>> +#endif
>> +
>>  static u32 page_to_balloon_pfn(struct page *page)
>>  {
>>  	unsigned long pfn =3D page_to_pfn(page);
>> @@ -481,6 +517,7 @@ static int init_vqs(struct virtio_balloon *vb)
>>  	names[VIRTIO_BALLOON_VQ_DEFLATE] =3D "deflate";
>>  	names[VIRTIO_BALLOON_VQ_STATS] =3D NULL;
>>  	names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>> +	names[VIRTIO_BALLOON_VQ_HINTING] =3D NULL;
>> =20
>>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>>  		names[VIRTIO_BALLOON_VQ_STATS] =3D "stats";
>> @@ -492,11 +529,18 @@ static int init_vqs(struct virtio_balloon *vb)
>>  		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
>>  	}
>> =20
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING)) {
>> +		names[VIRTIO_BALLOON_VQ_HINTING] =3D "hinting_vq";
>> +		callbacks[VIRTIO_BALLOON_VQ_HINTING] =3D hinting_ack;
>> +	}
>>  	err =3D vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>>  					 vqs, callbacks, names, NULL, NULL);
>>  	if (err)
>>  		return err;
>> =20
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING))
>> +		vb->hinting_vq =3D vqs[VIRTIO_BALLOON_VQ_HINTING];
>> +
>>  	vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
>>  	vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
>>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>> @@ -908,6 +952,11 @@ static int virtballoon_probe(struct virtio_device=
 *vdev)
>>  		if (err)
>>  			goto out_del_balloon_wq;
>>  	}
>> +
>> +#ifdef CONFIG_KVM_FREE_PAGE_HINTING
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING))
>> +		enable_hinting(vb);
>> +#endif
>>  	virtio_device_ready(vdev);
>> =20
>>  	if (towards_target(vb))
>> @@ -950,6 +999,10 @@ static void virtballoon_remove(struct virtio_devi=
ce *vdev)
>>  	cancel_work_sync(&vb->update_balloon_size_work);
>>  	cancel_work_sync(&vb->update_balloon_stats_work);
>> =20
>> +#ifdef CONFIG_KVM_FREE_PAGE_HINTING
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING))
>> +		disable_hinting();
>> +#endif
>>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>  		cancel_work_sync(&vb->report_free_page_work);
>>  		destroy_workqueue(vb->balloon_wq);
>> @@ -1009,6 +1062,7 @@ static unsigned int features[] =3D {
>>  	VIRTIO_BALLOON_F_MUST_TELL_HOST,
>>  	VIRTIO_BALLOON_F_STATS_VQ,
>>  	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>> +	VIRTIO_BALLOON_F_HINTING,
>>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>>  	VIRTIO_BALLOON_F_PAGE_POISON,
>>  };
>> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting=
=2Eh
>> index e800c6b07561..3ba8c1f3b4a4 100644
>> --- a/include/linux/page_hinting.h
>> +++ b/include/linux/page_hinting.h
>> @@ -1,15 +1,12 @@
>>  #include <linux/smpboot.h>
>> =20
>> -/*
>> - * Size of the array which is used to store the freed pages is define=
d by
>> - * MAX_FGPT_ENTRIES. If possible, we have to find a better way using =
which
>> - * we can get rid of the hardcoded array size.
>> - */
>>  #define MAX_FGPT_ENTRIES	1000
>>  /*
>>   * hypervisor_pages - It is a dummy structure passed with the hyperca=
ll.
>> - * @pfn: page frame number for the page which needs to be sent to the=
 host.
>> - * @order: order of the page needs to be reported to the host.
>> + * @pfn - page frame number for the page which is to be freed.
>> + * @pages - number of pages which are supposed to be freed.
>> + * A global array object is used to to hold the list of pfn and pages=
 and is
>> + * passed as part of the hypercall.
>>   */
>>  struct hypervisor_pages {
>>  	unsigned long pfn;
>> @@ -19,11 +16,18 @@ struct hypervisor_pages {
>>  extern int guest_page_hinting_flag;
>>  extern struct static_key_false guest_page_hinting_key;
>>  extern struct smp_hotplug_thread hinting_threads;
>> +extern void (*request_hypercall)(void *, u64, int);
>> +extern void *balloon_ptr;
>>  extern bool want_page_poisoning;
>> =20
>>  int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>>  			      void __user *buffer, size_t *lenp, loff_t *ppos);
>>  void guest_free_page(struct page *page, int order);
>> +extern int __isolate_free_page(struct page *page, unsigned int order)=
;
>> +extern void free_one_page(struct zone *zone,
>> +			  struct page *page, unsigned long pfn,
>> +			  unsigned int order,
>> +			  int migratetype);
>> =20
>>  static inline void disable_page_poisoning(void)
>>  {
> I guess you will want to put this in some other header.  Function
> declarations belong close to where they are implemented, not used.
I will find a better place.
>
>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/=
virtio_balloon.h
>> index a1966cd7b677..2b0f62814e22 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -36,6 +36,7 @@
>>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM *=
/
>>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages =
*/
>>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoni=
ng */
>> +#define VIRTIO_BALLOON_F_HINTING	5 /* Page hinting virtqueue */
>> =20
>>  /* Size of a PFN in the balloon interface. */
>>  #define VIRTIO_BALLOON_PFN_SHIFT 12
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d295c9bc01a8..93224cba9243 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1199,7 +1199,7 @@ static void free_pcppages_bulk(struct zone *zone=
, int count,
>>  	spin_unlock(&zone->lock);
>>  }
>> =20
>> -static void free_one_page(struct zone *zone,
>> +void free_one_page(struct zone *zone,
>>  				struct page *page, unsigned long pfn,
>>  				unsigned int order,
>>  				int migratetype)
>> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
>> index be529f6f2bc0..315099fcda43 100644
>> --- a/virt/kvm/page_hinting.c
>> +++ b/virt/kvm/page_hinting.c
>> @@ -1,6 +1,8 @@
>>  #include <linux/gfp.h>
>>  #include <linux/mm.h>
>> +#include <linux/page_ref.h>
>>  #include <linux/kvm_host.h>
>> +#include <linux/sort.h>
>>  #include <linux/kernel.h>
>> =20
>>  /*
>> @@ -39,6 +41,11 @@ int guest_page_hinting_flag;
>>  EXPORT_SYMBOL(guest_page_hinting_flag);
>>  static DEFINE_PER_CPU(struct task_struct *, hinting_task);
>> =20
>> +void (*request_hypercall)(void *, u64, int);
>> +EXPORT_SYMBOL(request_hypercall);
>> +void *balloon_ptr;
>> +EXPORT_SYMBOL(balloon_ptr);
>> +
>>  int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>>  			      void __user *buffer, size_t *lenp,
>>  			      loff_t *ppos)
>> @@ -55,18 +62,201 @@ int guest_page_hinting_sysctl(struct ctl_table *t=
able, int write,
>>  	return ret;
>>  }
>> =20
>> +void hyperlist_ready(struct hypervisor_pages *guest_isolated_pages, i=
nt entries)
>> +{
>> +	int i =3D 0;
>> +	int mt =3D 0;
>> +
>> +	if (balloon_ptr)
>> +		request_hypercall(balloon_ptr, (u64)&guest_isolated_pages[0],
>> +				  entries);
>> +
>> +	while (i < entries) {
>> +		struct page *page =3D pfn_to_page(guest_isolated_pages[i].pfn);
>> +
>> +		mt =3D get_pageblock_migratetype(page);
>> +		free_one_page(page_zone(page), page, page_to_pfn(page),
>> +			      guest_isolated_pages[i].order, mt);
>> +		i++;
>> +	}
>> +}
>> +
>> +struct page *get_buddy_page(struct page *page)
>> +{
>> +	unsigned long pfn =3D page_to_pfn(page);
>> +	unsigned int order;
>> +
>> +	for (order =3D 0; order < MAX_ORDER; order++) {
>> +		struct page *page_head =3D page - (pfn & ((1 << order) - 1));
>> +
>> +		if (PageBuddy(page_head) && page_private(page_head) >=3D order)
>> +			return page_head;
>> +	}
>> +	return NULL;
>> +}
>> +
>>  static void hinting_fn(unsigned int cpu)
>>  {
>>  	struct page_hinting *page_hinting_obj =3D this_cpu_ptr(&hinting_obj)=
;
>> +	int idx =3D 0, ret =3D 0;
>> +	struct zone *zone_cur;
>> +	unsigned long flags =3D 0;
>> +
>> +	while (idx < MAX_FGPT_ENTRIES) {
>> +		unsigned long pfn =3D page_hinting_obj->kvm_pt[idx].pfn;
>> +		unsigned long pfn_end =3D page_hinting_obj->kvm_pt[idx].pfn +
>> +			(1 << page_hinting_obj->kvm_pt[idx].order) - 1;
>> +
>> +		while (pfn <=3D pfn_end) {
>> +			struct page *page =3D pfn_to_page(pfn);
>> +			struct page *buddy_page =3D NULL;
>> +
>> +			zone_cur =3D page_zone(page);
>> +			spin_lock_irqsave(&zone_cur->lock, flags);
>> +
>> +			if (PageCompound(page)) {
>> +				struct page *head_page =3D compound_head(page);
>> +				unsigned long head_pfn =3D page_to_pfn(head_page);
>> +				unsigned int alloc_pages =3D
>> +					1 << compound_order(head_page);
>> +
>> +				pfn =3D head_pfn + alloc_pages;
>> +				spin_unlock_irqrestore(&zone_cur->lock, flags);
>> +				continue;
>> +			}
>> +
>> +			if (page_ref_count(page)) {
>> +				pfn++;
>> +				spin_unlock_irqrestore(&zone_cur->lock, flags);
>> +				continue;
>> +			}
>> +
>> +			if (PageBuddy(page)) {
>> +				int buddy_order =3D page_private(page);
>> =20
>> +				ret =3D __isolate_free_page(page, buddy_order);
>> +				if (!ret) {
>> +				} else {
>> +					int l_idx =3D page_hinting_obj->hyp_idx;
>> +					struct hypervisor_pages *l_obj =3D
>> +					page_hinting_obj->hypervisor_pagelist;
>> +
>> +					l_obj[l_idx].pfn =3D pfn;
>> +					l_obj[l_idx].order =3D buddy_order;
>> +					page_hinting_obj->hyp_idx +=3D 1;
>> +				}
>> +				pfn =3D pfn + (1 << buddy_order);
>> +				spin_unlock_irqrestore(&zone_cur->lock, flags);
>> +				continue;
>> +			}
>> +
>> +			buddy_page =3D get_buddy_page(page);
>> +			if (buddy_page) {
>> +				int buddy_order =3D page_private(buddy_page);
>> +
>> +				ret =3D __isolate_free_page(buddy_page,
>> +							  buddy_order);
>> +				if (!ret) {
>> +				} else {
>> +					int l_idx =3D page_hinting_obj->hyp_idx;
>> +					struct hypervisor_pages *l_obj =3D
>> +					page_hinting_obj->hypervisor_pagelist;
>> +					unsigned long buddy_pfn =3D
>> +						page_to_pfn(buddy_page);
>> +
>> +					l_obj[l_idx].pfn =3D buddy_pfn;
>> +					l_obj[l_idx].order =3D buddy_order;
>> +					page_hinting_obj->hyp_idx +=3D 1;
>> +				}
>> +				pfn =3D page_to_pfn(buddy_page) +
>> +					(1 << buddy_order);
>> +				spin_unlock_irqrestore(&zone_cur->lock, flags);
>> +				continue;
>> +			}
>> +			spin_unlock_irqrestore(&zone_cur->lock, flags);
>> +			pfn++;
>> +		}
>> +		page_hinting_obj->kvm_pt[idx].pfn =3D 0;
>> +		page_hinting_obj->kvm_pt[idx].order =3D -1;
>> +		page_hinting_obj->kvm_pt[idx].zonenum =3D -1;
>> +		idx++;
>> +	}
>> +	if (page_hinting_obj->hyp_idx > 0) {
>> +		hyperlist_ready(page_hinting_obj->hypervisor_pagelist,
>> +				page_hinting_obj->hyp_idx);
>> +		page_hinting_obj->hyp_idx =3D 0;
>> +	}
>>  	page_hinting_obj->kvm_pt_idx =3D 0;
>>  	put_cpu_var(hinting_obj);
>>  }
>> =20
>> +int if_exist(struct page *page)
>> +{
>> +	int i =3D 0;
>> +	struct page_hinting *page_hinting_obj =3D this_cpu_ptr(&hinting_obj)=
;
>> +
>> +	while (i < MAX_FGPT_ENTRIES) {
>> +		if (page_to_pfn(page) =3D=3D page_hinting_obj->kvm_pt[i].pfn)
>> +			return 1;
>> +		i++;
>> +	}
>> +	return 0;
>> +}
>> +
>> +void pack_array(void)
>> +{
>> +	int i =3D 0, j =3D 0;
>> +	struct page_hinting *page_hinting_obj =3D this_cpu_ptr(&hinting_obj)=
;
>> +
>> +	while (i < MAX_FGPT_ENTRIES) {
>> +		if (page_hinting_obj->kvm_pt[i].pfn !=3D 0) {
>> +			if (i !=3D j) {
>> +				page_hinting_obj->kvm_pt[j].pfn =3D
>> +					page_hinting_obj->kvm_pt[i].pfn;
>> +				page_hinting_obj->kvm_pt[j].order =3D
>> +					page_hinting_obj->kvm_pt[i].order;
>> +				page_hinting_obj->kvm_pt[j].zonenum =3D
>> +					page_hinting_obj->kvm_pt[i].zonenum;
>> +			}
>> +			j++;
>> +		}
>> +		i++;
>> +	}
>> +	i =3D j;
>> +	page_hinting_obj->kvm_pt_idx =3D j;
>> +	while (j < MAX_FGPT_ENTRIES) {
>> +		page_hinting_obj->kvm_pt[j].pfn =3D 0;
>> +		page_hinting_obj->kvm_pt[j].order =3D -1;
>> +		page_hinting_obj->kvm_pt[j].zonenum =3D -1;
>> +		j++;
>> +	}
>> +}
>> +
>>  void scan_array(void)
>>  {
>>  	struct page_hinting *page_hinting_obj =3D this_cpu_ptr(&hinting_obj)=
;
>> +	int i =3D 0;
>> =20
>> +	while (i < MAX_FGPT_ENTRIES) {
>> +		struct page *page =3D
>> +			pfn_to_page(page_hinting_obj->kvm_pt[i].pfn);
>> +		struct page *buddy_page =3D get_buddy_page(page);
>> +
>> +		if (!PageBuddy(page) && buddy_page) {
>> +			if (if_exist(buddy_page)) {
>> +				page_hinting_obj->kvm_pt[i].pfn =3D 0;
>> +				page_hinting_obj->kvm_pt[i].order =3D -1;
>> +				page_hinting_obj->kvm_pt[i].zonenum =3D -1;
>> +			} else {
>> +				page_hinting_obj->kvm_pt[i].pfn =3D
>> +					page_to_pfn(buddy_page);
>> +				page_hinting_obj->kvm_pt[i].order =3D
>> +					page_private(buddy_page);
>> +			}
>> +		}
>> +		i++;
>> +	}
>> +	pack_array();
>>  	if (page_hinting_obj->kvm_pt_idx =3D=3D MAX_FGPT_ENTRIES)
>>  		wake_up_process(__this_cpu_read(hinting_task));
>>  }
>> @@ -111,8 +301,18 @@ void guest_free_page(struct page *page, int order=
)
>>  		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].order =3D
>>  							order;
>>  		page_hinting_obj->kvm_pt_idx +=3D 1;
>> -		if (page_hinting_obj->kvm_pt_idx =3D=3D MAX_FGPT_ENTRIES)
>> +		if (page_hinting_obj->kvm_pt_idx =3D=3D MAX_FGPT_ENTRIES) {
>> +			/*
>> +			 * We are depending on the buddy free-list to identify
>> +			 * if a page is free or not. Hence, we are dumping all
>> +			 * the per-cpu pages back into the buddy allocator. This
>> +			 * will ensure less failures when we try to isolate free
>> +			 * captured pages and hence more memory reporting to the
>> +			 * host.
>> +			 */
>> +			drain_local_pages(NULL);
>>  			scan_array();
>> +		}
>>  	}
>>  	local_irq_restore(flags);
>>  }
>> --=20
>> 2.17.2
--=20
Regards
Nitesh


--H1YmM4bITRO8YYteLwWF3AKmcldcFHyYM--

--YSWSFOx2DDx856NC2X7WcbyY1QRAlwaHR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxaBfwACgkQo4ZA3AYy
ozkdQBAAwprOkGZeGRYReekmRNLGKpZoOiU46WEC3W7D77bMIu240eRep+F43U+X
VtyC3+E4WBAvgysMo5HzqDeOQ0c+Cof/qGApJLSMwRr9DhupPs0LfV9XSVgur6Rp
wvw09ABAp9o7UQ5kFmmkMa5RrSxxhhNjB6UulzlArHlmN49IFvaFRVXU0v5jofsM
VlnFCNna4dQPUFpkrWMWZVTTooSuAbVdLbayPUxu4iJj2l4msrCVuLF1EVgcKsNA
sCPk5usUNhX/O94+6zV59yc5EB1yIGfc1l+jih7IvDUxbLqwiTIo0KySv0FEynQz
fPWsT/8KIZdJ2egqtxA6REgcrfu37B7KuvQLHxX6yaaVqZOgNu4NeN6aUqcI+0vW
tlUHws+HnElYMJCYUtMq5QFrKFGlvYj/qtYvDAw1Rpwn5ewFOk02D888GWgIYOPw
mnDc6WicvF+vu2WgpD/FfkBYBWWm0F4bAOm5/krKuj8UC5RzgXVpRO2yomlsDXdU
LEGFhNY6ajzUtPx0VNyX2ceAPpVEn/dfpF79fQx70M4V1uy5iJPiyXGp4cw+ePFF
RjzU9DxdkUBOVof9qVQqd0Iut5j+8LWt/pYS7s4N4OUuDzr1dsgigg1puJjHNAcw
NEL8lXSye/vrNhv4MwNURZ1QR7M1oIDRKTDGuf3SQ4OsskmIj8s=
=lmu6
-----END PGP SIGNATURE-----

--YSWSFOx2DDx856NC2X7WcbyY1QRAlwaHR--
