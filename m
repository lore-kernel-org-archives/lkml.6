Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A14C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07882175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392916AbfBMRXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbfBMRW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:22:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7723C8535C;
        Wed, 13 Feb 2019 17:22:56 +0000 (UTC)
Received: from [10.40.205.148] (unknown [10.40.205.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC65A5D970;
        Wed, 13 Feb 2019 17:22:07 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B52A@shsmsx102.ccr.corp.intel.com>
 <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
 <6198f4b9-47ad-2647-73de-da057541c45f@redhat.com>
 <20190213120733-mutt-send-email-mst@kernel.org>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <b7956e84-256f-2304-3a09-28fc47c1efb7@redhat.com>
Date:   Wed, 13 Feb 2019 12:22:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213120733-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yleLHDC34gwq1yzKQOtSqiaBrG2fnychI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 13 Feb 2019 17:22:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yleLHDC34gwq1yzKQOtSqiaBrG2fnychI
Content-Type: multipart/mixed; boundary="2Oq7CUemwFhNkeRgHVsCtcezSKrAOGMoJ";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "Wang, Wei W"
 <wei.w.wang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
 "pagupta@redhat.com" <pagupta@redhat.com>,
 "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
 "riel@surriel.com" <riel@surriel.com>, "dodgen@google.com"
 <dodgen@google.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dhildenb@redhat.com" <dhildenb@redhat.com>,
 "aarcange@redhat.com" <aarcange@redhat.com>
Message-ID: <b7956e84-256f-2304-3a09-28fc47c1efb7@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B52A@shsmsx102.ccr.corp.intel.com>
 <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
 <6198f4b9-47ad-2647-73de-da057541c45f@redhat.com>
 <20190213120733-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190213120733-mutt-send-email-mst@kernel.org>

--2Oq7CUemwFhNkeRgHVsCtcezSKrAOGMoJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/13/19 12:09 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 13, 2019 at 07:17:13AM -0500, Nitesh Narayan Lal wrote:
>> On 2/13/19 4:19 AM, David Hildenbrand wrote:
>>> On 13.02.19 09:55, Wang, Wei W wrote:
>>>> On Tuesday, February 12, 2019 5:24 PM, David Hildenbrand wrote:
>>>>> Global means all VCPUs will be competing potentially for a single l=
ock when
>>>>> freeing/allocating a page, no? What if you have 64VCPUs allocating/=
freeing
>>>>> memory like crazy?
>>>> I think the key point is that the 64 vcpus won't allocate/free on th=
e same page simultaneously, so no need to have a global big lock, isn=E2=80=
=99t it?
>>>> I think atomic operations on the bitmap would be enough.
>>> If you have to resize/alloc/coordinate who will report, you will need=

>>> locking. Especially, I doubt that there is an atomic xbitmap  (prove =
me
>>> wrong :) ).
>>>
>>>>> (I assume some kind of locking is required even if the bitmap would=
 be
>>>>> atomic. Also, doesn't xbitmap mean that we eventually have to alloc=
ate
>>>>> memory at places where we don't want to - e.g. from arch_free_page =
?)
>>>> arch_free_pages is in free_pages_prepare, why can't we have memory a=
llocation there?
>>> I remember we were stumbling over some issues that were non-trivial. =
I
>>> am not 100% sure yet anymore, but allocating memory while deep down i=
n
>>> the freeing part of MM core smells like "be careful".
>>>
>>>> It would also be doable to find a preferred place to preallocate som=
e amount of memory for the bitmap.
>>> That makes things very ugly. Especially, preallocation will most like=
ly
>>> require locking.
>>>
>>>>> That's the big benefit of taking the pages of the buddy free list. =
Other VCPUs
>>>>> won't stumble over them, waiting for them to get freed in the hyper=
visor.
>>>> As also mentioned above, I think other vcpus will not allocate/free =
on the same page that is in progress of being allocated/freed.
>>> If a page is in the buddy but stuck in some other bitmap, there is
>>> nothing stopping another VCPU from trying to allocate it. Nitesh has
>>> been fighting with this problem already :)
>>>
>>>>> This sounds more like "the host requests to get free pages once in =
a while"
>>>>> compared to "the host is always informed about free pages". At the =
time
>>>>> where the host actually has to ask the guest (e.g. because the host=
 is low on
>>>>> memory), it might be to late to wait for guest action.
>>>> Option 1: Host asks for free pages:
>>>> Not necessary to ask only when the host has been in memory pressure.=

>>>> This could be the orchestration layer's job to monitor the host memo=
ry usage.
>>>> For example, people could set the condition "when 50% of the host me=
mory
>>>> has been used, start to ask a guest for some amount of free pages"=20
>>>>
>>>> Option 2: Guest actively offers free pages:
>>>> Add a balloon callback to arch_free_page so that whenever a page get=
s freed its gfn
>>>> will be filled into the balloon's report_vq and the host will take a=
way the backing
>>>> host page.
>>>>
>>>> Both options can be implemented. But I think option 1 would be more
>>>> efficient as the guest free pages are offered on demand. =20
>>> Yes, but as I mentioned this has other drawbacks. Relying on a a gues=
t
>>> to free up memory when you really need it is not going to work. It mi=
ght
>>> work for some scenarios but should not dictate the design. It is a go=
od
>>> start though if it makes things easier.
>>>
>>> Enabling/disabling free page hintning by the hypervisor via some
>>> mechanism is on the other hand a good idea. "I have plenty of free
>>> space, don't worry".
>>>
>>>>> Nitesh uses MADV_FREE here (as far as I recall :) ), to only mark p=
ages as
>>>>> candidates for removal and if the host is low on memory, only scann=
ing the
>>>>> guest page tables is sufficient to free up memory.
>>>>>
>>>>> But both points might just be an implementation detail in the examp=
le you
>>>>> describe.
>>>> Yes, it is an implementation detail. I think DONTNEED would be easie=
r
>>>> for the first step.
>>>>
>>>>>> In above 2), get_free_page_hints clears the bits which indicates t=
hat those
>>>>> pages are not ready to be used by the guest yet. Why?
>>>>>> This is because 3) will unmap the underlying physical pages from E=
PT.
>>>>> Normally, when guest re-visits those pages, EPT violations and QEMU=
 page
>>>>> faults will get a new host page to set up the related EPT entry. If=
 guest uses
>>>>> that page before the page gets unmapped (i.e. right before step 3),=
 no EPT
>>>>> violation happens and the guest will use the same physical page tha=
t will be
>>>>> unmapped and given to other host threads. So we need to make sure t=
hat
>>>>> the guest free page is usable only after step 3 finishes.
>>>>>> Back to arch_alloc_page(), it needs to check if the allocated page=
s
>>>>>> have "1" set in the bitmap, if that's true, just clear the bits. O=
therwise, it
>>>>> means step 2) above has happened and step 4) hasn't been reached. I=
n this
>>>>> case, we can either have arch_alloc_page() busywaiting a bit till 4=
) is done
>>>>> for that page Or better to have a balloon callback which prioritize=
 3) and 4)
>>>>> to make this page usable by the guest.
>>>>>
>>>>> Regarding the latter, the VCPU allocating a page cannot do anything=
 if the
>>>>> page (along with other pages) is just being freed by the hypervisor=
=2E
>>>>> It has to busy-wait, no chance to prioritize.
>>>> I meant this:
>>>> With this approach, essentially the free pages have 2 states:
>>>> ready free page: the page is on the free list and it has "1" in the =
bitmap
>>>> non-ready free page: the page is on the free list and it has "0" in =
the bitmap
>>>> Ready free pages are those who can be allocated to use.
>>>> Non-ready free pages are those who are in progress of being reported=
 to
>>>> host and the related EPT mapping is about to be zapped.=20
>>>>
>>>> The non-ready pages are inserted into the report_vq and waiting for =
the
>>>> host to zap the mappings one by one. After the mapping gets zapped
>>>> (which means the backing host page has been taken away), host acks t=
o
>>>> the guest to mark the free page as ready free page (set the bit to 1=
 in the bitmap).
>>> Yes, that's how I understood your approach. The interesting part is
>>> where somebody finds a buddy page and wants to allocate it.
>>>
>>>> So the non-ready free page may happen to be used when they are waiti=
ng in
>>>> the report_vq to be handled by the host to zap the mapping, balloon =
could
>>>> have a fast path to notify the host:
>>>> "page 0x1000 is about to be used, don=E2=80=99t zap the mapping when=
 you get
>>>> 0x1000 from the report_vq"  /*option [1] */
>>> This requires coordination and in any case there will be a scenario
>>> where you have to wait for the hypervisor to eventually finish a madv=

>>> call. You can just try to make that scenario less likely.
>>>
>>> What you propose is synchronous in the worst case. Getting pages of t=
he
>>> buddy makes it possible to have it done completely asynchronous. Nobo=
dy
>>> allocating a page has to wait.
>>>
>>>> Or
>>>>
>>>> "page 0x1000 is about to be used, please zap the mapping NOW, i.e. d=
o 3) and 4) above,
>>>> so that the free page will be marked as ready free page and the gues=
t can use it".
>>>> This option will generate an extra EPT violation and QEMU page fault=
 to get a new host
>>>> page to back the guest ready free page.
>>> Again, coordination with the hypervisor while allocating a page. That=
 is
>>> to be avoided in any case.
>>>
>>>>>> Using bitmaps to record free page hints don't need to take the fre=
e pages
>>>>> off the buddy list and return them later, which needs to go through=
 the long
>>>>> allocation/free code path.
>>>>> Yes, but it means that any process is able to get stuck on such a p=
age for as
>>>>> long as it takes to report the free pages to the hypervisor and for=
 it to call
>>>>> madvise(pfn_start, DONTNEED) on any such page.
>>>> This only happens when the guest thread happens to get allocated on =
a page which is
>>>> being reported to the host. Using option [1] above will avoid this.
>>> I think getting pages out of the buddy system temporarily is the only=

>>> way we can avoid somebody else stumbling over a page currently gettin=
g
>>> reported by the hypervisor. Otherwise, as I said, there are scenarios=

>>> where a allocating VCPU has to wait for the hypervisor to finish the
>>> "freeing" task. While you can try to "speedup" that scenario -
>>> "hypervisor please prioritize" you cannot avoid it. There will be bus=
y
>>> waiting.
>>>
>>> I don't believe what you describe is going to work (especially the no=
t
>>> locking part when working with global resources).
>>>
>>> What would be interesting is to see if something like a xbitmap could=
 be
>>> used instead of the per-vcpu list.=20
>> Yeap, exactly.
>>> Nitesh, do you remember what the
>>> problem was with allocating memory from these hooks? Was it a locking=
 issue?
>> In the previous implementation, the issue was due to the locking. In t=
he
>> current implementation having an allocation under these hooks will
>> result in lots of isolation failures under memory pressure.
> But then we shouldn't be giving host memory when under pressure
> at all, should we?
In normal condition yes we would not like to report any memory when the
guest is already under memory pressure.

I am not sure about the scenario where both guest and the host are under
memory pressure, who will be given priority? Is it something per-decided
or it depends on the use case?

In any case, the current implementation will not give away memory back
to the host when the guest is under continuous memory pressure.

>
>> By the above statement, if you are referring to having a dynamic array=

>> to hold the freed pages.
>> Then, that is an idea Andrea also suggested to get around this fixed
>> array size issue.
>>> Thanks!
>>>
>>>> Best,
>>>> Wei
>>>>
>> --=20
>> Regards
>> Nitesh
>>
>
>
--=20
Regards
Nitesh


--2Oq7CUemwFhNkeRgHVsCtcezSKrAOGMoJ--

--yleLHDC34gwq1yzKQOtSqiaBrG2fnychI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxkUjsACgkQo4ZA3AYy
ozmlkw//RBMotpmLGhJVJZVEqhkgNd4YXYTRQaN4orXYALwiFmCm8tyaYUuk7XWO
lYVLdp6DewoEsVMOjMDKqftC/3UhhOSnId/F6Td1in2N2oIx4rkWCd2TGRgRV0e4
ueYvbrbu6/7CM4/6CbRtI4HH1RHt+VsiGa8mrH0Ddsctid76x6mV3aMYk+m+5LM4
p9HsKQDdmrURRzbw6Pn+5pNe+9ZD2wqLb6qFtnwy+Gfd2PQCMisXU5nBSC3H+e7g
33kvq2A7upFtILWl4n/XZKStctPhGVfTvTxMQbZ3mjxHmRm6Z7S1sdg7CncXm6B/
byGlXzTCu4dZG/BYx9MMwNooU3f9O8KajzkyEEF2DyBlhSDfP+Ck86V/8zXQo448
at1r1TblLjwPBzhcD4Gba/mmp2at0FZ7nlf8H8D0p/uWbhw+kVw3Q5lEZhjS/Ub6
2P7H3iG8eX8s0B3Lqie9r2aHcULKTwywZ43A+9bMd2nX4BRslkDDA50jt7d6q7E7
PC0mjvCuetr/JI+n2VWn+EIL7PSmIWkyn7cNV0ju1V/fXKyP7VFF8yj7YD2IYLIe
2xOliAN04zNxz2IaDYtIH8nED4+ZB1vWlC5WXD2/I99ts3t0MeNubvLYgcHTByDR
9WLIjgYB+L18x7PsDP+T5SFF5DLalGhvbgO5pnH6o3ktuQCgvlI=
=dOpe
-----END PGP SIGNATURE-----

--yleLHDC34gwq1yzKQOtSqiaBrG2fnychI--
