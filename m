Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03B32075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VdbLFIEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfBVXbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:31:20 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19850 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:31:19 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c70864c0001>; Fri, 22 Feb 2019 15:31:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 15:31:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 22 Feb 2019 15:31:18 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 23:31:18 +0000
Subject: Re: [PATCH 00/10] HMM updates for 5.1
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <faf031d5-0aa0-e19e-0431-d5b0d0c5308d@nvidia.com>
Date:   Fri, 22 Feb 2019 15:31:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190129165428.3931-1-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550878284; bh=/oVuyOXOUrFyvdi2hXsVsKEk67GOJZtcuD65mETThWg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VdbLFIEGxXM1y5pTAMmuejyoxMGnLk2dVyUnfywBv2Q9XDhaZ+lJAwVhTL2n2MgfJ
         bbXeSUeJp1KaYb4Lj8eFf18hPAQ24sV/hqS+w4A6aDc3p+A8ele4J8cnycj8DemIUH
         5WM7DlI6cIApBRsBj90OoYGv5uYE32Hd4S/GAbuZuvOvGat4RTc92niR1G5fXuBlhR
         htpuqmpw7qvyFeYRLQ7Pzjt1Xq4kAqU9QVKTtlpBfjpp5Az/nsNkYwSccwkIWjpmDy
         TXwfipS6l3iefjsOPqfcNyTZGRb4GsDi4TzIMwyTmKcT94NvVDkwONUqZGKxhvBxUY
         A0/pA3ayG5+rA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> This patchset improves the HMM driver API and add support for hugetlbfs
> and DAX mirroring. The improvement motivation was to make the ODP to HMM
> conversion easier [1]. Because we have nouveau bits schedule for 5.1 and
> to avoid any multi-tree synchronization this patchset adds few lines of
> inline function that wrap the existing HMM driver API to the improved
> API. The nouveau driver was tested before and after this patchset and it
> builds and works on both case so there is no merging issue [2]. The
> nouveau bit are queue up for 5.1 so this is why i added those inline.
>=20
> If this get merge in 5.1 the plans is to merge the HMM to ODP in 5.2 or
> 5.3 if testing shows any issues (so far no issues has been found with
> limited testing but Mellanox will be running heavier testing for longer
> time).
>=20
> To avoid spamming mm i would like to not cc mm on ODP or nouveau patches,
> however if people prefer to see those on mm mailing list then i can keep
> it cced.
>=20
> This is also what i intend to use as a base for AMD and Intel patches
> (v2 with more thing of some rfc which were already posted in the past).
>=20
> [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=3Dodp-hmm
> [2] https://cgit.freedesktop.org/~glisse/linux/log/?h=3Dhmm-for-5.1
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
>=20
> J=C3=A9r=C3=B4me Glisse (10):
>    mm/hmm: use reference counting for HMM struct
>    mm/hmm: do not erase snapshot when a range is invalidated
>    mm/hmm: improve and rename hmm_vma_get_pfns() to hmm_range_snapshot()
>    mm/hmm: improve and rename hmm_vma_fault() to hmm_range_fault()
>    mm/hmm: improve driver API to work and wait over a range
>    mm/hmm: add default fault flags to avoid the need to pre-fill pfns
>      arrays.
>    mm/hmm: add an helper function that fault pages and map them to a
>      device
>    mm/hmm: support hugetlbfs (snap shoting, faulting and DMA mapping)
>    mm/hmm: allow to mirror vma of a file on a DAX backed filesystem
>    mm/hmm: add helpers for driver to safely take the mmap_sem
>=20
>   include/linux/hmm.h |  290 ++++++++++--
>   mm/hmm.c            | 1060 +++++++++++++++++++++++++++++--------------
>   2 files changed, 983 insertions(+), 367 deletions(-)
>=20

I have been testing this patch series in addition to [1] with some
success. I wouldn't go as far as saying it is thoroughly tested
but you can add:

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>


[1] https://marc.info/?l=3Dlinux-mm&m=3D155060669514459&w=3D2
     ("[PATCH v5 0/9] mmu notifier provide context informations")
