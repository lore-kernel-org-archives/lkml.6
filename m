Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1519C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E45820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfBRPu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:50:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfBRPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:50:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82E47315D44;
        Mon, 18 Feb 2019 15:50:27 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF7F5C1B2;
        Mon, 18 Feb 2019 15:50:25 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, mst@redhat.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <cb7888fc-52c9-8735-61e4-870e7e3c0e5f@redhat.com>
Date:   Mon, 18 Feb 2019 10:50:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mdyfYfDmjN5MPMwf7kRhxeoJJoZlN6TOI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 18 Feb 2019 15:50:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mdyfYfDmjN5MPMwf7kRhxeoJJoZlN6TOI
Content-Type: multipart/mixed; boundary="cW9cKcy4XGSw0A67mbAvusrJdUVpT6K3Y";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
 riel@surriel.com, mst@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
 dhildenb@redhat.com, aarcange@redhat.com,
 Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <cb7888fc-52c9-8735-61e4-870e7e3c0e5f@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
In-Reply-To: <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>

--cW9cKcy4XGSw0A67mbAvusrJdUVpT6K3Y
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/16/19 4:40 AM, David Hildenbrand wrote:
> On 04.02.19 21:18, Nitesh Narayan Lal wrote:
>
> Hi Nitesh,
>
> I thought again about how s390x handles free page hinting. As that seem=
s
> to work just fine, I guess sticking to a similar model makes sense.
>
>
> I already explained in this thread how it works on s390x, a short summa=
ry:
>
> 1. Each VCPU has a buffer of pfns to be reported to the hypervisor. If =
I
> am not wrong, it contains 512 entries, so is exactly 1 page big. This
> buffer is stored in the hypervisor and is on page granularity.
>
> 2. This page buffer is managed via the ESSA instruction. In addition, t=
o
> synchronize with the guest ("page reused when freeing in the
> hypervisor"), special bits in the host->guest page table can be
> set/locked via the ESSA instruction by the guest and similarly accessed=

> by the hypervisor.
>
> 3. Once the buffer is full, the guest does a synchronous hypercall,
> going over all 512 entries and zapping them (=3D=3D similar to MADV_DON=
TNEED)
>
>
> To mimic that, we
>
> 1. Have a static buffer per VCPU in the guest with 512 entries. You
> basically have that already.
>
> 2. On every free, add the page _or_ the page after merging by the buddy=

> (e.g. MAX_ORDER - 1) to the buffer (this is where we could be better
> than s390x). You basically have that already.
>
> 3. If the buffer is full, try to isolate all pages and do a synchronous=

> report to the hypervisor. You have the first part already. The second
> part would require a change (don't use a separate/global thread to do
> the hinting, just do it synchronously).
>
> 4. One hinting is done, putback all isolated pages to the budy. You
> basically have that already.
>
>
> For 3. we can try what you have right now, using virtio. If we detect
> that's a problem, we can do it similar to what Alexander proposes and
> just do a bare hypercall. It's just a different way of carrying out the=

> same task.
>
>
> This approach
> 1. Mimics what s390x does, besides supporting different granularities.
> To synchronize guest->host we simply take the pages off the buddy.
>
> 2. Is basically what Alexander does, however his design limitation is
> that doing any hinting on smaller granularities will not work because
> there will be too many synchronous hints. Bad on fragmented guests.
>
> 3. Does not require any dynamic data structures in the guest.
>
> 4. Does not block allocation paths.
>
> 5. Blocks on e.g. every 512'ed free. It seems to work on s390x, why
> shouldn't it for us. We have to measure.
>
> 6. We are free to decide which granularity we report.
>
> 7. Potentially works even if the guest memory is fragmented (little
> MAX_ORDER - 1) pages.
>
> It would be worth a try. My feeling is that a synchronous report after
> e.g. 512 frees should be acceptable, as it seems to be acceptable on
> s390x. (basically always enabled, nobody complains).

The reason I like the current approach of reporting via separate kernel
thread is that it doesn't block any regular allocation/freeing code path
in anyways.
>
> We would have to play with how to enable/disable reporting and when to
> not report because it's not worth it in the guest (e.g. low on memory).=

>
>
> Do you think something like this would be easy to change/implement and
> measure?

I can do that as I figure out a real world guest workload using which
the two approaches can be compared.

> Thanks!
>
>> The following patch-set proposes an efficient mechanism for handing fr=
eed memory between the guest and the host. It enables the guests with no =
page cache to rapidly free and reclaims memory to and from the host respe=
ctively.
>>
>> Benefit:
>> With this patch-series, in our test-case, executed on a single system =
and single NUMA node with 15GB memory, we were able to successfully launc=
h atleast 5 guests=20
>> when page hinting was enabled and 3 without it. (Detailed explanation =
of the test procedure is provided at the bottom).
>>
>> Changelog in V8:
>> In this patch-series, the earlier approach [1] which was used to captu=
re and scan the pages freed by the guest has been changed. The new approa=
ch is briefly described below:
>>
>> The patch-set still leverages the existing arch_free_page() to add thi=
s functionality. It maintains a per CPU array which is used to store the =
pages freed by the guest. The maximum number of entries which it can hold=
 is defined by MAX_FGPT_ENTRIES(1000). When the array is completely fille=
d, it is scanned and only the pages which are available in the buddy are =
stored. This process continues until the array is filled with pages which=
 are part of the buddy free list. After which it wakes up a kernel per-cp=
u-thread.
>> This kernel per-cpu-thread rescans the per-cpu-array for any re-alloca=
tion and if the page is not reallocated and present in the buddy, the ker=
nel thread attempts to isolate it from the buddy. If it is successfully i=
solated, the page is added to another per-cpu array. Once the entire scan=
ning process is complete, all the isolated pages are reported to the host=
 through an existing virtio-balloon driver.
>>
>> Known Issues:
>> 	* Fixed array size: The problem with having a fixed/hardcoded array s=
ize arises when the size of the guest varies. For example when the guest =
size increases and it starts making large allocations fixed size limits t=
his solution's ability to capture all the freed pages. This will result i=
n less guest free memory getting reported to the host.
>>
>> Known code re-work:
>> 	* Plan to re-use Wei's work, which communicates the poison value to t=
he host.
>> 	* The nomenclatures used in virtio-balloon needs to be changed so tha=
t the code can easily be distinguished from Wei's Free Page Hint code.
>> 	* Sorting based on zonenum, to avoid repetitive zone locks for the sa=
me zone.
>>
>> Other required work:
>> 	* Run other benchmarks to evaluate the performance/impact of this app=
roach.
>>
>> Test case:
>> Setup:
>> Memory-15837 MB
>> Guest Memory Size-5 GB
>> Swap-Disabled
>> Test Program-Simple program which allocates 4GB memory via malloc, tou=
ches it via memset and exits.
>> Use case-Number of guests that can be launched completely including th=
e successful execution of the test program.
>> Procedure:=20
>> The first guest is launched and once its console is up, the test alloc=
ation program is executed with 4 GB memory request (Due to this the guest=
 occupies almost 4-5 GB of memory in the host in a system without page hi=
nting). Once this program exits at that time another guest is launched in=
 the host and the same process is followed. We continue launching the gue=
sts until a guest gets killed due to low memory condition in the host.
>>
>> Result:
>> Without Hinting-3 Guests
>> With Hinting-5 to 7 Guests(Based on the amount of memory freed/capture=
d).
>>
>> [1] https://www.spinics.net/lists/kvm/msg170113.html=20
>>
>>
>
--=20
Regards
Nitesh


--cW9cKcy4XGSw0A67mbAvusrJdUVpT6K3Y--

--mdyfYfDmjN5MPMwf7kRhxeoJJoZlN6TOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxq1EAACgkQo4ZA3AYy
oznNBg/9FBQq6/Y7BO+Pr9oEa3tWOX/G/VUwS5uvPHVbLYC/M6vyp+3lc3HoGGZP
Ecez6jDTUS2iwOkp2etWgYPKqfp93+UtSbGGCCEms2UI1SteTTozPSkSHOf4SAPa
+2z6XB6s0vmuCEvQoxy7LPN/vgKd7aCgDHR/GN/iueuYZzUdrHPjMGVPBmtyCh7i
sZx9b9lFW70tDH+Tyxez2LA7do/fYmDpzc3mVIENZ9si+mRVJsxwVIWlPPOga2wI
WxF2oOqiTEQixHxPKxgc97qYAR1pdspLeFWyMxY+wdWA03vVpeYFj9XJs15Mv72/
cP4OPSdFAM/XZ++4ioAFutLMuuehZYtP/8IcO4u5TLzwlsOeftnDhxbt6vjChgrd
QAoD58TpcfoMnarhdcPQmX9tRRjHKRS5IPksHufpvd8CQGIAPrPLwW1Zs2Mx9VRC
3UeRJrvD5yJmoYjJND5bkchJoJShSPeCdG1WCcM7PH+Jrtkg1w3iSVkl2T3tGVuA
XdjRuvzDazrvDiYFjgnfzatM86V/yZhY7qdM5E9U0l1IrscX1i+eyBZJUZG1DNie
VV1vdIlHQefW2hBVXGhOIHZO/APs7BrW9BVi9lPZpAGmztG1eJpbI//dsGEKK2aO
qxiB/3IQCRhdxYHXoWVsrrlcmrKgFeF/k039hC6U/E56/5EuZ9k=
=FxZ6
-----END PGP SIGNATURE-----

--mdyfYfDmjN5MPMwf7kRhxeoJJoZlN6TOI--
