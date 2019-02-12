Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE5C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A70222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfBLRYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:24:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbfBLRYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:24:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B01B36887;
        Tue, 12 Feb 2019 17:24:40 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 252A19CDB;
        Tue, 12 Feb 2019 17:24:31 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <deb20a92-82bf-5d76-8a2b-447d9f2df36c@redhat.com>
Date:   Tue, 12 Feb 2019 12:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yNsgkFZEwKifI0Z0GXIZgIb7VVvotZdgH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 12 Feb 2019 17:24:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yNsgkFZEwKifI0Z0GXIZgIb7VVvotZdgH
Content-Type: multipart/mixed; boundary="haeWvAvM7vUbnEC8EgNr9JkZoC03Sn36N";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: David Hildenbrand <david@redhat.com>, "Wang, Wei W"
 <wei.w.wang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
 "pagupta@redhat.com" <pagupta@redhat.com>,
 "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
 "riel@surriel.com" <riel@surriel.com>, "mst@redhat.com" <mst@redhat.com>,
 "dodgen@google.com" <dodgen@google.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dhildenb@redhat.com" <dhildenb@redhat.com>,
 "aarcange@redhat.com" <aarcange@redhat.com>
Message-ID: <deb20a92-82bf-5d76-8a2b-447d9f2df36c@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
In-Reply-To: <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>

--haeWvAvM7vUbnEC8EgNr9JkZoC03Sn36N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/12/19 4:24 AM, David Hildenbrand wrote:
> On 12.02.19 10:03, Wang, Wei W wrote:
>> On Tuesday, February 5, 2019 4:19 AM, Nitesh Narayan Lal wrote:
>>> The following patch-set proposes an efficient mechanism for handing f=
reed
>>> memory between the guest and the host. It enables the guests with no =
page
>>> cache to rapidly free and reclaims memory to and from the host respec=
tively.
>>>
>>> Benefit:
>>> With this patch-series, in our test-case, executed on a single system=
 and
>>> single NUMA node with 15GB memory, we were able to successfully launc=
h
>>> atleast 5 guests when page hinting was enabled and 3 without it. (Det=
ailed
>>> explanation of the test procedure is provided at the bottom).
>>>
>>> Changelog in V8:
>>> In this patch-series, the earlier approach [1] which was used to capt=
ure and
>>> scan the pages freed by the guest has been changed. The new approach =
is
>>> briefly described below:
>>>
>>> The patch-set still leverages the existing arch_free_page() to add th=
is
>>> functionality. It maintains a per CPU array which is used to store th=
e pages
>>> freed by the guest. The maximum number of entries which it can hold i=
s
>>> defined by MAX_FGPT_ENTRIES(1000). When the array is completely fille=
d, it
>>> is scanned and only the pages which are available in the buddy are st=
ored.
>>> This process continues until the array is filled with pages which are=
 part of
>>> the buddy free list. After which it wakes up a kernel per-cpu-thread.=

>>> This kernel per-cpu-thread rescans the per-cpu-array for any re-alloc=
ation
>>> and if the page is not reallocated and present in the buddy, the kern=
el
>>> thread attempts to isolate it from the buddy. If it is successfully i=
solated, the
>>> page is added to another per-cpu array. Once the entire scanning proc=
ess is
>>> complete, all the isolated pages are reported to the host through an =
existing
>>> virtio-balloon driver.
>>  Hi Nitesh,
>>
>> Have you guys thought about something like below, which would be simpl=
er:
> Responding because I'm the first to stumble over this mail, hah! :)
>
>> - use bitmaps to record free pages, e.g. xbitmap: https://lkml.org/lkm=
l/2018/1/9/304.
>>   The bitmap can be indexed by the guest pfn, and it's globally access=
ed by all the CPUs;
> Global means all VCPUs will be competing potentially for a single lock
> when freeing/allocating a page, no? What if you have 64VCPUs
> allocating/freeing memory like crazy?
>
> (I assume some kind of locking is required even if the bitmap would be
> atomic. Also, doesn't xbitmap mean that we eventually have to allocate
> memory at places where we don't want to - e.g. from arch_free_page ?)
>
> That's the big benefit of taking the pages of the buddy free list. Othe=
r
> VCPUs won't stumble over them, waiting for them to get freed in the
> hypervisor.
>
>> - arch_free_page(): set the bits of the freed pages from the bitmap
>>  (no per-CPU array with hardcoded fixed length and no per-cpu scanning=
 thread)
>> - arch_alloc_page(): clear the related bits from the bitmap
>> - expose 2 APIs for the callers:
>>   -- unsigned long get_free_page_hints(unsigned long pfn_start, unsign=
ed int nr);=20
>>      This API searches for the next free page chunk (@nr of pages), st=
arting from @pfn_start.
>>      Bits of those free pages will be cleared after this function retu=
rns.
>>   -- void put_free_page_hints(unsigned long pfn_start, unsigned int nr=
);
>>      This API sets the @nr continuous bits starting from pfn_start.
>>
>> Usage example with balloon:
>> 1) host requests to start ballooning;
>> 2) balloon driver get_free_page_hints and report the hints to host via=
 report_vq;
>> 3) host calls madvise(pfn_start, DONTNEED) for each reported chunk of =
free pages and put back pfn_start to ack_vq;
>> 4) balloon driver receives pfn_start and calls put_free_page_hints(pfn=
_start) to have the related bits from the bitmap to be set, indicating th=
at those free pages are ready to be allocated.
> This sounds more like "the host requests to get free pages once in a
> while" compared to "the host is always informed about free pages". At
> the time where the host actually has to ask the guest (e.g. because the=

> host is low on memory), it might be to late to wait for guest action.
> Nitesh uses MADV_FREE here (as far as I recall :) ), to only mark pages=

> as candidates for removal and if the host is low on memory, only
> scanning the guest page tables is sufficient to free up memory.
>
> But both points might just be an implementation detail in the example
> you describe.
>
>> In above 2), get_free_page_hints clears the bits which indicates that =
those pages are not ready to be used by the guest yet. Why?
>> This is because 3) will unmap the underlying physical pages from EPT. =
Normally, when guest re-visits those pages, EPT violations and QEMU page =
faults will get a new host page to set up the related EPT entry. If guest=
 uses that page before the page gets unmapped (i.e. right before step 3),=
 no EPT violation happens and the guest will use the same physical page t=
hat will be unmapped and given to other host threads. So we need to make =
sure that the guest free page is usable only after step 3 finishes.
>>
>> Back to arch_alloc_page(), it needs to check if the allocated pages ha=
ve "1" set in the bitmap, if that's true, just clear the bits. Otherwise,=
 it means step 2) above has happened and step 4) hasn't been reached. In =
this case, we can either have arch_alloc_page() busywaiting a bit till 4)=
 is done for that page
>> Or better to have a balloon callback which prioritize 3) and 4) to mak=
e this page usable by the guest.
> Regarding the latter, the VCPU allocating a page cannot do anything if
> the page (along with other pages) is just being freed by the hypervisor=
=2E
> It has to busy-wait, no chance to prioritize.
>
>> Using bitmaps to record free page hints don't need to take the free pa=
ges off the buddy list and return them later, which needs to go through t=
he long allocation/free code path.
>>
> Yes, but it means that any process is able to get stuck on such a page
> for as long as it takes to report the free pages to the hypervisor and
> for it to call madvise(pfn_start, DONTNEED) on any such page.
>
> Nice idea, but I think we definitely need something the can potentially=

> be implemented per-cpu without any global locks involved.
>
> Thanks!
>
>> Best,
>> Wei
>>
Hi Wei,

For your comment, I agree with David. If we have one global per-cpu, we
will have to acquire a lock.
Also as David mentioned the idea is to derive the hints from the guest,
rather than host asking for free pages.

However, I am wondering if having per-cpu bitmaps is possible?
Using this I can possibly get rid of the fixed array size issue.

--=20
Regards
Nitesh


--haeWvAvM7vUbnEC8EgNr9JkZoC03Sn36N--

--yNsgkFZEwKifI0Z0GXIZgIb7VVvotZdgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxjAU4ACgkQo4ZA3AYy
ozmYxA/+KEd6b+8QmF5vsn8gZZN0sGR63uNYm7B/UXPo8nD/wSM30YXm7CsaHPDp
tcSfI7SJ4NPc0fpv8wDidXVKUWbaLQ8J5lvtXi98DA0oOmyhJkipIEcvR5yq2S4x
FQSgpWxa/WDj+Lu5ocu4BLgQStfAS6ilw8Jbfm8pNavhtcJN4umpo6iAlVXBJUsb
bXY1jwdw1ShAJxG+JLtEHuPClFzY/WcuMOIuY5J5YxhPqI50nP9Q4QJ6S3FC0roq
+2lBGdCy5NA/7jPHejf8CFthyTv97q7vu9dU66jHNI8KTTYwe+FEiwqUiicBfaQQ
NE6t5ACkYT5gRQNMqLBhk4yhYRkvCDZgdukoTmjqa6Vf0Y7WAbVG9ZXT5vte40ou
E/jy+ETMVyOUikEmfq1jQwDqNc+LrwSJiWg+//t8OrjgFWZJ/iG7rczZzscoei41
jnGWKM30BEE1XvyGmTtO0L/XN8BzK7jyxP+hizqPK9I8qqKfd/LpqKoloxt4oU+u
QnYC4C+zJCbcPmyVw/4kwnyvKIoFXP1DzZYeW0Yn2wbLPAkfLUg2WpwqbbN+rGNS
Fs/ieT0WL+vg7VRMfLIZZXdQwapErrMRawpxcQUhHhPE0rb2PDUPKivBkFg+IOtB
rLIFvfjOqAiBLtMAR8QszWnTPU6EhnBU4vxCeblerGUcVRHyUQg=
=FAWY
-----END PGP SIGNATURE-----

--yNsgkFZEwKifI0Z0GXIZgIb7VVvotZdgH--
