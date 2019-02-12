Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B81C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7459720700
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfBLRK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfBLRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8BDC6696E;
        Tue, 12 Feb 2019 17:10:55 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC3BF62667;
        Tue, 12 Feb 2019 17:10:53 +0000 (UTC)
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
References: <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
 <20190208163601-mutt-send-email-mst@kernel.org>
 <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
 <20190209192104-mutt-send-email-mst@kernel.org>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <941fc3c3-e38d-a744-5d4a-94a63c6ad62e@redhat.com>
Date:   Tue, 12 Feb 2019 12:10:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209192104-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7J8ManGoh82i3G7TWYecVQdqYvIjZDxYF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 12 Feb 2019 17:10:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7J8ManGoh82i3G7TWYecVQdqYvIjZDxYF
Content-Type: multipart/mixed; boundary="LGoU5OqJvrWR8z2fPxS0Q9CW28nUTKijU";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>,
 david@redhat.com, dodgen@google.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com,
 Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <941fc3c3-e38d-a744-5d4a-94a63c6ad62e@redhat.com>
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
References: <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
 <20190208163601-mutt-send-email-mst@kernel.org>
 <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
 <20190209192104-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190209192104-mutt-send-email-mst@kernel.org>

--LGoU5OqJvrWR8z2fPxS0Q9CW28nUTKijU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 2/9/19 7:38 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 08, 2019 at 02:05:09PM -0800, Alexander Duyck wrote:
>> On Fri, Feb 8, 2019 at 1:38 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
>>> On Fri, Feb 08, 2019 at 03:41:55PM -0500, Nitesh Narayan Lal wrote:
>>>>>> I am also planning to try Michael's suggestion of using MAX_ORDER =
- 1.
>>>>>> However I am still thinking about a workload which I can use to te=
st its
>>>>>> effectiveness.
>>>>> You might want to look at doing something like min(MAX_ORDER - 1,
>>>>> HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit f=
or
>>>>> THP which is the most likely to be used page size with the guest.
>>>> Sure, thanks for the suggestion.
>>> Given current hinting in balloon is MAX_ORDER I'd say
>>> share code. If you feel a need to adjust down the road,
>>> adjust both of them with actual testing showing gains.
>> Actually I'm left kind of wondering why we are even going through
>> virtio-balloon for this?
> Just look at what does it do.
>
> It improves memory overcommit if guests are cooperative, and it does
> this by giving the hypervisor addresses of pages which it can discard.
>
> It's just *exactly* like the balloon with all the same limitations.
>
>> It seems like this would make much more sense
>> as core functionality of KVM itself for the specific architectures
>> rather than some side thing.
> Well same as balloon: whether it's useful to you at all
> would very much depend on your workloads.
>
> This kind of cooperative functionality is good for co-located
> single-tenant VMs. That's pretty niche.  The core things in KVM
> generally don't trust guests.
>
>
>> In addition this could end up being
>> redundant when you start getting into either the s390 or PowerPC
>> architectures as they already have means of providing unused page
>> hints.
> Interesting. Is there host support in kvm?
>
>
>> I have a set of patches I proposed that add similar functionality via
>> a KVM hypercall for x86 instead of doing it as a part of a Virtio
>> device[1].  I'm suspecting the overhead of doing things this way is
>> much less then having to make multiple madvise system calls from QEMU
>> back into the kernel.
> Well whether it's a virtio device is orthogonal to whether it's an
> madvise call, right? You can build vhost-pagehint and that can
> handle requests in a VQ within balloon and do it
> within host kernel directly.
>
> virtio rings let you pass multiple pages so it's really hard to
> say which will win outright - maybe it's more important
> to coalesce exits.
>
> Nitesh, how about trying same tests and reporting performance?
Noted, I can give it a try before my next positing.
>
>
>> One other concern that has been pointed out with my patchset that
>> would likely need to be addressed here as well is what do we do about
>> other hypervisors that decide to implement page hinting. We probably
>> should look at making this KVM/QEMU specific code run through the
>> paravirtual infrastructure instead of trying into the x86 arch code
>> directly.
>>
>> [1] https://lkml.org/lkml/2019/2/4/903
>
> So virtio is a paravirtual interface, that's an argument for
> using it then.
>
> In any case pls copy the Cc'd crowd on future version of your patches.
>
--=20
Regards
Nitesh


--LGoU5OqJvrWR8z2fPxS0Q9CW28nUTKijU--

--7J8ManGoh82i3G7TWYecVQdqYvIjZDxYF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxi/hwACgkQo4ZA3AYy
ozm79g//UvTPI4aVhIteaZHs3qkezYTAZa/qjveQePvFwZwxnL2zPu28xPUOU0E1
rsobZJYN8xSLDqRdje2p3eJZHx03ChNT9cRO3XhMWRdHLqnBQ7gt0SJFPd+qWEf+
YpLUjlWVC4kepIeEKlaPvFlGQ8sXDdc9OX6aTrIccmXsD2F7wOYVldlAT5qoZ+K9
lzKugk3gAesdlTJSAoGy2aaQ3MEAFCpqGgDpmHIOU2za9AAPLL3PUBpwC5PVtPtb
wgMc5yYebCWxDTICWupYjcw+yceNkF0Es829r5ivPwk1DKEMrPK98piv9+8jjvWj
XgflFyfrHiU1tUpdhLkmLk+bZIkhxigHwAUBNY6Kdh6OAN11kgBQgsDh0FSDbXcC
l/EMrv2Pnktw9VfcsoABO43Y42FHZN8qLkKmq+re4YwkHy2QgVilBR2uNbSzDNrM
J1xig2TTMs652QED4DLa/+7r71ceoP9WImtWuH8OGSkZan2ybInOC07fR2/QL7+m
9NUss4eSes3u95470h5jUh9D1yVrwwT6Vz8+t91XHZc7K6AfGEezo653A6ekH6pl
ZvHa0WJ0ZBNkZnEFH/G68Yegm3/ZO9Wph6v+O9lWKjTD1uNL3GFZU/1+Je6XtMHJ
3PXiummtTXTgPpZdO7VOCFhLJGeTug7T9GTVSCf6wYhaMaquEqE=
=E0SH
-----END PGP SIGNATURE-----

--7J8ManGoh82i3G7TWYecVQdqYvIjZDxYF--
