Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B88C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C12146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfBGUuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:50:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGUuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:50:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9DB12D7FD;
        Thu,  7 Feb 2019 20:50:18 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6F79101962A;
        Thu,  7 Feb 2019 20:50:05 +0000 (UTC)
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
Date:   Thu, 7 Feb 2019 15:50:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ap5ABYvzzX70JdDbWmp50N1oSp8VGQhFh"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Feb 2019 20:50:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ap5ABYvzzX70JdDbWmp50N1oSp8VGQhFh
Content-Type: multipart/mixed; boundary="AeVANRcNT1h5gVoi0tgysK58tOu3mh1zQ";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com, david@redhat.com,
 dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
In-Reply-To: <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>

--AeVANRcNT1h5gVoi0tgysK58tOu3mh1zQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/7/19 12:43 PM, Alexander Duyck wrote:
> On Tue, Feb 5, 2019 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>> On Tue, Feb 05, 2019 at 04:54:03PM -0500, Nitesh Narayan Lal wrote:
>>> On 2/5/19 3:45 PM, Michael S. Tsirkin wrote:
>>>> On Mon, Feb 04, 2019 at 03:18:53PM -0500, Nitesh Narayan Lal wrote:
>>>>> This patch enables the kernel to scan the per cpu array and
>>>>> compress it by removing the repetitive/re-allocated pages.
>>>>> Once the per cpu array is completely filled with pages in the
>>>>> buddy it wakes up the kernel per cpu thread which re-scans the
>>>>> entire per cpu array by acquiring a zone lock corresponding to
>>>>> the page which is being scanned. If the page is still free and
>>>>> present in the buddy it tries to isolate the page and adds it
>>>>> to another per cpu array.
>>>>>
>>>>> Once this scanning process is complete and if there are any
>>>>> isolated pages added to the new per cpu array kernel thread
>>>>> invokes hyperlist_ready().
>>>>>
>>>>> In hyperlist_ready() a hypercall is made to report these pages to
>>>>> the host using the virtio-balloon framework. In order to do so
>>>>> another virtqueue 'hinting_vq' is added to the balloon framework.
>>>>> As the host frees all the reported pages, the kernel thread returns=

>>>>> them back to the buddy.
>>>>>
>>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>>> This looks kind of like what early iterations of Wei's patches did.
>>>>
>>>> But this has lots of issues, for example you might end up with
>>>> a hypercall per a 4K page.
>>>> So in the end, he switched over to just reporting only
>>>> MAX_ORDER - 1 pages.
>>> You mean that I should only capture/attempt to isolate pages with ord=
er
>>> MAX_ORDER - 1?
>>>> Would that be a good idea for you too?
>>> Will it help if we have a threshold value based on the amount of memo=
ry
>>> captured instead of the number of entries/pages in the array?
>> This is what Wei's patches do at least.
> So in the solution I had posted I was looking more at
> HUGETLB_PAGE_ORDER and above as the size of pages to provide the hints
> on [1]. The advantage to doing that is that you can also avoid
> fragmenting huge pages which in turn can cause what looks like a
> memory leak as the memory subsystem attempts to reassemble huge
> pages[2]. In my mind a 2MB page makes good sense in terms of the size
> of things to be performing hints on as anything smaller than that is
> going to just end up being a bunch of extra work and end up causing a
> bunch of fragmentation.
As per my opinion, in any implementation which page size to store before
reporting depends on the allocation pattern of the workload running in
the guest.

I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
However I am still thinking about a workload which I can use to test its
effectiveness.

>
> The only issue with limiting things on an arbitrary boundary like that
> is that you have to hook into the buddy allocator to catch the cases
> where a page has been merged up into that range.
I don't think, I understood your comment completely. In any case, we
have to rely on the buddy for merging the pages.
>
> [1] https://lkml.org/lkml/2019/2/4/903
> [2] https://blog.digitalocean.com/transparent-huge-pages-and-alternativ=
e-memory-allocators/
--=20
Regards
Nitesh


--AeVANRcNT1h5gVoi0tgysK58tOu3mh1zQ--

--Ap5ABYvzzX70JdDbWmp50N1oSp8VGQhFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxcmfwACgkQo4ZA3AYy
ozmcbxAA0bPiT1tMZ/E+yhmf2apUR9i5EzEkX8qohBUtF0FAvapWxBmvNkDM6AA/
3ahI8QoemLxuw3J1CpzKb9pdL1b9j45KrHVu9YaV0OPQi76chdMhs3CYi7duTEoF
rK/bc+2vpcLX/8Eh04WyE2YrSJaB6RAOmMGMGM3229bO8aiBB3rFjs+Gv3WXrZ5Y
mTQe4yimTLAONiRhvlK7KMKb1SYIlePRtWoY0GyVu0VFIdy9MbyU+rcG1lt5LrIq
0v1sjG6RFpLuBUTAcKwYMzw0zLBPNwcV/5KGokoboTmxHO4m7BmtFSZZ93gQ/Isk
jn2xZf2u6P4XzqVUEwdCj0614z2jI6yOFgkhug/iRtBIOVnKN/ayh/gJp4XcQ9z+
LLHmKr04fvGe0KUyS5S1I0SNIMtyn+mnHhG4vaigmvNKPl4jQCgUz0cxXduFeVkW
j2vsn/lszQStsB8wWo2IQGEk7asPRx4FteBoMTEZJ+6Yu4ynC16DB7pFEt+/KM2P
8dZDRozNVTPxz3FAIvPGyp2DXH7EJ4ux6iYxVhrYDDstQn5PrIK2ocZ2fZ/JnRuU
6LbLJY+RAjtm2FLkRRlExDmdsSGW6yQXL1u1rchc3KrS3jcjM0udPFxWnsfO0w5J
qFMBDrBob1A7GO0HoilRz10dB85yyNe9KH3FMrwvYvPjU2kdx8Q=
=dj7S
-----END PGP SIGNATURE-----

--Ap5ABYvzzX70JdDbWmp50N1oSp8VGQhFh--
