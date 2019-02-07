Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29EEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD562083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31613 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:56:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E92377F6BB;
        Thu,  7 Feb 2019 17:56:39 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47A1A6155B;
        Thu,  7 Feb 2019 17:56:38 +0000 (UTC)
Subject: Re: [RFC][Patch v8 4/7] KVM: Disabling page poisoning to prevent
 corruption
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-5-nitesh@redhat.com>
 <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <97de9a69-fb19-3e9e-d88d-b5b8219b0d9f@redhat.com>
Date:   Thu, 7 Feb 2019 12:56:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j6E1ImAeesDDqkyjqyFiwxKCfhIsh3Ow0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 17:56:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j6E1ImAeesDDqkyjqyFiwxKCfhIsh3Ow0
Content-Type: multipart/mixed; boundary="BTHtnbsw0M4wX6IA1ZtPswxBSUT5LLRAY";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com,
 Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <97de9a69-fb19-3e9e-d88d-b5b8219b0d9f@redhat.com>
Subject: Re: [RFC][Patch v8 4/7] KVM: Disabling page poisoning to prevent
 corruption
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-5-nitesh@redhat.com>
 <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com>
In-Reply-To: <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com>

--BTHtnbsw0M4wX6IA1ZtPswxBSUT5LLRAY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/7/19 12:23 PM, Alexander Duyck wrote:
> On Mon, Feb 4, 2019 at 2:11 PM Nitesh Narayan Lal <nitesh@redhat.com> w=
rote:
>> This patch disables page poisoning if guest page hinting is enabled.
>> It is required to avoid possible guest memory corruption errors.
>> Page Poisoning is a feature in which the page is filled with a specifi=
c
>> pattern of (0x00 or 0xaa) after arch_free_page and the same is verifie=
d
>> before arch_alloc_page to prevent following issues:
>>     *information leak from the freed data
>>     *use after free bugs
>>     *memory corruption
>> Selection of the pattern depends on the CONFIG_PAGE_POISONING_ZERO
>> Once the guest pages which are supposed to be freed are sent to the
>> hypervisor it frees them. After freeing the pages in the global list
>> following things may happen:
>>     *Hypervisor reallocates the freed memory back to the guest
>>     *Hypervisor frees the memory and maps a different physical memory
>> In order to prevent any information leak hypervisor before allocating
>> memory to the guest fills it with zeroes.
>> The issue arises when the pattern used for Page Poisoning is 0xaa whil=
e
>> the newly allocated page received from the hypervisor by the guest is
>> filled with the pattern 0x00. This will result in memory corruption er=
rors.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> This seems kind of backwards to me. Why disable page poisoning instead
> of just not hinting about the free pages? There shouldn't be that many
> instances when page poisoning is enabled, and when it is it would make
> more sense to leave it enabled rather than silently disable it.
As I have mentioned in the cover email, I intend to reuse Wei's already
merged work.

This will enable the guest to communicate the poison value which is in
use to the host.

>
>> ---
>>  include/linux/page_hinting.h | 8 ++++++++
>>  mm/page_poison.c             | 2 +-
>>  virt/kvm/page_hinting.c      | 1 +
>>  3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting=
=2Eh
>> index 2d7ff59f3f6a..e800c6b07561 100644
>> --- a/include/linux/page_hinting.h
>> +++ b/include/linux/page_hinting.h
>> @@ -19,7 +19,15 @@ struct hypervisor_pages {
>>  extern int guest_page_hinting_flag;
>>  extern struct static_key_false guest_page_hinting_key;
>>  extern struct smp_hotplug_thread hinting_threads;
>> +extern bool want_page_poisoning;
>>
>>  int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>>                               void __user *buffer, size_t *lenp, loff_=
t *ppos);
>>  void guest_free_page(struct page *page, int order);
>> +
>> +static inline void disable_page_poisoning(void)
>> +{
>> +#ifdef CONFIG_PAGE_POISONING
>> +       want_page_poisoning =3D 0;
>> +#endif
>> +}
>> diff --git a/mm/page_poison.c b/mm/page_poison.c
>> index f0c15e9017c0..9af96021133b 100644
>> --- a/mm/page_poison.c
>> +++ b/mm/page_poison.c
>> @@ -7,7 +7,7 @@
>>  #include <linux/poison.h>
>>  #include <linux/ratelimit.h>
>>
>> -static bool want_page_poisoning __read_mostly;
>> +bool want_page_poisoning __read_mostly;
>>
>>  static int __init early_page_poison_param(char *buf)
>>  {
>> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
>> index 636990e7fbb3..be529f6f2bc0 100644
>> --- a/virt/kvm/page_hinting.c
>> +++ b/virt/kvm/page_hinting.c
>> @@ -103,6 +103,7 @@ void guest_free_page(struct page *page, int order)=

>>
>>         local_irq_save(flags);
>>         if (page_hinting_obj->kvm_pt_idx !=3D MAX_FGPT_ENTRIES) {
>> +               disable_page_poisoning();
>>                 page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx]=
=2Epfn =3D
>>                                                         page_to_pfn(pa=
ge);
>>                 page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx]=
=2Ezonenum =3D
> At a minimum it seems like you should have some sort of warning
> message that you are disabling page poisoning rather than just
> silently turning it off.
--=20
Regards
Nitesh


--BTHtnbsw0M4wX6IA1ZtPswxBSUT5LLRAY--

--j6E1ImAeesDDqkyjqyFiwxKCfhIsh3Ow0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxccVUACgkQo4ZA3AYy
ozluYRAAmHbZnwo/QtacGqYjvvgfUv2DVV0Zj8HE+JXQUmDZuwQWccAFaJVZMFK9
bcAolUit6YbgH/Kg3tMogrr0qS2HTg/cr77jSsZH/3ceYn4ZFsqJdHaIKsap/vb0
Rj+gVtFAZQ7CXJ+15sUF0eTjJvdbad7WBqtdro8FIS0sf7HmG7K1oGJ3npVI80Ef
P8WqgJXmXflX7JSeUHACTzrYyaRylT6ftlJJ+d9GcoLeFVYGF6Dq7+diP2mE6VD+
/kR7kn4oBwTyFMbGdIUcJHfJAs3vnbnC0lbcW50N72Nd4uVkuNH6hVEFuXv+K6u8
v66Q5M3eAmh6kmgK4H7LcyX7jXVotiCPoJsdW1TCc+5G5XV7ic5S8QGcyIZaIBM2
r4Rq9jeGerRnkwuuZ6Tw20lnbdAzKX0EUf8KODAx/EBW7j4TK/ew1y+Xb3H6VPeG
8pJ0v+dIZXrsRmUVwzdW5bHdlWdf+SKEAnVjUyLS6VHahDT4pMhlvbG68yxlxjZo
R0tfW5kXjV0+TNjRehvpD4tFfki1fDg0lnhJI97Wf6Cbct0D7111V5j26SzQHM5D
Et6DPcmF3XK0+DQvof807rv6dNEP7AMTvFOlfO+tEnz3OvNdOtrlS3aq0adn0EED
6MtjUn5VJhU6z7ZGQvcItbw7FVFBKPvC86azruo7+5+J2+NkZp0=
=CVGR
-----END PGP SIGNATURE-----

--j6E1ImAeesDDqkyjqyFiwxKCfhIsh3Ow0--
