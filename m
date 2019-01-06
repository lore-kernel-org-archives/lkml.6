Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B2C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F26217F4
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KQxOTJug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfAFImI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:42:08 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10795 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfAFImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:42:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c31bf480000>; Sun, 06 Jan 2019 00:41:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 06 Jan 2019 00:42:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 06 Jan 2019 00:42:06 -0800
Received: from [10.24.229.42] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 6 Jan
 2019 08:42:03 +0000
Subject: Re: [PATCH] mm: Expose lazy vfree pages to control via sysctl
To:     Matthew Wilcox <willy@infradead.org>
CC:     <vdumpa@nvidia.com>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <Snikam@nvidia.com>,
        <avanbrunt@nvidia.com>
References: <1546616141-486-1-git-send-email-amhetre@nvidia.com>
 <20190104180332.GV6310@bombadil.infradead.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
Message-ID: <a7bb656a-c815-09a4-69fc-bb9e7427cfa6@nvidia.com>
Date:   Sun, 6 Jan 2019 14:12:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104180332.GV6310@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546764104; bh=N57xE6X60kc1vPkUyv21EpTcZH2YwZpb2Eb7+F4WVoM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KQxOTJugnLHQ/dfCYrJYOCZouVtBXuRn37rGh3xe2d8wYNZjJh9IHQGBzm9ZtgSl1
         zeit6GG3RL7oJSmILsW7CKita4WZ8GdEcfBSp4/6zbBQnsb+f2fNn8tdK7ci1axiCz
         1hc3gpVyZyG7b6sn6VjwgwJmAT3VQ0H+emmnrIszbw98kPN3es94K0BuLxIDMjq3ZN
         mVFJhodCG9+nnZyxGiydLA++rcxsy96PBWB1Lx0Oad9S+yMEsHmdyep5Ra5N0dyWl3
         48ff0nZuHZuKEVixdP00kroxjgY77ayjE207kgyK6LQo9SuTbRaTwlJ6TfFsqoeD4R
         cqj4mHfFoSzcA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew, this issue was last reported in September 2018 on K4.9.
I verified that the optimization patches mentioned by you were not 
present in our downstream kernel when we faced the issue. I will check 
whether issue still persist on new kernel with all these patches and 
come back.

On 04/01/19 11:33 PM, Matthew Wilcox wrote:
> On Fri, Jan 04, 2019 at 09:05:41PM +0530, Ashish Mhetre wrote:
>> From: Hiroshi Doyu <hdoyu@nvidia.com>
>>
>> The purpose of lazy_max_pages is to gather virtual address space till it
>> reaches the lazy_max_pages limit and then purge with a TLB flush and hence
>> reduce the number of global TLB flushes.
>> The default value of lazy_max_pages with one CPU is 32MB and with 4 CPUs it
>> is 96MB i.e. for 4 cores, 96MB of vmalloc space will be gathered before it
>> is purged with a TLB flush.
>> This feature has shown random latency issues. For example, we have seen
>> that the kernel thread for some camera application spent 30ms in
>> __purge_vmap_area_lazy() with 4 CPUs.
> 
> You're not the first to report something like this.  Looking through the
> kernel logs, I see:
> 
> commit 763b218ddfaf56761c19923beb7e16656f66ec62
> Author: Joel Fernandes <joelaf@google.com>
> Date:   Mon Dec 12 16:44:26 2016 -0800
> 
>      mm: add preempt points into __purge_vmap_area_lazy()
> 
> commit f9e09977671b618aeb25ddc0d4c9a84d5b5cde9d
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Dec 12 16:44:23 2016 -0800
> 
>      mm: turn vmap_purge_lock into a mutex
> 
> commit 80c4bd7a5e4368b680e0aeb57050a1b06eb573d8
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Fri May 20 16:57:38 2016 -0700
> 
>      mm/vmalloc: keep a separate lazy-free list
> 
> So the first thing I want to do is to confirm that you see this problem
> on a modern kernel.  We've had trouble with NVidia before reporting
> historical problems as if they were new.
> 
