Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6847C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58BA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d3iRdJ/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfAUIGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:06:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13483 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfAUIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:06:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c457d4c0000>; Mon, 21 Jan 2019 00:05:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 21 Jan 2019 00:06:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 21 Jan 2019 00:06:05 -0800
Received: from [10.24.229.42] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 21 Jan
 2019 08:06:01 +0000
Subject: Re: [PATCH] mm: Expose lazy vfree pages to control via sysctl
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <vdumpa@nvidia.com>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <Snikam@nvidia.com>,
        <avanbrunt@nvidia.com>
References: <1546616141-486-1-git-send-email-amhetre@nvidia.com>
 <20190104180332.GV6310@bombadil.infradead.org>
 <a7bb656a-c815-09a4-69fc-bb9e7427cfa6@nvidia.com>
Message-ID: <27bd8776-87fa-69ad-7b6e-4425251b5e9c@nvidia.com>
Date:   Mon, 21 Jan 2019 13:36:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a7bb656a-c815-09a4-69fc-bb9e7427cfa6@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548057932; bh=p32sQDI6ox884rw5fGb9+nzl0KtF9Y6AnqZiwtU2mA8=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=d3iRdJ/VYyrOLckotFMOUko9EC56GYaN0i/ItutV3lHntwGMBRttdbgRwSmFk+NES
         fnK3hwBKifXG25nNbbFX81U9mUwQyadFr8T8rgfhmiczRHofAg3oSkMm9NnReu5Y4t
         Zy4jRTWcsIssJsJbHHCd6iD/acCI4tqtgGwf2yZfeGum0S93gjQPiLEVtJdoSQhnff
         NPZUvA58krZT0fid46WvtW3VoQ4qCGc/act+rZIQswuYjdxzvemRV4BDTqKGXAouMD
         LtW8IkH60KKO9EKWzyWryfIDIAhnf+gAWF4yxj9Gl0sVQFtKWtwZQZd+S38QZxSrmj
         4TnaQnFoADiXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is not seen on new kernel. This patch won't be needed. Thanks.

On 06/01/19 2:12 PM, Ashish Mhetre wrote:
> Matthew, this issue was last reported in September 2018 on K4.9.
> I verified that the optimization patches mentioned by you were not=20
> present in our downstream kernel when we faced the issue. I will check=20
> whether issue still persist on new kernel with all these patches and=20
> come back.
>=20
> On 04/01/19 11:33 PM, Matthew Wilcox wrote:
>> On Fri, Jan 04, 2019 at 09:05:41PM +0530, Ashish Mhetre wrote:
>>> From: Hiroshi Doyu <hdoyu@nvidia.com>
>>>
>>> The purpose of lazy_max_pages is to gather virtual address space till i=
t
>>> reaches the lazy_max_pages limit and then purge with a TLB flush and=20
>>> hence
>>> reduce the number of global TLB flushes.
>>> The default value of lazy_max_pages with one CPU is 32MB and with 4=20
>>> CPUs it
>>> is 96MB i.e. for 4 cores, 96MB of vmalloc space will be gathered=20
>>> before it
>>> is purged with a TLB flush.
>>> This feature has shown random latency issues. For example, we have seen
>>> that the kernel thread for some camera application spent 30ms in
>>> __purge_vmap_area_lazy() with 4 CPUs.
>>
>> You're not the first to report something like this.=C2=A0 Looking throug=
h the
>> kernel logs, I see:
>>
>> commit 763b218ddfaf56761c19923beb7e16656f66ec62
>> Author: Joel Fernandes <joelaf@google.com>
>> Date:=C2=A0=C2=A0 Mon Dec 12 16:44:26 2016 -0800
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 mm: add preempt points into __purge_vmap_area_l=
azy()
>>
>> commit f9e09977671b618aeb25ddc0d4c9a84d5b5cde9d
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:=C2=A0=C2=A0 Mon Dec 12 16:44:23 2016 -0800
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 mm: turn vmap_purge_lock into a mutex
>>
>> commit 80c4bd7a5e4368b680e0aeb57050a1b06eb573d8
>> Author: Chris Wilson <chris@chris-wilson.co.uk>
>> Date:=C2=A0=C2=A0 Fri May 20 16:57:38 2016 -0700
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 mm/vmalloc: keep a separate lazy-free list
>>
>> So the first thing I want to do is to confirm that you see this problem
>> on a modern kernel.=C2=A0 We've had trouble with NVidia before reporting
>> historical problems as if they were new.
>>
